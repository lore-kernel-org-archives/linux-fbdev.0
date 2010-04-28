From: Jonathan Corbet <corbet@lwn.net>
Date: Wed, 28 Apr 2010 22:17:07 +0000
Subject: [PATCH 06/30] viafb: Determine type of 2D engine and store it in chip_info
Message-Id: <1272493051-25380-7-git-send-email-corbet@lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272493051-25380-1-git-send-email-corbet@lwn.net>
In-Reply-To: <1272493051-25380-1-git-send-email-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Harald Welte <laforge@gnumonks.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

From: Harald Welte <laforge@gnumonks.org>

This will help us for the upcoming support for 2D acceleration using
the M1 engine.

[jc: fixed merge conflicts]
Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
---
 drivers/video/via/chip.h |    8 ++++++++
 drivers/video/via/hw.c   |   15 +++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/video/via/chip.h b/drivers/video/via/chip.h
index 8c06bd3..d9b6e06 100644
--- a/drivers/video/via/chip.h
+++ b/drivers/video/via/chip.h
@@ -121,9 +121,17 @@ struct lvds_chip_information {
 	int i2c_port;
 };
 
+/* The type of 2D engine */
+enum via_2d_engine {
+	VIA_2D_ENG_H2,
+	VIA_2D_ENG_H5,
+	VIA_2D_ENG_M1,
+};
+
 struct chip_information {
 	int gfx_chip_name;
 	int gfx_chip_revision;
+	enum via_2d_engine twod_engine;
 	struct tmds_chip_information tmds_chip_info;
 	struct lvds_chip_information lvds_chip_info;
 	struct lvds_chip_information lvds_chip_info2;
diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index c94bcce..ae664fb 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -2016,6 +2016,21 @@ static void init_gfx_chip_info(struct pci_dev *pdev,
 				CX700_REVISION_700;
 		}
 	}
+
+	/* Determine which 2D engine we have */
+	switch (viaparinfo->chip_info->gfx_chip_name) {
+	case UNICHROME_VX800:
+	case UNICHROME_VX855:
+		viaparinfo->chip_info->twod_engine = VIA_2D_ENG_M1;
+		break;
+	case UNICHROME_K8M890:
+	case UNICHROME_P4M900:
+		viaparinfo->chip_info->twod_engine = VIA_2D_ENG_H5;
+		break;
+	default:
+		viaparinfo->chip_info->twod_engine = VIA_2D_ENG_H2;
+		break;
+	}
 }
 
 static void init_tmds_chip_info(void)
-- 
1.7.0.1

