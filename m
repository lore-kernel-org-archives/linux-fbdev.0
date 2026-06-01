Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4844E3DCD87
	for <linux-fbdev@vger.kernel.org>; Mon,  1 Jun 2026 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327151; cv=none; b=VtK2HvDUYyU7KkwcDAj7tW+sAHWVNSbfyP5vMZRwbJiMmSrcl3CKBA81ugT+vpiHffkxgPfoFcTI/e8ejuBZuWrx4YqUNMEJBM7jJVH0CghWJPfwpAajicacB0+GA0kCOMfEsYVqs3GHPfRzw8s04+jFhsgXSOhuwgN3fhdeT30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327151; c=relaxed/simple;
	bh=UtPscoMn7/+u3hgCsxGsK5x29OOmOoQ7cGtI5AS2sAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QG/hFpgrqQouvI84oolRT8Zr4E+n2nk3TglXx5z9EDEnOGj+XmbwaIVI9diUC4CB34Si0H9aaZDGkiOuPow/tmC/d2evHmkkByu5MMIJM77kuUdWI3q7a+aPN/loQeIA4B+PvrS8WUCvXjonduSdxyA7r6XcOoaUeL+q6uI7Xis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiszMNeP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiszMNeP"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45fd464d51fso796324f8f.3
        for <linux-fbdev@vger.kernel.org>; Mon, 01 Jun 2026 08:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327142; x=1780931942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y382WZZPSXgqkJt8F6mrSdOVSYmocK83eFeJ1TSWQE4=;
        b=XiszMNeP4wUTqUxFlUnFLah3PuhRurrdvgYAUaNSfjnBlvvHl4pqWSxVXYji1IkvFB
         d/yKXKPKYdhAClOQR2tK7rd6MK0PKTeG97Uq4lP711I9N9hCNI2BFP6N7qWzvyjHc9In
         al2CzUtKFUSIaZNGOZIpI8FLH0E4BJUb5YmBDgLKILvJBa+bbu4E4IvcnkuvDSFQnaHg
         nYFpMdRKzuUytJchtXBfPXAil8EeAdG9FtyAHUiXh6o0PV5OWMnFdXvXhATbuPKKfPtG
         Z1EuUnHfzPSCc6uQzKa9H7DvHB5/7IdKsHlpFTWKT1lXdCDdKXCd043ftoa/GPZL4lGk
         G50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327142; x=1780931942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y382WZZPSXgqkJt8F6mrSdOVSYmocK83eFeJ1TSWQE4=;
        b=AQUtg6gkEKUxNYpURGyxx8acCoIkI8lBRcw2hFY65RXH2igmDR0KmbwmPMOhXiE5DX
         XB7mGxn6qhrO1658DJJWdwCt/kOljQesYniKzPH8ChTzfyT67dcbu1zdujeTb5pNzxd3
         a20shbRmhfiXRa0Ol20tMAYRG9Bb1qxyBLDhezA+wWLwoxf2bQy0O5dVudECnyy2pArB
         2Jzw2EkGwFV0cFAjdFEUM3TcDW2958qrSecXgy9ikUv0TY921BCyOkhGEmnEEqlKo4JN
         WK5wGHDPxCE6mbk1FdPmHMQsX2I7ivqX3BuVwvGgZ0PlVcFGqS/7qviL/HIi3+L645+Q
         lNOw==
X-Forwarded-Encrypted: i=1; AFNElJ/+sr1CsMx/3MJ5F28fRxSCpIHFHNlCv2miJLEpaDuQkM4jklCg0RJgTjyAu4EVuF3QSQ7F04PLJ5eTgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiB7xWsvHBKJV6RfBiJaeXhE324EL5mgcl7S1a/9l/WnwyuxlD
	UcUF25HGYb/blxJnCDU8sPPyue1i2fu43ul+SyGRCJUhbe0l/Q289veb
