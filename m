From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 03 Sep 2010 07:19:45 +0000
Subject: [PATCH 00/15] ARM: mach-shmobile: HDMI hot-plug and improvements
Message-Id: <Pine.LNX.4.64.1009030856020.2883@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The main purpose of this patch set is supporting dynamic framebuffer 
reconfiguration upon monitor hot-plug. The good thing is - it works. The 
not so good thing is - only to the extent, that the current fbdev API 
allows. Specifically, there is currently no possibility under the fbdev 
API to inform framebuffer users about a changed framebuffer configuration, 
as can easily be the case, when a new monitor has been plugged in. It is, 
however, possible to inform in-kernel framebuffer users, e.g., the fbcon 
console, about such a change, using framebuffer notifications. This patch 
series implements support for monitor hot-plug on the hardware level, 
i.e., the LCD and HDMI controllers get reconfigured for a new device. The 
user configuration remains untouched. With this approach with a new 
monitor plugged in, the user either gets to see the upper left corner of 
the framebuffer image, or the whole framebuffer will be displayed in the 
upper left corner of the display.

The patch series also contains a number of improvements to both the lcdc 
and hdmi SH-Mobile drivers.

Based on the current (commit 410d878b) genesis-2.6/master tree.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
