"use client";

import { Users, CreditCard, Tv, TrendingUp } from "lucide-react";

const stats = [
  {
    label: "Total Users",
    value: "1,247",
    change: "+12% this month",
    icon: Users,
    color: "text-emerald-400",
    bg: "bg-emerald-500/10",
  },
  {
    label: "Active Subscriptions",
    value: "892",
    change: "+8% this month",
    icon: CreditCard,
    color: "text-purple-400",
    bg: "bg-purple-500/10",
  },
  {
    label: "Total Channels",
    value: "156",
    change: "3 new added",
    icon: Tv,
    color: "text-blue-400",
    bg: "bg-blue-500/10",
  },
  {
    label: "Revenue",
    value: "$24,580",
    change: "+15% this month",
    icon: TrendingUp,
    color: "text-amber-400",
    bg: "bg-amber-500/10",
  },
];

export default function AdminDashboard() {
  return (
    <div>
      <h2 className="text-2xl font-bold text-white mb-6">Dashboard</h2>

      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        {stats.map((stat) => (
          <div
            key={stat.label}
            className="bg-[#12121a] border border-white/10 rounded-xl p-5"
          >
            <div className="flex items-center justify-between mb-3">
              <span className="text-sm text-gray-400">{stat.label}</span>
              <div
                className={`w-10 h-10 rounded-lg ${stat.bg} flex items-center justify-center`}
              >
                <stat.icon size={20} className={stat.color} />
              </div>
            </div>
            <p className="text-2xl font-bold text-white">{stat.value}</p>
            <p className="text-xs text-gray-500 mt-1">{stat.change}</p>
          </div>
        ))}
      </div>

      <div className="mt-8 bg-[#12121a] border border-white/10 rounded-xl p-6">
        <h3 className="text-lg font-semibold text-white mb-4">
          Recent Activity
        </h3>
        <p className="text-gray-400 text-sm">
          Activity feed will be displayed here.
        </p>
      </div>
    </div>
  );
}
