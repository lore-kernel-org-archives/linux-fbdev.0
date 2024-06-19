Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C6B15886B
	for <linux-fbdev@vger.kernel.org>; Wed, 19 Jun 2024 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718825773; cv=none; b=U94ZYCd3BUJ8bizBGyFBZ1R0k3gpr8extpqgNfZZv1GElYw5cTw3PWQOGTfInl8U1R7CR2qW25gJqNh4opS/l+jtXzlheL0POmBUzfnT4rs4Pbp7O+4avCDoSdZ8+IcFrzpoPvdU6dZ2pH/ScyzzJBzAIpH0jueD1PXZ/QD0Ebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718825773; c=relaxed/simple;
	bh=b6KdZZ9MVHXlW6Kzlm1yP66Bz8tcUOfRhuVRKx4scF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o0CCV/5hq+IiwDuwNlrfCKkCxf0S6r0h1xpTyTkZcsr+08Z/xH/BiJmwxY/GyPTjkIoFRgEhiYTlFLbOHupDoplxhzq98uJbREIkOHe63tbSR9Wk+LR9HAXi51KjBOZGHij5ZCmtHFJhnR6HKvMPabAGSCm+6WeS1nLHgOvK5rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pf774buo; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pf774buo"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f11a2d18aso11299466b.2
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Jun 2024 12:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718825768; x=1719430568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vnLZjzsiZJ7wwEMZFq71NfmdNt4xwTT/ZS6jS7RPwME=;
        b=pf774buo4m0BBEzx/ciencbovn0EECfbMXFrORG8KoJng/yxCZXKLirumtEErdubfm
         Zpsts3AroP1ZezlxAzSf7ego/3eaKRJoLEAON8NBMRaL3u3CVdnHkKEIU60edojqOABN
         WHfUYjnzvuJG5pva1rtCBMGGrLGieYoN9ZYk09YkMO5G2s/pgwkpKbq3rf0nPfIg/eOJ
         A/w8WZXc9ljsQDrW/It+woeE0Y1Y7tPrAKudgV3ceb5ahJeG/eoLaYl2ZH9mu/8HYn1H
         KI+vdaek4hYRVV56o3Z2BOxmVj6x2zGwxwM+5mSjQTko24yD+etgSfhlKZ9eAmUty6uK
         AI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718825768; x=1719430568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnLZjzsiZJ7wwEMZFq71NfmdNt4xwTT/ZS6jS7RPwME=;
        b=WqcnaayMuAiH+hY5+yNgpOF7wmU1S2wxQcFucgq/Q6LIZdYcXYEDp5mQJoDMA7K1nk
         lRNzg17bOGpRvW3tUXK1D7yrnInU52pDmBAcTcil34ChaSiagBYJEIlQc6SamFTGn4u9
         4qBVpcRfQ5Gt4i53eCNs5VDKT7A423dTRsa3jpYynGnHo5rfHbcDhVeji1xkHL3igCmu
         F/kI2DHHAsX1823PmHP7Z+Sx0BANNYVWZAXMZbwSokrEOHEPAh6P4apf2aVPyzFXgCcY
         iRbAzg/UszW1KJIeKa5lEP0NT9JtkZ/7aP6jepQzOPX2dFF4mZPY561YDrWvcrcD2Lzu
         k0rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkQnyDSPXj0ly6/8Tfbx6JfwBp9W9VmCWy0QwENIvTcGhav74jUwt+6JmYSX58Ely3RBTgHX9hsh6jv6XmyeCvq2mGiz7Xh34EjsA=
X-Gm-Message-State: AOJu0YwM2B/XZ0AOJSpRMJrKz2rH5iyoMCiPSQYB3PsSgR0ZFMj7WJb7
	AoK2QVECpWmTBSmkLZzfc2HcHAahNzKn6k5oaNunrBfWcp+WO0hW+Sd2lTD44FMjiepHb1KFTZH
	yV9o=
X-Google-Smtp-Source: AGHT+IGIHtLyHv1BeR7I51HKBBQr1rPaFSrD0CBlXThWh80UhE0jre2aByQrY4pyvX81yH54k+ylqw==
X-Received: by 2002:a17:907:175e:b0:a6f:1166:fb7a with SMTP id a640c23a62f3a-a6fab614d2cmr160009166b.32.1718825768582;
        Wed, 19 Jun 2024 12:36:08 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecdd79sm697709866b.132.2024.06.19.12.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 12:36:08 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Helge Deller <deller@gmx.de>,
	Jianhua Lu <lujianhua000@gmail.com>,
	Flavio Suligoi <f.suligoi@asem.it>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH] backlight: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Wed, 19 Jun 2024 21:35:57 +0200
