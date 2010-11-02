From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 02 Nov 2010 10:47:28 +0000
Subject: [PATCH 0/4 v2] E-EDID for framebuffer and sh-mobile HDMI
Message-Id: <Pine.LNX.4.64.1011021135080.4552@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This is v2 of the patch series, that adds support for E-EDID parsing to 
the framebuffer subsystem and extends the sh_mobile_hdmi driver to use it. 
The first patch is unmodified patch from Erik Gilling, included here only 
for completeness. Fixes, that Andrew suggested (thanks again) and I 
proposed for it are included in the second incremental patch. Since the 
discussion on the fbdev mailing list, concerning where and how to 
implement this functionality to be able to share it between framebuffer 
and DRM drivers, I decided to continue implementing this locally under 
drivers/video for the beginning, later we can certainly discuss how to 
further improve and share this and other common functionality between the 
two subsystems. Comments, as usual, welcome.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

