Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D80314A95
	for <linux-fbdev@vger.kernel.org>; Sat,  6 Jun 2026 04:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721933; cv=none; b=F9acfbRJuut8gaiK8MSZAUwzNnpdEvxtHVkYSe+vUllyrMr95ycZlemA6FH72NbNNjwRmsBa0s3Ur0u8Zvxj30fht27HdMYzu/MUqYQcbG0ae+3yXqULfUB8xXgWnBa5Gt3gRcvX9BFoKkxI2ABRyOpbXfIEi7xXN/ahG+QvxV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721933; c=relaxed/simple;
	bh=J/hbghdGiskCXq2LMuJR1POlS86t7rcaRIUrzBWVHgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Av7dzG9G6b9ZAzN17c1TAo+9hotj7xT9SwBny1o0M2DB0sdLYJhx0N6WiyeLifDfbs/57YxwPQeVHyoMRMTkZCZPk6ITCK/kFwOAsR2Ji5q79Lvx4kozPnbxW2sJBzOLCALw25FO9Ws66gw2BcIti1CUefhlxUs6xRRU+/xUCII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YduCpeko; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YduCpeko"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bf523d7b6afso20197066b.2
        for <linux-fbdev@vger.kernel.org>; Fri, 05 Jun 2026 21:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780721929; x=1781326729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THaL1QVPpQgP2z5ftX+u3ovu7VRE23Z1E4qNugQA6t8=;
        b=YduCpekonrnNLVeTKOipMxkHqK9ZRrMCmfcIqHtSKi+Gb1r2p2R2pSajBPHv0wUH94
         vG3ZDzYW22kbtqWDbqgc7S4eF3chQbsehw6l3nhGjFhLf3icNZD79XVsr140tkQ6a5Xk
         /69X8ba4crVwVD7aM8l6Gzcm/je+PzYn8r2QxKaTBk972bfN1727q+rCnpMJuDb1srbk
         5MILrAIn1MU2boYxE+MDyz3UQnEtVOY82K9VEMccUw35dMoScaHy0KKjS4RieUPwDPRs
         D42KzQNWq73p+4oyoLevuEuRBz5zQEoA6CJSoH8g6fucj4nCK3L1AC/IDNBxlVJOZ2BX
         v7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780721929; x=1781326729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=THaL1QVPpQgP2z5ftX+u3ovu7VRE23Z1E4qNugQA6t8=;
        b=oLfYJyUTtB7gG9ZtofIpTjLVbSRCtLTy2czi7ldHMWFOMXbHLuuOFUtmRE0QJZQ1o1
         W+QeoFIrs3q20/2qSfaEcBwAuDoOhUkXCsGoXZ1RNJuOVohXn0RSEYnsOoimDLCmGejP
         9URkqZtVDPA4K89SG58iYJgs5fYtFco7YhlF5Eu8fkxpto1mhFHBNthlqFpyH5Cc/ulc
         c4GxNm3WcJRgdLxybiYGcHyZu/CLm9MiqeK+RV5GWtCd47QsJu+dHqG7xSnxp7Uw69Tp
         6kaJvlxHyY7pEe0Gh427+7w1Nus6nF6cxwQ1yNrP355m7pUXTDqOmxRFPLRj2r/1a5uG
         P5gQ==
X-Forwarded-Encrypted: i=1; AFNElJ8kSMoJxNvNkiyJstkcexYmd3GsPmVKGEG5xK4Nlfj7vpedGwR3JC9hHjzaXYH9fmmWVpC+hVn08abggA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1nw4YfWOP+06T8YJeTj2Qzo/wcUUWV6O5YAU1sgpEX9seGmP4
	Ci3ac6hbbeyMbvK4Xgg2RvhQXso0k75+Ms0qDZbKi+2EBUcERlwNHTjp
