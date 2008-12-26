From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/4 v6] i.MX31: dmaengine and framebuffer drivers
Date: Fri, 26 Dec 2008 18:11:13 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812261714290.4895@axis700.grange>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753988AbYLZRLU@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.arm.linux.org.uk, Dan Williams <dan.j.williams@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>

Hi,

This is version 6 of dmaengine and framebuffer drivers for i.MX31.

Changes since version 5: as requested by Sascha Hauer switched to dynamic 
IPU IRQ mapping. Instead of statically allocating 137 irq_desc[] elements, 
I provide a configuration variable to specify how many interrupt slots 
should be allocated. The default value is 4, minimum 2, maximum 137. Then 
these slots are used to dynamically map interrupts upon user requests to 
available IRQ numbers. Also removed all traces of overlay framebuffer, and 
removed bogus use of nonstd field from the framebuffer driver, as 
requested by Geert Uytterhoeven. Thanks to all who commented.

Changes since version 4: addressed comments from Sascha Hauer, apart from: 
the idmac driver still uses two locks - a mutex and a spinlock, the "ugly" 
construction like "to_ipu(to_idmac(ichan->dma_chan.device));" is still 
there, still all 144 IRQs are registered. So now the driver is under 
drivers/dma, also fixed all docbook comments.

Changes since version 3: fixed idmac_issue_pending() to not reset the 
current buffer, fixed return value from idmac_tx_submit(), fixed 
framebuffer panning.

Changes since version 2: now uses a tasklet to clean up completed 
transaction descriptors, as suggested by Dan Williams.

Changes since version 1: rebased on the updated dmaengine framework.

Aimed at 2.6.29.

Based on linux-next as of commit f0e0e8954d03b414927650a6129ace01d554afdc.

Thanks
Guennadi
---
Guennadi Liakhovetski
