From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 29 Dec 2010 08:12:18 +0000
Subject: [PATCH 0/3] fbdev: make the sh-mobile MIPI DSI driver more flexible
Message-Id: <Pine.LNX.4.64.1012290859290.14233@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

These patches teach the sh-mobile MIPI DSI driver to use platform data to 
support different SoC with register layout variations and different LCD 
panels. Two of these patches affect the actual driver and one - currently 
its only user - the ap4evb board. To avoid compilation and run-time 
regressions we have to first add new gields to the header, then set them 
in the affected platform, and only then modify the driver to use them. 
This produces an unpleasant dependency chain. Alternatively, all these 
patches could be merged into one, but that would span multiple subsystems. 
I leave it to the maintainer to decide:)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
