From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 0/4 v6] i.MX31: dmaengine and framebuffer drivers
Date: Thu, 8 Jan 2009 11:50:48 +0100
Message-ID: <20090108105048.GA8021@pengutronix.de>
References: <Pine.LNX.4.64.0812261714290.4895@axis700.grange>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759441AbZAHKvZ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0812261714290.4895@axis700.grange>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk, Dan Williams <dan.j.williams@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>

Hi Russell et al,

I just had some offline discussion with Guennadi about the chained
interrupt issue in the IPU (image processing unit) driver discussed in
this thread. We came up with several solutions but none of them seems
to be ideal. To sum this up we are talking about 142 interrupt sources
which consist of:

96 DMA channel interrupts (32 channels, 3 interrupts each)
46 misc interrupts which are going to be handled by various client
   drivers such as camera interface and framebuffer.

So far our possible solutions are:

1) handle all 142 interrupts in a chained handler. This involves adding
   of 142 struct irq_desc (implemented in -v1)
2) add a pool of chained interrupt sources and create a virtual mapping
   (implemented in -v6)
3) forget about chained interrupt handlers, handle the 96 channel
   interrupts in a normal interrupt handler and create callbacks for the
   rest. This would create a new API instead of using an existing one.

In a normal system most of these interrupts are unused. For example the
framebuffer needs the 3 interrupts for the corresponding DMA channel and
there is a vsync interrupt which is currently unused.

Russell, I would be glad if you could comment on this so that we come up
with a solution acceptable for mainline.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
