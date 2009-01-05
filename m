From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 0/4 v6] i.MX31: dmaengine and framebuffer drivers
Date: Mon, 5 Jan 2009 22:02:47 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0901052139400.8605@axis700.grange>
References: <Pine.LNX.4.64.0812261714290.4895@axis700.grange>
 <e9c3a7c20901051143m37c0d7c0x5779475ddc7c5dc2@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754732AbZAEVDC@vger.kernel.org>
In-Reply-To: <e9c3a7c20901051143m37c0d7c0x5779475ddc7c5dc2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.arm.linux.org.uk, Geert Uytterhoeven <geert@linux-m68k.org>

On Mon, 5 Jan 2009, Dan Williams wrote:

> On Fri, Dec 26, 2008 at 10:11 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Hi,
> >
> > This is version 6 of dmaengine and framebuffer drivers for i.MX31.
> >
> 
> Tha drivers/dma/ bits look ok to me minus the new warnings:
> 
> drivers/dma/ipu/ipu_irq.c: In function 'ipu_irq_fn':
> drivers/dma/ipu/ipu_irq.c:328: warning: 'irq' may be used
> uninitialized in this function
> drivers/dma/ipu/ipu_irq.c: In function 'ipu_irq_err':
> drivers/dma/ipu/ipu_irq.c:290: warning: 'irq' may be used
> uninitialized in this function

Wow... with what gcc version? My 4.1.2 correctly recognises, that it 
_doesn't_ get used uninitialised.

> I can take patches 1 and 2 through the async_tx tree, or if you would
> rather, add my Acked-by to those and take 1-4 through the MXC tree.
> I'll be sending the async_tx pull request for 2.6.29 in the next few
> days.

Thanks, great! Don't know what's better, let's see what Sascha says. But 
there's one small problem with the patch 2/4: it breaks compilation on 
i.MX31 if IPU is _not_ set, so, default imx31 configs would break:-( The 
problem is, that I use CONFIG_MX3_IPU_IRQS unconditionally in calculation 
of NR_IRQ. The easiest for me is to fix it in mx31.h like

#ifdef CONFIG_MX3_IPU_IRQS
#define MX3_IPU_IRQS CONFIG_MX3_IPU_IRQS
#else
#define MX3_IPU_IRQS 0
#endif

but that's less than elegant:-) A probably better solution would be to fix 
this in Kconfig, best would be to show

config MX3_IPU_IRQS
	int "..."

if MX3_IPU is set and hide it otherwise, setting to 0... But I don't know 
off hand how to do this properly. Hm, looks like the following works:

config MX3_IPU_IRQS
	int "Number of dynamically mapped interrupts for IPU"
	depends on MX3_IPU
	range 2 137
	default 4
	help
	  Out of 137 interrupt sources on i.MX31 IPU only very few are used.
	  To avoid bloating the irq_desc[] array we allocate a sufficient
	  number of IRQ slots and map them dynamically to specific sources.

config MX3_IPU_IRQS
	int
	default 0
	depends on !MX3_IPU

Would it be considered a proper Kbuild (ab)use?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
