Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6AF3D4132
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jun 2026 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683272; cv=none; b=BZ5cD2bnoo6sogPYvfCEee0t4AlolU8UfgRI3MKAzCcLJXa7AFjX+CptLV7H1f6jPCCAQQ9KOwgTrF43YvqO6mplF4tp5kpQuoIaL3IO1BLkFLPWUZtlPi81FCu3WMZF8/rSikCLsOUpJf5ADvqGwysVOqIOeahUuep6qdYIxmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683272; c=relaxed/simple;
	bh=KKu9vuzjNh2iqUZwT5xjE/o1dLesFPk+03y2gSGMhFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsMwUfxyZ5V36qNWdwJmCLkalaGJ3fYEVtSqSRLnN+d3Vvb6hXJs86kHIdaOS+TGVejZpme8U2p6oz0Vcyl83otydCAieT8n1/48c91RPmAPTpB04t1ja8mLgCZi/dGg5JPldaySUYW+QGfOw8RLt9ninuhxXQJQnLuFigOzT9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Seuj2uvl; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Seuj2uvl"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bf0170c80f7so929906866b.3
        for <linux-fbdev@vger.kernel.org>; Wed, 17 Jun 2026 01:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781683258; x=1782288058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2i1k8AoyDEf4+SEcMRPttiYCfUlkSwT7R4ZGBXCsSZk=;
        b=Seuj2uvl/9+wEOZEUExytld1ZS+46/FfLivxy3+PSQsYqdTMvu7F6JRigSUqqFDFAP
         Y7OVmlqKdgycRsE2yddzapgI+c5E/Pleyu5ALZJ/fQjqyLf3/T8cuLzI5FgmkK6wi1kG
         E/WIi+EDZfZHMhzOTYJCfhzlDYQELq3ly+gVdfr3xy0U5wlYY+lL38bpA72TAV13KwTV
         zcLq+AcHDslSWCp405e4eUG+FdrMkIXyoQORl7drXR6ao4R6Flp8EU4fEBGratJPYAbL
         cMzJCJIO9bGKDUISVufjCR17iW8CUViJadOQY0ePhKRqvoF4oMMK4uVLYpxzdoEe3/yR
         blag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781683258; x=1782288058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2i1k8AoyDEf4+SEcMRPttiYCfUlkSwT7R4ZGBXCsSZk=;
        b=W+tB8eAR3ktCEa2eFYxVsgCoPPJhizunyl8feBl/RJguA6FpvrqGcnzok0WIXjE1Sa
         x1FiaPmmEzpTyjdawVnGdbIjFc3AqjrMc40C90CGS7R1Ge0mUxpZoyrS3zbSLFGZj4v0
         m+ykqOVJCyVCqGvaV/wp4SVb9IeYF8IdSdrNaYp8kC4eEGtc3GM/ChD0K6om9ooLinJw
         t1lP75sJYNyuo68G23RtBAwTPiUz+fFH5m6U9F497DNj1fP73JfNF+5uGQnoqaDW2QyH
         Ln0w3+UqignWzsz+2ZOhdzz/iKxIn+q38UYw1iOhw8DA4DUNP6ZI1V2jb7Zuk6wzlm+O
         MEkA==
X-Forwarded-Encrypted: i=1; AFNElJ8EbsWaisw6QiCT/cnw7nm0IH81VXyOiLmsLt3/kU7TvrSpumxpC9i/KIS0mYTjhWFUv5FjwsTRuz4quA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgvKmGnIknhGx8xQEUURXp18STq2cEXsDiAZkqoQHT0DQgn8wT
	uifcRnQzWD5eqiCieRq8BpHgL+qLzuly3i3cyPE9Xaz9XGIQQyGeT8YR
X-Gm-Gg: Acq92OFFZiQPuzqSbXM6UT3oSc0UrC2HVZ9tgHGVd51vU9aNgf4jbfe0yvKS1gaF6Sk
	iC6P2IxRH6FSVKlyhQCVvENn9h2udpYkB6wGRNj4xA9DDqav2reOgbJagFH+txE677LXFvbZLgb
	793uddxXWtMquCKyfZEPUgulrUDhCfajON23CWxW/gnYBouTaMJXSDrdRVd6XU14A1cgNR+UO5d
	hgBlxxSxYQYjKDjPLmr8PLe5TEE2V51DdImUfsI6XebtKoj06kXvs/gcgbboIYxmBLlvBwVJ3oW
	CJ2WygnIC8VXYMC2GL8k3foQmxxLNQEepx/1s5ZuVB0IWpVGrT8KR9aI4DyKRgVQBwouMYD0smQ
	vPBV+Z0YPrKhxFqoEPqZEEDXR7zlqpVxOSDkkGYFtPaeEfZsWRGm2UJOQKQMRlAXlD92/EHvWIU
	H7pQ==
X-Received: by 2002:a17:907:9305:b0:bfe:ed06:5a1f with SMTP id a640c23a62f3a-c05a83a199dmr195494666b.52.1781683257844;
        Wed, 17 Jun 2026 01:00:57 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:00:57 -0700 (PDT)
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
Subject: [PATCH v5 11/14] video: backlight: lm3533_bl: Improve logic of sysfs functions
Date: Wed, 17 Jun 2026 11:00:28 +0300
Message-ID: <20260617080031.99156-12-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617080031.99156-1-clamor95@gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
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
 drivers/video/backlight/lm3533_bl.c | 62 ++++++++++-------------------
 1 file changed, 22 insertions(+), 40 deletions(-)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 2c24647fc17a..9eb0db640948 100644
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
-	if (ret)
+	ret = regmap_test_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+			       CTRLBANK_AB_BCONF_ALS(ctrlbank));
+	if (ret < 0)
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
-	if (ret)
+	ret = regmap_test_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+			       CTRLBANK_AB_BCONF_MODE(ctrlbank));
+	if (ret < 0)
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

