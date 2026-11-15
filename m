Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794732727;
	b=Y2JkyXQaiYutJtoB6rYlI8QmRThtxejNqO7+fR/W9VLx1uQGX05u+sG1bi+ucQWoT/Ek
	 0WiKsIvjlwoG1vW1ifQAYyVFZzhF5RBzNygzRC7p/UsKesobSBTvN/FJPsMRPB9trEt/g
	 R87Ycj0EytBjR3ZDghwhG3G66VdjzWkT9PXLQQ1h66ReS6iqquTHHMeH9sN5BvqJJoIur
	 rJ/fKZFfDmLxXuLsJIElWNBajo6i6aMQB0SlM5jQxcnrMSS5jb/p6Zjr9ue78GHxw/J2M
	 bvZXZKYcaUyw1mV2ZG6xBhMyCiabkGh9M4PiLTmCVhs7H1/6iY7VqEZNIlIeHaG29Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794732727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cVjBt24AZadG8lfyxs4mRXI5N5Rh1ABfAQ7ljq9C298=;
	b=STuSo7uKY0ZQ/iRz341TFxCm6pNFCLvZ2/6aIAVxHMvNPf4iGCYE4UbbrmlU3MI3OZ6x
	 giLHVhq0cSsMsXw79GRXJy+/hPF3gikBt4hbuXSbeyFQ5EmMseiEBeWBNRqHnMxc0qSSm
	 vB0m2NghPXgGXok5ZOB5hsYUD0Ne4mAmBjMNacWbM5K7Vrdsl8iybD+0Rs9OwdWcILHj8
	 fpdI/xaDSA8NxsZMzHC6OjpYJMMYar6NbAeMJCYEK/lCXMru5YCoWH9U2q34A/U+a4yj5
	 YzoJr76PuUqpfd3V2wWxy6WeNg8DvIRgSANLBhm1hq120sDW+8iL5zuQiTGQBUnWuGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N5CnSrK5;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E104606A31D
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Nov 2026 08:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E104606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N5CnSrK5
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b587591414so3082326a12.0
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Nov 2026 00:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794732725; x=1795337525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cVjBt24AZadG8lfyxs4mRXI5N5Rh1ABfAQ7ljq9C298=;
        b=N5CnSrK5PjiERs3XjuKDct+r3kV34T7huuhONym/1t3LnJYualzj+8qkB9FrYdMblM
         P6baO2JIy7weNaQydD95hE5qUYCRTOukJsL4oayCT3+b/qkM7ASLzNAsewK/S7deP9Cp
         r3sXX+4hrNNOXxvkxQPYgEBVa96ti22mNqKXdHm7+Ia2DrlGbCyxtwVlkzoKAmVFKtze
         f/l9qSpNSwOYTkUavOSit24BwqzL3DwlnzavyoYeCC5UpHVV/gYYbOp4Hq/pAEwuFtc+
         YF0FMewXCAHh5MAzS1pjq16Bxm+KjC1oGRbnUcLFAoD/iU0vqHNOD8+vb8OzMIX4QPLi
         3B+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794732725; x=1795337525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cVjBt24AZadG8lfyxs4mRXI5N5Rh1ABfAQ7ljq9C298=;
        b=Q+96ZAO8ivZTVD85DvzrgWvfqzkwIzXu1+G4Nmj4qwDuhx3U7n/t88pKhBObrA5zJ6
         24tbGazVp4bHxZ6KdM3TqVZ5mSTZS89w02csH0ve9lFQEoCkeNS6a7mSIi2i9B+5n9Vu
         n6mc9uBYGKfbW1YY9Ptfr3YGTssKC78GN1eoOHHk4zFPdEfleN7HyDPc+m6nPkctjXqA
         Rm8a3ImG70TBHYMQ4EfwHKgUGtiMPNLdtUR0XcbuYmcvbhIcLzMtTyPRUfNoG+V36xCh
         ZK5RQVIvwfLxFa0k7Ar/lF3n9otLa1NqMDowlIoZI8HFsTNfvqnWIy/eAe0F+Glmhl9x
         KiFQ==
