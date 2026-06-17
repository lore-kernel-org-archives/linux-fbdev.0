Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134EF3CE0B4
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jun 2026 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683267; cv=none; b=uJIRJ+BM2vdkz7xHPUeeF3JXndu1XOqc9kvZupr6/jmxwlyoTV9qWb2SMpiq/4e7niuKBkRwifawCi4EJEtpkJ9onE9zJk9dB17YohkdazcQZN8IUiV4B7SmNLYCufsWFtG2p+0yYayMuHOqRqOc3Ut+sKjcozHO4SxMlSVI0/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683267; c=relaxed/simple;
	bh=4WjmiWfFTCp+1bBNDrcHv5gGqTRg8YPvmqnJ/PwH9+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4OnzdIhccSlsfuEmm9kpf7JpLogHU0Zg55zd7ERcpN+AO9TivxtPf1lkKL0o1ZVkOE9fb7L6xf6DqQ1evMfwRObf195H2EzGV1HbjpIdk9PUUOPObiJK0p3VCj8btfGcp56tavrbjfGTtpd7zxp1YNqwTHeA/pUPTRJ9XZP/mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVF+bSHq; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVF+bSHq"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68d23396ed3so9231379a12.1
        for <linux-fbdev@vger.kernel.org>; Wed, 17 Jun 2026 01:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781683256; x=1782288056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDbkv4yENGcso8lbBuowMRR6EhhW3sM2nEWvZfEX0tI=;
        b=HVF+bSHqNdQvwqLcn9tqAERPwc90kPjvY1ZlbO9x4CEynUEdYqSkotKSHBTysqh1xa
         f0Nz9C1tt9TuXyQ0YZ13rtHlKkt2q23ZE22a0rO1zvJTB0ecXWc6xyp5tIu6Ju9YRBW3
         4U+gjnfRkDhoYlipuhzNKy6NfC+UXWTaWKzhknJeV4Atb5dU8wHDWScavvsAzrZ05stY
         F/SwjhQ+AX4yLCqOeHfW+ml3x+Lq8gz5WrV1eHpVV7iWuK2yn+nSwW2HrRGoj3XNT4pF
         K0/ltZ+jBPHoG8OIpo3bYyIMmjVqezRifhdb5Q6pLRk74EOfwjw1NS4lmoogwi6+jkWS
         88Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781683256; x=1782288056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bDbkv4yENGcso8lbBuowMRR6EhhW3sM2nEWvZfEX0tI=;
        b=b7N2WYN0/BFbbSqr3x3wb1oJvM49HC23kkINi1g/iI1sk+/v8Z1iFkn601g5exG57w
         xDm/+ABMZyRgD2dI8xj4vBcmm0PajW8Hy3ZOkQzGIBeRu5e238t6TJX9W/ghGv12YVWC
         q6oSlfv/PEetzNrCmXjJNeOC2JZKCd0y0fSrmFdfzZgfxJvk1k9nRiodfq6KFY8VUIy8
         tNvspcei0XtO4GDP+O5bLdqo0c0i5ldaKUERV1IfNUQUxH8BV+DuFhMAhguVmv4SBTUV
         Xa5o4AyNrkJscET8cYL5gC7Gx8FCsEOXCzuhlS2RRBST/1nWoKLKOpeOzMsIZpnHDQLs
         emKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/stKRX2CUVCto/eJMF/9c7AP4zrgaInPyTQ4dI697/7ZElOBKPnF5uY6Y5U+dJOhx5jq/Lp0/asjwg3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxodcEzEMdQoaL40/Dy+n5Jw84my6XawgPpA67HROK+Rxb2uSLI
	VfnGkNtK6FcA3pPlsnVQsPdatVyHE4n5tdxBA5EmFouGliIgTC6k8lAl
X-Gm-Gg: Acq92OHxTSap1kWnx23tdE4JqJbbzcsH9RGVoZcz4VfOUX66doSLjag9NwUidr+arg+
	NAt30sRHt6YJvPk44zsfBSsrpyfOOEEuqDqbJE8Qd+ntIdgTM/t9zjWXdukHCtKfWp4dO2A3hSJ
	/C9xaWgvXQzgoFobRz8Douqwa5JL6g/Fethbxxz/Ukl3mEfUEixc0KgexD9DrUZyFuQ0v8SJ/f6
	ZhU9+UhdCCfSofsrNBBloBdomwWQXG381aM34mdezHhE4zYioSNZCQWsqF+wtRLe4kpkIicb4a9
	/3VBmm6rDGkw3FAoexsXIJ+eWMMPpiYMQZw4eCGGL5zacL3IV76yLynFjLO0Pc1kuc975I6tqm4
	B43fA2Y6Iy4y3UvYSaOKRi8ySo29Huvw5fZ8H2G+X+IzmD5ae2DWPv48ms3B6lUX5h1X1j3f91h
	stEQYEZFs0YvYu
X-Received: by 2002:a17:907:94d6:b0:bec:b4e3:e930 with SMTP id a640c23a62f3a-c05a511f1ccmr158862466b.12.1781683255042;
        Wed, 17 Jun 2026 01:00:55 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:00:54 -0700 (PDT)
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
Subject: [PATCH v5 09/14] mfd: lm3533: Add support for VIN power supply
Date: Wed, 17 Jun 2026 11:00:26 +0300
Message-ID: <20260617080031.99156-10-clamor95@gmail.com>
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

Add support for 2.7V-5.5V VIN power supply.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c  | 23 +++++++++++++++++++++--
 include/linux/mfd/lm3533.h |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index a5aa7da9668b..4b5d94e9ed27 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -17,6 +17,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -113,14 +114,25 @@ static int lm3533_set_lvled_config(struct lm3533 *lm3533, u8 lvled, u8 led)
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
@@ -333,7 +345,9 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 		}
 	}
 
-	lm3533_enable(lm3533);
+	ret = lm3533_enable(lm3533);
+	if (ret)
+		return ret;
 
 	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
 				 LM3533_BOOST_FREQ_MASK,
@@ -447,6 +461,11 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
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
index 5710e88da45d..8f72dd41e8f0 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -22,6 +22,7 @@
 struct device;
 struct gpio_desc;
 struct regmap;
+struct regulator;
 
 struct lm3533 {
 	struct device *dev;
@@ -29,6 +30,7 @@ struct lm3533 {
 	struct regmap *regmap;
 
 	struct gpio_desc *hwen;
+	struct regulator *vin_supply;
 
 	u32 boost_ovp;
 	u32 boost_freq;
-- 
2.53.0

