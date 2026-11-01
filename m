Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793543088;
	b=RvUvmHI3G1WBUzIR/rqQgctBLM/S0ys08Wfn0O+4lv3bNeSnCc9fk11WFhvao/HKYifH
	 ESBtIgirgzD5wPygrp3Bhn4kkDgQWnZoy8Pn4lq8iqMBvaAqbjqWeYBG3Kio/0Mn2+haZ
	 76muTrVU12e9YKpl2Lff+v+LjeV/q3a+wUv0eryQoEwKLV3VJNPnkARMeBzBMiCZnu1Gd
	 jGS00L95L5USUUPItM7nxyswSgZkPyC96Rna+1Hu/72o1q37JmIPVAV1Z5s6131wJpsf/
	 yMEkHa+QPofMDtLqDFlDy49Um9Bi2yUutewVT5Rksonak4UgyRe54DtGxv3CFdbCyCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793543088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9S5hKR3Q9jtJKLTHVg9rJOjWtvZaDRDoo7tiPR+mJPw=;
	b=1sL0D8ZbbNlWQ3Wnwnm9gja1dAJyTF7w0QzT5acsK5JEf7utYC2e2NtTxSC5eukB8ipS
	 TiJw/T4UNEvAX1Xei3XqUOCIZQH42/0kgOKxoaViXNfJha7XIsX8CRO2L7xBHJkMT3Tg1
	 BUznn/Wih72Q5X2t4OVret6RDAkdwuXJEjVZrffbhqlJXp8O0qZyF9K8iEj6lN4+nBebL
	 FnEdBWnzF5LNqIS1TJrvUKrEpPajX06thTBLTZIuC3Qsm/oCFBSZag2FLxBX+syOr7FSR
	 /C4ul11m7W0ABgnR2J1bK8cdqpRKC8rA0Wo7154w48EfemHhdA2PzLKR/CSDajjo8VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wq0p8kXt;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC55606A324
	for <linux-fbdev@vger.kernel.org>; Sun,  1 Nov 2026 14:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAC55606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wq0p8kXt
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c169ae1cb26so520365266b.1
        for <linux-fbdev@vger.kernel.org>; Sun, 01 Nov 2026 06:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793543086; x=1794147886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9S5hKR3Q9jtJKLTHVg9rJOjWtvZaDRDoo7tiPR+mJPw=;
        b=wq0p8kXtaFaZumbLF7xYGaSfJRmZIQVIy/eK86L39ggOI67iXZNBjBD1AUVqgVOK0d
         QSb65Z/6iwph4ucFEmljF7LtdNJzAYWLuuMJryKRaTYczY6q8XmRkvQoZj++VfIE7Ulj
         KjMQEtIO5dhms/XcZ7wtTlRjii/meLFNYSaOZCWEzS9zjmKjm+HWBS1lAasFtmSH3IiZ
         GDwwhD2OQOMaPvrX1aw4GOLmMgIvouegb59aAqPveENTeMPErvNumxfamdInCpFq/729
         I1nIQtn5fZNxYtXMFR+03RnKE+CFMn8nnh71mG/eC1M99/GSZB3bu7EtnZmI3frTcZqw
         W6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793543086; x=1794147886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9S5hKR3Q9jtJKLTHVg9rJOjWtvZaDRDoo7tiPR+mJPw=;
        b=aUSi6NlZUQS5s0h+8Tkf0AXHqt4izNHl6h4V1dWnFU/ilADQ2cVQBtn0VQrBnP2bPY
         rn3niTIgHSwytmEXf2k6PNrVf7jogHTINnXK1mqEB9w/5vrgnB7nQ3JM32zT9yqdBom/
         sshtyMImQLSu/RsWFcPKS4sDYjBdA3ezTFuL5oLREd3TErRlfvzrBoCP8PRlb+1dZtmA
         jBZTtQO3E8okyL565vNQWLyUKiDD53y3tjDp6S6lR4KLtyhCpHg84lmzu02qWTd9bvFg
         d8s3Ul6PrXW/u4YSngKteQPRiB0lin5Wrv8D3eC27HrP5TgmK8KYPur4z7oxI8J4mdE2
         6A4g==
X-Forwarded-Encrypted: i=1; AKwUvByePvAzHGWHq/h6tojxpOI/6dqqLbCUe/cXOtR5jy21TW5HlOzORh10PZsoT089ltn6ls0pVH4oWq+Jnw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9vGK7+1tku+0r89vsjKQmzECWe0Kba7VRC3RjdJxHMRX9zasqB
	IoA7DxHVbs0iUPqbZ5W4kAA1sxTpqAunNVbitoYaocFftVKO++iEcsy0
