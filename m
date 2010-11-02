From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 02 Nov 2010 11:27:10 +0000
Subject: [PATCH 0/4 v2] implement HDMI clock rate optimization
Message-Id: <Pine.LNX.4.64.1011021207050.4552@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This is a further improvement of HDMI quality on sh-mobile, by improving 
clock precision. Currently on ap4evb PLLC2 is used as HDMI clock parent, 
clocked at 594MHz, which provides exact 74.25MHz, required for 720p, when 
divided through 8. However, for other video modes other parent clock 
frequencies can provide better precision for the HDMI clock. This patch 
adds necessary platform callbacks to reconfigure the parent clock and 
implements this optimization in the sh clock framework and uses it on 
ap4evb.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
