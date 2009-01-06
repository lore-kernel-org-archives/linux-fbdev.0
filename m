From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 0/4 v6] i.MX31: dmaengine and framebuffer drivers
Date: Tue, 6 Jan 2009 10:04:22 +0100
Message-ID: <20090106090422.GC18861@pengutronix.de>
References: <Pine.LNX.4.64.0812261714290.4895@axis700.grange>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753880AbZAFJEq@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0812261714290.4895@axis700.grange>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk, Dan Williams <dan.j.williams@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>

Hi Guennadi,

On Fri, Dec 26, 2008 at 06:11:13PM +0100, Guennadi Liakhovetski wrote:
> Hi,
> 
> This is version 6 of dmaengine and framebuffer drivers for i.MX31.
> 
> Changes since version 5: as requested by Sascha Hauer switched to dynamic 
> IPU IRQ mapping.

I tried to express that it's really odd that you demux your _internal_
interrupts as chained handlers. Consider a network driver which has a
rx, tx and an error status bit, all of them can trigger an interrupt. A
you aware of a single driver that uses chained interrupts for this
case?
No, they don't have to, because all this happens inside one driver
and this can easily be dispatched in one interrupt handler. IMHO chained
interrupts only make sense when you have an interrupt source which
leaves your driver code and you don't know who might be interested in,
like the assorted non channel interrupts the IPU also provides.

I bet you'd never have the idea for such a code design without the
Freescale code as a sample.

Note that arch/arm/plat-mxc/include/mach/mx31.h does not apply anymore
due to upstream changes.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
