From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 28 May 2010 10:25:05 +0000
Subject: q: monitor hotplug with fbdev?
Message-Id: <Pine.LNX.4.64.1005281208120.32352@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi all

What's the correct driver behaviour on detected monitor unplu / replug 
events? Possibly, of a different monitor, maybe with a different 
resolution? I see an attempt to support this in the via FB driver, but 
that hot-plug rather reminds some kind of a cold-plug: it is triggered by 
a VIA-specific ioctl. Even DRM/KMS subsystem doesn't seem to be doing much 
upon such hotplug events to inform /dev/fb* users?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
