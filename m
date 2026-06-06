Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CEF30C15E
	for <linux-fbdev@vger.kernel.org>; Sat,  6 Jun 2026 04:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721905; cv=none; b=Pg8VAS/T3gRjPaFEbu6gJjeRb/NcRusfPC5Ql8VlV5fs7GFBy0W0OG6Cm7NN+aOe7HozeWnXz8wF2fenTQzzaGXpbkb1xkoegIxV68rcp2msrQIWrETJzwPkZLFd0UM5cOhp6rmiwbOZbaWYrz/DN/SS3zNx64s7cGCubODM8sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721905; c=relaxed/simple;
	bh=4z8TZ1ZUPM43BFkNRD7i/+Vv36ZfSXtks2zi9DysJhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZC3CoEyeYWieJzwgV13nK7IBd3NRkbWpGC6w7ExrGu1d+MOwMDN9KObsfTBdzuutgMh7r6bnHDxyG8Q4l8kpXXaQVx0hP8epn4KtL0YERI6Ul+tegigImAgK22ypfNnA8eTKJTy7hv6G/i3jb0Dlz7Juy2tiU4jCrRZeOsl+3P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1+nCZh9; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1+nCZh9"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bebb72b845aso378098066b.3
        for <linux-fbdev@vger.kernel.org>; Fri, 05 Jun 2026 21:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780721903; x=1781326703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wS67jochwubseohJgYpjn1pYUwemo5z+ytbVISXPDzc=;
        b=l1+nCZh9V7/wz6JtkQQ6PBnqXL/wtVrqwMlhOqOaVMYkob9Wpupqqjq0mZ0KpL26B9
         y4b4hPJFKh5sDnxM5QFJd99qkzPoMCE/UKzvL714iLWhyhdeDSnnXugP8R4JYN3d9EcJ
         ySja4FYQ7zoU7Duh7m26VxteXMBx81fYQSihfnZZGaaYPq6edxOQpzHZQGmM+fBWPg5Q
         oP7NZmfCcvzd0RH6m6sujxTI1jXn0aqUxv3ttU4o092DZoQryryUlo6M9y/rSWuwWthG
         V8FMQPaUZiK9ajYwkKkEERFQv23w7jGIsa2b97/FQeca89ief8a4ePr2tTHAOKAPGWXh
         /fDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780721903; x=1781326703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wS67jochwubseohJgYpjn1pYUwemo5z+ytbVISXPDzc=;
        b=ipZEdMjdjudlhqOXjm7bV4TLDgB35OYz9UKPI9ICQdgQBQuXFkARtoffndZv1/Rnpe
         zOL4MlTgq7E6Oq0Ueoz09eQR7+804nbcdN+FX1l2jNCbuJSOF4j/XwyxZ6/QHRb+v6yU
         UVv9jAE58f+9xMDCpfxBC6I0p3MXRD4V/I0gV21dUrVUHf6ixVs2P/SCBP8P2XSqMQTo
         ETWZxELyEGgOZNdGWOvTBiOad0Ulc5XCLNdRzeIqMI0f3HuDXZZ4B19/XJZbauRfNrsD
         dCT7ccwaOuTiUB/ogiugGDhV37UnIJL4dIt5QdhW4vnGj7YYnZbTIzNemMfsebiVMgsg
         lSgg==
X-Forwarded-Encrypted: i=1; AFNElJ/8M3AklDL3R80WTyEu3E3pJ2A8dbvVLxF5rToCn+zVK/IUJUV9LiunQIeE09ZvyBybaF3Y+StFoLoPnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx86EjIkVh/4gx/oflZRVbGMNBKdUJVF6AJSDZKe5WAusEvie1Z
	pcLnndYQvTnN2mJmiEI21YuizhcA/LuuEbdce8P2jryXrD9N3rpXRbEb
X-Gm-Gg: Acq92OG2yxPx87mT8D9e4tIDPzdkHCnAe406825QnSOqdMpjZCJAYuyMUnw8NQONhI/
	a9rGgeUVmF+DYWnGOv81Pof6vjBfeWG7S3vU6Ad3EmGgs6t3xnZwPUFJfMLnSASEORWtfHuY44h
	KL4AmI3EcbtxynOWYdh3A7MbLyDIOa0GZzlFWcuhFnpvdGJe/wTbNlgxZ5Z0vXhCXvHLCS4i/qc
	axz2MGI3VuOd8oMk5y7PpW91dYm9lLQUvMLHKOIdCXg6FbQsK2q5dyCJVf88wpZejdWPj9W7p/5
	70LqaTIVf/X6H6unWcLp7DnzKOQQyizuL3DniPbcQuFyqGo7GeaExHlP4TYqzPxpAYsvmGhe2YH
	WGQZeuulX120iNZNLmTpbSouQWL2o9Rd1c+KXg8DHzk2/lOoTdT3Grn6uWetzJcJrAPnQ6Nmgg+
	H202XhihPxRL1iHmydx29I6uo=
X-Received: by 2002:a17:907:3fa1:b0:bdd:378:3f2a with SMTP id a640c23a62f3a-bf372d28da4mr313211866b.38.1780721902322;
        Fri, 05 Jun 2026 21:58:22 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 21:58:20 -0700 (PDT)
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
Subject: [PATCH v4 06/14] mfd: lm3533-core: Remove redundant pdata helpers
Date: Sat,  6 Jun 2026 07:57:30 +0300
Message-ID: <20260606045738.21050-7-clamor95@gmail.com>
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

The lm3533_set_boost_freq and lm3533_set_boost_ovp functions are used only
in lm3533_device_setup, which in turn is only called by
lm3533_device_init. Incorporate their code directly into
lm3533_device_init to simplify driver readability.

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

