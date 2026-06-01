Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA193E0098
	for <linux-fbdev@vger.kernel.org>; Mon,  1 Jun 2026 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327173; cv=none; b=nwjLVInIoJn9MmGDjSE7cWmvJahN3uFi6Dic2yL0DYGUBh/12sdv9ql0EyrcmBe2y3WMEhDHKHMxO7deuKH+O3524oE33+nUd6i/YsidZu5rSqeJsGrE2uaiRgZSSbHEFAKlNhTal4tTmSVh5CoMy0wskrVpWGHwmN0IBbkDw5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327173; c=relaxed/simple;
	bh=RZTQ2H/zzNTFrVxP5f5192LTONxSh/ltoz3RRhQzsG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXBRs1B8r7jbXWHxtU3t6bXxo/HjLDyhrG/TTWXKnuSOKVLpEj2gNb7rScSnvBwdOdf0TrzSeEx1j9Ha5Oi1YF9IJJm4mZDbW1Q4F9/5ouhKSyWL0hxnet/+YkjMwi5NpKI4bEht5SBtKWv+cnYYLzwzZ8h8Wz/kKkptlpwWQiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1/4O/gP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1/4O/gP"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so1806488f8f.1
        for <linux-fbdev@vger.kernel.org>; Mon, 01 Jun 2026 08:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327154; x=1780931954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fl3qFf3690+fE50JY3SQOXjzJEQ1bfcjE1YgTovPA6E=;
        b=h1/4O/gPfRv/HHJqc/lQyR287miEaJngBhbvey0jCYwGsUUUF05RtFdcwvDFn+z6Zj
         6FWGRME/fTf4SFB3c3DR7hQBjG3CiAiVbPMDh/SRyM3GykIxJUGB/MbJMTzn5btjcazo
         e8y+ByQORZZP5U0QfLffflTrIv5drS6KYIWtDZYBOTAwSbgS/jvjsM1G0L8Se3EqCbk7
         Gbv41GbC1+SFKHFWKK0E5S7yOdCrhGgPP5+6s1nXkjy8yuEvORbscLTFDhd+dVKFCWhw
         yinQbg/1FXZte3lPlRoKDbBDCJ8BE8tIbe46fofSQ6mbERohk9e/zQqSSZIvUmy+ClK3
         JPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327154; x=1780931954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fl3qFf3690+fE50JY3SQOXjzJEQ1bfcjE1YgTovPA6E=;
        b=HWPMncOGG55kBD/5JeTF8M6yJnp5JF+gep7st+XjUyCc0wLQZXKKO+SuEYnHysK7G8
         fAsvjNYW9Yq9Ver5OB7eduyxgWru7xLqoq3RezDsf44RvTgVNd11n+ClAQzXXm17JVC8
         2d1DWm2JfydSolDAr1AP/TZYYul79yatJnmO8BNIX4k0YjL9gkQsW4AjHqxe8xJBg+qb
         n6c44OarKrPTMed+67NvyxO3CCsrOsk9V9lDV9uUp7GDtJbg3oqnSBIig66cUxLQ2q/0
         gbSBd3/f0CCETwRyfX6VcKyEcr2sfUHqLURAQOlGalaortgSLhDNwVjFqpS6en9J6t9s
         JwrQ==
X-Forwarded-Encrypted: i=1; AFNElJ/jOInd9ZxPzsFf2GCr3SUd0h+GzZG7EMsi2YEL7JDTuyGwgcHtCQLH+EruJCeNxU/fR64NnkCO8lb/4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHVBHt67x8vDnc+H38IWBxr3hziVo4SvimlwvAj/0dR2uAgy/X
	wQaeKBlSWJHImbuN2wsfjKcb8WuFh/At9hyVxbIPRyTKjzMeogpkarvG
