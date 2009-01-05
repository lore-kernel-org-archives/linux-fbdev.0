From: "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/4 v6] i.MX31: dmaengine and framebuffer drivers
Date: Mon, 5 Jan 2009 12:43:13 -0700
Message-ID: <e9c3a7c20901051143m37c0d7c0x5779475ddc7c5dc2@mail.gmail.com>
References: <Pine.LNX.4.64.0812261714290.4895@axis700.grange>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755189AbZAETnf@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0812261714290.4895@axis700.grange>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.arm.linux.org.uk, Geert Uytterhoeven <geert@linux-m68k.org>

On Fri, Dec 26, 2008 at 10:11 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Hi,
>
> This is version 6 of dmaengine and framebuffer drivers for i.MX31.
>

Tha drivers/dma/ bits look ok to me minus the new warnings:

drivers/dma/ipu/ipu_irq.c: In function 'ipu_irq_fn':
drivers/dma/ipu/ipu_irq.c:328: warning: 'irq' may be used
uninitialized in this function
drivers/dma/ipu/ipu_irq.c: In function 'ipu_irq_err':
drivers/dma/ipu/ipu_irq.c:290: warning: 'irq' may be used
uninitialized in this function

I can take patches 1 and 2 through the async_tx tree, or if you would
rather, add my Acked-by to those and take 1-4 through the MXC tree.
I'll be sending the async_tx pull request for 2.6.29 in the next few
days.

Thanks,
Dan
