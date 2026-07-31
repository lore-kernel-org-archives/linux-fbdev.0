Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1323F926D
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 11:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497826; cv=none; b=hEeYB764l4pKhL319z7vvgo2/Gmlk+1tF9GjrixO/MisNH1R7OY5v7zrdFC09gC/pDKJh/VUuP9tkbLvHONix30f1MmVsWEuf3vDiwP5yUHcUWSldeEobb0efP9q5G7/zkNL4tIQhEvNy6mnSFlcLojRaBnG1lvJur0XrfFO3C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497826; c=relaxed/simple;
	bh=utgrkcrPEexnwKubYxzeT83rM8IkZKoDxi9jYmOHcaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUXdgb42nCwkwAvxogGjoJuuQzUUmgwm/TsUa9q8ydWF0BSztEbJSSkTVFnVcVoT+KaqEGRK8LSyUDWtFBxW/j4GCmLqQZSeQ4C77ONeNeJZxSoujvNdvZouw5oE3tPxXNQ1DdxqPOl23R8kkiriHd4udaTE1dbopp+jlIHULiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVsyJL0i; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVsyJL0i"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47de0093c42so184475f8f.3
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 04:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785497822; x=1786102622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NbqFKXAPXCgqFlzsfbnx5DNlo8ULOW4jbUhFKit/7gU=;
        b=bVsyJL0iA1ILDrQepRgEpqQNOPuwkNzhvXYcEx5ESXDi44zEYYSGlwME8ecqFNVOn+
         LMoHcPanl7RD/WZOh+zci0B7M+w7KuS4UDhiAj/Nx33nM9TWb6gizZneGDH1mWs6UL0g
         FGuy5AuoWbUdLAMpaITzdx/obza62VLz7reFi/BRy98xqZ558/n7c3euCCqjbhHlCV/3
         VBSf1lUJSXxP1aC9U8Nt//L2WPoBq1KaYlWzpTho8Mi9j8XT4GJ1c361IpzoCgSylCzi
         EcIwsi6JEKKW/MoJzc9V+isAXWy7meSh+qSCLfEHIXbP+eD1TFIfRPH2EzB8vA5b/4iu
         oFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497822; x=1786102622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NbqFKXAPXCgqFlzsfbnx5DNlo8ULOW4jbUhFKit/7gU=;
        b=nl4mpxWk+/LkYFwrP0GwW8mticjpUHrIRMtpzzkX31PGwyDpiK/RW4bM7nuk7LGt29
         38lx/nmOIQbYdsSeWi4UQDGCkNIuk6QbZDWbkYW3Bz1a7eBBWUdliLzpZfVbk9WJ6gp+
         Q/Nv0VKc1PkePtQSXNcOQnrf6doXQzkwMQ7Ndgy7/+uGHUkQrx+hhMZ0OZsFmE5uNImm
         HuHebYiQbJEwJsaRV2L0Nhb0fCmN6kUTwjFYJd/f7q+2rjZEKmW2IKlT8J9tMuvH6VlO
         RL5YECSveCKF2tWfFilpSf5sZH2owZZQ1radcoqJMznwWLRIyZPW9lJkf+cYKIZ4yNdR
         HSLg==
X-Forwarded-Encrypted: i=1; AHgh+RqIeHFRDLvFgwVQOWHvwI7NmickRlcE8Hlu6aaDlXLO/0+WA/jaQa0LBCjkPP/iPnyK1RzjJoKhlOPZ/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpiriIdgNkCDK7yLcOGkmdp9Gycq1g2uko65Mf3AgEo3Lp8PAV
	J6mKvEdsYON2FvIk9x3wAsjwZe9yNr2YUvnYJ2+HsZLvaMXgDjkBTtHd
X-Gm-Gg: AR+sD10i5QQJlOzf/ineo4kgKlvBXoHKaiG75XNuraznReKdjHkqyrlZce/Jcg1p+nL
	Im8Ac7k58juXK5qBB0A8V/DeeYiQ/LpOxSZVjcux96p+hqGrXj/89G5NqVox8VMBu/qQwArwPtc
	tEPwxgxhsF+nFxfiCjudxeqUSXADfSNqh7YmC0U5mbFOGdv3ghwkx/9k39pg7Lwb0h5M6F+J/ZU
	83MwmzC5gdXAEwRERiZBD35OoM4MV3pBqxFRmwzcBpcyA66JiLflz4OUy8BBCkgH32T8lMTKmpZ
	6RXPq5tl3VTSx5jzwlQNG4vbXt+fv09yBCznFpY4fVMwP/Ahk6xtt/5Od4kHMiOaT1CsCTZkOd/
	1ji72fENNsPhGrPWqm0lTCPinTbnrRuHboyEpkAX8p1F74HwNdEML1ECiu0viUt3ymisV3X02xI
	tYkbv+33G/hg2QPWI+yAr6mHLk0ed8PZ0bZC0N1pKaUhqUjHQZ+GqZnQBs69r7dpjR3bUSsO/NW
	9QN9twx3g==