X-Gm-Gg: Acq92OFT/LEn8BeYyGVkKB+yfkz818dK8ndNiw+ru1/4K5iL8WLFnRbWyBynKg9hDU9
	EMCtBTegpmqwam2hCItO5vZOHe9HwzTNPLqdOlr02G9XBLYTRFnvQPTDkHB3zsS54rlZqioaGgP
	NVBwixt9UinTvCFzGPAo+Bb68WlJm0rwrW6k+2cxi49cnruH4vkvo0UGbx+3nfx+doSbP5W9/zK
	Bwz9VDhluZmml7Tr4I2naDT19xhZDjPt0ZFUbxtcVBnousC49+18h+Bx80kKzokyEM9C6wHawLI
	SFSpVgmE/j3xGDQA1hBe3ggrKzY228EczDyWaqZgRLq15iMUqd6fLNWwYPY2+HmirJpgJPByzua
	YYZQI4e2dMenkuHZtNvoe6KcNVY8fyn0L3bwp0M1ZTgNyvIvs1kZAiWXu/1dkEOLRhv2ZrrkITS
	B71pJEpwvb4Xja4FHBbHmnCDNizPj4l+NtgA==
X-Received: by 2002:a17:907:608b:b0:bcb:66df:819a with SMTP id a640c23a62f3a-bf3741e8062mr385758166b.40.1780721928778;
        Fri, 05 Jun 2026 21:58:48 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 21:58:47 -0700 (PDT)
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
Subject: [PATCH v4 14/14] video: leds: backlight: lm3533: Support getting LED sources from DT
Date: Sat,  6 Jun 2026 07:57:38 +0300
Message-ID: <20260606045738.21050-15-clamor95@gmail.com>
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

Add Control Bank to HVLED/LVLED muxing support based on the led-sources
defined in the device tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/leds/leds-lm3533.c          | 58 ++++++++++++++++++++++++++++-
 drivers/video/backlight/lm3533_bl.c | 43 ++++++++++++++++++++-
 2 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
index a661aedcdc60..fe3e01b265e1 100644
--- a/drivers/leds/leds-lm3533.c
+++ b/drivers/leds/leds-lm3533.c
@@ -27,6 +27,11 @@
 #define LM3533_ALS_CHANNEL_LV_MIN	1
 #define LM3533_ALS_CHANNEL_LV_MAX	2
 
+#define LM3533_REG_OUTPUT_CONF1			0x10
+#define   OUTPUT_CONF1_SHIFT			2
+#define   OUTPUT_LVLED_MASK			0x3
+#define LM3533_REG_OUTPUT_CONF2			0x11
+#define   OUTPUT_CONF2_SHIFT			6
 #define LM3533_REG_CTRLBANK_BCONF_BASE		0x1b
 #define LM3533_REG_PATTERN_ENABLE		0x28
 #define LM3533_REG_PATTERN_LOW_TIME_BASE	0x71
@@ -55,6 +60,9 @@ struct lm3533_led {
 	u32 max_current;
 	u32 pwm;
 
+	int num_leds;
+	u32 leds[LM3533_LVCTRLBANK_MAX];
+
 	bool have_als;
 };
 
@@ -623,7 +631,35 @@ static const struct attribute_group *lm3533_led_attribute_groups[] = {
 
 static int lm3533_led_setup(struct lm3533_led *led)
 {
-	int ret;
+	u32 output_cfg_shift = 0;
+	u32 output_cfg_val = 0;
+	u32 output_cfg_mask = 0;
+	int ret, i;
+
+	if (led->num_leds) {
+		for (i = 0; i < led->num_leds; i++) {
+			if (led->leds[i] >= LM3533_LVCTRLBANK_MAX)
+				continue;
+
+			output_cfg_shift = led->leds[i] * 2;
+			output_cfg_val |= led->id << output_cfg_shift;
+			output_cfg_mask |= OUTPUT_LVLED_MASK << output_cfg_shift;
+		}
+
+		/* LVLED1, LVLED2 and LVLED3 */
+		ret = regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF1,
+					 output_cfg_mask << OUTPUT_CONF1_SHIFT,
+					 output_cfg_val << OUTPUT_CONF1_SHIFT);
+		if (ret)
+			return ret;
+
+		/* LVLED4 and LVLED5 */
+		ret = regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF2,
+					 output_cfg_mask >> OUTPUT_CONF2_SHIFT,
+					 output_cfg_val >> OUTPUT_CONF2_SHIFT);
+		if (ret)
+			return ret;
+	}
 
 	ret = lm3533_ctrlbank_set_max_current(&led->cb, led->max_current);
 	if (ret)
