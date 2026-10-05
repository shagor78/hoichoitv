import type { Metadata, Viewport } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import { Toaster } from "react-hot-toast";
import "./globals.css";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: {
    default: "Hoichoi IPTV - Watch Everything",
    template: "%s | Hoichoi IPTV",
  },
  description: "Premium IPTV streaming platform. Watch live TV, sports, news, movies and more.",
  keywords: ["IPTV", "live tv", "streaming", "sports", "movies", "news"],
};

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
  maximumScale: 1,
  themeColor: "#0a0a0f",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className={`${geistSans.variable} ${geistMono.variable} dark`}>
      <body className="min-h-screen bg-[#0a0a0f] text-white antialiased">
        <Toaster
          position="top-right"
          toastOptions={{
            duration: 3000,
            style: {
              background: '#12121a',
              color: '#e5e5e5',
              border: '1px solid rgba(255,255,255,0.1)',
            },
            success: { iconTheme: { primary: '#10b981', secondary: '#12121a' } },
            error: { iconTheme: { primary: '#ef4444', secondary: '#12121a' } },
          }}
        />
        {children}
      </body>
    </html>
  );
}
