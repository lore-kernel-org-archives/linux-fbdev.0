Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790FE3128DF
	for <linux-fbdev@vger.kernel.org>; Sat,  6 Jun 2026 04:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721924; cv=none; b=LeHEWvFIvfDtZKJs4/4i/sEEpLgVE90X5KuMWw3o8HtRBmtwj6fKbBLBjwJMnCIpKsl5dr6milmtL8g6Hq1+f2hJ4ghJgb0OL+3nQ9jBbf2/gUdC1STBHotb1L/s6LRhcjzEi+EQhZ1f+8kVB+PP6xzTymLwVXiV9Q5EqFzGzaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721924; c=relaxed/simple;
	bh=1X3Fe5KMAyI8d0lBSX7gzgdG4WYUQVZ8AWRde1CmRRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XK9TmNJOwitElQVgyVAQfoM0PLhqUYk/KueIzKtCQwY+W97nkTT0lD6CLI4Md0xlJ8LOrnYuogww1X0PQc0IowL7npVNLF4J10hyFYesN5a65YllqAdKOtx/etG/8bAEyo+mgLRlxZBVutzZdJtvn5e3L3HFk+JAfauwx3chLd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtSr6VpN; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtSr6VpN"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bec429c2bb1so382389166b.1
        for <linux-fbdev@vger.kernel.org>; Fri, 05 Jun 2026 21:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780721922; x=1781326722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMzv/S8Y4Icyy6C4SSXqpDWOb9w1xnX2+g+CSvM++O4=;
        b=WtSr6VpNr5A1Ml2hGyJFaVqvyy6fxdgIFVLXIUFtW0YsU3e93OWG6eVDH8OYO/VAXH
         qnqlb2GvKyBGxF+ZNcPHtJeyGzapi/3lhMyI4yUHGvLA4eXjYkHd8e0xqptkOzsX+p8W
         lTXYexnL2obWiFIU7CJRXtRV8/QzFvPgR8ctCxYHSSwshvvUSOM06XPi6V+nd1FcmCMh
         P4s5eYoK/Js6UOp083Gw+pKhrJ6JBvWzgf/Q75tkU4sVMVkl420LeDTV2CBMiCNb5X2V
         KlJ+AW/m8Z4g7n99HixqijrLfpY9aaisaNNkmWbiziId9dTqjRv/aJzhQTAepwRJhyHf
         RCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780721922; x=1781326722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tMzv/S8Y4Icyy6C4SSXqpDWOb9w1xnX2+g+CSvM++O4=;
        b=E3wW5aYgDQogJD/ENnARDaajFQFrpOYPBCmnZrWQLU/DJzV/mRIqnzkse2Q2/fjXoR
         td0gY7aSYg833Zl7HS0/uK+cGbiaVfC5iC9SpeuVEDrCbvnxSblNBvMS0ihF3fsAE0JX
         XMgKGKZDSv5VI4OKea2aemGYGlqRWKR5wzxTZt56A6UyCIBROJudoQjqyHAJc9fuE8Rp
         Nim7iiZsPdeMIPy1m0wu2CKy4JSuxTqWPrLVNtkp/Vlez8TuHuj0fs6mz10kE434CFs0
         DB24SjHpCtkda/YGVJjzm2A29Bx/eFj1H+ukE7giEFQOxLBmrW1v5aRTfYoghlCuIa8v
         7Lbg==
X-Forwarded-Encrypted: i=1; AFNElJ9Y+fesNvpTpwZ6rQJpIRJLfsWtcARjUF1imMzCcMKxcXLG6BMDNRrDefmRMjVuR8ux2V6Sv8U7ljnpeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxA1FgD8KPpZH7CDXgVtnPUcF5YcLw+B+x97DNfHxhRGPtD+rOD
	PFTBS/DamwMH3Bya6Dazd0a0tUl4iP1hQ5/ifZ4+62T2vCkgb1/aiB3v
X-Gm-Gg: Acq92OHYwepgj8mXU3bY9CrbRlX5BvBCU6co6nkiEGqdEUUtN3ZEPgzOTszznYn8ZnA
	O9IJQEUIOhtH5P36PlcqcBBkmwyV76gWXJwLDAaDBvDsvVKphP50wszH+dDAyiPxyH9Cl0iXpNr
	P54zO0UnnigdLFXv0W3heRw5xKMzEOOo85B/AXWuknEH32xk2YHFKdnkVm7dW0K3pgoIg07zlQl
	rf+ZEkQrS+/c22ww5K/izbvYFQ0FujdBbueY60SxXyV7ZxvHP2fAPt5VYu1FtduT94MdXWpGtIQ
	zLwofRiNjefzFOy0tkJMEjFeznskRcyxg5eP610ZV1kOjQ/zbUjy0MxCPhdK2ITr9+/US1DkyTl
	We7E3e4anvNOraJowKHxkF0wkPWaykdHVdhSdKVAK2+4IP92wT3D/ai4TuSkKMXvVVcHUK9pvEY
	HJO9iN1dv7B1eJqxZpzUUpZ0Xr+zwitIaxhw==
X-Received: by 2002:a17:907:6d05:b0:bed:afd7:185 with SMTP id a640c23a62f3a-bf3737ed359mr332707666b.43.1780721921881;
        Fri, 05 Jun 2026 21:58:41 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 21:58:40 -0700 (PDT)
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
Subject: [PATCH v4 12/14] video: backlight: lm3533_bl: Set initial mapping mode from DT
Date: Sat,  6 Jun 2026 07:57:36 +0300
Message-ID: <20260606045738.21050-13-clamor95@gmail.com>
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

Add support to obtain the initial mapping mode from DT instead of leaving
it unconfigured.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 drivers/video/backlight/lm3533_bl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 9ad7ea1bbbcc..4f8cde9f290d 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -37,6 +37,7 @@ struct lm3533_bl {
 	u32 pwm;
 
 	bool have_als;
+	bool linear;
 };
 
 
@@ -226,8 +227,14 @@ static struct attribute_group lm3533_bl_attribute_group = {
 
 static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
+	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	int ret;
 
+	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+				 CTRLBANK_AB_BCONF_MODE(ctrlbank), bl->linear);
+	if (ret)
+		return ret;
+
 	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
@@ -281,6 +288,9 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 	props.max_brightness = LM3533_BL_MAX_BRIGHTNESS;
 	props.brightness = default_brightness;
 
+	bl->linear = device_property_read_bool(&pdev->dev,
+					       "ti,linear-mapping-mode");
+
 	bd = devm_backlight_device_register(&pdev->dev, name, &pdev->dev,
 					    bl, &lm3533_bl_ops, &props);
 	if (IS_ERR(bd)) {
-- 
2.53.0

