Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCEF3F54CE
	for <linux-fbdev@vger.kernel.org>; Mon, 18 May 2026 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102749; cv=none; b=EjlX1mvwVnKXBrrzXATaua2Rs64bIKNc99FU5LAF+ayf2qptpSg1uaddcV2x6U4mh/hMonAq4+HgIUfCtkIPESLWAwugQKLJ4U/H0i2OZ+LK1gRMz2cySYMD6N8pODLnDUl2ZQwdVZiJr0l3rHYAsk3Ct4fyPjMMKYNFuk+oBkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102749; c=relaxed/simple;
	bh=K3nI7LF5tAwngbkcN/5y5N1EdW2D0ZhyMSO4iSSKwwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mcoigL95Kp13yefYJTky7AXh6fMwF/cuVc/6E0RO2cicnK5EQuNyuGys6/ZYS98S5+lsYniAZeGGOKvQl2P5Fx6LnhJM/vZEMRk05nYvihAAOjrBY8yeO/YmVEKnrkDsdlg3XvBU/OuHSJH7RomkC1DvY5n+3FkVGDNifZAl8f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=ANgcdPWz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ANgcdPWz"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-459bf19e87bso1205697f8f.1
        for <linux-fbdev@vger.kernel.org>; Mon, 18 May 2026 04:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779102737; x=1779707537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U4/++U9j8mYC/3Jzj1PcVr50bYvBfT6iMwOvy7pBLPM=;
        b=ANgcdPWzELZzqzJX5TnsLoF1rx2wBzqJ27dgbnhQsWhQMxVzXjRGZpC81zLmC1UKwL
         mzL6xMr1EUF1FdRQX6rSLhrlPs4o3XiPAAmT5FxOL/96ex5HGwj2vcxrsnwFxtibYcYV
         D1s5liuCsmxQHR906LtOfsKiou9wSNkP6fw7K8d/LtYqZYcGkh4TP6CtRjOmGYER9YWB
         QvzbQMrU6aowWS5ipx7D1BoBKZADJUW8aC3mEso/HlRpDSfxyih4hIfs+YFsU2RJnN4F
         flHcAjbE8x6aesGOl4rLQ0pxwNRjXvZ5bHvlh3yR345vE224qW8Fgkn1Q1BcnvQ43z1/
         VQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779102737; x=1779707537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4/++U9j8mYC/3Jzj1PcVr50bYvBfT6iMwOvy7pBLPM=;
        b=CSQtashnZ50m8Bqi8t3F8usyBIrqv6ErO8hIEzUfDHOwiHmf2XBgRysTHBdqx5EABh
         9yo3njs+OglykZc1f0diKk71Tmov/eoyvxrdiyFIZt9+B/kuSBJLbBC2VGEDHjNZx5jP
         zeeJ1UYU1FFfGq8oPwRjsdC+NJvP0+krojSI47S+u7Fw3cuZ3oxlPSFHPaEnHXfVk5JF
         7tndk/T3Yx2d7whLz9SYaiBjoJ5uB9y9Dy9M9j3TY1Qv6A1Jp966FFsZ1MsRECqecgil
         v7N7OWn+WQfi1NFlmD2FgecPRgs3Gv41/odjmV/BobtEcE/VNcne0SxZcT44zEJD1Xbv
         /3mw==
X-Forwarded-Encrypted: i=1; AFNElJ/Rr94dDhMyqskymekExXdAt74SRkrOHBh43foMSqefESUFC9AonVb+y3PMO0cgLBOAMRCgucWb99mYFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoDLrTVNPSmjqa29kwMFjDHab7afLxajASF6DRScW9d2AaKSYz
	OAplAaKHHrBmJkha89U9/PZbBDAzZlkHn6i941/01OHGvrUgJeMT6tbIr33FmMd8Ctk=
