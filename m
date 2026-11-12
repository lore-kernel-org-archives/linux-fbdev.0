Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471609;
	b=lfhU8sLTmaLA04hvRdieq/OpzqMiUtb9k26I9ThZD72IBtNrtx3jQY4V+UDtjBRX6VJi
	 RVYqYKRFG3ejft4gJA2nUujc5RBj0TIWuz33srsidwGWvFZ8ja/AQ9vJLoZRaDFTYujhl
	 Oia0H33jCKuoI5i9gSR0XoxO27o1/pa5gie16r8ggC+faIRJcVxWJuTLhJsnm0OjVJfyz
	 nHJSRldXTsWpN0aYJR3GSDYFeLHou3Mi5Y0RVWSi+MKro0hTosUJo+Ru2bfXnlwvGBC5F
	 cMQeoXbG0coblXa/8hLObymc6kdOJkusFkE9kfNyuPyBjRWPYp5tKCl9Fss7D2opJlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rU4i6XVY/9JL9bi+qmA1w92G0CtofTM34rsUqi+UGrs=;
	b=ZYCnZNGGr1oRXAxu4SceG4myYKFWfeZ88UaisCzhXxnIOefQjBH5w2Hc339tpYbJlNlv
	 vj4V1+Q0YOoaO0EyRV4l2S8iC8pGv6t11nDRC6gYnHtY9K+XzXHtaGXR82khjm7qkyuvl
	 Yv33235lrmdAJV6bGHKpB71wq20mbdiqi7hlRxo85xqFZPzrv3Asn6WDKK5pSNXMSfsEJ
	 BNdeM71fZYOY1zSP2PJNamvEeaA4OB63Sv8PoDe8GOZg40rGhzGCzs054lfvyFTyCxtwf
	 Ur9Nt59KW2sa5ej+eFlBPj3A4rMfXDFTJoqIxAITtvuOJZ/+Sghoa4WB2+G+NX/ClGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k76KJz8b;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C05606A323
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Nov 2026 08:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07C05606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k76KJz8b
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c505b2e1cb9so23043066b.2
        for <linux-fbdev@vger.kernel.org>; Thu, 12 Nov 2026 00:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794471607; x=1795076407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rU4i6XVY/9JL9bi+qmA1w92G0CtofTM34rsUqi+UGrs=;
        b=k76KJz8bSjhf/JnDAS5vPzaw8WqGpetl1GpLuZzpWuDDzFZpwI4fL0mB9K1w82KrK0
         hSb1ErK7gDowCliTwk1O92+0QSOJaGL6XPzCXtSjHlnu8RJ9VVSxu7ZJUbw72Xjkfa7c
         oN7WCKOz1g/1GUb+NzfLmEM3s04iFJZeImkktoewfvDvs71fq6gpK6k/bWoTh6ZyrdDI
         Vwj9zWyUFQJvYwS9h5HQPjJ1xv8hOu69aEVvaeZSST/4GuadYSgf6JAKzLC71l80JQXM
         DzQ2NgycByvMw93sOecjyNZnKTu1ewqfefsDgiZHCT13A3EQcxdsoHhpG+oziV2694Iu
         oJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794471607; x=1795076407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rU4i6XVY/9JL9bi+qmA1w92G0CtofTM34rsUqi+UGrs=;
        b=CHFpZMsF+RqwpS7i6qHp6IePHqJBttWSn2HL9cPkOasdar4K48b3IH7OXneRzXDNWS
         UQqvmCfGf8Jzw+DcYS5hNve3M+YsY0aKtdI9WKPS4rFKw/N50VXD/rT2VC4aDETsPzkM
         y4hnNbsOsiX4agmstf4wFvun/6Tm+jRktrdFnXDb1c2PDVdDT0TCT46FF330gmRnl1Ye
         wJ0H/ygOWvPYW0aSZtyVJFC207SVOAyG+oM2EVgCm/KMEM712Wg8hSAIyIqQ2g7gpdRA
         rhhCTVzdXWy4X72ZPwQEOZP57mHsy+S7Y4VxCXSbUYAj0pHpVP180fvGUWylu1VjmRJo
         fUuw==
X-Forwarded-Encrypted: i=1; AL+hErE69Jt/SWM/DhjtuQdWfEuErX5rCuEttMmUg6msKDNF5bI8rARHMtZ9nCLd7Ik3MzTqAeYkoHeQntK4wQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/AHZ2xeb2SVxxAw3M4eajv/bSUbAeMqFvP2qXcVe5ZlxH+NsI2
	KMW8rO1Bsz2pIanOJ8CMI6QKZp4fhXzP3RXkk5tk1sUthrxAJCNB9TWp
