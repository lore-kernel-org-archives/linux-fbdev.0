Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1849C19CD1E
	for <linux-fbdev@vger.kernel.org>; Sat,  9 Nov 2024 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731174447; cv=none; b=VX+0hVlPaII+5w1wMunr1epvrez4xmZUmgi+Gqj6iN1yxc5LOvh7V0rXQu+psV5YLeonwOJkctI0Oqw7fsT8ibPo8PdQVDjxdDY+4riEp5Dw1qiIloQhfxCr5Wu6Jw2QxosYjHuuaCfv/Bwz8x9lZEd9mlTRaVuWdgN/wubEzgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731174447; c=relaxed/simple;
	bh=E2geTdbXiQmLaAty8/2EMgECF6diNU8eKtMXb4ZB/kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EnTSKidZItirzhgjGbx3rUy8931hJ+pAVhS3LGVJd3aIxLslU9vTfQfDXDvRE8Yqveh1TYyHbvCd3jEiJwinmux6f+1SOR2ojo7uSX9B68jEaNUoYpI0qXV6wmeu6/jegej1R5lddRfUlwEmAc+If6UqwgKxijrJtRHuIjPB4HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pqgGVyCx; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pqgGVyCx"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cefc36c5d4so4337498a12.0
        for <linux-fbdev@vger.kernel.org>; Sat, 09 Nov 2024 09:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731174442; x=1731779242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mS9pz7F1aaDN/ZOdRUw2lCD3EzMHHJ9M85Tk+LBqBLI=;
        b=pqgGVyCxwUl79K2AnrIVtFfl9QmqShcR93qOBN4ju680ZPEYd4o6H0Z81IDXii9Tq3
         vR+rIbN4N6bjjAQoLLGyZlLqM04N6/gTCxkovtvUPLPqVR8tIdvUeuR6qP8WDojfDzDP
         bF/5feiztnfJqgKXTtJMLCxVT7f3u+fxFhFSk+udEUsYIG4Hp79TCmD1JpYF69hvOhum
         82jG/OZWOaZbjd7ms0y+mnmx9HijXgW/uJOq2WmiR0FpmZmI5uIbq0Ij9+ET8oQQFHyf
         4gzGKffHtM25LvmpPkFGlgT0vPUvHuLGvjQMXH6aadCyk8+Grn7unm8y480/xeBAXrsv
         gffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731174442; x=1731779242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mS9pz7F1aaDN/ZOdRUw2lCD3EzMHHJ9M85Tk+LBqBLI=;
        b=jiB9T/JtE9l641m8Xm70FwfsDnlayo3fq0HUNrDXd0FwLmKDGcPGCBNt9sDuT9FUJ5
         b6yIs5a2bZCxjMC+4XmBJln0Dq55goiuAaujeTo204Fph+W5cjKs+HakXr3zHfSGIe0F
         OnoXq5UhofaZH8FJtSqmVKlNvN84BSJhA7vb0com5jUj//hYT1+Ux46Je7q+A3f/rDzW
         ECnytAGComf9nvwSvUZKsm/k3wxix0MQP4ZokyHBQCSBSrSAtqmprONmKNQXdmZ6Ra8x
         82K/3SPHiUFWKhYVYwE05xnSb4EfrxRliL4ihyhY50DcuRitDgXk1Yp0NBomTnIF4OQz
         5SkA==
X-Forwarded-Encrypted: i=1; AJvYcCU3VHt4jl+kmlpkk6bO7rcGePnIsKpLZNDrqzUyYIiCHReWguTi7N+G6zvgHIsecPyuTP25hbbkBb1dXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0GMXoGOZqZIy85xVpRNcUR4NQ77aJLB8LcDQp+GOzEMl1p8Ye
	Jtu1EYZWZnfOpZHfNglhOhRRIxuwqRw/ttK8b+2bjOl2168oyz35tFFmoirqi94=
X-Google-Smtp-Source: AGHT+IGJCTMOIjftfGiK2wILQrVE69oNLiwz7mzb5YOsUCHt/S1Cp1slGT50grlnlMbHdWGpyNa4Cg==
X-Received: by 2002:a05:6402:5203:b0:5cb:6ca3:af96 with SMTP id 4fb4d7f45d1cf-5cf0a3245camr5846634a12.19.1731174442127;
        Sat, 09 Nov 2024 09:47:22 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb7530sm3155853a12.43.2024.11.09.09.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 09:47:20 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH] backlight: Switch back to struct platform_driver::remove()