X-Gm-Gg: Acq92OHZUi9hOIYVmUyhczNXcDSVR/EEvp+QKm7MfDLTeoNc7ThNQqEjxH9O8Ge33XB
	ArMeLBEXOMNrL+yAzBbLM9de0x+FpIYHUdTojGFIDSKFote2jECCI9g2tL/QWv3gwGkSQSvHmyw
	D8nmqtZzxWsMwVluF7DtQeIFk+C9bC4+q9Ce2SU5GukJWfdfrmoO9uqNgIy1H1tppsfjHtHLMEV
	vCTJtflXwmJ6epkQ4n9AwQZYtqHaoWYC5Lc8mX45KLi3Iv4b8pEo6pC90yyHsxFnmXFiIXdu+8u
	VnYQ+LxsOs5/H83UKHfNjdUUnluMcCKo143UyQdRi93pzz0h/jFwZwv5vRjYoSzUB9RzX6rzXnV
	zPu9gqg2CrhRns2M2120L1OP3+/iZhXC/qaMjrYak7Deq0sppydIssnkKrOXH93DXSx0wuzyv8p
	1kOMJNJhDtR1a+w5q+0Uz5XhEusjIktBGqgHVMJ9WaI0mzqVCeLPznhQQpO6NtHMM8JgP9ssvz0
	sAvFbjXJrIwr0hXxR4C15AgMg==
X-Received: by 2002:a05:6000:1aca:b0:451:bbe4:b48e with SMTP id ffacd0b85a97d-45e5c57d380mr21724462f8f.5.1779102736933;
        Mon, 18 May 2026 04:12:16 -0700 (PDT)
Received: from localhost (p200300f65f47db049367b55fc4056f2b.dip0.t-ipconnect.de. [2003:f6:5f47:db04:9367:b55f:c405:6f2b])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45d9ed30110sm40072081f8f.13.2026.05.18.04.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:12:16 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Helge Deller <deller@gmx.de>,
	Junjie Cao <caojunjie650@gmail.com>,
	Jianhua Lu <lujianhua000@gmail.com>,
	Flavio Suligoi <f.suligoi@asem.it>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: Use named initializers for arrays of i2c_device_data
Date: Mon, 18 May 2026 13:12:03 +0200
Message-ID: <20260518111203.639603-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=10444; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=K3nI7LF5tAwngbkcN/5y5N1EdW2D0ZhyMSO4iSSKwwc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqCvQDGhiz+NaNyCL/bt09zi+ljomP6xQyEK03D Jw9Z6v71dyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagr0AwAKCRCPgPtYfRL+ TuwGCACQmNoq+xBBztZ4JjEvMXVaDKp024W7I5M0OdibuvGqottuSIMsO6nKHTUe96WHjqNd8Na sVYXq+Ulvsx/qnzZ0eCVG8vZK0ADa8e3FANK8W9OKZo42Btyv5Zx8MehVXX/6chtHrH15023LE4 4cvYYo5nDsZqsms8W37SGSj2x7R02rkHlHwblWeBbbBEKdRrm1t87X96cMfIW9sS/BypNQ4itz5 ndCoRNt4tAZ+ARN4zDPJMAGfn05Gf7+i28Ro9jPoqv0ku7yEJbjKCbVuh+6u9VAsgyzAJzTfUSG Y3V6+zBFM3Fn0z1Ywn5IYB3gZG2RJHslickgak1do1X/WlBR
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
i2c_device_id that replaces .driver_data by an anonymous union.

While touching all these arrays, unify usage of whitespace in the list
terminator.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

