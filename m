From: Hannes Eder <hannes@hanneseder.net>
Subject: [PATCH v2 11/15] NULL noise: drivers/video/via/hw.c
Date: Thu, 05 Mar 2009 20:16:50 +0100
Message-ID: <20090305191646.30062.6857.stgit@f10box.hanneseder.net>
References: <20090305190954.30062.44759.stgit@f10box.hanneseder.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757911AbZCETSS@vger.kernel.org>
In-Reply-To: <20090305190954.30062.44759.stgit@f10box.hanneseder.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: trivial@kernel.org
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Fix this sparse warning:
  drivers/video/via/hw.c:2020:46: warning: Using plain integer as NULL pointer

Signed-off-by: Hannes Eder <hannes@hanneseder.net>
---
v2: other subject, as suggested by Al Viro

 drivers/video/via/hw.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index fcd53ce..70d6b6c 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -2017,7 +2017,7 @@ static void init_gfx_chip_info(void)
 	/* Indentify GFX Chip Name */
 	for (i = 0; pciidlist[i].vendor != 0; i++) {
 		pdev = pci_get_device(pciidlist[i].vendor,
-			pciidlist[i].device, 0);
+			pciidlist[i].device, NULL);
 		if (pdev)
 			break;
 	}
