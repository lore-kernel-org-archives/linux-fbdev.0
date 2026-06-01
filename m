Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6746A3DEFF3
	for <linux-fbdev@vger.kernel.org>; Mon,  1 Jun 2026 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327170; cv=none; b=gMf9zjrbXaH1vNFC+2BdO7xwrfodylAc9zkFA5s2dO157vgZI5X0VWWWdW8Ax7GelTva6nQx7AGKPNcrer3dCPXYfHmG++i80AfQdCxLcYZMti1HKMJHfGtt9Y3dg7UvW9VNoFXo4ejVA9VprjEwc6XX/Y7aTsWq2K24etza61o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327170; c=relaxed/simple;
	bh=Gqs7G7t00pywVX3rRhClLifko2DwPlgtzGf6OODWNOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLQwAPEtgAJ5hUq7bo//C1ZeDwWD9CQOOzdJyk47AN5GiuzYE28VdB8j637/YGcL4GcK48fkkRLQCxjhe5YtDgTpYSCPZDETTvkHFcOiMj1UWs+20sPDE6P+AI0o4kXFBq26EEivK+T4W92lPudOI7xV9JIwyf/OKM1KGtbueMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlWReqmt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlWReqmt"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4908b92904fso50656345e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 01 Jun 2026 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327153; x=1780931953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33jV+tJR7Nm5ReUL1Jncj608Et9Ag1X54glyJfKp5cY=;
        b=SlWReqmtNBJgpuPqFBJ12rBdSTE7NTWat1EwcxNlvUeN/Q1Vmuq084pYnUVAPpNXTh
         K/7XijqDSNVP7JleW6xrVBhilYT/7pjmhsYeZF9ykncXIuFMw/AtI6IpMBZR6qIu4CtJ
         alpPerpSV5LkvxU/kBG54B0uhhRDRFWkd5FMNNar2kl+3CugOLVhYN6/sc2ugYKu+TAw
         GEE5AbOxDZlxbR00XBDHRloB4HW4NFOiKkUllyhnpOAiKzdCZtt3ofTzfdmmP4Uul2G0
         L0AR5zkgyJnyrnDlY7WwxlOVcK0V5rKis71rON1FV69F0QFYRmo/K1JgOYetuUizzmJG
         jEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327153; x=1780931953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=33jV+tJR7Nm5ReUL1Jncj608Et9Ag1X54glyJfKp5cY=;
        b=ev2lh7AcpJP6REiFNw0/d7zlc0mnUU2UBjg0KalC6Bl02izx8YRdQhawzI2OErErOf
         7voSmkBXn9ZgM0jzeNuZE97IYetxfLISrGgcVg22JG0Rg75Jt2RA7f6PwONDF1umgNXX
         3PSGqXknOajzlRFw/xoxq0TTqtZZJFkHl0NiHCVU1YZa0v3VH3oc7/BaQgPQvcEMZmfO
         T2Ea0GDcZgeLLDhjprlQ0RyzzY9BT9w+2+UzdIdAziOmjX8nWyD47NDEPVfH1qOh0Wx6
         N/U7a1L+BPACml9N9X/ydUeVhVf72hjnAWVk9NUpWAjU/rE7DhfXqPhWQWaY6borBUDp
         RrjA==
X-Forwarded-Encrypted: i=1; AFNElJ8QUhvM4hoivjCmb+gLFwnBuqNBQ383iLbDBjU+R0HPF3YPunvxtUSGWv5v1SzQECB8O2qwyokC2LwpdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRnRdKcUrQ0Ve1PhkpbSf20VaXFEpH1hKiROHwkH4lhC7coqwX
	JowsDqz5tUs8zjFkfaZfJr8jXnQTcyJMuBptV2WuUohR+DO65SVzBvEC
X-Gm-Gg: Acq92OFJplq4g4Gf3/qMVYCM81iZUetzibYhp0PpnmG6fCuBguU8Z7hsBUAbL6dDHeR
	E1w7R0LGBhF3RPhG9pXqqw59jfGg1ilBM575NxCqsg8rXnBz6AEV6UbP2puL+wiM23rvS9c0MnD
	XREkA/nDvAeeoOkJ7Q1GRs5C/UwiYLhN+bAFdyxjLWYd5X/WastewRP4e0RSfNN69mx6Y8RAOWG
	bsuCD92w4RQX9XREel+wuZM2dHGAdzNVOlY4VXoja84475uYyPIUog17IlZSmapw2J6OSxrtoIX
	OTXBMQYJvTcnVKawiPbVqHw8FW0jV6hqtbO3HgQYyrA4pAFEW6XzZSiwqWb13miYJ9OWJy5o2hx
	7cotYUrOA+uOGvf3YSB4Hs/AdZ3rFODl9EkUYhH/8fk2vo+RP9776SDAR7nmm3lyYSu7aqwU3Bc
	IXD/9fqb832cSUkz++MnL+TdEBI1W8gLPWFQ==
X-Received: by 2002:a05:600c:6385:b0:490:40f1:5314 with SMTP id 5b1f17b1804b1-490a290ec08mr258749965e9.1.1780327152708;
        Mon, 01 Jun 2026 08:19:12 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:19:12 -0700 (PDT)
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
Subject: [PATCH v3 10/11] video: backlight: lm3533_bl: Implement backlight_scale property
Date: Mon,  1 Jun 2026 18:18:30 +0300
Message-ID: <20260601151831.76350-11-clamor95@gmail.com>
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

Since the device supports linear and non-linear modes, implement the
backlight_scale property to describe this state.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/backlight/lm3533_bl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index f0d88b7bc229..945625c54fc4 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -161,6 +161,7 @@ static ssize_t store_linear(struct device *dev,
 					const char *buf, size_t len)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
+	struct backlight_device *bd = bl->bd;
 	int id = lm3533_bl_get_ctrlbank_id(bl);
 	unsigned long linear;
 	int ret;
@@ -174,6 +175,9 @@ static ssize_t store_linear(struct device *dev,
 	if (ret)
 		return ret;
 
+	bd->props.scale = linear ? BACKLIGHT_SCALE_LINEAR :
+				   BACKLIGHT_SCALE_NON_LINEAR;
+
 	return len;
 }
 
@@ -309,6 +313,8 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	bl->linear = device_property_read_bool(&pdev->dev,
 					       "ti,linear-mapping-mode");
+	props.scale = bl->linear ? BACKLIGHT_SCALE_LINEAR :
+				   BACKLIGHT_SCALE_NON_LINEAR;
 
 	bd = devm_backlight_device_register(&pdev->dev, name, &pdev->dev,
 					    bl, &lm3533_bl_ops, &props);
-- 
2.51.0