X-Gm-Gg: Acq92OFNeLJZiUik/7QMiQxig4RAZS1p8P2sYAAjQpXg9+4KziPjTivf19FM9Sb3AQj
	mBsR6bYOR+eUnGL2ygGm8J/QwMjwlJSoluNgMRU5NkL9LewRdNiH/LBrqxTyr5kwDKEz4+BcXRC
	dQjuQm91fbP8/efrvrN+hPrH+ZfjCe5Ff/SsHPQdTN4H3nyPek2kg0pv+a3AjGcO9kSHeHwIsj2
	eff3D2PTTosyU88emQybnLuWX+HImf77yQI13TAdxOijgEu1sbvtOvNKADi5L65yNkI3gp3AuGE
	5LM3HC4nqMLWkWkSt7dOpzY6XSjyYQPDMm6Bpa/LamNBouYXr00/Bybl9/TAVGDFi8iwViaUAtL
	tiXyNnjShYHHrIIi10aP1CuMPQOoU3x/Ai3Lxd3+Z2pVp+GQcjH6ja3oolvT19zy5H6Nd3uM06x
	bvHbdJ1Ft5HUrtKe1L1QKV6xY=
X-Received: by 2002:a05:6000:1376:b0:43d:7868:21f0 with SMTP id ffacd0b85a97d-45ef6afc537mr16294468f8f.9.1780327154150;
        Mon, 01 Jun 2026 08:19:14 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:19:13 -0700 (PDT)
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
Subject: [PATCH v3 11/11] video: leds: backlight: lm3533: Support getting LED sources from DT
Date: Mon,  1 Jun 2026 18:18:31 +0300
Message-ID: <20260601151831.76350-12-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260601151831.76350-1-clamor95@gmail.com>
References: <20260601151831.76350-1-clamor95@gmail.com>
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
 drivers/leds/leds-lm3533.c          | 55 ++++++++++++++++++++++++++++-
 drivers/video/backlight/lm3533_bl.c | 40 ++++++++++++++++++++-
 2 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
index f2502daf450d..6db1c1fd2e20 100644
--- a/drivers/leds/leds-lm3533.c
+++ b/drivers/leds/leds-lm3533.c
@@ -7,6 +7,7 @@
  * Author: Johan Hovold <jhovold@gmail.com>
  */
 
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/leds.h>
 #include <linux/mfd/core.h>
@@ -27,6 +28,12 @@
 #define LM3533_ALS_CHANNEL_LV_MIN	1
 #define LM3533_ALS_CHANNEL_LV_MAX	2
 
+#define LM3533_REG_OUTPUT_CONF1			0x10
+#define   OUTPUT_CONF1_MASK			GENMASK(7, 2)
+#define   OUTPUT_CONF1_SHIFT			2
+#define LM3533_REG_OUTPUT_CONF2			0x11
+#define   OUTPUT_CONF2_MASK			GENMASK(3, 0)
+#define   OUTPUT_CONF2_SHIFT			6
 #define LM3533_REG_CTRLBANK_BCONF_BASE		0x1b
 #define LM3533_REG_PATTERN_ENABLE		0x28
 #define LM3533_REG_PATTERN_LOW_TIME_BASE	0x71
@@ -54,6 +61,9 @@ struct lm3533_led {
 
 	u32 max_current;
 	u32 pwm;
+
+	int num_leds;
+	u32 leds[LM3533_LVCTRLBANK_MAX];
 };
 
 
