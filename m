From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 25 Sep 2013 09:36:12 +0000
Subject: [patch 2/2] backlight: lm3630: potential NULL deref in probe()
Message-Id: <20130925093612.GR6192@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130925085549.GB6661@elgon.mountain>
In-Reply-To: <20130925085549.GB6661@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We dereference "pdata" later in the function so we can't leave it as
NULL.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Jingoo Han <jg1.han@samsung.com>

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 65392f9..6146481 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -389,22 +389,21 @@ static int lm3630a_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, pchip);
 	if (pdata = NULL) {
-		pchip->pdata = devm_kzalloc(pchip->dev,
-					    sizeof(struct
-						   lm3630a_platform_data),
-					    GFP_KERNEL);
-		if (pchip->pdata = NULL)
+		pdata = devm_kzalloc(pchip->dev,
+				     sizeof(struct lm3630a_platform_data),
+				     GFP_KERNEL);
+		if (pdata = NULL)
 			return -ENOMEM;
 		/* default values */
-		pchip->pdata->leda_ctrl = LM3630A_LEDA_ENABLE;
-		pchip->pdata->ledb_ctrl = LM3630A_LEDB_ENABLE;
-		pchip->pdata->leda_max_brt = LM3630A_MAX_BRIGHTNESS;
-		pchip->pdata->ledb_max_brt = LM3630A_MAX_BRIGHTNESS;
-		pchip->pdata->leda_init_brt = LM3630A_MAX_BRIGHTNESS;
-		pchip->pdata->ledb_init_brt = LM3630A_MAX_BRIGHTNESS;
-	} else {
-		pchip->pdata = pdata;
+		pdata->leda_ctrl = LM3630A_LEDA_ENABLE;
+		pdata->ledb_ctrl = LM3630A_LEDB_ENABLE;
+		pdata->leda_max_brt = LM3630A_MAX_BRIGHTNESS;
+		pdata->ledb_max_brt = LM3630A_MAX_BRIGHTNESS;
+		pdata->leda_init_brt = LM3630A_MAX_BRIGHTNESS;
+		pdata->ledb_init_brt = LM3630A_MAX_BRIGHTNESS;
 	}
+	pchip->pdata = pdata;
+
 	/* chip initialize */
 	rval = lm3630a_chip_init(pchip);
 	if (rval < 0) {
--
To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
