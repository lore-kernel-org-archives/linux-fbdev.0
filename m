Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F053112A5
	for <linux-fbdev@vger.kernel.org>; Sat,  6 Jun 2026 04:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721921; cv=none; b=Prof5sYmI1pj6kgg/ZOUNx1QSgJ/rjP69YpsNkkXm5wfyTZOpAbrWe4he2FzTdbN5FlcI+DaFJN0nIyVtZHUhjq5QEFUS/uzlN51KCDPwsoQqe8iSxP3qceFq65NL2509DY04kITzFCLnhxJWeGUJlR7debt5uRGTBdymfQdY5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721921; c=relaxed/simple;
	bh=/uaa0Rfad4NLZbr7JCGcZ/k7YxCiey9V8icGrQZSDTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axCLX8ETWoI5034DKZ05OFA7II1TmfuATN3JgQUa2Yt2GU6RomV3ZH9KHgxSOyYPir22Loq388aTPyU7rviGqtV0ytpfC07hPVJCYgXJix4ATuTx1Z5jE0/K8L2BNG2pZIsmAe8Q09pI7g7+k8Ye178VJ2JF00+oJ58IFm5gl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcwU1SnI; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcwU1SnI"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68852a4fc68so4548235a12.3
        for <linux-fbdev@vger.kernel.org>; Fri, 05 Jun 2026 21:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780721918; x=1781326718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpLTvUbX/MW96Oy59fQWRealZVBkci3zFRen/ePeGpY=;
        b=bcwU1SnIaojyRF02UDyw0xrz0CtVVG9O/vVworaEsVBb/tpTD11chsUybEjm0DPbTj
         YDPcgPk243grbapbfcxbVE/m/buNJy0+nxNF1ovpe8fFmchj6ePejXYLWbfcuXNDHxrb
         FaKOmxVbEo4YUNYaCGQGKKLQ7cC56tyWmjuiv8VacUN1A95nrmxWa9SIkQe6SgmOlaLE
         KKiwc9MTC2JCZUrvwZYPilSK5DmSDZLwli+zPjEGbXbgRV4Ab1w/Gjv94y5B4fwLwxrG
         0TDjohQl+IDaRuY6B9HJuOi9elT6q/uRuFR7WiE+75ZA3g6QjDbExbCrhkP4j/DUNTSR
         Gqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780721918; x=1781326718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GpLTvUbX/MW96Oy59fQWRealZVBkci3zFRen/ePeGpY=;
        b=L/2sqm79pPWy9oBvJk2Kw4/IbCNYVrAYcckqmCOS5MPR38L2DoQEAUGgiqscanVxU0
         ubbzvAyEHMsv2055Ubg4yxq7fesE7nSccpERsd4/Z5sO6id9PezToIN9zrX776d32U7L
         SiHbn3tnV6lcmDn1IW02cXLnclpdmif8NJ1FpQ+Ej3Zd0vjy/b8aOFtI8koaVP0MYaQs
         y2dZ5PJXSXH50cnNlS6laCtRZ5Duf3Zven50/YYaYutZ8SFqVzoaKz5Mr5MxkxLK7E1j
         5SOKVBt/cddON5QDmROTgQBfvnVKo6gaVpxQB0ndvhq/FYx1GxUb8/bqeyvQePw8iRhp
         LQdQ==
X-Forwarded-Encrypted: i=1; AFNElJ/lb0KPJdC6JmA74oZYmQ1+zJErQ5GEDaRYTuGHTSxdk92ALfc90xorm4i+2rfOinm2dPCx+eRsfiHLPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzojKc5QUdov9hMka+OOvLNh15rDd57Wt3gOSEK3Xi5pF1mvdvx
	cDrmGiTn6w0mSPNOooUX9oupxYP+9ybW3sVIP08tUzr7ItT4kO8eza3a
