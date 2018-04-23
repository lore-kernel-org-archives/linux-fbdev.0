From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 23 Apr 2018 13:56:53 +0000
Subject: Re: [PATCH 5/7] omapfb: omapfb_dss.h: add stubs to build with COMPILE_TEST && DRM_OMAP
Message-Id: <5379683.QunLsIS18Z@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1524245455.git.mchehab@s-opensource.com>
 <c6ef815da57085bf7e98753463e551905f5d2706.1524245455.git.mchehab@s-opensource.com>
 <2542100.cElVns0SR0@amdc3058>
 <CGME20180423135655eucas1p1a935ce9c167e52cf1e76adcc0b4486e4@eucas1p1.samsung.com>
In-Reply-To: <2542100.cElVns0SR0@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Linux Media Mailing List <linux-media@vger.kernel.org>

On Monday, April 23, 2018 02:47:28 PM Bartlomiej Zolnierkiewicz wrote:
> On Friday, April 20, 2018 01:42:51 PM Mauro Carvalho Chehab wrote:
> > Add stubs for omapfb_dss.h, in the case it is included by
> > some driver when CONFIG_FB_OMAP2 is not defined, with can
> > happen on ARM when DRM_OMAP is not 'n'.
> > 
> > That allows building such driver(s) with COMPILE_TEST.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> 
> This patch should be dropped (together with patch #6/7) as it was
> superseded by a better solution suggested by Laurent:
> 
> https://patchwork.kernel.org/patch/10325193/
> 
> ACK-ed by Tomi:
> 
> https://www.spinics.net/lists/dri-devel/msg171918.html
> 
> and already merged by you (commit 7378f1149884 "media: omap2:
> omapfb: allow building it with COMPILE_TEST")..

Hmm, I see now while this patch is still included:

menuconfig FB_OMAP2
        tristate "OMAP2+ frame buffer support"
        depends on FB
        depends on DRM_OMAP = n

Ideally we should be able to build both drivers in the same kernel
(especially as modules).

I was hoping that it could be fixed easily but then I discovered
the root source of the problem:

drivers/gpu/drm/omapdrm/dss/display.o: In function `omapdss_unregister_display':
display.c:(.text+0x2c): multiple definition of `omapdss_unregister_display'
drivers/video/fbdev/omap2/omapfb/dss/display.o:display.c:(.text+0x198): first defined here
...

I need some more time to think about this..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