Date: Sat,  9 Nov 2024 18:47:10 +0100
Message-ID: <20241109174710.292128-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8119; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=E2geTdbXiQmLaAty8/2EMgECF6diNU8eKtMXb4ZB/kM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnL6Afi/iMzSDb+OigQAp+L7XwwVJGKjDySz/NY fOeD6CGpd2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZy+gHwAKCRCPgPtYfRL+ ThzhB/sGt+oJ4HQwFpd3iQmQbVXTZGNqc/ag8Kv0rc6jUt1eEG9M5LKySpZneqakogzueVU12Aa 9N0pkYhmrph8F9iskLUhrowJwEHPzvNF4d+iGb9bPMs9eqPDf03T05qiQNDtdviMl8AA8CViwX9 ksWE4uE5+HNIPq9mW0fMoOhukaYrROQ0dpkv8cEOIp91zyifjxlRL9RVU4qXAQqZ0wLZgDTXeiL ePV5Bn6e4r/pjQsX4kwvMKRoIvRrKEEq5+d1+/uVFQktjYLUDsntM8jr2fYt3llq/zxho1zr8vY MSJV4DO3Jt/OSOYcuWtM3vsFxpQBOF0yE6jwqCrXNEsStJGm
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/backlight to use .remove(),
with the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I did a single patch for all of drivers/video/backlight. While I usually
prefer to do one logical change per patch, this seems to be
overengineering here as the individual changes are really trivial and
shouldn't be much in the way for stable backports. But I'll happily
split the patch if you prefer it split. Also if you object the
indentation stuff, I can rework that.

This is based on yesterday's next, if conflicts arise when you apply it
at some later time and don't want to resolve them, feel free to just
drop the changes to the conflicting files. I'll notice and followup at a
later time then. Or ask me for a fixed resend. (Having said that, I
recommend b4 am -3 + git am -3 which should resolve most conflicts just
fine.)

Best regards
Uwe

 drivers/video/backlight/aat2870_bl.c         | 2 +-
 drivers/video/backlight/adp5520_bl.c         | 2 +-
 drivers/video/backlight/da9052_bl.c          | 2 +-
 drivers/video/backlight/hp680_bl.c           | 2 +-
 drivers/video/backlight/led_bl.c             | 2 +-
 drivers/video/backlight/lm3533_bl.c          | 2 +-
 drivers/video/backlight/lp8788_bl.c          | 2 +-
 drivers/video/backlight/mt6370-backlight.c   | 2 +-
 drivers/video/backlight/pwm_bl.c             | 2 +-
 drivers/video/backlight/qcom-wled.c          | 2 +-
 drivers/video/backlight/rt4831-backlight.c   | 2 +-
 drivers/video/backlight/sky81452-backlight.c | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
index 68d327ee4b2e..8b790df1e842 100644
--- a/drivers/video/backlight/aat2870_bl.c
+++ b/drivers/video/backlight/aat2870_bl.c
@@ -186,7 +186,7 @@ static struct platform_driver aat2870_bl_driver = {
 		.name	= "aat2870-backlight",
 	},
 	.probe		= aat2870_bl_probe,
-	.remove_new	= aat2870_bl_remove,
+	.remove		= aat2870_bl_remove,
 };
 
 static int __init aat2870_bl_init(void)
diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/backlight/adp5520_bl.c
index 8e0e9cfe5fe9..aa5c15e8db86 100644
--- a/drivers/video/backlight/adp5520_bl.c
+++ b/drivers/video/backlight/adp5520_bl.c
@@ -375,7 +375,7 @@ static struct platform_driver adp5520_bl_driver = {
 		.pm	= &adp5520_bl_pm_ops,
 	},
 	.probe		= adp5520_bl_probe,
-	.remove_new	= adp5520_bl_remove,
+	.remove		= adp5520_bl_remove,
 };
 
 module_platform_driver(adp5520_bl_driver);
