import Link from "next/link";

export default function HomePage() {
  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
      <div className="text-center mb-16">
        <h1 className="text-4xl md:text-5xl font-bold text-white mb-4">
          Welcome to{" "}
          <span className="text-emerald-400">Hoichoi IPTV</span>
        </h1>
        <p className="text-gray-400 text-lg max-w-2xl mx-auto">
          Stream your favorite Bengali channels, movies, and original series.
          Premium entertainment at your fingertips.
        </p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6 max-w-2xl mx-auto">
        <Link
          href="/channels"
          className="bg-[#12121a] border border-white/10 rounded-2xl p-8 hover:border-emerald-500/50 transition-all group"
        >
          <div className="w-12 h-12 bg-emerald-500/20 rounded-xl flex items-center justify-center mb-4 group-hover:bg-emerald-500/30 transition-colors">
            <svg
              className="w-6 h-6 text-emerald-400"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14M5 18h8a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z"
              />
            </svg>
          </div>
          <h2 className="text-white text-lg font-semibold mb-2">Channels</h2>
          <p className="text-gray-400 text-sm">
            Browse all available live TV channels
          </p>
        </Link>

        <Link
          href="/categories"
          className="bg-[#12121a] border border-white/10 rounded-2xl p-8 hover:border-purple-500/50 transition-all group"
        >
          <div className="w-12 h-12 bg-purple-500/20 rounded-xl flex items-center justify-center mb-4 group-hover:bg-purple-500/30 transition-colors">
            <svg
              className="w-6 h-6 text-purple-400"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"
              />
            </svg>
          </div>
          <h2 className="text-white text-lg font-semibold mb-2">Categories</h2>
          <p className="text-gray-400 text-sm">
            Explore content organized by genre and category
          </p>
        </Link>
      </div>
    </div>
  );
}
