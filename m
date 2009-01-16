From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 0/4 v6] i.MX31: dmaengine and framebuffer drivers
Date: Fri, 16 Jan 2009 11:09:54 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0901161106100.4940@axis700.grange>
References: <Pine.LNX.4.64.0812261714290.4895@axis700.grange>
 <e9c3a7c20901051143m37c0d7c0x5779475ddc7c5dc2@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932124AbZAPKKV@vger.kernel.org>
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
> 
> I can take patches 1 and 2 through the async_tx tree, or if you would
> rather, add my Acked-by to those and take 1-4 through the MXC tree.
> I'll be sending the async_tx pull request for 2.6.29 in the next few
> days.

Ok, let's do it this way: Sascha has acked version 8 of patches 2 and 3. 
And there seems to be no active framebuffer maintainer ATM. So, maybe you 
could take patches 1-3 into your tree, so they are exposed to the public, 
people have easier access to them in case they want to test (I had several 
requests), and you update them in case you change async-tx API again:-) It 
would be good to try and push them in for 2.6.29 - these are new drivers, 
so, might still be possible to convince Andrew / Linus, if not, you could 
keep them in your tree (and in next) until 2.6.30, then we'd add platform 
bindings and the camera driver. What do you think?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
