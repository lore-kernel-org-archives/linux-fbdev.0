From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken when
 PM set
Date: Tue, 10 Nov 2009 03:50:52 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911100347320.20233@utopia.booyaka.com>
References: <200910292339.48610.jkrzyszt@tis.icnet.pl> <200910301542.27206.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <200910301542.27206.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Jonathan McDowell <noodles@earth.li>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Imre Deak <imre.deak@nokia.com>, linux-fbdev-devel@lists.sourceforge.net

Hello Janusz et al,

On Fri, 30 Oct 2009, Janusz Krzysztofik wrote:

> More looking at it, I found that might be omap_dma_running() from 
> arch/arm/plat-omap/dma.c that needs correction. It already checks for LCD dma 
> running for OMAP1610, but does nothing similiar for 1510. I have revisited 
> http://focus.ti.com/lit/ug/spru674/spru674.pdf, but found no hint how to do 
> that in a 1610 similiar way.

Speaking of this code, here's a project suggestion if someone has some 
spare time.  All of the LCD DMA code in plat-omap/dma.c appears to be 
OMAP1-only (and apparently only is available on a subset of OMAP1 chips).  
It would be great if this code could be moved to mach-omap1/lcd_dma.c or 
a similar place.


- Paul
