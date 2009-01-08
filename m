From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/4 v8] i.MX31: dmaengine and
	framebuffer drivers
Date: Thu, 8 Jan 2009 19:04:04 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0901081850280.6387@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <g.liakhovetski@gmx.de>) id 1LKzEh-0005iq-HF
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Jan 2009 18:04:03 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 1b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1LKzEd-0005NX-Q4 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Jan 2009 18:04:03 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net, Dan Williams <dan.j.williams@intel.com>, adaplas@gmail.com, linux-kernel@vger.kernel.org

Hi,

This is version 8 of dmaengine and framebuffer drivers for i.MX31.

Changes since version 7: updated to today's Linus git with pulled patches 
from async_tx tree (dmaengine)

Changes since version 6: fixed compiler warnings, compilation breakage for 
CONFIG_MX3_IPU not defined

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

Based on Linus' git commit 9e42d0cf5020aaf217433cad1a224745241d212a
plus git://git.kernel.org/pub/scm/linux/kernel/git/djbw/async_tx.git next

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer

------------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It is the best place to buy or sell services for
just about anything Open Source.
http://p.sf.net/sfu/Xq1LFB
