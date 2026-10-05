import { PrismaClient } from '../src/generated';
import bcrypt from 'bcryptjs';

const prisma = new PrismaClient();

async function main() {
  console.log('Seeding database...');

  // Create admin user
  const adminPassword = await bcrypt.hash('Admin@123', 12);
  const admin = await prisma.user.upsert({
    where: { email: 'admin@hoichoi.com' },
    update: {},
    create: {
      uuid: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
      name: 'Super Admin',
      email: 'admin@hoichoi.com',
      passwordHash: adminPassword,
      role: 'super_admin',
      isActive: true,
      emailVerified: true,
    },
  });
  console.log(`Admin user: ${admin.email}`);

  // Create test user
  const testPassword = await bcrypt.hash('User@123', 12);
  const testUser = await prisma.user.upsert({
    where: { email: 'user@hoichoi.com' },
    update: {},
    create: {
      uuid: 'b2c3d4e5-f6a7-8901-bcde-f12345678901',
      name: 'Test User',
      email: 'user@hoichoi.com',
      passwordHash: testPassword,
      role: 'user',
      isActive: true,
      emailVerified: true,
    },
  });
  console.log(`Test user: ${testUser.email}`);

  // Create subscription plans
  const plans = [
    {
      name: 'Trial',
      slug: 'trial',
      description: 'Try Hoichoi IPTV for free. Limited channels for 24 hours.',
      price: 0,
      durationDays: 1,
      maxDevices: 1,
      features: { limited_channels: true, hd: false, uhd: false, simultaneous_streams: 1 },
      isActive: true,
      isTrial: true,
      trialDurationHours: 24,
      sortOrder: 0,
    },
    {
      name: 'Basic',
      slug: 'basic',
      description: 'Access to standard definition streams on 1 device.',
      price: 9.99,
      durationDays: 30,
      maxDevices: 1,
      features: { sd_quality: true, hd_quality: false, uhd_quality: false, simultaneous_streams: 1 },
      isActive: true,
      isTrial: false,
      trialDurationHours: null,
      sortOrder: 1,
    },
    {
      name: 'Premium',
      slug: 'premium',
      description: 'HD streaming on up to 2 devices simultaneously.',
      price: 19.99,
      durationDays: 30,
      maxDevices: 2,
      features: { sd_quality: true, hd_quality: true, uhd_quality: false, simultaneous_streams: 2 },
      isActive: true,
      isTrial: false,
      trialDurationHours: null,
      sortOrder: 2,
    },
    {
      name: 'Pro',
      slug: 'pro',
      description: 'UHD streaming on up to 5 devices simultaneously.',
      price: 29.99,
      durationDays: 30,
      maxDevices: 5,
      features: { sd_quality: true, hd_quality: true, uhd_quality: true, simultaneous_streams: 5 },
      isActive: true,
      isTrial: false,
      trialDurationHours: null,
      sortOrder: 3,
    },
  ];

  for (const plan of plans) {
    await prisma.subscriptionPlan.upsert({
      where: { slug: plan.slug },
      update: plan,
      create: plan,
    });
  }
  console.log('Subscription plans seeded');

  // Create categories
  const categories = [
    { name: 'Sports', slug: 'sports', description: 'Live sports channels', sortOrder: 1 },
    { name: 'News', slug: 'news', description: 'Breaking news channels', sortOrder: 2 },
    { name: 'Entertainment', slug: 'entertainment', description: 'Entertainment channels', sortOrder: 3 },
    { name: 'Movies', slug: 'movies', description: 'Movie channels', sortOrder: 4 },
    { name: 'Kids', slug: 'kids', description: 'Kids channels', sortOrder: 5 },
    { name: 'Music', slug: 'music', description: 'Music channels', sortOrder: 6 },
    { name: 'Documentary', slug: 'documentary', description: 'Documentary channels', sortOrder: 7 },
    { name: 'International', slug: 'international', description: 'International channels', sortOrder: 8 },
  ];

  for (const cat of categories) {
    await prisma.category.upsert({
      where: { slug: cat.slug },
      update: cat,
      create: cat,
    });
  }
  console.log('Categories seeded');

  // Create default homepage sections
  const sections = [
    { title: 'Live TV', type: 'live_tv' as const, sortOrder: 0, isActive: true, displayCount: 20 },
    { title: 'Sports', type: 'sports' as const, sortOrder: 1, isActive: true, displayCount: 12 },
    { title: 'News', type: 'news' as const, sortOrder: 2, isActive: true, displayCount: 12 },
    { title: 'Movies', type: 'movies' as const, sortOrder: 3, isActive: true, displayCount: 12 },
    { title: 'Kids', type: 'kids' as const, sortOrder: 4, isActive: true, displayCount: 12 },
    { title: 'Recently Added', type: 'recently_added' as const, sortOrder: 5, isActive: true, displayCount: 10 },
    { title: 'Recommended', type: 'recommended' as const, sortOrder: 6, isActive: true, displayCount: 10 },
  ];

  for (const section of sections) {
    const existing = await prisma.homepageSection.findFirst({ where: { type: section.type } });
    if (!existing) {
      await prisma.homepageSection.create({ data: section });
    }
  }
  console.log('Homepage sections seeded');

  // Create default navbar items
  const navItems = [
    { label: 'Home', href: '/', sortOrder: 0, isActive: true },
    { label: 'Live TV', href: '/channels', sortOrder: 1, isActive: true },
    { label: 'Sports', href: '/categories/sports', sortOrder: 2, isActive: true },
    { label: 'News', href: '/categories/news', sortOrder: 3, isActive: true },
    { label: 'Movies', href: '/categories/movies', sortOrder: 4, isActive: true },
    { label: 'Kids', href: '/categories/kids', sortOrder: 5, isActive: true },
  ];

  for (const item of navItems) {
    const existing = await prisma.navbarItem.findFirst({ where: { href: item.href } });
    if (!existing) {
      await prisma.navbarItem.create({ data: item });
    }
  }
  console.log('Navbar items seeded');

  // Create default footer settings
  await prisma.footerSetting.upsert({
    where: { id: 1 },
    update: {},
    create: {
      companyName: 'Hoichoi IPTV',
      description: 'Premium IPTV streaming platform.',
      copyrightText: `© ${new Date().getFullYear()} Hoichoi IPTV. All rights reserved.`,
      email: 'support@hoichoi.com',
      phone: '+880 1234-567890',
      address: 'Dhaka, Bangladesh',
      socialLinks: { facebook: '', twitter: '', instagram: '', youtube: '', telegram: '' },
      newsletterEnabled: true,
    },
  });
  console.log('Footer settings seeded');

  // Create default settings
  const defaultSettings = [
    { key: 'site_name', value: 'Hoichoi IPTV', groupName: 'general', type: 'string' },
    { key: 'site_tagline', value: 'Watch Everything', groupName: 'general', type: 'string' },
    { key: 'maintenance_mode', value: '0', groupName: 'general', type: 'boolean' },
    { key: 'registration_enabled', value: '1', groupName: 'general', type: 'boolean' },
    { key: 'trial_duration_hours', value: '24', groupName: 'subscription', type: 'integer' },
    { key: 'currency', value: 'USD', groupName: 'general', type: 'string' },
  ];

  for (const setting of defaultSettings) {
    await prisma.setting.upsert({
      where: { key: setting.key },
      update: setting,
      create: setting,
    });
  }
  console.log('Settings seeded');

  // Create default payment methods
  const paymentMethods = [
    { name: 'bKash', slug: 'bkash', isActive: true, sortOrder: 0, configuration: {} },
    { name: 'Nagad', slug: 'nagad', isActive: true, sortOrder: 1, configuration: {} },
    { name: 'Rocket', slug: 'rocket', isActive: true, sortOrder: 2, configuration: {} },
    { name: 'Stripe', slug: 'stripe', isActive: true, sortOrder: 3, configuration: {} },
    { name: 'SSLCommerz', slug: 'sslcommerz', isActive: true, sortOrder: 4, configuration: {} },
  ];

  for (const method of paymentMethods) {
    const existing = await prisma.paymentMethod.findFirst({ where: { slug: method.slug } });
    if (!existing) {
      await prisma.paymentMethod.create({ data: method });
    }
  }
  console.log('Payment methods seeded');

  // Create CMS pages
  const pages = [
    { slug: 'about', title: 'About Us', content: '<p>Hoichoi IPTV is a premium streaming platform.</p>', isPublished: true },
    { slug: 'contact', title: 'Contact Us', content: '<p>Contact us at support@hoichoi.com</p>', isPublished: true },
    { slug: 'privacy', title: 'Privacy Policy', content: '<p>Your privacy is important to us.</p>', isPublished: true },
    { slug: 'terms', title: 'Terms & Conditions', content: '<p>Terms and conditions apply.</p>', isPublished: true },
    { slug: 'faq', title: 'FAQ', content: '<p>Frequently asked questions.</p>', isPublished: true },
  ];

  for (const page of pages) {
    await prisma.cmsPage.upsert({
      where: { slug: page.slug },
      update: page,
      create: page,
    });
  }
  console.log('CMS pages seeded');

  console.log('Seed complete!');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
