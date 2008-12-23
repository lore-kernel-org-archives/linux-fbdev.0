From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/4 v4] i.MX31: Image Processing Unit DMA and IRQ drivers
Date: Tue, 23 Dec 2008 17:33:11 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812231727460.5188@axis700.grange>
References: <20081218225834.GJ20756@pengutronix.de>
 <Pine.LNX.4.64.0812221240210.5241@axis700.grange> <20081222183753.GD1614@pengutronix.de>
 <Pine.LNX.4.64.0812221942480.7796@axis700.grange> <20081223105006.GE1614@pengutronix.de>
 <Pine.LNX.4.64.0812231157180.5188@axis700.grange> <20081223125015.GG1614@pengutronix.de>
 <Pine.LNX.4.64.0812231359030.5188@axis700.grange> <20081223140320.GH1614@pengutronix.de>
 <Pine.LNX.4.64.0812231529080.5188@axis700.grange> <20081223160942.GJ1614@pengutronix.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752771AbYLWQdS@vger.kernel.org>
In-Reply-To: <20081223160942.GJ1614@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk, Dan Williams <dan.j.williams@intel.com>

On Tue, 23 Dec 2008, Sascha Hauer wrote:

> You're still not getting it. Consider an implementation of the chained
> interrupt handler like this:
> 
> static struct ipu_irq_bank irq_bank_fn[IPU_IRQ_NR_FN_BANKS] = {
>         {
>                 .nr_irqs        = 1,	/* IDMAC EOF and NF irq */
>         }, {
>                 .nr_irqs        = 24,	/* misc interrupts the IPU is not
> 					 * interested in, but clients drivers
> 					 * may be.
> 					 */
>         },
> };
> 
> static struct ipu_irq_bank irq_bank_err[IPU_IRQ_NR_ERR_BANKS] = {
>         /* 2 groups of error interrupts */
>         {
>                 .nr_irqs        = 1,	/* IDMAC channel error irq */
>         }, {
>                 .nr_irqs        = 17,	/* misc interrupts the IPU is not
>                                          * interested in, but clients drivers
>                                          * may be.
>                                          */
>         },
> };
> 
> /* Chained IRQ handler for IPU error interrupt */
> static void ipu_irq_err(unsigned int irq, struct irq_desc *desc)
> {
>         struct ipu *ipu = get_irq_data(irq);
>         u32 status;
>         int i, line;
> 
> 	/* These interrupts are handled exclusively by the IPU code */
> 	if (ipu_read_reg(ipu, IPU_INT_STAT_4))
> 		generic_handle_irq(IPU_IRQ);
> 
> 	status = ipu_read_reg(ipu, IPU_INT_STAT_5);
>         while ((line = ffs(status))) {
>                 status &= ~(1UL << (line - 1));
>                 generic_handle_irq(irq_bank_err[i].irq_base + line - 1);
>         }
> }
> 
> /* Chained IRQ handler for IPU function interrupt */
> static void ipu_irq_fn(unsigned int irq, struct irq_desc *desc)
> {
>         struct ipu *ipu = get_irq_data(irq);
>         u32 status;
>         int i, line;
> 
>         /* These interrupts are handled exclusively by the IPU code */
>         if (ipu_read_reg(ipu, IPU_INT_STAT_1) || ipu_read_reg(ipu, IPU_INT_STAT_2))
>                 generic_handle_irq(IPU_ERR_IRQ);
> 
>         status = ipu_read_reg(ipu, IPU_INT_STAT_3);
>         while ((line = ffs(status))) {
>                 status &= ~(1UL << (line - 1));
>                 generic_handle_irq(irq_bank_err[i].irq_base + line - 1);
>         }
> }
> 
> 
> and in ipu_idmac.c:
> 
> request_irq(IPU_ERR_IRQ, &ipu_err_handler);
> request_irq(IPU_IRQ, &ipu_irq);

These all are just slightly different variations - with this one you'd 
have to scan dma channels in your dma irq handler, which I currently don't 
have to do.

> That said I'm not sure whether we need a chained interrupt handler at all.
> Looking at the remaining interrupts it seems that for example the
> CSI_EOF (IPU_INT_STAT3 bit 5) interrupt is redundant to the corresponding
> channels interrupt. In the camera driver you already realized that it's
> the dma end event you're interested in, not the CSI_EOF event. Not sure
> if that holds for the other interrupts though.

I think the version with a lookup table is optimal - it uses standard 
mechanisms for irq handling and doesn't waste RAM. The disadvantage - 
every addition will need driver modification...

But ok, this is taking way too long. Just tell me which way you'd like to 
have it and I'll do it.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
