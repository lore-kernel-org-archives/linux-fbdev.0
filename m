From: Pavel Machek <pavel@ucw.cz>
Date: Thu, 05 Nov 2015 20:26:18 +0000
Subject: Re: Mobility Radeon HD 4530/4570/545v: flicker in 1920x1080
Message-Id: <20151105202618.GB3624@amd>
List-Id: <linux-fbdev.vger.kernel.org>
References: <563522C5.1000206@amd.com> <20151031212259.GA6253@amd>
 <CADnq5_MoThbrDADBHBRXiEGWC8jukwOLyfjfX9-7d0fB0kbpMA@mail.gmail.com>
 <20151103220919.GA4824@amd>
 <CADnq5_P8TOQ14NiWKgV-YUy0_8P+K842pZ4h7WuU6XBu4o9fyQ@mail.gmail.com>
 <20151103230329.GA4167@amd> <5639B580.1050409@vodafone.de>
 <20151104221000.GA3608@amd>
 <CADnq5_OwDpgTKuS66dBSeFEMqkxi=1mie_xONZsnYj8su4Z_xw@mail.gmail.com>
 <563B32C7.3080202@vodafone.de>
In-Reply-To: <563B32C7.3080202@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>



> >>>>RADEON_PLL_PREFER_MINM_OVER_MAXP).
> >>>The flickering would vanish completely if that's the reason for the issue
> >>>you are seeing.
> >>>Try setting ref_div_min and ref_div_max to 2 in
> >>>  radeon_compute_pll_avivo().
> >>Ok, I did this, but no luck, still flickers. But the flicker only
> >>happens when something changes on screen, like dragging a big
> >>window. Is that consistent with wrong PLL timings?
> >Does it go away with radeon.dpm=0?  Sounds more like either memory
> >reclocking happening outside of vblank, or underflow to the display
> >controllers.
> 
> Sounds like my suspicion was right, that doesn't seem to be a PLL issue
> after all.
> 
> Just to rule out the obvious your system works fine with windows and you
> don't have a extra long cable for the monitor or something like
>this?

Cable is something like 2 meters. It does not seem to be EMI, because
it only happens when the display is being updated.

The system had some thermal issues before, but a) there's big fan
cooling it now and b) it does not get worse with more usage. I don't
think its heat.

I don't have Windows for a test, sorry.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