X-Gm-Gg: AYBFou2X8zKyP2UDxHA2WJu1f2D0tJvz3W06ObvRoCVc+48N13+OQxmEcGFQRCpJT/3
	eRBkX4za9rGTQdbfbLOsS5OYlNr20pZ0pckOchTk2Pgw0MAS3HjWOrRcIm7YMB6Fcl4z9I+5TZs
	TKOTovRyyaS1D5Gw1BV1STUovfks3ea19e/JFVRLurwPZWeOFHiyRxhV89IV0i2FZK+jgsUeB8m
	unSLo4EKAVj+KhTBdUdOw0zMZ66/GBo6Afi3XHIA8iKNC7NEKUDw8Ne21p4F487xPSZcYr8IvTP
	ggKr4DlxZRt35E+eXRZkDpfA6IFtUJ2CH9IUDelKJlWLUFmgvSFTd4ixRjWDjI2MKKUcLNJtlfz
	tEx1l8fYPOpP1tz5hmBKfSNuYcFxZv5pLIwBY6hZidhW5ELeQmqdvxtOJgunqMI2spmf1c85g2e
	LAJ64zmNLS/YgKsSU095HJBPgQnadeB58T2+sJ9W+OvGLQYYunHNGh4YWL9kAH0scmM1PCdsDrD
	Y+M/Wgd+LaLvGvAoL4BDM9k4pXaOZy5dNa7tDLtStckkQUZJ3hlsw0gkC4I7isS1WLrZXewIR5k
	ECvWhPJuLN5eQRCsyw3kLRssQN0lzE0nqH9U7JzVS1XnRlUnEw==
X-Received: by 2002:a17:907:558:b0:c4c:c62a:b9b3 with SMTP id a640c23a62f3a-c4cc62ad38bmr131681666b.22.1793543086239;
        Sun, 01 Nov 2026 06:24:46 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabf0bfa2sm279135766b.80.2026.11.01.06.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:24:45 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Cc: linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v1] video: leds: backlight: lm3533: Support getting LED sources from DT
Date: Sun,  1 Nov 2026 16:24:35 +0200
Message-ID: <20261101142435.130520-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Control Bank to HVLED/LVLED muxing support based on the led-sources
defined in the device tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
This was part of the original LM3533 controller DT/OF conversion patchset,
but it appears to have been accidentally separated during the final iteration.
Therefore, I am sending it as a follow-up.
---
 drivers/leds/leds-lm3533.c          | 60 +++++++++++++++++++++++++++++
 drivers/video/backlight/lm3533_bl.c | 45 ++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
index 7259097bd6a71..a1aeff70a90fc 100644
--- a/drivers/leds/leds-lm3533.c
+++ b/drivers/leds/leds-lm3533.c
@@ -26,6 +26,11 @@
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
@@ -54,6 +59,9 @@ struct lm3533_led {
 	u32 max_current;
 	u32 pwm;
 
+	int num_leds;
+	u32 leds[LM3533_LVCTRLBANK_MAX];
+
 	bool have_als;
 };
 
@@ -622,8 +630,36 @@ static const struct attribute_group *lm3533_led_attribute_groups[] = {
 
 static int lm3533_led_setup(struct lm3533_led *led)
 {
+	u32 output_cfg_shift = 0;
+	u32 output_cfg_val = 0;
+	u32 output_cfg_mask = 0;
 	int ret;
 
+	if (led->num_leds) {
+		for (int i = 0; i < led->num_leds; i++) {
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
+
 	ret = lm3533_ctrlbank_set_max_current(&led->cb, led->max_current);
 	if (ret)
 		return ret;
@@ -698,6 +734,30 @@ static int lm3533_led_probe(struct platform_device *pdev)
 
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->pwm);
 
+	/*
+	 * If led-sources property is not set then either this Control Bank uses
+	 * its default LVLED or is not linked to any LVLED at all.
+	 */
+	led->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
+	if (led->num_leds > LM3533_LVCTRLBANK_MAX) {
+		dev_err(&pdev->dev, "num of LED sources exceeds max %d: %d\n",
+			LM3533_LVCTRLBANK_MAX, led->num_leds);
+		ret = -EINVAL;
+		goto err_deregister;
+	}
+
+	if (led->num_leds < 0)
+		led->num_leds = 0;
+
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
index adcd6ac7cf229..e8164c8528577 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -7,6 +7,7 @@
  * Author: Johan Hovold <jhovold@gmail.com>
  */
 
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -21,6 +22,7 @@
 #define LM3533_HVCTRLBANK_COUNT		2
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
+#define LM3533_REG_OUTPUT_CONF1		0x10
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
 #define   CTRLBANK_AB_BCONF_ALS(n)	BIT(2 * (n))
 #define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
@@ -35,6 +37,9 @@ struct lm3533_bl {
 	u32 max_current;
 	u32 pwm;
 
+	int num_leds;
+	u32 led_strings[LM3533_HVCTRLBANK_COUNT];
+
 	bool have_als;
 	bool linear;
 };
@@ -236,6 +241,8 @@ static const struct attribute_group *lm3533_bl_attribute_groups[] = {
 static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
+	u32 output_cfg_val = 0;
+	u32 output_cfg_mask = 0;
 	int ret;
 
 	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
@@ -243,6 +250,21 @@ static int lm3533_bl_setup(struct lm3533_bl *bl)
 	if (ret)
 		return ret;
 
+	if (bl->num_leds) {
+		for (int i = 0; i < bl->num_leds; i++) {
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
@@ -320,6 +342,29 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->pwm);
 
+	/*
+	 * If led-sources property is not set then either this Control Bank uses
+	 * its default HVLED or is not linked to any HVLED at all.
+	 */
+	bl->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
+	if (bl->num_leds > LM3533_HVCTRLBANK_COUNT) {
+		dev_err(&pdev->dev, "num of LED sources %d exceeds max %d\n",
+			bl->num_leds, LM3533_HVCTRLBANK_COUNT);
+		return -EINVAL;
+	}
+
+	if (bl->num_leds < 0)
+		bl->num_leds = 0;
+
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

