From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date: Mon, 23 Apr 2018 14:25:21 +0000
Subject: Re: [PATCH 5/7] omapfb: omapfb_dss.h: add stubs to build with COMPILE_TEST && DRM_OMAP
Message-Id: <20180423112521.52b2a230@vento.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1524245455.git.mchehab@s-opensource.com>
 <c6ef815da57085bf7e98753463e551905f5d2706.1524245455.git.mchehab@s-opensource.com>
 <2542100.cElVns0SR0@amdc3058>
 <CGME20180423135655eucas1p1a935ce9c167e52cf1e76adcc0b4486e4@eucas1p1.samsung.com>
 <5379683.QunLsIS18Z@amdc3058>
 <d155af94-539b-699a-73cc-7eae72bd9efa@ti.com>
In-Reply-To: <d155af94-539b-699a-73cc-7eae72bd9efa@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Linux Media Mailing List <linux-media@vger.kernel.org>

Em Mon, 23 Apr 2018 17:11:14 +0300
Tomi Valkeinen <tomi.valkeinen@ti.com> escreveu:

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
> 
> At some point in time we could compile both as modules (but not
> built-in), but the only use for that was development/testing and in the
> end made our life more difficult. So, now you must fully disable one of
> them to enable the other. And, actually, we even have boot-time code,
> not included in the module itself, which gets enabled when omapdrm is
> enabled.
> 
> While it's of course good to support COMPILE_TEST, if using COMPILE_TEST
> with omapfb is problematic, I'm not sure if it's worth to spend time on
> that. We should be moving away from omapfb to omapdrm.

Yeah, moving away from omapfb sounds the best alternative. As it seems that
there's just one driver currently depending on it, I guess it shouldn't be
that hard to do such change from Kernel's view, but I may be wrong, as I've
no clue what this would mean to userspace.

Thanks,
Mauro
