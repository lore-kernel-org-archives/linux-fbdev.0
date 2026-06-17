Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE35A3CF96B
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jun 2026 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683260; cv=none; b=lgT5SkU0g3SNCN8caQ4Xqft3E4o9oDGt08363M04gfzOM/xgLwV0dBCJSExjYD8QofwC0ztNDZVrHSg73ZXk9xzFQ/YMqnsoW8IMte263fRC86VpEJ714OCroQ3BSCTNBHZqCiPZVFCMYo/HETq0XkZpZUQA+HzLhIQYS6QDHmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683260; c=relaxed/simple;
	bh=BwWYKnYatgp0/f3D570qVWCNy9eZh1sTktWSktle2dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgG8tqoz43tB93RIK/+ASjNoGPv1jOQyGSL4vx90hOW+hjEvpl3FHGunOM13jSUdp09tyiYvwakfh7paGuTa4PPC3+ahn/XvTG3PVCIhIbdc3kCdiW+FhObzU0jSNOpX8Qhp4U1iO+1OYgB+ZHSL/E0Fp43n807JYOGbesPj4Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5FvIMP4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5FvIMP4"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bf0170c80f7so929882566b.3
        for <linux-fbdev@vger.kernel.org>; Wed, 17 Jun 2026 01:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781683251; x=1782288051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8y+i4Wk6Q8lVb7K/zxazYX8oolr+QPONOjz4+CZ6S0=;
        b=q5FvIMP48mll3yVpjAuWYJ3T/u8Cg5dIq6l67h4fvUg3PiilFeHS/nBCe7KHm8M2nM
         Uw6BTGaGfd8U7E+7yrdpvDibkoKmSW1uJaJbWTDZiicaqgBvJG6suX6gkT4ul/q1vY8a
         KwvRRXWHUAY3HgPapPfOu6PCw4Bo4quZLc1xxm8bLDfeabnMf+CYz3z/KqIMjp3lcU0m
         d0YAQhg5bS3P9346WFMu5yzpdSeMkQRrstkj+AlCbaAQBMgFuVRvanArFdAz0sFbAjkw
         Madl+Dx5oaB5m2CXiBeH64ew2UakvEOt9V0yJ43GlGY2wNHo1TlyN2Y+YE5emmm9bk6u
         wO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781683251; x=1782288051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j8y+i4Wk6Q8lVb7K/zxazYX8oolr+QPONOjz4+CZ6S0=;
        b=Lx8BmW/qXMHJtFANirwlawR3ZGnDLpk4zYb/dRLKdY60y8eR9n2AJqCCNWAyGj2FvV
         anq9Q00kLBCZDLSO5HcuXGy4YDxcEC6xFKlNBwC9Hw7Pwa8E/rOuJ07zxCFzK7srZp3o
         30cHl4l0qfcCV0y+TB8LZR3aI9qKulSoi8tcvbkqmTWtLC1QbH0mZ94XWiyeWiOUbqOH
         G0AdJIAHnDGGDO28Hkt9m5ZvhJMaC7jcuSFcMgM3hewB2PwU4jnN+Q8lTT0hwlVTtl4h
         i1PkRC+wtkwm5Wb8GG6InfNDYFqisNsvZbZqIOSyQj7ivXhIPkJR3Uf+7uDZLFmSMXTL
         Ky8g==
X-Forwarded-Encrypted: i=1; AFNElJ8UeayZL0qs6w1r/ezVs2pXv7JBTZp1hOxl9nebSMEvHr3qkQCNyWrwO5cmFs8oWOCb5erdNxMV7m5EUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUgt5R9u7szU37PNIH4k2R5CweNTCEdGfqNbxXtS1SZ9G8xNBJ
	7fF7QGgCNvPx1qWLTXd3N0EnHd85j1GriSULQPuHfMMrezo+3iFBvY+y
X-Gm-Gg: AfdE7cnfnJGFzKsVdkomnP2vX1tYKQp0Zxaw1baNx+YzPsJ4l01gy5HNpLTVadtxKr/
	R4HXqEP+VablTe0ui0tz543aD5MsS7nqFYXTGWZLIr72EM6d23Y2IZO3tQ9xzswDPmGK7X8KmFU
	ULrI/yHkUhKtjS2ZBcvHgmNpmfODhDg0D1EpI9r0my6rkqe8P9cXEP4OHnwHhVlVecOpMHCNRK7
	n9f7kRXWSoUU2OTBfZEXqykk4IEYVulRkRmCxhRhAGu12bzuuM0t4I3Cqdtx5+9Ce77MVulYSTa
	ev1p8PUAvU9S7eDIxsyX5ZpBULlOVBYxT7iafJ7+k4CzvLvjTULIz10qMSmCWoHeLDYlRhh72qw
	etYqt7tTNr1IRtCAgyipyeUdAeN0zaccgD9NE/rMp9BXwNo0gC/sBXrG/r6JELKElYa7i6mZjJ/
	+o08SWJrTOyOSl
X-Received: by 2002:a17:907:d02:b0:be2:d66:eb4d with SMTP id a640c23a62f3a-c05a7abd063mr208115166b.44.1781683250733;
        Wed, 17 Jun 2026 01:00:50 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:00:50 -0700 (PDT)
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
Subject: [PATCH v5 06/14] mfd: lm3533-core: Remove redundant pdata helpers
Date: Wed, 17 Jun 2026 11:00:23 +0300
Message-ID: <20260617080031.99156-7-clamor95@gmail.com>
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

The lm3533_set_boost_freq() and lm3533_set_boost_ovp() functions are used
only in lm3533_device_setup(), which in turn is only called by
lm3533_device_init(). Incorporate their code directly into
lm3533_device_init() to simplify driver readability.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c | 57 ++++++++++-----------------------------
 1 file changed, 14 insertions(+), 43 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index f9bdc0a1d9be..45e7f7481aa0 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -80,35 +80,6 @@ static struct mfd_cell lm3533_led_devs[] = {
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
@@ -406,18 +377,6 @@ static int lm3533_device_led_init(struct lm3533 *lm3533)
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
@@ -437,9 +396,21 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 
 	lm3533_enable(lm3533);
 
-	ret = lm3533_device_setup(lm3533, pdata);
-	if (ret)
+	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
+				 LM3533_BOOST_FREQ_MASK,
+				 pdata->boost_freq << LM3533_BOOST_FREQ_SHIFT);
+	if (ret) {
+		dev_err(lm3533->dev, "failed to set boost frequency\n");
 		goto err_disable;
+	}
+
+	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
+				 LM3533_BOOST_OVP_MASK,
+				 pdata->boost_ovp << LM3533_BOOST_OVP_SHIFT);
+	if (ret) {
+		dev_err(lm3533->dev, "failed to set boost ovp\n");
+		goto err_disable;
+	}
 
 	lm3533_device_als_init(lm3533);
 	lm3533_device_bl_init(lm3533);
-- 
2.53.0

