Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA003FDBF8
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497839; cv=none; b=TLHcGQxizXLEhPH7T7LYDI+YkSp8z4mIO1GqbAEKYFg6IBCLqzFrt6Vnk0Ofir+l+jQOHliqcsUAXzoMuWWsC+pAuD/ODzRzJNosa0lyGl1aAQ105+htJw3V4ulYCpvQ+SyvrIIYTn8jv9Bi+IUZwZJMc4rceQVktlu4m3ccs5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497839; c=relaxed/simple;
	bh=Fsi9naHLvq24ntJl8U1aGARdwDxfue5n7pfYhUOdjEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqLeNgHmbWtjjSutd15UfUIyDPf1CEY4skDIhdRiBI+Uni/4cfwkntJb92ZgyZch/GrGEZXO49twzDCuyY8IEWdPd2cjjmDcK3pbPX6YIAXWLE1JjW9W0eCUoxVqipC0wE6XfP16LPrP8pXarq1qo5NJ9ahdQOLkHxWPe51kfuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A95vPldS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A95vPldS"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1677c91969so103016566b.1
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 04:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785497832; x=1786102632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HoJ5QEzgIc1R//Ldk+eAj0/fHRhzYHI0+TPDQsoclNc=;
        b=A95vPldSdrEKSwrXHx+iMhHhdBfisS9tpnWPOflxrJLJZIPH0r1wtS2TDjDMg+Ult+
         v7rOWz9LKBtts4zSX0o1BOouk7Kx8qlwxWXE3Fx/m89bkEUQ6g+bXcRozJh54J4hMv0v
         HCS5PlrQ24CWu2VyyG74Jp8g1Y66adoBx8Kucuvw32CAxqufcywm6cvz90PSDn1t+ri8
         qfhgA6y7QfkwLXGuQpCpNsCqpKBdd1ECEuY6F/nYmcny9urYKRMJ6D/WMG5+bfoZPegD
         Qi9wfHv1sVRvB7LGjQP9kciplQisaj8FosdMrlueI6B+Dh7WkcUBfFj+dWSSCxN4h5iA
         ZYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497832; x=1786102632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HoJ5QEzgIc1R//Ldk+eAj0/fHRhzYHI0+TPDQsoclNc=;
        b=ZPVudlXxW4SZ9QkWUSWb/1SRZlty6vm20nXgE3OtEMHjcyzx6XYgtLw/nFp0mntKJT
         DmenWW1hA/dB3zACVvnhsOodbsZGBRaeHabeobG0+o3yvIXnaF/oKzmnG5hk/Tve29p3
         C8thF8TyV1ax2k+2Wp00QRYjUne1xH6Fu7NSFsSrLSknJ3+ICVFEp8yUg0TZy7UJX7ep
         o5nWjAtcObgXKKPi5mYR+mnuWFg8wXV4heu1i5FxOhrDj38qSZUaZrIDWmDAGAMt7QD4
         Lyu8qD3wbmiKK+ptiCFVho/aAn4+yqvEPmnt36X7OaiRhtuOsC2VUwKUK8NN6su4mU97
         i6Aw==
X-Forwarded-Encrypted: i=1; AHgh+RoKBoxPtK4U9iGydxv1z6ZyAZNdfxDVpnQhT6kkpL6aWerLPy7CK4rU5SVwoHF5AALjxkIvS+7nwHCDMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZBXbMXktgUco+zlL8crmIi4yjy9cUtyTArbQUTsfbJWaST1o
	6pOiSGpUm5uzJRo1EcyPXM/oZQmpMU5c5Az5AYRDtV1rLhROrxvcadxL
X-Gm-Gg: AR+sD10aETyFja0TLDuNCjlPzyyFMJoJKgft8aH/KG1FEI0u+EDs5zG5YPEaPGA5+wg
	9MwsasuJGZoAYXfzehhtY3i7/dJDfJrc35AzFV6Tim1ea1/TIR0vwN7riWo2IPuQCPZGZ5y5frx
	HwcZfYf13Ml87UIZNnrMlzzMJfBenE4T7Wx7y9BPxABkIHgrf6rKo2mz23FpLOfxkk6riBa4R3o
	8sYtCsBMIOUKD+TBoxyMKpfD8xtn0xHzKqkc6m8LHYNyDYHQbIK4UQa+t+mY1dni3WSKx5ztTvg
	RVQC6cebMq6eeNM/3nsT80nI/Le2oRLqBf7g45EC8a+K1aDqpxA10dHP3LZ9vMreiAYVm+Y0QN0
	z32Ukmehy1Pe7/j5ubwLKmToHC49QLYc63YSHBWPgIQVyyEwfewjC68ala1L4lbiG9plmBJsH7B
	XjVfblyMBGK4Gs3cGvd/EFduiJbup5XMrH4rDsw7aqIUMhIF2ipKdaGjQjc0OesUCcJySOER2iC
	UcDmGfJ1A==
X-Received: by 2002:a17:907:c78e:b0:c12:7934:52fd with SMTP id a640c23a62f3a-c1fd250eeb8mr91901366b.32.1785497831684;
        Fri, 31 Jul 2026 04:37:11 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:37:10 -0700 (PDT)
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
Subject: [PATCH v6 09/14] mfd: lm3533: Add support for VIN power supply
Date: Fri, 31 Jul 2026 14:36:27 +0300
Message-ID: <20260731113632.158440-10-clamor95@gmail.com>
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

Add support for 2.7V-5.5V VIN power supply.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c  | 23 +++++++++++++++++++++--
 include/linux/mfd/lm3533.h |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index c7c7e71719ae0..2a63df034171e 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -17,6 +17,7 @@
 #include <linux/mfd/core.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -111,14 +112,25 @@ static int lm3533_set_lvled_config(struct lm3533 *lm3533, u8 lvled, u8 led)
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
@@ -332,7 +344,9 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 		}
 	}
 
-	lm3533_enable(lm3533);
+	ret = lm3533_enable(lm3533);
+	if (ret)
+		return ret;
 
 	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
 				 LM3533_BOOST_FREQ_MASK,
@@ -446,6 +460,11 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
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
index 5710e88da45d2..8f72dd41e8f02 100644
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

