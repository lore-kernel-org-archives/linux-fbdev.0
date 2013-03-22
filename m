From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 22 Mar 2013 16:15:46 +0000
Subject: [PATCH v3 0/3] DT support for AS3711 MFD, regulator and backlight drivers
Message-Id: <1363968949-12151-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>

This is just a split of the previous version of this patch(-set), no code 
changes.

Guennadi Liakhovetski (3):
  mfd: as3711: add OF support
  regulator: as3711: add OF support
  backlight: as3711: add OF support

 Documentation/devicetree/bindings/mfd/as3711.txt |   73 +++++++++++++
 drivers/mfd/as3711.c                             |   27 ++++-
 drivers/regulator/as3711-regulator.c             |   74 +++++++++++++-
 drivers/video/backlight/as3711_bl.c              |  118 +++++++++++++++++++++-
 4 files changed, 284 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/as3711.txt

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