@@ -641,7 +651,33 @@ static const struct attribute_group *lm3533_led_attribute_groups[] = {
 
 static int lm3533_led_setup(struct lm3533_led *led)
 {
-	int ret;
+	u32 output_cfg_shift = 0;
+	u32 output_cfg_val = 0;
+	int ret, i;
+
+	if (led->num_leds) {
+		for (i = 0; i < led->num_leds; i++) {
+			if (led->leds[i] >= LM3533_LVCTRLBANK_MAX)
+				continue;
+
+			output_cfg_shift = led->leds[i] * 2;
+			output_cfg_val |= led->id << output_cfg_shift;
+		}
+
+		/* LVLED1, LVLED2 and LVLED3 */
+		ret = regmap_update_bits(led->lm3533->regmap, LM3533_REG_OUTPUT_CONF1,
+					 OUTPUT_CONF1_MASK,
+					 output_cfg_val << OUTPUT_CONF1_SHIFT);
+		if (ret)
+			return ret;
+
+		/* LVLED4 and LVLED5 */
+		ret = regmap_update_bits(led->lm3533->regmap, LM3533_REG_OUTPUT_CONF2,
+					 OUTPUT_CONF2_MASK,
+					 output_cfg_val >> OUTPUT_CONF2_SHIFT);
+		if (ret)
+			return ret;
+	}
 
 	ret = lm3533_ctrlbank_set_max_current(&led->cb, led->max_current);
 	if (ret)
@@ -716,6 +752,23 @@ static int lm3533_led_probe(struct platform_device *pdev)
 	led->pwm = 0;
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->pwm);
 
+	led->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
+
+	/*
+	 * If led-sources property is not set then either this Control Bank uses
+	 * its default LVLED or is not linked to any LVLED at all.
+	 */
+	if (led->num_leds > 0 && led->num_leds <= LM3533_LVCTRLBANK_MAX) {
+		ret = device_property_read_u32_array(&pdev->dev, "led-sources",
+						     led->leds, led->num_leds);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to get led-sources\n");
+			goto err_deregister;
+		}
+	} else {
+		led->num_leds = 0;
+	}
+
 	ret = lm3533_led_setup(led);
 	if (ret)
 		goto err_deregister;
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 945625c54fc4..2119433bae45 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -7,6 +7,7 @@
  * Author: Johan Hovold <jhovold@gmail.com>
  */
 
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/mod_devicetable.h>
@@ -22,6 +23,8 @@
 #define LM3533_HVCTRLBANK_COUNT		2
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
+#define LM3533_REG_OUTPUT_CONF1		0x10
+#define   OUTPUT_CONF1_MASK		GENMASK(1, 0)
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
 #define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
 
@@ -35,6 +38,9 @@ struct lm3533_bl {
 	u32 max_current;
 	u32 pwm;
 	bool linear;
+
+	int num_leds;
+	u32 led_strings[LM3533_HVCTRLBANK_COUNT];
 };
 
 
@@ -253,7 +259,8 @@ static struct attribute_group lm3533_bl_attribute_group = {
 static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
 	int id = lm3533_bl_get_ctrlbank_id(bl);
-	int ret;
+	u32 output_cfg_val = 0;
+	int ret, i;
 
 	ret = regmap_update_bits(bl->lm3533->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
 				 CTRLBANK_AB_BCONF_MODE(id),
@@ -261,6 +268,20 @@ static int lm3533_bl_setup(struct lm3533_bl *bl)
 	if (ret)
 		return ret;
 
+	if (bl->num_leds) {
+		for (i = 0; i < bl->num_leds; i++) {
+			if (bl->led_strings[i] >= LM3533_HVCTRLBANK_COUNT)
+				continue;
+
+			output_cfg_val |= id << bl->led_strings[i];
+		}
+
+		ret = regmap_update_bits(bl->lm3533->regmap, LM3533_REG_OUTPUT_CONF1,
+					 OUTPUT_CONF1_MASK, output_cfg_val);
+		if (ret)
+			return ret;
+	}
+
 	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
@@ -336,6 +357,23 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 	bl->pwm = 0;
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->pwm);
 
+	bl->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
+
+	/*
+	 * If led-sources property is not set then either this Control Bank uses
+	 * its default HVLED or is not linked to any HVLED at all.
+	 */
+	if (bl->num_leds > 0 && bl->num_leds <= LM3533_HVCTRLBANK_COUNT) {
+		ret = device_property_read_u32_array(&pdev->dev, "led-sources",
+						     bl->led_strings,
+						     bl->num_leds);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed to get led-sources\n");
+	} else {
+		bl->num_leds = 0;
+	}
+
 	ret = lm3533_bl_setup(bl);
 	if (ret)
 		return ret;
-- 
2.51.0

