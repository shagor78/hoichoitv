export const dynamic = 'force-dynamic';

import { NextRequest, NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';
import { verifyRefreshToken, signAccessToken } from '@/lib/auth';

export async function POST(request: NextRequest) {
  try {
    let refreshToken: string | undefined;

    const body = await request.json().catch(() => null);
    if (body?.refreshToken) {
      refreshToken = body.refreshToken;
    }

    if (!refreshToken) {
      refreshToken = request.cookies.get('refreshToken')?.value;
    }

    if (!refreshToken) {
      return NextResponse.json(
        { success: false, error: { message: 'Refresh token is required' } },
        { status: 401 }
      );
    }

    let payload;
    try {
      payload = verifyRefreshToken(refreshToken);
    } catch {
      return NextResponse.json(
        { success: false, error: { message: 'Invalid or expired refresh token' } },
        { status: 401 }
      );
    }

    const storedToken = await prisma.refreshToken.findFirst({
      where: { token: refreshToken },
    });

    if (!storedToken) {
      return NextResponse.json(
        { success: false, error: { message: 'Refresh token not found' } },
        { status: 401 }
      );
    }

    if (new Date(storedToken.expiresAt) < new Date()) {
      await prisma.refreshToken.delete({ where: { id: storedToken.id } });
      return NextResponse.json(
        { success: false, error: { message: 'Refresh token expired' } },
        { status: 401 }
      );
    }

    const user = await prisma.user.findUnique({
      where: { id: payload.id },
    });

    if (!user || !user.isActive) {
      return NextResponse.json(
        { success: false, error: { message: 'User not found or deactivated' } },
        { status: 401 }
      );
    }

    const accessToken = signAccessToken({
      id: user.id,
      uuid: user.uuid,
      email: user.email,
      role: user.role,
    });

    return NextResponse.json({
      success: true,
      data: { accessToken },
    });
  } catch (error) {
    console.error('Refresh error:', error);
    return NextResponse.json(
      { success: false, error: { message: 'Internal server error' } },
      { status: 500 }
    );
  }
}
