From: Pavel Machek <pavel@ucw.cz>
Date: Thu, 05 Nov 2015 20:23:01 +0000
Subject: Re: Mobility Radeon HD 4530/4570/545v: flicker in 1920x1080
Message-Id: <20151105202301.GA3624@amd>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20151031201344.GA30459@amd> <563522C5.1000206@amd.com>
 <20151031212259.GA6253@amd>
 <CADnq5_MoThbrDADBHBRXiEGWC8jukwOLyfjfX9-7d0fB0kbpMA@mail.gmail.com>
 <20151103220919.GA4824@amd>
 <CADnq5_P8TOQ14NiWKgV-YUy0_8P+K842pZ4h7WuU6XBu4o9fyQ@mail.gmail.com>
 <20151103230329.GA4167@amd> <5639B580.1050409@vodafone.de>
 <20151104221000.GA3608@amd>
 <CADnq5_OwDpgTKuS66dBSeFEMqkxi=1mie_xONZsnYj8su4Z_xw@mail.gmail.com>
In-Reply-To: <CADnq5_OwDpgTKuS66dBSeFEMqkxi=1mie_xONZsnYj8su4Z_xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>

Hi!

> >> The flickering would vanish completely if that's the reason for the issue
> >> you are seeing.
> >
> >> Try setting ref_div_min and ref_div_max to 2 in
> >>  radeon_compute_pll_avivo().
> >
> > Ok, I did this, but no luck, still flickers. But the flicker only
> > happens when something changes on screen, like dragging a big
> > window. Is that consistent with wrong PLL timings?
> 
> Does it go away with radeon.dpm=0?  Sounds more like either memory
> reclocking happening outside of vblank, or underflow to the display
> controllers.

No, it does not:

pavel@half:~$ cat /proc/cmdline
BOOT_IMAGE=(hd0,2)/l/linux/arch/x86/boot/bzImage root=/dev/sda4
resume=/dev/sda1 radeon.dpm=0

..and same issue. And yes, it looks like an underflow to me. How can I
debug reclocking / underflows?

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