X-Gm-Gg: Acq92OHcSe4PzcuRKGZCfjr4fJZxA7L/DJQ6PStI3HJ74u3cNxwvslMBjfzTOwt2uYG
	OB8TrbtZKhnPerWACMmxbFJaPSU2G1Lheghu9LPh8bohORhaR8qcAfbuafzues88OTbHayzA4mN
	RxCtbmevZ6ya0u9Xjod76PbXROIVQ927AaojaALXxGrokeo1zoZsBxrR+b+dShmguNSDS5vjFH9
	WWdkjA107+5o6rIO1VOYS4T8gjjl4qhqBvrZiei9tgdUu1bJ0SWvTYBF+WGCIzmCsmwmSXdShsK
	VxsqMWNNus9ylaYfeWyUAFjxGCUwZgJjHZbr82W8NO1rYH5hdaoiDq5pqis3MTB3+ZMQpeKE1nu
	QMVU69+w3UKH7iYhx83j4+JGhijxayPhlcaSJv3o0ojEZZLltQaOJ/8Er7XKxXa1AcIcvoCQcE5
	tnTDeGyc+bvs51u0reP6LEKGY=
X-Received: by 2002:a17:907:72d1:b0:bde:170:a0ef with SMTP id a640c23a62f3a-bf37234c5d9mr367725366b.27.1780721918445;
        Fri, 05 Jun 2026 21:58:38 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 21:58:36 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v4 11/14] video: backlight: lm3533_bl: Improve logic of sysfs functions
Date: Sat,  6 Jun 2026 07:57:35 +0300
Message-ID: <20260606045738.21050-12-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606045738.21050-1-clamor95@gmail.com>
References: <20260606045738.21050-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the sysfs logic of properties by switching to macros and proper
regmap helpers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 drivers/video/backlight/lm3533_bl.c | 58 ++++++++++-------------------
 1 file changed, 20 insertions(+), 38 deletions(-)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index e91c598342ad..9ad7ea1bbbcc 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -23,6 +23,8 @@
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
+#define   CTRLBANK_AB_BCONF_ALS(n)	BIT(2 * (n))
+#define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
 
 
 struct lm3533_bl {
@@ -85,88 +87,68 @@ static ssize_t show_als_channel(struct device *dev,
 	return scnprintf(buf, PAGE_SIZE, "%u\n", channel);
 }
 
-static ssize_t show_als_en(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t show_als_en(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
-	u32 val;
-	u8 mask;
-	bool enable;
 	int ret;
 
-	ret = regmap_read(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF, &val);
+	ret = regmap_test_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+			       CTRLBANK_AB_BCONF_ALS(ctrlbank));
 	if (ret)
 		return ret;
 
-	mask = 1 << (2 * ctrlbank);
-	enable = val & mask;
-
-	return scnprintf(buf, PAGE_SIZE, "%d\n", enable);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
 }
 
-static ssize_t store_als_en(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t len)
+static ssize_t store_als_en(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t len)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	int enable;
-	u8 mask;
 	int ret;
 
 	if (kstrtoint(buf, 0, &enable))
 		return -EINVAL;
 
-	mask = 1 << (2 * ctrlbank);
-
 	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
-				 mask, enable);
+				 CTRLBANK_AB_BCONF_ALS(ctrlbank), enable);
 	if (ret)
 		return ret;
 
 	return len;
 }
 
-static ssize_t show_linear(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t show_linear(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
-	u32 val;
-	u8 mask;
-	int linear;
+	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	int ret;
 
-	ret = regmap_read(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF, &val);
+	ret = regmap_test_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+			       CTRLBANK_AB_BCONF_MODE(ctrlbank));
 	if (ret)
 		return ret;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
-	if (val & mask)
-		linear = 1;
-	else
-		linear = 0;
-
-	return scnprintf(buf, PAGE_SIZE, "%x\n", linear);
+	return scnprintf(buf, PAGE_SIZE, "%x\n", ret);
 }
 
-static ssize_t store_linear(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t len)
+static ssize_t store_linear(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t len)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
+	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	unsigned long linear;
-	u8 mask;
 	int ret;
 
 	if (kstrtoul(buf, 0, &linear))
 		return -EINVAL;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
 	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
-				 mask, linear);
+				 CTRLBANK_AB_BCONF_MODE(ctrlbank), linear);
 	if (ret)
 		return ret;
 
-- 
2.53.0

