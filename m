From: Lynn Lei <lynnl.wit@gmail.com>
Date: Sun, 02 Jul 2017 23:14:54 +0000
Subject: [PATCH] staging: sm750fb: coordinate conditional compilation
Message-Id: <20170702231454.GA5545@lynnl.wit>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

coordinate conditional compilation with g_dcftSupportedDviController[]

fix exceed-80-characters issue

Signed-off-by: Lynn Lei <lynnl.wit@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 171ae063f06f..c4f329c2f1ed 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -42,14 +42,19 @@ int dviInit(
 	unsigned char pllFilterValue
 			)
 {
+#ifdef DVI_CTRL_SII164
 	dvi_ctrl_device_t *pCurrentDviCtrl;
 
 	pCurrentDviCtrl = g_dcftSupportedDviController;
-	if (pCurrentDviCtrl->pfnInit) {
-		return pCurrentDviCtrl->pfnInit(edgeSelect, busSelect, dualEdgeClkSelect, hsyncEnable,
-						vsyncEnable, deskewEnable, deskewSetting, continuousSyncEnable,
-						pllFilterEnable, pllFilterValue);
-	}
+
+	return pCurrentDviCtrl->pfnInit(
+		edgeSelect, busSelect, dualEdgeClkSelect,
+		hsyncEnable, vsyncEnable, deskewEnable,
+		deskewSetting, continuousSyncEnable,
+		pllFilterEnable, pllFilterValue
+	);
+#endif
+
 	return -1; /* error */
 }
 
-- 
2.13.2