diff --git a/drivers/video/backlight/da9052_bl.c b/drivers/video/backlight/da9052_bl.c
index b8ff7046510e..5e13ef96b717 100644
--- a/drivers/video/backlight/da9052_bl.c
+++ b/drivers/video/backlight/da9052_bl.c
@@ -165,7 +165,7 @@ MODULE_DEVICE_TABLE(platform, da9052_wled_ids);
 
 static struct platform_driver da9052_wled_driver = {
 	.probe		= da9052_backlight_probe,
-	.remove_new	= da9052_backlight_remove,
+	.remove		= da9052_backlight_remove,
 	.id_table	= da9052_wled_ids,
 	.driver	= {
 		.name	= "da9052-wled",
diff --git a/drivers/video/backlight/hp680_bl.c b/drivers/video/backlight/hp680_bl.c
index ddb7ab4df77e..fa9a983533b2 100644
--- a/drivers/video/backlight/hp680_bl.c
+++ b/drivers/video/backlight/hp680_bl.c
@@ -130,7 +130,7 @@ static void hp680bl_remove(struct platform_device *pdev)
 
 static struct platform_driver hp680bl_driver = {
 	.probe		= hp680bl_probe,
-	.remove_new	= hp680bl_remove,
+	.remove		= hp680bl_remove,
 	.driver		= {
 		.name	= "hp680-bl",
 		.pm	= &hp680bl_pm_ops,
diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
index c7aefcd6e4e3..ae34d1ecbfbe 100644
--- a/drivers/video/backlight/led_bl.c
+++ b/drivers/video/backlight/led_bl.c
@@ -246,7 +246,7 @@ static struct platform_driver led_bl_driver = {
 		.of_match_table	= led_bl_of_match,
 	},
 	.probe		= led_bl_probe,
-	.remove_new	= led_bl_remove,
+	.remove		= led_bl_remove,
 };
 
 module_platform_driver(led_bl_driver);
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 5d06f8ca976c..babfd3ceec86 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -387,7 +387,7 @@ static struct platform_driver lm3533_bl_driver = {
 		.pm	= &lm3533_bl_pm_ops,
 	},
 	.probe		= lm3533_bl_probe,
-	.remove_new	= lm3533_bl_remove,
+	.remove		= lm3533_bl_remove,
 	.shutdown	= lm3533_bl_shutdown,
 };
 module_platform_driver(lm3533_bl_driver);
diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backlight/lp8788_bl.c
index 0b7663519fa5..f61a64905a02 100644
--- a/drivers/video/backlight/lp8788_bl.c
+++ b/drivers/video/backlight/lp8788_bl.c
@@ -177,7 +177,7 @@ static void lp8788_backlight_remove(struct platform_device *pdev)
 
 static struct platform_driver lp8788_bl_driver = {
 	.probe = lp8788_backlight_probe,
-	.remove_new = lp8788_backlight_remove,
+	.remove = lp8788_backlight_remove,
 	.driver = {
 		.name = LP8788_DEV_BACKLIGHT,
 	},
diff --git a/drivers/video/backlight/mt6370-backlight.c b/drivers/video/backlight/mt6370-backlight.c
index 94422c956453..e55f26888d0f 100644
--- a/drivers/video/backlight/mt6370-backlight.c
+++ b/drivers/video/backlight/mt6370-backlight.c
@@ -340,7 +340,7 @@ static struct platform_driver mt6370_bl_driver = {
 		.of_match_table = mt6370_bl_of_match,
 	},
 	.probe = mt6370_bl_probe,
-	.remove_new = mt6370_bl_remove,
+	.remove = mt6370_bl_remove,
 };
 module_platform_driver(mt6370_bl_driver);
 
diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index e942908d1275..237d3d3f3bb1 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -697,7 +697,7 @@ static struct platform_driver pwm_backlight_driver = {
 		.of_match_table	= of_match_ptr(pwm_backlight_of_match),
 	},
 	.probe		= pwm_backlight_probe,
-	.remove_new	= pwm_backlight_remove,
+	.remove		= pwm_backlight_remove,
 	.shutdown	= pwm_backlight_shutdown,
 };
 
diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 10129095a4c1..9afe701b2a1b 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -1741,7 +1741,7 @@ MODULE_DEVICE_TABLE(of, wled_match_table);
 
 static struct platform_driver wled_driver = {
 	.probe = wled_probe,
-	.remove_new = wled_remove,
+	.remove = wled_remove,
 	.driver	= {
 		.name = "qcom,wled",
 		.of_match_table	= wled_match_table,
diff --git a/drivers/video/backlight/rt4831-backlight.c b/drivers/video/backlight/rt4831-backlight.c
index c2f6fb29e1d0..7ead75929a43 100644
--- a/drivers/video/backlight/rt4831-backlight.c
+++ b/drivers/video/backlight/rt4831-backlight.c
@@ -224,7 +224,7 @@ static struct platform_driver rt4831_bl_driver = {
 		.of_match_table = rt4831_bl_of_match,
 	},
 	.probe = rt4831_bl_probe,
-	.remove_new = rt4831_bl_remove,
+	.remove = rt4831_bl_remove,
 };
 module_platform_driver(rt4831_bl_driver);
 
diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
index 935043b67786..2749231f0385 100644
--- a/drivers/video/backlight/sky81452-backlight.c
+++ b/drivers/video/backlight/sky81452-backlight.c
@@ -337,7 +337,7 @@ static struct platform_driver sky81452_bl_driver = {
 		.of_match_table = of_match_ptr(sky81452_bl_of_match),
 	},
 	.probe = sky81452_bl_probe,
-	.remove_new = sky81452_bl_remove,
+	.remove = sky81452_bl_remove,
 };
 
 module_platform_driver(sky81452_bl_driver);

base-commit: 929beafbe7acce3267c06115e13e03ff6e50548a
-- 
2.45.2

