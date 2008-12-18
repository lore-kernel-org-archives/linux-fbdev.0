From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/4 v4] i.MX31: dmaengine and framebuffer drivers
Date: Thu, 18 Dec 2008 14:26:02 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812181406000.5510@axis700.grange>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753390AbYLRN0I@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.arm.linux.org.uk, Dan Williams <dan.j.williams@intel.com>

Hi,

This is version 4 of dmaengine and framebuffer drivers for i.MX31.

Changes since version 3: fixed idmac_issue_pending() to not reset the 
current buffer, fixed return value from idmac_tx_submit(), fixed 
framebuffer panning.

Changes since version 2: now uses a tasklet to clean up completed 
transaction descriptors, as suggested by Dan Williams.

Changes since version 1: rebased on the updated dmaengine framework.

I'd really like to get this in for 2.6.29, so, please, review and comment.

Based on linux-next as of commit f0e0e8954d03b414927650a6129ace01d554afdc.

Thanks
Guennadi
---
Guennadi Liakhovetski
