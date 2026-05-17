Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D704B311C11
	for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779003818; cv=none; b=mWOA/0EBH7RFcIDoscZO35cPU+puuYM1N9paTU9kkwVYKqezfeSVYa/2drb/n4DqQLyPpVYBmpgPy4aCz/JeoMxArVLIsCrYn3d6+9aB+T8cp9WEz7NX0R9odNhbgPfVKeschO9r0yiWnXOhJHJqwQBbRo8D6D0SURISGgioiCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779003818; c=relaxed/simple;
	bh=oH4r5AK/iPEQl02poYMM4nYKVOSVc+BYgsBQehbqz44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PT7DnMdqK8AtCnm3CEHBF+rHv8VIcR/E9SOzfb6aT28htbTLKTxFUWb8fZ7cnEoZYTLRw++ZNSBsnxkqM+YNFzduAvGr05DZxSWOLs5rYqUpLjZGDJQ7hdhilnAZl0ofyEehPxnsY1jvIDcJxAusJWniy47QiXwmQ5FW5oBrpPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLMRetIP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLMRetIP"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-448528f4e69so616048f8f.3
        for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 00:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779003815; x=1779608615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCgjDXarYti7vTNUFmsGSYACwS96Ny5FHsWUIJ695K8=;
        b=PLMRetIP4UM4g8nu7qtTeUoNZnfGz3U40p0FB9Mw+JtAUo54isiMoEqn985F+GA8nW
         xJJIjVVQeNUXMCMKBd8xi87QGbmHgQFwz8oLGzAC2X1CtD8DRUu4YrMzIANQEDAZQcqB
         akNFYK1fxsT+FK9srY8Atjm/D/+uqR+/ZpkitcJvaeESTmErJSdNaYGLbjUCXzYPx8ra
         iAF+TJC8Ke+9455cRHV644vkFOVRForE/KUOphvgUlg17x4ZdCSmqT1D/QJLXLghwDz6
         tJ5p2MmN/1Rg8+afj0k8p11Ikn5gJAJW/k7v47I6mGFS/eNWCQZVQH8hBiLLq3voDNfG
         UY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779003815; x=1779608615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XCgjDXarYti7vTNUFmsGSYACwS96Ny5FHsWUIJ695K8=;
        b=hyv66OkfAm/U5CR04VOVHDyG34EEPrzqOXqmMqiDW65EWXFnpwfSThgMu4fRoDrGxg
         by/4+SwJBs1vKZJGLq9Utz5RvAY0qZwr+Wq1EAQ6u4YI7ShwL34rUVFvqci+zF8ypAVI
         4iVSf7WnkPT/O8JNPzzY2IFXa5QFws3hkkLvtQOV9fP+jvxrXLXEYsz5kkG/kDMMpB4R
         JRG3+htTMHzXobfW1rxE53T92Sa4n5sS6uqG+Y4LtxKuxbhLEurAQTx/0SmLj5/e99/e
         6mco0OoMZqqSNaRoN//1ejj35VgxlNjMvn9Yj9iJ4A1NcZhvUsVOUYtNyAY8GQl1UHCF
         9eTg==
X-Forwarded-Encrypted: i=1; AFNElJ9lr3k74pOpNJhTTDV0l81Dq0ZiV02koIWjClTIuWdFQ+HumuU0oh1Qs9ck1BbwWv/cZrG1JjOJ+mwm5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhQsoUMuVGY7PCH+CSLdAp74lnJeN7KAhqmHHsf8UUdFt+xsEe
	5Q6+99nbJy21/aoL0zsDsv8VpVs3dmZ325oGoySpW5H7zF3gekrkEjDr
X-Gm-Gg: Acq92OHXdAinMRdr/f4SEx27Qag3w4EWfZYPfc6lDncAOYBi49KE2+HAu+K0WvAZJp3
	lxEK6siTSSvYFsQyybGdp+Ifxl3VY4DJAOTRkYzW6cev8IY9ivN4mT+psEFHHvw39R1V8XnAui1
	RdgaKI+w3//llTPBtC28FviBMIKNJrLh6+zKP8KcrrFjuFrvt8UVDPU4cJWrTnmygn0gs6+ALhn
	8SXMxkDjrb9Ws6lCK/K+muCQe+ZNmxWVbCb4WGLNwBEyuxvl4n7HhdCi92FzEP2VvQ+3L/ZLEeK
	9WdFv4TtxXXHcNC3ySK0QyRDhokivf0+d6BV2T6DuZNLqojZn2u555qwPqLWKO93H/2kr4ezrxv
	KaEf1MCJ/2zd8ihT7lfxkjkM0OO4sFRni338EPGLiDpa9fNsC0ivcdZpXvk8itlx0W3dTqH4pqh
	8iUXApWCaN8ZVA
X-Received: by 2002:a05:6000:25c4:b0:43d:184:8aa2 with SMTP id ffacd0b85a97d-45e5c589d93mr16397649f8f.16.1779003815037;
        Sun, 17 May 2026 00:43:35 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm27512864f8f.30.2026.05.17.00.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 00:43:34 -0700 (PDT)
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
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v1 3/6] mfd: lm3533: Add support for VIN power supply
Date: Sun, 17 May 2026 10:43:03 +0300
Message-ID: <20260517074306.30937-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260517074306.30937-1-clamor95@gmail.com>
References: <20260517074306.30937-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for 2.7V-5.5V VIN power supply.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c  | 22 ++++++++++++++++++++--
 include/linux/mfd/lm3533.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 83ebd780f39d..131eb1a1c8eb 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -173,14 +173,25 @@ static int lm3533_set_lvled_config(struct lm3533 *lm3533, u8 lvled, u8 led)
 	return ret;
 }
 
-static void lm3533_enable(struct lm3533 *lm3533)
+static int lm3533_enable(struct lm3533 *lm3533)
 {
+	int ret;
+
+	ret = regulator_enable(lm3533->vin_supply);
+	if (ret) {
+		dev_err(lm3533->dev, "failed to enable vin power supply\n");
+		return ret;
+	}
+
 	gpiod_set_value(lm3533->hwen, 1);
+
+	return 0;
 }
 
 static void lm3533_disable(struct lm3533 *lm3533)
 {
 	gpiod_set_value(lm3533->hwen, 0);
+	regulator_disable(lm3533->vin_supply);
 }
 
 enum lm3533_attribute_type {
@@ -331,7 +342,9 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 	struct device *dev = lm3533->dev;
 	int ret;
 
-	lm3533_enable(lm3533);
+	ret = lm3533_enable(lm3533);
+	if (ret)
+		return ret;
 
 	ret = lm3533_update(lm3533, LM3533_REG_BOOST_PWM,
 			    lm3533->boost_freq << LM3533_BOOST_FREQ_SHIFT,
@@ -453,6 +466,11 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->hwen),
 				     "failed to get HWEN GPIO\n");
 
+	lm3533->vin_supply = devm_regulator_get(lm3533->dev, "vin");
+	if (IS_ERR(lm3533->vin_supply))
+		return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->vin_supply),
+				     "failed to get vin-supply\n");
+
 	device_property_read_u32(lm3533->dev, "ti,boost-ovp-microvolt",
 				 &lm3533->boost_ovp);
 
diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
index 3aa962d4c747..e355a3ac982e 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -28,6 +28,7 @@ struct lm3533 {
 	struct regmap *regmap;
 
 	struct gpio_desc *hwen;
+	struct regulator *vin_supply;
 
 	u32 boost_ovp;
 	u32 boost_freq;
-- 
2.51.0