@@ -700,6 +736,26 @@ static int lm3533_led_probe(struct platform_device *pdev)
 	led->pwm = 0;
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->pwm);
 
+	led->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
+	if (led->num_leds > LM3533_LVCTRLBANK_MAX) {
+		dev_err(&pdev->dev, "num of LED sources exceeds max %d: %d\n",
+			LM3533_LVCTRLBANK_MAX, led->num_leds);
+		goto err_deregister;
+	}
+
+	/*
+	 * If led-sources property is not set then either this Control Bank uses
+	 * its default LVLED or is not linked to any LVLED at all.
+	 */
+	if (led->num_leds > 0) {
+		ret = device_property_read_u32_array(&pdev->dev, "led-sources",
+						     led->leds, led->num_leds);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to get led-sources\n");
+			goto err_deregister;
+		}
+	}
+
 	ret = lm3533_led_setup(led);
 	if (ret)
 		goto err_deregister;
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 2aa4b86042ff..ed358fb3c759 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -7,6 +7,7 @@
  * Author: Johan Hovold <jhovold@gmail.com>
  */
 
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/mod_devicetable.h>
@@ -22,6 +23,7 @@
 #define LM3533_HVCTRLBANK_COUNT		2
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
+#define LM3533_REG_OUTPUT_CONF1		0x10
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
 #define   CTRLBANK_AB_BCONF_ALS(n)	BIT(2 * (n))
 #define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
@@ -36,6 +38,9 @@ struct lm3533_bl {
 	u32 max_current;
 	u32 pwm;
 
+	int num_leds;
+	u32 led_strings[LM3533_HVCTRLBANK_COUNT];
+
 	bool have_als;
 	bool linear;
 };
@@ -232,13 +237,30 @@ static struct attribute_group lm3533_bl_attribute_group = {
 static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
-	int ret;
+	u32 output_cfg_val = 0;
+	u32 output_cfg_mask = 0;
+	int ret, i;
 
 	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
 				 CTRLBANK_AB_BCONF_MODE(ctrlbank), bl->linear);
 	if (ret)
 		return ret;
 
+	if (bl->num_leds) {
+		for (i = 0; i < bl->num_leds; i++) {
+			if (bl->led_strings[i] >= LM3533_HVCTRLBANK_COUNT)
+				continue;
+
+			output_cfg_val |= ctrlbank << bl->led_strings[i];
+			output_cfg_mask |= BIT(bl->led_strings[i]);
+		}
+
+		ret = regmap_update_bits(bl->regmap, LM3533_REG_OUTPUT_CONF1,
+					 output_cfg_mask, output_cfg_val);
+		if (ret)
+			return ret;
+	}
+
 	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
@@ -316,6 +338,25 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->pwm);
 
+	bl->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
+	if (bl->num_leds > LM3533_HVCTRLBANK_COUNT)
+		return dev_err_probe(&pdev->dev, bl->num_leds,
+				     "num of LED sources exceeds max %d\n",
+				     LM3533_HVCTRLBANK_COUNT);
+
+	/*
+	 * If led-sources property is not set then either this Control Bank uses
+	 * its default HVLED or is not linked to any HVLED at all.
+	 */
+	if (bl->num_leds > 0) {
+		ret = device_property_read_u32_array(&pdev->dev, "led-sources",
+						     bl->led_strings,
+						     bl->num_leds);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed to get led-sources\n");
+	}
+
 	ret = lm3533_bl_setup(bl);
 	if (ret)
 		return ret;
-- 
2.53.0

