From: "H. Nikolaus Schaller" <hns@goldelico.com>
Date: Wed, 08 Nov 2017 21:09:28 +0000
Subject: [PATCH 0/4] Fixes for omapdrm on OpenPandora and GTA04
Message-Id: <cover.1510175371.git.hns@goldelico.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sean Paul <seanpaul@chromium.org>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, kernel@pyra-handheld.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This patch set fixes vendor names of the panels
and fixes a problem on omapdrm with enabling
VDD_DSI for OMAP3 which is needed for displaying
the Red and Green channel on OMAP3530 (Pandora).

H. Nikolaus Schaller (4):
  omapdrm: fix compatible string for td028ttec1
  DTS: GTA04: fix panel compatibility string
  DTS: Pandora: fix panel compatibility string
  omapdss: fix problem enabling VDDS_DSI on OMAP3530 (OpenPandora)

 .../display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt}      | 4 ++--
 arch/arm/boot/dts/omap3-gta04.dtsi                                    | 2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi                           | 2 +-
 drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c               | 4 ++--
 drivers/gpu/drm/omapdrm/dss/dpi.c                                     | 3 +--
 drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c      | 4 ++--
 6 files changed, 9 insertions(+), 10 deletions(-)
 rename Documentation/devicetree/bindings/display/panel/{toppoly,td028ttec1.txt => tpo,td028ttec1.txt} (84%)

-- 
2.12.2

