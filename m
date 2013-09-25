From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 25 Sep 2013 09:35:33 +0000
Subject: [patch 1/2] backlight: lm3630: signedness bug in lm3630a_chip_init()
Message-Id: <20130925093533.GQ6192@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130925085451.GA6661@elgon.mountain>
In-Reply-To: <20130925085451.GA6661@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

"rval" needs to be signed for the error handling to work.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Jingoo Han <jg1.han@samsung.com>

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index c63f918..65392f9 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -105,7 +105,7 @@ static int lm3630a_chip_init(struct lm3630a_chip *pchip)
 /* interrupt handling */
 static void lm3630a_delayed_func(struct work_struct *work)
 {
-	unsigned int rval;
+	int rval;
 	struct lm3630a_chip *pchip;
 
 	pchip = container_of(work, struct lm3630a_chip, work.work);
--
To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
