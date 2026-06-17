Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952413D522F
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jun 2026 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683272; cv=none; b=iRcj3zPKA2NqEc+lUIH4mglx2nPubSZN7kab0DzKJboOwc8ZK76wT3hsKSU+4kISLPTqaOHkiPI97mPxLB9P/55isJa3Pp0lJg3TdOmwBKje21qcsiuvv6RTbok1reefXdANZToJowZwg6Bdy0mSKZJpMOelP5vlaZf+hrQix8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683272; c=relaxed/simple;
	bh=Ls0b0vD2wig6OC9g77u6/BGQVzYqGOsH2nEh1F6Jtno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXzz/vuukbUwrGWGjcaZXXF9jk3AlLxnOrt1wE46HCvS0+I2aJCrS87huuNngAMngf7DQsG2M3YTnqDcfaRZSuDgdrQkUe7XL8HOenYRNWMngujW/CkK8wrRAkuEI0MLHppPSH/dsPSK9/HGJp+ufkKuj9SosDr8Kjb8ADz6fig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j55C8Dpw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j55C8Dpw"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-695737cf38bso374619a12.0
        for <linux-fbdev@vger.kernel.org>; Wed, 17 Jun 2026 01:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781683260; x=1782288060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTLq06Trmxaj5LKPvLHLVj78rBrJr8ohTB02upYl/fw=;
        b=j55C8Dpw4JAjpowjX5MRGoQSu11jbYYeo6Zl4jngfa7KhsF/kDxBkNiNIbB3DDTU1M
         wPSA9RLVxsiaY1PpRPGEzt5DVTEr0KecZ+S72Qac0e98lOmV+U62TisaDvJRbgQ+0IQI
         S3hhEjGK+bz93ZR9xIXDP8vPetOaFqWE19npJqo3Fe8DWRDe3hu1+iVpCzJ8bePJETXB
         NNDicfx7oQGavFEabaO8h/fF9m0Mpj4JEsuMdYNFBJE9tptyGMwJs8V/s/6DOGGWm8Je
         PKkPTUxBYKuBCoLElUszqDDZMrSn7hpTKsL1EqbeB6vT7Fn/j9YW7Xm7B7uxqp5+fGJ9
         JZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781683260; x=1782288060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTLq06Trmxaj5LKPvLHLVj78rBrJr8ohTB02upYl/fw=;
        b=nAp1jF4dQHbyv4kw0zOWqIGW0jC+M0I/EUALRWCZ0BwcrHN5Ta+JyWHwZPhhdkyJaE
         ptwpEqp1VHkIqElBEhEXHuOBz9p3MuFyJe+2SaTDBDnRK7y/nBEYk+1XW81ndKpFFkUa
         mHzb9edbqNLM7ICxMl2bnOVYsLIjwpehCoxG5wlHOZTu7ukYqVpSXrPOzEyvCfIpXpzs
         L4sZG2EgmbpmZ6kbO8oP/jtj4UEFhrwKTVEMGNc6LD0hV146KlH9T9mn758/UJRz1NT/
         va/EHZxpqSmK1MsUbkgC5Q0VAU16VZ2uKzu76pKfFQHTwXGEMMth6P/VwMPxRM/sZ+3E
         IaBg==
X-Forwarded-Encrypted: i=1; AFNElJ+Rv4FB9T8DNwuacnB+yWKSl/6Fcxpm5+FXHU2FEgyAPA0d4Dxp0Mqtek7q0/iYXX0i/jRZdgzsTkHjYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtrrUWRooLrHAA109BBmMIb6bIumb/6lWImPb5l4+KuIrIpE1f
	WsHTTpCk/YA4LgBGN2tvKWGUBkNClT9icdlI0X0iRGXx1ChmSa5cxGX+
X-Gm-Gg: Acq92OGudzdX88cHKhuyKRCbv59s5eGUF+1IpkVbnJsO45l+GK34DsBhQf634aszTzy
	gjdhmdFDpJDD4PaVFxvoq1ps1Xo8QXnN+E53daZb3h3u2dUw/ZYuP7Yny649uqQ2CpNQ69qyz8h
	vzGe3k1KTo8b+jUXSkORFt8DOjGmdrLQvtSMJpdhYDvdKMHIxsXVlSbQqIDC4hmN+3QMrJguGQJ
	awf0TaRwrQH3tJs7lNQqPjqY38XxWoGFEMuC3ToDu8j0hkTBtDx610ML8eDMX6AO7LRuaFm7gP+
	WiaAxgG4lz+17UgHp88c25adB34BkuYYwoGgt7DEf0aUDgHkqnmFaVc1mwJDBsaLgNSEtpSrhcr
	iuX7ddzBf/bNg1DKq1d2Xxma8K+6em0cP/RSOOw60zOXU8UVJqJ2IiBIEKeVj0BWRI/uYcMhqVM
	GF4w==
X-Received: by 2002:a17:907:da4:b0:bf9:ad4f:4437 with SMTP id a640c23a62f3a-c05a6105803mr189014466b.3.1781683259392;
        Wed, 17 Jun 2026 01:00:59 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:00:58 -0700 (PDT)
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
Subject: [PATCH v5 12/14] video: backlight: lm3533_bl: Set initial mapping mode from DT
Date: Wed, 17 Jun 2026 11:00:29 +0300
Message-ID: <20260617080031.99156-13-clamor95@gmail.com>
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

Add support to obtain the initial mapping mode from DT instead of leaving
it unconfigured.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 drivers/video/backlight/lm3533_bl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 9eb0db640948..d003d5802508 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -37,6 +37,7 @@ struct lm3533_bl {
 	u32 pwm;
 
 	bool have_als;
+	bool linear;
 };
 
 
@@ -231,8 +232,14 @@ static const struct attribute_group *lm3533_bl_attribute_groups[] = {
 
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
@@ -286,6 +293,9 @@ static int lm3533_bl_probe(struct platform_device *pdev)
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

