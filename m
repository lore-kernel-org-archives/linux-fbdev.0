From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/4 v2] i.MX31: dmaengine and framebuffer drivers
Date: Wed, 10 Dec 2008 11:35:53 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812101122250.4578@axis700.grange>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755995AbYLJKgD@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.arm.linux.org.uk, Dan Williams <dan.j.williams@intel.com>

Hi,

this is the second version of the dmaengine and framebuffer for i.MX31 and 
its Image Processing Unit patch-series. Being based on linux-next of 08.12 
it now uses the updated dmaengine API, still, patch 1 adds the discussed 
tx_free link to the descriptor struct. Please, review and comment. I 
understand we have little time left for the next merge window, but as this 
is a new driver, and hence cannot cause regressions, I hope to get it in 
for 2.6.29.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.

DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
