From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 25 Apr 2018 11:13:18 +0000
Subject: Re: [PATCH 5/7] omapfb: omapfb_dss.h: add stubs to build with COMPILE_TEST && DRM_OMAP
Message-Id: <2150137.NOxbZFYopW@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1524245455.git.mchehab@s-opensource.com>
 <5379683.QunLsIS18Z@amdc3058> <d155af94-539b-699a-73cc-7eae72bd9efa@ti.com>
 <CGME20180425111319eucas1p163fa4f5f7f51bc854763ba3c3c87b605@eucas1p1.samsung.com>
In-Reply-To: <d155af94-539b-699a-73cc-7eae72bd9efa@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Linux Media Mailing List <linux-media@vger.kernel.org>


On Monday, April 23, 2018 05:11:14 PM Tomi Valkeinen wrote:
> On 23/04/18 16:56, Bartlomiej Zolnierkiewicz wrote:
> 
> > Ideally we should be able to build both drivers in the same kernel
> > (especially as modules).
> > 
> > I was hoping that it could be fixed easily but then I discovered
> > the root source of the problem:
> > 
> > drivers/gpu/drm/omapdrm/dss/display.o: In function `omapdss_unregister_display':
> > display.c:(.text+0x2c): multiple definition of `omapdss_unregister_display'
> > drivers/video/fbdev/omap2/omapfb/dss/display.o:display.c:(.text+0x198): first defined here
> 
> The main problem is that omapdrm and omapfb are two different drivers
> for the same HW. You need to pick one, even if we would change those
> functions and fix the link issue.

With proper resource allocation in both drivers this shouldn't be
a problem - the one which allocates resources first will be used
(+ we can initialize omapdrm first in case it is built-in). This is
how similar situations are handled in other kernel subsystems.

It seems that the real root problem is commit f76ee892a99e ("omapfb:
copy omapdss & displays for omapfb") from Dec 2015 which resulted in
duplication of ~30 KLOC of code. The code in question seems to be
both fbdev & drm independent:

"
    * omapdss, located in drivers/video/fbdev/omap2/dss/. This is a driver for the
      display subsystem IPs used on OMAP (and related) SoCs. It offers only a
      kernel internal API, and does not implement anything for fbdev or drm.
    
    * omapdss panels and encoders, located in
      drivers/video/fbdev/omap2/displays-new/. These are panel and external encoder
      drivers, which use APIs offered by omapdss driver. These also don't implement
      anything for fbdev or drm.
"

While I understand some motives behind this change I'm not overall
happy with it..

> At some point in time we could compile both as modules (but not
> built-in), but the only use for that was development/testing and in the
> end made our life more difficult. So, now you must fully disable one of
> them to enable the other. And, actually, we even have boot-time code,
> not included in the module itself, which gets enabled when omapdrm is
> enabled.

Do you mean some code in arch/arm/mach-omap2/ or something else?

> While it's of course good to support COMPILE_TEST, if using COMPILE_TEST
> with omapfb is problematic, I'm not sure if it's worth to spend time on
> that. We should be moving away from omapfb to omapdrm.

Is there some approximate schedule for omapfb removal available?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

