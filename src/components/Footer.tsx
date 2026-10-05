import Link from "next/link";

export default function Footer() {
  return (
    <footer className="bg-[#12121a] border-t border-white/10">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          <div>
            <h3 className="text-lg font-bold mb-3">
              <span className="text-emerald-400">Hoichoi</span>
              <span className="text-white"> TV</span>
            </h3>
            <p className="text-gray-400 text-sm">
              Your gateway to premium Bengali entertainment. Stream live TV,
              movies, and originals anytime, anywhere.
            </p>
          </div>

          <div>
            <h4 className="text-white font-medium mb-3">Explore</h4>
            <ul className="space-y-2 text-sm">
              <li>
                <Link href="/channels" className="text-gray-400 hover:text-white transition-colors">
                  Channels
                </Link>
              </li>
              <li>
                <Link href="/categories" className="text-gray-400 hover:text-white transition-colors">
                  Categories
                </Link>
              </li>
              <li>
                <Link href="/subscription" className="text-gray-400 hover:text-white transition-colors">
                  Plans & Pricing
                </Link>
              </li>
            </ul>
          </div>

          <div>
            <h4 className="text-white font-medium mb-3">Company</h4>
            <ul className="space-y-2 text-sm">
              <li>
                <Link href="/about" className="text-gray-400 hover:text-white transition-colors">
                  About Us
                </Link>
              </li>
              <li>
                <Link href="/contact" className="text-gray-400 hover:text-white transition-colors">
                  Contact
                </Link>
              </li>
            </ul>
          </div>

          <div>
            <h4 className="text-white font-medium mb-3">Legal</h4>
            <ul className="space-y-2 text-sm">
              <li>
                <Link href="/privacy" className="text-gray-400 hover:text-white transition-colors">
                  Privacy Policy
                </Link>
              </li>
              <li>
                <Link href="/terms" className="text-gray-400 hover:text-white transition-colors">
                  Terms of Service
                </Link>
              </li>
            </ul>
          </div>
        </div>

        <div className="border-t border-white/10 mt-8 pt-8 text-center text-sm text-gray-500">
          &copy; {new Date().getFullYear()} Hoichoi TV. All rights reserved.
        </div>
      </div>
    </footer>
  );
}