the mentioned change to i2c_device_id is the following:

	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
	index 23ff24080dfd..aebd3a5e90af 100644
	--- a/include/linux/mod_devicetable.h
	+++ b/include/linux/mod_devicetable.h
	@@ -477,7 +477,11 @@ struct rpmsg_device_id {

	 struct i2c_device_id {
		char name[I2C_NAME_SIZE];
	-	kernel_ulong_t driver_data;	/* Data private to the driver */
	+	union {
	+		/* Data private to the driver */
	+		kernel_ulong_t driver_data;
	+		const void *driver_data_ptr;
	+	};
	 };

	 /* pci_epf */

and this requires that .driver_data is assigned via a named initializer
for static data. This requirement isn't a bad one because named
initializers are also much better readable than list initializers.

The union added to struct i2c_device_id enables further cleanups like:

	diff --git a/drivers/regulator/ad5398.c b/drivers/regulator/ad5398.c
	index 0123ca8157a8..dfb0b07500a7 100644
	--- a/drivers/regulator/ad5398.c
	+++ b/drivers/regulator/ad5398.c
	@@ -207,8 +207,8 @@ struct ad5398_current_data_format {
	 static const struct ad5398_current_data_format df_10_4_120 = {10, 4, 0, 120000};

	 static const struct i2c_device_id ad5398_id[] = {
	-	{ .name = "ad5398", .driver_data = (kernel_ulong_t)&df_10_4_120 },
	-	{ .name = "ad5821", .driver_data = (kernel_ulong_t)&df_10_4_120 },
	+	{ .name = "ad5398", .driver_data_ptr = &df_10_4_120 },
	+	{ .name = "ad5821", .driver_data_ptr = &df_10_4_120 },
	 	{ }
	 };
	 MODULE_DEVICE_TABLE(i2c, ad5398_id);
	@@ -219,8 +219,7 @@ static int ad5398_probe(struct i2c_client *client)
	 	struct regulator_init_data *init_data = dev_get_platdata(&client->dev);
	 	struct regulator_config config = { };
	 	struct ad5398_chip_info *chip;
	-	const struct ad5398_current_data_format *df =
	-	                (struct ad5398_current_data_format *)id->driver_data;
	+	const struct ad5398_current_data_format *df = id->driver_data;

	 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
	 	if (!chip)

that are an improvement for readability (again!) and it keeps some
properties of the pointers (here: being const) without having to pay
attention for that. (I didn't find a backlight driver that benefits, so
this is "only" a regulator driver example.)

My additional motivation for this effort is CHERI[1]. This is a hardware
extension that uses 128 bit pointers but unsigned long is still 64 bit.
So with CHERI you cannot store pointers in unsigned long variables.

Best regards
Uwe

[1] https://cheri-alliance.org/discover-cheri/
    https://lwn.net/Articles/1037974/
---
 drivers/video/backlight/adp8860_bl.c |  6 +++---
 drivers/video/backlight/adp8870_bl.c |  2 +-
 drivers/video/backlight/arcxcnn_bl.c |  2 +-
 drivers/video/backlight/aw99706.c    |  2 +-
 drivers/video/backlight/bd6107.c     |  2 +-
 drivers/video/backlight/ktz8866.c    |  4 ++--
 drivers/video/backlight/lm3509_bl.c  |  4 ++--
 drivers/video/backlight/lm3630a_bl.c |  4 ++--
 drivers/video/backlight/lm3639_bl.c  |  4 ++--
 drivers/video/backlight/lp855x_bl.c  | 14 +++++++-------
 drivers/video/backlight/lv5207lp.c   |  2 +-
 drivers/video/backlight/mp3309c.c    |  2 +-
 12 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
index d4bbd7a7406b..09dd67702431 100644
--- a/drivers/video/backlight/adp8860_bl.c
+++ b/drivers/video/backlight/adp8860_bl.c
@@ -790,9 +790,9 @@ static SIMPLE_DEV_PM_OPS(adp8860_i2c_pm_ops, adp8860_i2c_suspend,
 			adp8860_i2c_resume);
 
 static const struct i2c_device_id adp8860_id[] = {
-	{ "adp8860", adp8860 },
-	{ "adp8861", adp8861 },
-	{ "adp8863", adp8863 },
+	{ .name = "adp8860", .driver_data = adp8860 },
+	{ .name = "adp8861", .driver_data = adp8861 },
+	{ .name = "adp8863", .driver_data = adp8863 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adp8860_id);
diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
index e09e20492e7c..d009f2c8a11d 100644
--- a/drivers/video/backlight/adp8870_bl.c
+++ b/drivers/video/backlight/adp8870_bl.c
@@ -962,7 +962,7 @@ static SIMPLE_DEV_PM_OPS(adp8870_i2c_pm_ops, adp8870_i2c_suspend,
 			adp8870_i2c_resume);
 
 static const struct i2c_device_id adp8870_id[] = {
-	{ "adp8870" },
+	{ .name = "adp8870" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adp8870_id);
diff --git a/drivers/video/backlight/arcxcnn_bl.c b/drivers/video/backlight/arcxcnn_bl.c
index 1d5a570cfe02..f46eeab02e90 100644
--- a/drivers/video/backlight/arcxcnn_bl.c
+++ b/drivers/video/backlight/arcxcnn_bl.c
@@ -382,7 +382,7 @@ static const struct of_device_id arcxcnn_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, arcxcnn_dt_ids);
 
 static const struct i2c_device_id arcxcnn_ids[] = {
-	{"arc2c0608", ARC2C0608},
+	{ .name = "arc2c0608", .driver_data = ARC2C0608 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, arcxcnn_ids);
diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/aw99706.c
index 938f352aaab7..18299faf06ad 100644
--- a/drivers/video/backlight/aw99706.c
+++ b/drivers/video/backlight/aw99706.c
@@ -443,7 +443,7 @@ static int aw99706_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(aw99706_pm_ops, aw99706_suspend, aw99706_resume);
 
 static const struct i2c_device_id aw99706_ids[] = {
-	{ "aw99706" },
+	{ .name = "aw99706" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, aw99706_ids);
diff --git a/drivers/video/backlight/bd6107.c b/drivers/video/backlight/bd6107.c
index 74567af84e97..6778b4030b02 100644
--- a/drivers/video/backlight/bd6107.c
+++ b/drivers/video/backlight/bd6107.c
@@ -179,7 +179,7 @@ static void bd6107_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bd6107_ids[] = {
-	{ "bd6107" },
+	{ .name = "bd6107" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bd6107_ids);
diff --git a/drivers/video/backlight/ktz8866.c b/drivers/video/backlight/ktz8866.c
index 351c2b4d63ed..53c1301dbb8c 100644
--- a/drivers/video/backlight/ktz8866.c
+++ b/drivers/video/backlight/ktz8866.c
@@ -179,8 +179,8 @@ static void ktz8866_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ktz8866_ids[] = {
-	{ "ktz8866" },
-	{}
+	{ .name = "ktz8866" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ktz8866_ids);
 
diff --git a/drivers/video/backlight/lm3509_bl.c b/drivers/video/backlight/lm3509_bl.c
index 24e1a19ff72d..53136c5e1460 100644
--- a/drivers/video/backlight/lm3509_bl.c
+++ b/drivers/video/backlight/lm3509_bl.c
@@ -311,8 +311,8 @@ static void lm3509_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lm3509_id[] = {
-	{ LM3509_NAME },
-	{}
+	{ .name = LM3509_NAME },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, lm3509_id);
diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 37651c2b9393..8f49e59ce374 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -596,8 +596,8 @@ static void lm3630a_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lm3630a_id[] = {
-	{ LM3630A_NAME },
-	{}
+	{ .name = LM3630A_NAME },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, lm3630a_id);
diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
index 37ccc631c498..ea748b80b737 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -403,8 +403,8 @@ static void lm3639_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lm3639_id[] = {
-	{ LM3639_NAME },
-	{}
+	{ .name = LM3639_NAME },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, lm3639_id);
diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index d191560ce285..43a2123d3a4d 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -570,13 +570,13 @@ static const struct of_device_id lp855x_dt_ids[] __maybe_unused = {
 MODULE_DEVICE_TABLE(of, lp855x_dt_ids);
 
 static const struct i2c_device_id lp855x_ids[] = {
-	{"lp8550", LP8550},
-	{"lp8551", LP8551},
-	{"lp8552", LP8552},
-	{"lp8553", LP8553},
-	{"lp8555", LP8555},
-	{"lp8556", LP8556},
-	{"lp8557", LP8557},
+	{ .name = "lp8550", .driver_data = LP8550 },
+	{ .name = "lp8551", .driver_data = LP8551 },
+	{ .name = "lp8552", .driver_data = LP8552 },
+	{ .name = "lp8553", .driver_data = LP8553 },
+	{ .name = "lp8555", .driver_data = LP8555 },
+	{ .name = "lp8556", .driver_data = LP8556 },
+	{ .name = "lp8557", .driver_data = LP8557 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lp855x_ids);
diff --git a/drivers/video/backlight/lv5207lp.c b/drivers/video/backlight/lv5207lp.c
index a205f004eab2..e643ab9c3536 100644
--- a/drivers/video/backlight/lv5207lp.c
+++ b/drivers/video/backlight/lv5207lp.c
@@ -131,7 +131,7 @@ static void lv5207lp_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lv5207lp_ids[] = {
-	{ "lv5207lp" },
+	{ .name = "lv5207lp" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lv5207lp_ids);
diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
index 9337110ce6e5..413cfe27dfd9 100644
--- a/drivers/video/backlight/mp3309c.c
+++ b/drivers/video/backlight/mp3309c.c
@@ -400,7 +400,7 @@ static const struct of_device_id mp3309c_match_table[] = {
 MODULE_DEVICE_TABLE(of, mp3309c_match_table);
 
 static const struct i2c_device_id mp3309c_id[] = {
-	{ "mp3309c" },
+	{ .name = "mp3309c" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mp3309c_id);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