X-Gm-Gg: AYBFou0K4cIM+VMInMispzTFKpS9SruVHa2mQ8xcANtYNRraB+0CDL0DPsmoZyIEJpO
	0nt+1Iwp49WUYd7FNpC4Si9IbcBIkYPWWB2Vj8J0xOwmxm73JRy9xXUYwPWPB71LF9yn20cN1wI
	ZpE+DLoFveXpWfo1KshQzG1rTDSWtajn8kGmyHIFr2GEf8mbGQLWq15RQzgPnAhs798yxDzLWLw
	S70gIC84GBh9GqKqhT6h5dRUP4daYbyeeYVZmKbmKZmGXJ+z6kVVbwVK5u509hu3kbM+PSo4/uq
	XzB16OY6cyAkhs0GeAlujImNEQciV67a5akoYqrYNKTBRXl3QBCNSpjEIajTHTj61JscS2XdGHh
	gXARQ8sV+3Jja3cRlOCdMhKkLDNQN6G8l+fpt4MckE86DXHbNplV9i9oT9skKs3BqyA2SJp60HU
	jdG3wtyGwszWXEQJ4efBFnr7GDBiDa3nOO6gXvyD51Eo0afZ7i4QRFKoXtWgdaiUKPyeXjq+96E
	QiwJS2qeU33pukvsCKevGq6TSbFU9Kp6/8EPYwdLU0/5oiqTfOWGNg4NG2zGypQmzHGH2sm90pV
	9BqZnfgN7LZAqS761B/OumWIJ7t3ZiPFLVOQl+aPAsI9RcuB7BFds8eNvzoMogIzPbg7KLC+UbW
	6b+4/93m84g==
X-Received: by 2002:a17:907:7ba3:b0:c50:4d71:a855 with SMTP id a640c23a62f3a-c5066ad7440mr341389866b.19.1794471607157;
        Thu, 12 Nov 2026 00:20:07 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a62a91bsm312997966b.57.2026.11.12.00.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:20:06 -0800 (PST)
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
Subject: [PATCH v2] video: leds: backlight: lm3533: Support getting LED sources from DT
Date: Thu, 12 Nov 2026 10:19:41 +0200
Message-ID: <20261112081941.41363-1-clamor95@gmail.com>
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

Changes in v2:
- leds: switch to macros in regmap_update_bits() calls to apply 0xff mask
  since regmap writes may cause unwanted writing.
---
 drivers/leds/leds-lm3533.c          | 62 +++++++++++++++++++++++++++++
 drivers/video/backlight/lm3533_bl.c | 45 +++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
index 7259097bd6a71..0612f99d3dc7d 100644
--- a/drivers/leds/leds-lm3533.c
+++ b/drivers/leds/leds-lm3533.c
@@ -26,6 +26,13 @@
 #define LM3533_ALS_CHANNEL_LV_MIN	1
 #define LM3533_ALS_CHANNEL_LV_MAX	2
 
+#define LM3533_REG_OUTPUT_CONF1			0x10
+#define   OUTPUT_CONF1_SHIFT			2
+#define   OUTPUT_LVLED_MASK			0x3
+#define   OUTPUT_CONF1_PREP(x)			(((x) << OUTPUT_CONF1_SHIFT) && 0xff)
+#define LM3533_REG_OUTPUT_CONF2			0x11
+#define   OUTPUT_CONF2_SHIFT			6
+#define   OUTPUT_CONF2_PREP(x)			(((x) >> OUTPUT_CONF2_SHIFT) && 0xff)
 #define LM3533_REG_CTRLBANK_BCONF_BASE		0x1b
 #define LM3533_REG_PATTERN_ENABLE		0x28
 #define LM3533_REG_PATTERN_LOW_TIME_BASE	0x71
@@ -54,6 +61,9 @@ struct lm3533_led {
 	u32 max_current;
 	u32 pwm;
 
+	int num_leds;
+	u32 leds[LM3533_LVCTRLBANK_MAX];
+
 	bool have_als;
 };
 
@@ -622,8 +632,36 @@ static const struct attribute_group *lm3533_led_attribute_groups[] = {
 
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
+					 OUTPUT_CONF1_PREP(output_cfg_mask),
+					 OUTPUT_CONF1_PREP(output_cfg_val));
+		if (ret)
+			return ret;
+
+		/* LVLED4 and LVLED5 */
+		ret = regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF2,
+					 OUTPUT_CONF2_PREP(output_cfg_mask),
+					 OUTPUT_CONF2_PREP(output_cfg_val));
+		if (ret)
+			return ret;
+	}
+
 	ret = lm3533_ctrlbank_set_max_current(&led->cb, led->max_current);
 	if (ret)
 		return ret;
@@ -698,6 +736,30 @@ static int lm3533_led_probe(struct platform_device *pdev)
 
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

