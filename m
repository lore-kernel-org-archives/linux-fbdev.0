From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Jul 2018 15:44:52 +0000
Subject: Re: [PATCH] omapfb: rename omap2 module to omap2fb.ko
Message-Id: <7035461.Acm8y0QBsZ@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180706123528.2729378-1-arnd@arndb.de>
 <CGME20180709070222epcas2p23ff1e3707fcad5eb9270aafd3081a63e@epcas2p2.samsung.com>
 <20180709070216.GE112168@atomide.com>
In-Reply-To: <20180709070216.GE112168@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Monday, July 09, 2018 12:02:16 AM Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [180706 12:39]:
> > In a kernel configuration with both CONFIG_FB_OMAP=m and CONFIG_FB_OMAP2=m,
> > Kbuild fails to point out that we have two modules with the same name (omapfb.ko),
> > but instead fails with a cryptic error message like:
> > 
> > ERROR: "omapfb_register_panel" [drivers/video/fbdev/omap/lcd_osk.ko] undefined!
> > 
> > This can now happen when building a randconfig kernel with CONFIG_ARCH_OMAP1,
> > as the omap1 fbdev driver depends on that, whiel the omap2 fbdev driver can
> > now be built anywhere with CONFIG_COMPILE_TEST.
> > 
> > The solution is to rename one of the two modules, so for consistency with
> > the directory naming I decided to rename the omap2 version to omap2fb.ko.
> 
> Sounds good to me:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

