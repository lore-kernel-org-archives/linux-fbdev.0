From: Henrik =?ISO-8859-1?Q?Nordstr=F6m?= <henrik@henriknordstrom.net>
Date: Tue, 26 Aug 2014 18:40:09 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <1409078409.2701.17.camel@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com> <20140825141600.GA14763@ulmo.nvidia.com>
 <53FB46FF.1010208@redhat.com> <20140825145303.GC14763@ulmo.nvidia.com>
 <20140825150705.GB15297@lukather> <20140826082626.GE17263@ulmo>
 <20140826090035.GB17528@sirena.org.uk> <20140826091853.GI17263@ulmo>
 <20140826100612.GH17528@sirena.org.uk> <20140826105451.GD31124@ulmo>
In-Reply-To: <20140826105451.GD31124@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

tis 2014-08-26 klockan 12:55 +0200 skrev Thierry Reding:


> So the firmware does control the resources to a point where the display
> hardware is initialized and then it will happily forget about them. The
> device will keep scanning out the framebuffer and simplefb can update it
> with boot messages. To prevent the console from suddenly disappearing
> the kernel needs to make sure that the resources aren't inadvertently
> turned off at some more or less random point in time.

Which imho is until simplefb is unbound from the device.

Separately to this there needs to be a in-kernel handover procedure
where a new driver (i.e. video kms driver) can bind to a device and take
over resources, but it's completely unrelated to who owns the hardware
resources while simplefb is the active driver for the device.

It is not clear to me where the hardware resources should be listed in
DT, being it a simplefb node or part of the actual hardware device node
properly marked as dynamic boot defaults or something else? It's
somewhere inbetween hardware and virtual device, and somewhat volatile.
As far as simplefb is concerned it is a hardware desription of the
framebuffer, but for a kms driver it's no more than firmware handover of
boottime settings and ceases to exists once the kms driver have
reconfigured the hardware.

What I can do is to list some properties that these settings need to
provide:

1. Handover of hardware settings from bootloader to kernel.

2. Hardware description for simplefb use. It's at this level not really
any different from any other hardware.

3. Volatile and removed when kms driver have reconfigured the hardware
or it's been decided that the (virtual) device should not be active.

Regarding 3 and kexec as mentioned earlier. A new set of properties may
be added again for kexec usage to describe the current framebuffer for
the new kernel but op to the system which prepares for kexec to
determine. Should be no different in mechanism from bootloader to kernel
handover (the kexecing kernel is the bootloader in kexec case).


Regards
Henrik

