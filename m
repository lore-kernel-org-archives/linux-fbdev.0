From: Tony Lindgren <tony@atomide.com>
Date: Wed, 22 Feb 2012 18:57:28 +0000
Subject: Re: [PATCH 8/8] ARM: OMAP2+: Limit omap_read/write usage to legacy USB drivers
Message-Id: <20120222185728.GJ18185@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120221233619.18709.87982.stgit@kaulin.local>
 <20120221234051.18709.3571.stgit@kaulin.local>
 <1329898441.2070.10.camel@deskari>
In-Reply-To: <1329898441.2070.10.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120221 23:42]:
> On Tue, 2012-02-21 at 15:40 -0800, Tony Lindgren wrote:
> > Drivers should no longer use omap_read/write functions
> > but instead use ioremap + read/write functions.
> > 
> > As some USB legacy code is still shared between omap1 and
> > omap2420, let's limit the omap_read/write to plat/usb.h.
> > 
> > Also, let's make drivers/video/omap/lcdc.c depend on
> > ARCH_OMAP1 as it is not needed for omap2+.
> 
> I'm ok with the lcdc.c change, but I also have a patch series that makes
> the same change, plus removes the omap2 code from drivers/video/omap/.

OK, I'll drop the lcdc.c change from my series as that should
only affect randconfig builds.
 
> Can you check the series, and give ack if the arch/arm side looks fine?
> It's this one: [PATCH 00/16] OMAPDSS: old OMAPFB cleanup

Yeah great, I've acked those. Let's do a test merge when I
have these in cleanup branch, looks like the conflicts should
be trivial.

Tony
