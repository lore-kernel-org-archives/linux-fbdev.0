From: Pavel Machek <pavel@ucw.cz>
Date: Wed, 04 Nov 2015 22:10:00 +0000
Subject: Re: Mobility Radeon HD 4530/4570/545v: flicker in 1920x1080
Message-Id: <20151104221000.GA3608@amd>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20151031201344.GA30459@amd> <563522C5.1000206@amd.com>
 <20151031212259.GA6253@amd>
 <CADnq5_MoThbrDADBHBRXiEGWC8jukwOLyfjfX9-7d0fB0kbpMA@mail.gmail.com>
 <20151103220919.GA4824@amd>
 <CADnq5_P8TOQ14NiWKgV-YUy0_8P+K842pZ4h7WuU6XBu4o9fyQ@mail.gmail.com>
 <20151103230329.GA4167@amd> <5639B580.1050409@vodafone.de>
In-Reply-To: <5639B580.1050409@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>

Hi!

> >>>>index dac78ad..b86f06a 100644
> >>>>--- a/drivers/gpu/drm/radeon/atombios_crtc.c
> >>>>+++ b/drivers/gpu/drm/radeon/atombios_crtc.c
> >>>>@@ -569,6 +569,8 @@ static u32 atombios_adjust_pll(struct drm_crtc *crtc,
> >>>>         radeon_crtc->pll_flags = 0;
> >>>>
> >>>>         if (ASIC_IS_AVIVO(rdev)) {
> >>>>+               radeon_crtc->pll_flags |= RADEON_PLL_PREFER_MINM_OVER_MAXP;
> >>>>+
> >>>>                 if ((rdev->family = CHIP_RS600) ||
> >>>>                     (rdev->family = CHIP_RS690) ||
> >>>>                     (rdev->family = CHIP_RS740))
> >>>>
> >>>Help.. maybe... it is tricky to tell. It definitely does _not_ fix the
> >>>issue completely.
> >>You could also try the old pll algorithm:
> >I reverted the patch above, and switched to the old algorithm.
> >
> >The flicker is still there. (But maybe its less horrible, like with
> >RADEON_PLL_PREFER_MINM_OVER_MAXP).
> 
> The flickering would vanish completely if that's the reason for the issue
> you are seeing.

> Try setting ref_div_min and ref_div_max to 2 in
>  radeon_compute_pll_avivo().

Ok, I did this, but no luck, still flickers. But the flicker only
happens when something changes on screen, like dragging a big
window. Is that consistent with wrong PLL timings?

diff --git a/config.32 b/config.32
index 00e5dd2..4734158 100644
--- a/config.32
+++ b/config.32
@@ -1090,7 +1090,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
 CONFIG_FIRMWARE_IN_KERNEL=y
-CONFIG_EXTRA_FIRMWARE="radeon/R700_rlc.bin"
+CONFIG_EXTRA_FIRMWARE="radeon/R700_rlc.bin radeon/RV710_smc.bin radeon/RV710_uvd.bin"
 CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"
 # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
 CONFIG_ALLOW_DEV_COREDUMP=y
diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
index dac78ad..dcc4f4d 100644
--- a/drivers/gpu/drm/radeon/atombios_crtc.c
+++ b/drivers/gpu/drm/radeon/atombios_crtc.c
@@ -569,6 +569,8 @@ static u32 atombios_adjust_pll(struct drm_crtc *crtc,
 	radeon_crtc->pll_flags = 0;
 
 	if (ASIC_IS_AVIVO(rdev)) {
+		//radeon_crtc->pll_flags |= RADEON_PLL_PREFER_MINM_OVER_MAXP;
+
 		if ((rdev->family = CHIP_RS600) ||
 		    (rdev->family = CHIP_RS690) ||
 		    (rdev->family = CHIP_RS740))
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 6743174..bebaf4f 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -947,6 +947,7 @@ void radeon_compute_pll_avivo(struct radeon_pll *pll,
 	fb_div_max = pll->max_feedback_div;
 
 	if (pll->flags & RADEON_PLL_USE_FRAC_FB_DIV) {
+		printk("radeon: fractional divider\n");
 		fb_div_min *= 10;
 		fb_div_max *= 10;
 	}
@@ -966,6 +967,9 @@ void radeon_compute_pll_avivo(struct radeon_pll *pll,
 	else
 		ref_div_max = pll->max_ref_div;
 
+	ref_div_min = 2;
+	ref_div_max = 2;
+
 	/* determine allowed post divider range */
 	if (pll->flags & RADEON_PLL_USE_POST_DIV) {
 		post_div_min = pll->post_div;
@@ -1020,6 +1024,8 @@ void radeon_compute_pll_avivo(struct radeon_pll *pll,
 		diff = abs(target_clock - (pll->reference_freq * fb_div) /
 			(ref_div * post_div));
 
+		printk("post_div = %d, diff = %d\n", post_div, diff);
+
 		if (diff < diff_best || (diff = diff_best &&
 		    !(pll->flags & RADEON_PLL_PREFER_MINM_OVER_MAXP))) {
 
@@ -1028,6 +1034,7 @@ void radeon_compute_pll_avivo(struct radeon_pll *pll,
 		}
 	}
 	post_div = post_div_best;
+	printk("Selected post_div = %d\n", post_div);
 
 	/* get the feedback and reference divider for the optimal value */
 	avivo_get_fb_ref_div(nom, den, post_div, fb_div_max, ref_div_max,
@@ -1062,7 +1069,7 @@ void radeon_compute_pll_avivo(struct radeon_pll *pll,
 	*ref_div_p = ref_div;
 	*post_div_p = post_div;
 
-	DRM_DEBUG_KMS("%d - %d, pll dividers - fb: %d.%d ref: %d, post %d\n",
+	printk("%d - %d, pll dividers - fb: %d.%d ref: %d, post %d\n",
 		      freq, *dot_clock_p * 10, *fb_div_p, *frac_fb_div_p,
 		      ref_div, post_div);
 }


> But I'm not 100% convinced that this is actually a PLL problem, try to
> compile the firmware it complains about into the kernel as well.

Did that, too.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
