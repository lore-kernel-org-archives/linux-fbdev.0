From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 07 May 2010 09:07:14 +0000
Subject: [PATCH 0/4] MIPI DSI support for SH-mobile, common header, switch
Message-Id: <Pine.LNX.4.64.1005071054510.4777@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

This patch series adds support for the MIPI DSI unit on sh-mobile SoCs, to 
eliminate redundancy a common mipi_dsi.h header is added. The SH-mobile 
part depends on pending clock and INTC patches by Magnus.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