X-Forwarded-Encrypted: i=1; AL+hErEKQKAhmNdTRL8b4nurCLi9caLuLfwUd5BAUSod2Zx5JlfwIfoZLzSiS3H/XRkFv2K3yw5xRZGScwysww==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Xc49e0CDn0xX2u6o7LlDyLXHcsSSdwq0jRV7hSOgqSam6lEuA
	tnpybtb5b/VB7NGBMZHoSi3pPI1NyDyCSM489X/njmUmHnwCR0Mc6asAbyLRIw==
X-Gm-Gg: AYBFou3GVPxr73Z5tkfqDUN8WvQjuq9QESBzz854v4bOdPV08laEEX7WNnkh4gqPRvz
	VLq0ngbqPgEBtQDDuHv1LZNrcQ5ePRaGuGYpEro1OBFe2sYQpBKnRc/eRAqzuR+bpkbNJbybSp9
	amqdbtwhWeT4j5TZgMsv0KYCMuPOexYrfkns1hguIPbvoxw+IthsYlz3K5rXqk5uxn6jXifbrvP
	xXCO30MaW7Xw8zjVfrn5/dRwNnR9uAkU0NLX8VOA1NgxtNSa2bg553/muaXFN99QIRPZj7r/9ZT
	fk/ciPXo4U9NTdMAl062z6j27dpz92BMuWXiE/8wyBVtXpgDiGrpFo/GcuwFrOCmfFxo5rJt8Sn
	UOEvEuiOJvsrRn5d6XMB3E+qAlXWPg8NNyyr08w9Cy87Vv/0GMNBpY0VHIht/9J4p6vDtp12fQN
	GJf/aAt6LGy4seb9E1JFhK6lg0b9DPGL3XOCBlB/TK2XQcxoUdGzc9GbMb6VuD4ZUcTNH3EXaHA
	HRx/eYnqUydm6hfcU2Tfd8oQ43Kn7hMEHqkbLpvx98JPkynQKoTdG38hQIxt04myHWd/RcLu1IX
	teZ/6Z9j2pbm6MESDrg8fX5+7udOYO7J8NwwtlSzLPsnqwQ2odXhCcvaWqINuy4Y+N4LwPGHGlw
	5FW0u1Ie0bQ==
X-Received: by 2002:a05:6402:42c7:b0:6b7:eda4:e136 with SMTP id 4fb4d7f45d1cf-6b7eda4e281mr1999786a12.41.1794732725246;
        Sun, 15 Nov 2026 00:52:05 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23c672asm3090610a12.15.2026.11.15.00.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 00:52:04 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] video: leds: backlight: lm3533: Support getting LED sources from DT
Date: Sun, 15 Nov 2026 10:51:55 +0200
Message-ID: <20261115085155.80043-1-clamor95@gmail.com>
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

Changes in v3:
- leds part moved into a separate patchset
- switched to dev_err_probe()
- for loop moved out of if condition
---
 drivers/video/backlight/lm3533_bl.c | 44 +++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index fd6e7f4f1f61c..cb9df6ff73001 100644
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
 
+	for (int i = 0; i < bl->num_leds; i++) {
+		if (bl->led_strings[i] >= LM3533_HVCTRLBANK_COUNT)
+			continue;
+
+		output_cfg_val |= ctrlbank << bl->led_strings[i];
+		output_cfg_mask |= BIT(bl->led_strings[i]);
+	}
+
+	if (bl->num_leds) {
+		ret = regmap_update_bits(bl->regmap, LM3533_REG_OUTPUT_CONF1,
+					 output_cfg_mask, output_cfg_val);
+		if (ret)
+			return ret;
+	}
+
 	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
@@ -320,6 +342,28 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->pwm);
 
+	/*
+	 * If led-sources property is not set then either this Control Bank uses
+	 * its default HVLED or is not linked to any HVLED at all.
+	 */
+	bl->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
+	if (bl->num_leds > LM3533_HVCTRLBANK_COUNT)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "num of LED sources %d exceeds max %d\n",
+				     bl->num_leds, LM3533_HVCTRLBANK_COUNT);
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