X-Gm-Gg: Acq92OELBuuUXpAendvxuRbPkzAQv+Vfl9hEGz4olgooGn8JFK8Phg2LjTKb0GXqoAw
	c0zUBjZAlhFo7CxxfBjlZTlI2tkW3xdGmmZRYOuOX/T/6TIByeB8W/NucAlwMG7cwTydnNmnHBp
	nfUZ8cKc7kr/UagPNWGswehnmfEn3ky1HVVLMTZ2OwJp6S8Ri+v5nlpb5bhOmB242ogequyNd9b
	BFpjLWdYXwnIzwqMRkUUWpKEsGFZokoY6WPhlBD/Ibkjr5QWfGdu2LV/z8MqvaiikGigBQUjJnK
	5SkB3t7hHotlPMymD5i1YP0h1Lc7Pkw5vFpvHOjZ+PQHTSAbiOVGnCWdR3BIz84/BS8vUEhij93
	dnOFMgy2f2QZyg/5FzpCvq3dywmgihkkG3QuHyI7Alxv2Rw/PWmRML2td0YgVcJCqjyNF0mHK4I
	RTg4lQtzaY15wXgXzuMc6cBJw=
X-Received: by 2002:a05:6000:4c8:b0:45e:ea3a:47d6 with SMTP id ffacd0b85a97d-45ef6b93b94mr15555475f8f.32.1780327142357;
        Mon, 01 Jun 2026 08:19:02 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:19:01 -0700 (PDT)
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
Subject: [PATCH v3 03/11] iio: light: lm3533-als: Remove redundant pdata helpers
Date: Mon,  1 Jun 2026 18:18:23 +0300
Message-ID: <20260601151831.76350-4-clamor95@gmail.com>
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

The lm3533_als_set_input_mode and lm3533_als_set_resistor functions are
used only in lm3533_als_setup. Incorporate their code into
lm3533_als_setup directly to simplify driver readability.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/light/lm3533-als.c | 61 +++++++++-------------------------
 1 file changed, 16 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index fb61904f110f..52136ca1abc9 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -716,61 +716,32 @@ static const struct attribute_group lm3533_als_attribute_group = {
 	.attrs = lm3533_als_attributes
 };
 
-static int lm3533_als_set_input_mode(struct lm3533_als *als, bool pwm_mode)
-{
-	u8 mask = LM3533_ALS_INPUT_MODE_MASK;
-	u8 val;
-	int ret;
-
-	if (pwm_mode)
-		val = mask;	/* pwm input */
-	else
-		val = 0;	/* analog input */
-
-	ret = regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CONF,
-				 mask, val);
-	if (ret) {
-		dev_err(&als->pdev->dev, "failed to set input mode %d\n",
-								pwm_mode);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
-{
-	int ret;
-
-	if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MAX) {
-		dev_err(&als->pdev->dev, "invalid resistor value\n");
-		return -EINVAL;
-	}
-
-	ret = regmap_write(als->lm3533->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
-			   val);
-	if (ret) {
-		dev_err(&als->pdev->dev, "failed to set resistor\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 static int lm3533_als_setup(struct lm3533_als *als,
 			    const struct lm3533_als_platform_data *pdata)
 {
+	struct device *dev = &als->pdev->dev;
 	int ret;
 
-	ret = lm3533_als_set_input_mode(als, pdata->pwm_mode);
+	ret = regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CONF,
+				 LM3533_ALS_INPUT_MODE_MASK,
+				 pdata->pwm_mode ? LM3533_ALS_INPUT_MODE_MASK : 0);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to set input mode %d\n",
+				     pdata->pwm_mode);
+
 
 	/* ALS input is always high impedance in PWM-mode. */
 	if (!pdata->pwm_mode) {
-		ret = lm3533_als_set_resistor(als, pdata->r_select);
+		if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
+		    pdata->r_select > LM3533_ALS_RESISTOR_MAX) {
+			dev_err(&als->pdev->dev, "invalid resistor value\n");
+			return -EINVAL;
+		}
+
+		ret = regmap_write(als->lm3533->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
+				   pdata->r_select);
 		if (ret)
-			return ret;
+			return dev_err_probe(dev, ret, "failed to set resistor\n");
 	}
 
 	return 0;
-- 
2.51.0

