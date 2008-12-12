From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/4 v3] i.MX31: dmaengine and framebuffer drivers
Date: Fri, 12 Dec 2008 17:48:52 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812121740240.6411@axis700.grange>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759279AbYLLQs5@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.arm.linux.org.uk, Dan Williams <dan.j.williams@intel.com>

Hi,

This is version 3 of dmaengine and framebuffer drivers for i.MX31.

Changes since version 2: now uses a tasklet to clean up completed 
transaction descriptors, as suggested by Dan Williams.

Changes since version 1: rebased on the updated dmaengine framework.

Thanks
Guennadi
---
Guennadi Liakhovetski
