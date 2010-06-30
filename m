From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 30 Jun 2010 09:55:23 +0000
Subject: [PATCH 0/6] fbdev: sh-mobile: HDMI support for SH-Mobile SoCs
Message-Id: <Pine.LNX.4.64.1006301128310.17489@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch set adds a static HDMI support to SH-Mobile SoCs, specifically, 
to sh7372 (ap4evb) in this version. "Static" means only 720p is supported 
ATM. Also hotplug support is implemented without changing the framebuffer 
geometry. Dynamic geometry reconfiguration is planned for a future patch.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
