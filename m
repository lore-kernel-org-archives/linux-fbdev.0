From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 08 Jul 2010 14:12:47 +0000
Subject: [PATCH 0/6 v2] fbdev: sh-mobile: HDMI support for SH-Mobile SoCs
Message-Id: <Pine.LNX.4.64.1007081417340.32100@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch set adds a static HDMI support to SH-Mobile SoCs, specifically, 
to sh7372 (ap4evb) in this version. "Static" means only 720p is supported 
ATM. Also hotplug support is implemented without changing the framebuffer 
geometry. Dynamic geometry reconfiguration is planned for a future patch.

This series now depends on an arm-shmobile runtime PM RFC patch from 
Magnus with my incremental patch to it [1].

Thanks
Guennadi

[1] http://thread.gmane.org/gmane.linux.ports.sh.devel/8457

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
