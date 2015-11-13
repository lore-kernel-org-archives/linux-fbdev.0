From: "H. Nikolaus Schaller" <hns@goldelico.com>
Date: Fri, 13 Nov 2015 10:29:06 +0000
Subject: [PATCH 0/2] Fix omap VENC (PAL/NTSC TV out) operation with omapdrm driver
Message-Id: <cover.1447410543.git.hns@goldelico.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Airlie <airlied@linux.ie>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, gta04-owner@goldelico.com, notasas@gmail.com, "H. Nikolaus Schaller" <hns@goldelico.com>

This patch set fixes some issues with the OMAP VENC
when used with the omapdrm driver.

Tested on: BeagleBoard XM, GTA04 and OpenPandora


H. Nikolaus Schaller (2):
  video:omap2:dss: fix timings for VENC to match what omapdrm expects
  video:omapdrm: make omapdrm assume the tv-out cable is always
    connected

 drivers/gpu/drm/omapdrm/omap_connector.c |  1 +
 drivers/video/fbdev/omap2/dss/venc.c     | 12 ++++++++++++
 2 files changed, 13 insertions(+)

-- 
2.5.1

