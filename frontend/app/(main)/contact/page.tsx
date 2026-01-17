'use client';

import Link from 'next/link';
import { usePageSEO } from '@/lib/seo';
import ContactSection from '@/components/Contact/ContactSection';

export default function ContactPage() {
  // Apply dynamic SEO
  usePageSEO('/contact');

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="bg-white border-b">
        <div className="container mx-auto px-3 sm:px-4 py-2 sm:py-3">
          <div className="flex items-center gap-2 text-xs sm:text-sm">
            <Link href="/" className="text-[#E63946] hover:underline">Home</Link>
            <span className="text-gray-400">/</span>
            <span className="text-gray-800 font-medium">Contact Us</span>
          </div>
        </div>
      </div>

      <ContactSection />
    </div>
  );
}