Message-ID: <20240619193558.2543645-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4552; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=b6KdZZ9MVHXlW6Kzlm1yP66Bz8tcUOfRhuVRKx4scF4=; b=owGbwMvMwMXY3/A7olbonx/jabUkhrRiYznNlJmzDTYGHym8Y3STZYvRHxGeSCG2q8r2N2TnW j6aHfyyk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJ7PrFwTDJupbj79UPj/V4 H01h0JPJ8tXuuF/9Nv7Dlusr1Fd+l4oUn6fB96JT2aRduDpkzd43zxe1hVz5qlzzR1kh+X2D0sY tNRc+rL85Uaixg1Vdpk/3/6S1M3Umhmd/q26c/ElBtKYn5XStUpZm45V5t56yHS3+H8SucjiZY8 eCvb6vXfVzeQI9VmX+7Dis5xe1y8TYt8KBIXD1tTsfU5gmni07oa0SJ76tROuDSe6qfvGfdcIzd NSlL66fzcO+XInBzTHshED9w9r9Cq/mOYlHR3hxs8w13ntM9vVyEaUn8184bnu3QX6a7fuYY5cW q8dcs9vwPMFLT91NMCHgtlGF0SQug6r88J6efuHj+lu8AA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

These drivers don't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

While add it, also remove commas after the sentinel entries.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/backlight/adp8870_bl.c | 2 +-
 drivers/video/backlight/bd6107.c     | 2 +-
 drivers/video/backlight/ktz8866.c    | 4 ++--
 drivers/video/backlight/lm3509_bl.c  | 5 ++++-
 drivers/video/backlight/lm3630a_bl.c | 2 +-
 drivers/video/backlight/lm3639_bl.c  | 2 +-
 drivers/video/backlight/lv5207lp.c   | 2 +-
 drivers/video/backlight/mp3309c.c    | 2 +-
 8 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
index 6bb18dc970e9..ad4bd4c8f441 100644
--- a/drivers/video/backlight/adp8870_bl.c
+++ b/drivers/video/backlight/adp8870_bl.c
@@ -963,7 +963,7 @@ static SIMPLE_DEV_PM_OPS(adp8870_i2c_pm_ops, adp8870_i2c_suspend,
 			adp8870_i2c_resume);
 
 static const struct i2c_device_id adp8870_id[] = {
-	{ "adp8870", 0 },
+	{ "adp8870" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adp8870_id);
diff --git a/drivers/video/backlight/bd6107.c b/drivers/video/backlight/bd6107.c
index 6be2c67ba85c..90764f83d2f1 100644
--- a/drivers/video/backlight/bd6107.c
+++ b/drivers/video/backlight/bd6107.c
@@ -180,7 +180,7 @@ static void bd6107_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bd6107_ids[] = {
-	{ "bd6107", 0 },
+	{ "bd6107" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bd6107_ids);
diff --git a/drivers/video/backlight/ktz8866.c b/drivers/video/backlight/ktz8866.c
index 014877b5a984..2e508741c0af 100644
--- a/drivers/video/backlight/ktz8866.c
+++ b/drivers/video/backlight/ktz8866.c
@@ -179,8 +179,8 @@ static void ktz8866_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ktz8866_ids[] = {
-	{ "ktz8866", 0 },
-	{},
+	{ "ktz8866" },
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, ktz8866_ids);
 
diff --git a/drivers/video/backlight/lm3509_bl.c b/drivers/video/backlight/lm3509_bl.c
index c93cdedff5ad..11b8e1824e07 100644
--- a/drivers/video/backlight/lm3509_bl.c
+++ b/drivers/video/backlight/lm3509_bl.c
@@ -311,7 +311,10 @@ static void lm3509_remove(struct i2c_client *client)
 	regmap_write(data->regmap, REG_GP, 0x00);
 }
 
-static const struct i2c_device_id lm3509_id[] = { { LM3509_NAME, 0 }, {} };
+static const struct i2c_device_id lm3509_id[] = {
+	{ LM3509_NAME },
+	{}
+};
 
 MODULE_DEVICE_TABLE(i2c, lm3509_id);
 
diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 76d47e2e8242..37651c2b9393 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -596,7 +596,7 @@ static void lm3630a_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lm3630a_id[] = {
-	{LM3630A_NAME, 0},
+	{ LM3630A_NAME },
 	{}
 };
 
diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
index 564f62acd721..37ccc631c498 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -403,7 +403,7 @@ static void lm3639_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lm3639_id[] = {
-	{LM3639_NAME, 0},
+	{ LM3639_NAME },
 	{}
 };
 
diff --git a/drivers/video/backlight/lv5207lp.c b/drivers/video/backlight/lv5207lp.c
index 0cf00fee0f60..5f60989fa70f 100644
--- a/drivers/video/backlight/lv5207lp.c
+++ b/drivers/video/backlight/lv5207lp.c
@@ -132,7 +132,7 @@ static void lv5207lp_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lv5207lp_ids[] = {
-	{ "lv5207lp", 0 },
+	{ "lv5207lp" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lv5207lp_ids);
diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
index a28036c964af..2bdb20129c81 100644
--- a/drivers/video/backlight/mp3309c.c
+++ b/drivers/video/backlight/mp3309c.c
@@ -400,7 +400,7 @@ static const struct of_device_id mp3309c_match_table[] = {
 MODULE_DEVICE_TABLE(of, mp3309c_match_table);
 
 static const struct i2c_device_id mp3309c_id[] = {
-	{ "mp3309c", 0 },
+	{ "mp3309c" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mp3309c_id);

base-commit: 2102cb0d050d34d50b9642a3a50861787527e922
-- 
2.43.0

