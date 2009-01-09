From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 0/4 v8] i.MX31: dmaengine and framebuffer drivers
Date: Fri, 9 Jan 2009 09:27:01 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0901090922530.4848@axis700.grange>
References: <Pine.LNX.4.64.0901081850280.6387@axis700.grange>
 <20090109081719.GB2020@pengutronix.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755553AbZAII1R@vger.kernel.org>
In-Reply-To: <20090109081719.GB2020@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Dan Williams <dan.j.williams@intel.com>, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-kernel@vger.kernel.org

On Fri, 9 Jan 2009, Sascha Hauer wrote:

> On Thu, Jan 08, 2009 at 07:04:04PM +0100, Guennadi Liakhovetski wrote:
> > Hi,
> > 
> > This is version 8 of dmaengine and framebuffer drivers for i.MX31.
> 
> Does this depend on some other patch? It does not compile:
> 
> drivers/dma/ipu/ipu_idmac.c: In function 'idmac_tx_submit':
> drivers/dma/ipu/ipu_idmac.c:851: error: invalid type argument of '->'
> drivers/dma/ipu/ipu_idmac.c:851: error: invalid type argument of '->'
> drivers/dma/ipu/ipu_idmac.c: In function 'idmac_alloc_chan_resources':
> drivers/dma/ipu/ipu_idmac.c:1490: error: invalid type argument of '->'
> drivers/dma/ipu/ipu_idmac.c:1490: error: invalid type argument of '->'
> drivers/dma/ipu/ipu_idmac.c: In function 'ipu_idmac_init':
> drivers/dma/ipu/ipu_idmac.c:1547: error: 'DMA_PRIVATE' undeclared (first use in this function)
> drivers/dma/ipu/ipu_idmac.c:1547: error: (Each undeclared identifier is reported only once
> drivers/dma/ipu/ipu_idmac.c:1547: error: for each function it appears in.)
> drivers/dma/ipu/ipu_idmac.c:1551: warning: assignment from incompatible pointer type

A quote from the message you're replying to:

> > Changes since version 7: updated to today's Linus git with pulled patches 
> > from async_tx tree (dmaengine)

and later

> > Based on Linus' git commit 9e42d0cf5020aaf217433cad1a224745241d212a
> > plus git://git.kernel.org/pub/scm/linux/kernel/git/djbw/async_tx.git next

So, yes, you have to pull that tree, there are a few patches there...

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
