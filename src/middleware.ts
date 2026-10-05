import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";
import { jwtVerify } from "jose";

const JWT_SECRET = new TextEncoder().encode(process.env.JWT_SECRET);

const protectedRoutes = ["/admin", "/watch", "/profile", "/favorites", "/history", "/subscription", "/payment"];
const adminRoutes = ["/admin"];
const authRoutes = ["/login", "/register"];
const publicRoutes = ["/", "/channels", "/categories", "/about", "/contact", "/privacy", "/terms"];

function matchRoute(pathname: string, routes: string[]): boolean {
  return routes.some((route) => pathname === route || pathname.startsWith(route + "/"));
}

export async function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;
  const token = request.cookies.get("accessToken")?.value;

  if (pathname.startsWith("/api")) {
    return NextResponse.next();
  }

  if (matchRoute(pathname, authRoutes) && token) {
    try {
      const { payload } = await jwtVerify(token, JWT_SECRET);
      if (payload.role === "admin" || payload.role === "super_admin") {
        return NextResponse.redirect(new URL("/admin", request.url));
      }
      return NextResponse.redirect(new URL("/", request.url));
    } catch {
      const response = NextResponse.next();
      response.cookies.delete("accessToken");
      return response;
    }
  }

  if (matchRoute(pathname, protectedRoutes) && !token) {
    const loginUrl = new URL("/login", request.url);
    loginUrl.searchParams.set("redirect", pathname);
    return NextResponse.redirect(loginUrl);
  }

  if (token && matchRoute(pathname, protectedRoutes)) {
    try {
      const { payload } = await jwtVerify(token, JWT_SECRET);

      if (matchRoute(pathname, adminRoutes)) {
        if (payload.role !== "admin" && payload.role !== "super_admin") {
          return NextResponse.redirect(new URL("/", request.url));
        }
      }
    } catch {
      const response = NextResponse.redirect(new URL("/login", request.url));
      response.cookies.delete("accessToken");
      return response;
    }
  }

  if (!matchRoute(pathname, publicRoutes) && !matchRoute(pathname, protectedRoutes) && !matchRoute(pathname, authRoutes)) {
    if (!token) {
      return NextResponse.next();
    }
  }

  return NextResponse.next();
}

export const config = {
  matcher: ["/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)"],
};
