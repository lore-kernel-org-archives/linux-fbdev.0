From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 04 May 2018 10:48:46 +0000
Subject: Re: [PATCH] drivers: omap2: Kconfig: make FB_OMAP2_DSS_INIT depend on OF
Message-Id: <44871995.YYHkG5ofpC@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180420112551.27027-1-anders.roxell@linaro.org>
 <CGME20180503154901epcas2p417fd08a4daaf1520ec4d8ed1312728c8@epcas2p4.samsung.com>
 <16e74acc-1265-faec-0c36-49681a7760e4@infradead.org>
In-Reply-To: <16e74acc-1265-faec-0c36-49681a7760e4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Randy Dunlap <rdunlap@infradead.org>, Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: linux-fbdev@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org

On Thursday, May 03, 2018 08:48:56 AM Randy Dunlap wrote:
> On 04/20/2018 04:25 AM, Anders Roxell wrote:
> > Commit 7378f1149884 ("media: omap2: omapfb: allow building it with
> > COMPILE_TEST") broke compilation without CONFIG_OF selected.
> >   CC      drivers/video/fbdev/core/fbmem.o
> > drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c: In function ‘omapdss_update_prop’:
> > drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c:68:2: error: implicit declaration of function ‘of_update_property’; did you mean ‘of_get_property’? [-Werror=implicit-function-declaration]
> >   of_update_property(node, prop);
> >   ^~~~~~~~~~~~~~~~~~
> >   of_get_property
> > cc1: some warnings being treated as errors
> > scripts/Makefile.build:312: recipe for target 'drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.o' failed
> > make[7]: *** [drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.o] Error 1
> > scripts/Makefile.build:559: recipe for target 'drivers/video/fbdev/omap2/omapfb/dss' failed
> > make[6]: *** [drivers/video/fbdev/omap2/omapfb/dss] Error 2
> > make[6]: *** Waiting for unfinished jobs....
> > 
> > Add OF dependency in order to make all configurations work again.
> > 
> > of_update_property() has no inline stub, and that that could be added as
> > an alternative.
> > 
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  drivers/video/fbdev/omap2/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/fbdev/omap2/Kconfig b/drivers/video/fbdev/omap2/Kconfig
> > index 82008699d253..4de381f2452e 100644
> > --- a/drivers/video/fbdev/omap2/Kconfig
> > +++ b/drivers/video/fbdev/omap2/Kconfig
> > @@ -1,4 +1,4 @@
> > -if ARCH_OMAP2PLUS || COMPILE_TEST
> > +if OF && (ARCH_OMAP2PLUS || COMPILE_TEST)
> >  
> >  source "drivers/video/fbdev/omap2/omapfb/Kconfig"
> >  
> > 
> 
> Hi,
> 
> This patch certainly fixes the build errors that I have been seeing in
> linux-next for several days now, so:
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

Since there has been no follow up from Mauro on this ([1]) I guess
that the best thing I can do is simply merging both patches to fbdev
tree..

[1] https://www.spinics.net/lists/linux-media/msg132583.html

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

