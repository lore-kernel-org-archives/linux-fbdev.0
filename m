From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Oct 2010 07:53:44 +0000
Subject: [PATCH 0/4] fbdev: sh: "video=" command line parsing, improved HDMI
Message-Id: <Pine.LNX.4.64.1010150942270.3945@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi

Another round of SH-HDMI improvements. Tests showed, that the best result 
is achieved with the 720p format on HDMI, to override that users are given 
a possibility to use the "video=sh_mobile_lcdc:..." kernel command line to 
specified a preferred video-mode.

Paul, since one of the patches touches the ap4evb board, it's better to 
push this via genesis.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
