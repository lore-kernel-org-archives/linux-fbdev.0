From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 04 Nov 2018 23:14:57 +0000
Subject: Re: radeon vs radeonfb Mobility quirks (Thinkpad X32)
Message-Id: <365d8b24f1c6a28c32998924a95b6a2a74655526.camel@kernel.crashing.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181104042328.jzavn47y2wloprbs@untitled>
In-Reply-To: <20181104042328.jzavn47y2wloprbs@untitled>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Wong <e@80x24.org>, David Airlie <airlied@linux.ie>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>

On Sun, 2018-11-04 at 04:23 +0000, Eric Wong wrote:
> Looking at drivers/video/fbdev/aty/radeon_pm.c, I notice it sets
> a D2 sleep mode for my X32:
> 
>         BUGFIX("IBM Thinkpad X31/X32",
>                PCI_VENDOR_ID_IBM, 0x052f,
>                radeon_pm_d2, NULL),
> 
> Which I suspect is what allows "radeonfb" to work for me
> 
> But I can't find the corresponding quirk in drivers/gpu/drm/radeon/,
> so I now believe a missing quirk is the cause of this problem
> with the "radeon" driver.
> 
> I poked around but couldn't figure out what changes to make to
> the "radeon" driver to enable the corresponding, but I'm willing
> to test patches.
> 
> Setting "dynpm" in /sys/**/power_method didn't seem to change
> things, either.
> 
> Help greatly appreaciated.  Thanks
> 
> 
> I've mainly been using the X32 as a server this decade so didn't
> use suspend/hibernate so I didn't investigate until recently
> (because my netbook died).

There's a whole pile of power management stuff for ancient laptops that
never quite made it from radeonfb to the radeon DRM driver... sadly it
also prevents sleep on old PowerBooks but I haven't had many complaints
so...

The code for D2 and D3 on those old things is reasonably self
contained, it shouldn't be that hard to move it over I suppose.

Cheers,
Ben.
