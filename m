From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 24 Jan 2012 10:45:17 +0000
Subject: [PATCH 0/3]: ARM: OMAP2/3: HWMOD fixes for DSS
Message-Id: <1327401920-5617-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, paul@pwsan.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

There are some sysconfig flags missing for OMAP2/3 DSS hwmods. This series adds
those.

This series is based on the earlier series "[PATCH 0/3] OMAP: DSS PM fixes",
but is sent separately here as the first series is inteded to go into the next
rc, and this can be left to next merge window.

Tested on OMAP3 Overo. I don't have OMAP3 DSI or RFBI boards, so I haven't been
able to test those.

 Tomi

Tomi Valkeinen (3):
  ARM: OMAP2/3: HWMOD: Add missing flags for dispc class
  ARM: OMAP2/3: HWMOD: Add missing flag for rfbi class
  ARM: OMAP3: HWMOD: Add omap_hwmod_class_sysconfig for dsi

 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    3 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   15 ++++++++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

-- 
1.7.4.1

