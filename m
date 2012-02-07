From: Grazvydas Ignotas <notasas@gmail.com>
Date: Tue, 07 Feb 2012 00:13:50 +0000
Subject: [PATCH] OMAP: DSS2: TPO-TD03MTEA1: update default gamma
Message-Id: <1328573630-7348-2-git-send-email-notasas@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1328573630-7348-1-git-send-email-notasas@gmail.com>
In-Reply-To: <1328573630-7348-1-git-send-email-notasas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

Over time better gamma has been determined and tuned with some
equipment so update the defaults. From subjective point of view
dark shades should be better visible.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index 741e9d7..d63e5e5 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -47,7 +47,7 @@
 			TPO_R03_EN_PRE_CHARGE | TPO_R03_SOFTWARE_CTL)
 
 static const u16 tpo_td043_def_gamma[12] = {
-	106, 200, 289, 375, 460, 543, 625, 705, 785, 864, 942, 1020
+	105, 315, 381, 431, 490, 537, 579, 686, 780, 837, 880, 1023
 };
 
 struct tpo_td043_device {
-- 
1.7.0.4

