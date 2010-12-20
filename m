From: Dzianis Kahanovich <mahatma@bspu.unibel.by>
Date: Mon, 20 Dec 2010 19:16:14 +0000
Subject: [PATCH] viafb: fix viafb_find_i2c_adapt return value
Message-Id: <4D0FAB7E.1080704@bspu.unibel.by>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

viafb_find_i2c_adapt return unverifyed value, "is_active" field still uplevel.
Fix it.

Signed-off-by: Dzianis Kahanovich <mahatma@eu.by>
---
--- a/drivers/video/via/via_i2c.c	2010-12-18 06:42:37.000000000 +0200
+++ b/drivers/video/via/via_i2c.c	2010-12-20 19:55:17.000000000 +0200
@@ -188,7 +188,7 @@ struct i2c_adapter *viafb_find_i2c_adapt
 {
 	struct via_i2c_stuff *stuff = &via_i2c_par[which];

-	return &stuff->adapter;
+	return stuff->is_active ? &stuff->adapter : NULL;
 }
 EXPORT_SYMBOL_GPL(viafb_find_i2c_adapter);

--