X-Received: by 2002:a05:6000:2997:20b0:47f:9661:6766 with SMTP id ffacd0b85a97d-47fd2b9824emr2824366f8f.61.1785497822299;
        Fri, 31 Jul 2026 04:37:02 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:37:01 -0700 (PDT)
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
	mfd@lists.linux.dev,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v6 06/14] mfd: lm3533-core: Remove redundant pdata helpers
Date: Fri, 31 Jul 2026 14:36:24 +0300
Message-ID: <20260731113632.158440-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731113632.158440-1-clamor95@gmail.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lm3533_set_boost_freq() and lm3533_set_boost_ovp() functions are used
only in lm3533_device_setup(), which in turn is only called by
lm3533_device_init(). Incorporate their code directly into
lm3533_device_init() to simplify driver readability.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c | 61 ++++++++++-----------------------------
 1 file changed, 15 insertions(+), 46 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index f9bdc0a1d9bec..5baf934fac825 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -7,6 +7,7 @@
  * Author: Johan Hovold <jhovold@gmail.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -23,10 +24,7 @@
 
 
 #define LM3533_BOOST_OVP_MASK		0x06
-#define LM3533_BOOST_OVP_SHIFT		1
-
 #define LM3533_BOOST_FREQ_MASK		0x01
-#define LM3533_BOOST_FREQ_SHIFT		0
 
 #define LM3533_BL_ID_MASK		1
 #define LM3533_LED_ID_MASK		3
@@ -80,35 +78,6 @@ static struct mfd_cell lm3533_led_devs[] = {
 	},
 };
 
-static int lm3533_set_boost_freq(struct lm3533 *lm3533,
-						enum lm3533_boost_freq freq)
-{
-	int ret;
-
-	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
-				 LM3533_BOOST_FREQ_MASK,
-				 freq << LM3533_BOOST_FREQ_SHIFT);
-	if (ret)
-		dev_err(lm3533->dev, "failed to set boost frequency\n");
-
-	return ret;
-}
-
-
-static int lm3533_set_boost_ovp(struct lm3533 *lm3533,
-						enum lm3533_boost_ovp ovp)
-{
-	int ret;
-
-	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
-				 LM3533_BOOST_OVP_MASK,
-				 ovp << LM3533_BOOST_OVP_SHIFT);
-	if (ret)
-		dev_err(lm3533->dev, "failed to set boost ovp\n");
-
-	return ret;
-}
-
 /*
  * HVLED output config -- output hvled controlled by backlight bl
  */
@@ -406,18 +375,6 @@ static int lm3533_device_led_init(struct lm3533 *lm3533)
 	return 0;
 }
 
-static int lm3533_device_setup(struct lm3533 *lm3533,
-					struct lm3533_platform_data *pdata)
-{
-	int ret;
-
-	ret = lm3533_set_boost_freq(lm3533, pdata->boost_freq);
-	if (ret)
-		return ret;
-
-	return lm3533_set_boost_ovp(lm3533, pdata->boost_ovp);
-}
-
 static int lm3533_device_init(struct lm3533 *lm3533)
 {
 	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
@@ -437,9 +394,21 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 
 	lm3533_enable(lm3533);
 
-	ret = lm3533_device_setup(lm3533, pdata);
-	if (ret)
+	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
+				 LM3533_BOOST_FREQ_MASK,
+				 FIELD_PREP(LM3533_BOOST_FREQ_MASK, pdata->boost_freq));
+	if (ret) {
+		dev_err(lm3533->dev, "failed to set boost frequency\n");
 		goto err_disable;
+	}
+
+	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
+				 LM3533_BOOST_OVP_MASK,
+				 FIELD_PREP(LM3533_BOOST_OVP_MASK, pdata->boost_ovp));
+	if (ret) {
+		dev_err(lm3533->dev, "failed to set boost ovp\n");
+		goto err_disable;
+	}
 
 	lm3533_device_als_init(lm3533);
 	lm3533_device_bl_init(lm3533);
-- 
2.53.0

