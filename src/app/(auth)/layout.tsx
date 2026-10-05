import Link from "next/link";

export default function AuthLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="min-h-screen bg-[#0a0a0f] flex items-center justify-center px-4">
      <div className="w-full max-w-md">
        <div className="text-center mb-8">
          <Link href="/" className="inline-block">
            <h1 className="text-3xl font-bold text-emerald-400 tracking-tight">
              Hoichoi
              <span className="text-white"> TV</span>
            </h1>
          </Link>
          <p className="text-gray-400 text-sm mt-2">
            Stream your favorite Bengali content
          </p>
        </div>
        {children}
      </div>
    </div>
  );
}
