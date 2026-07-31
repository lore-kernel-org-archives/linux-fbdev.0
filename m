Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEB93F8243
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497824; cv=none; b=NnqW944DMgOu496lQL6WD1P8iqrzrbiaRwg7Og3J9motYf/V24VwCLDNxKOPoW6o7nBGTJVcLIQgJ3i2lolYXZRONOjZWhDLKGymUdnhhvfzpzS+4bArEOkelI2AoauD3PgtvMeKWXBokmuJdThtRFK/BCuienFaAMn71VD41ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497824; c=relaxed/simple;
	bh=YR6/oGVbHnlemUZ2JFQ25LTccScQ1moNvQCqFBjDqAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alXuLDiUnhBLgWMMIHE2GrKE+s3uWQRlxr9G+mEwqqQ6OVTxuTDOtNrPLVrQ7lGzylLN/J0cSMkcvgWE0QesdX8an1di87au53q1dvnPEus+1w6n5yEfTN9DAlkG4JPhZM08s1b6CafNVFRA8pKLD67hZg21DHMAjJmSFewCuEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IteGXC1X; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IteGXC1X"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso436481f8f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 04:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785497820; x=1786102620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=88fGtlotIiUSgMJVrGrIa8cGFo+gZlVN06W7NwNhiU4=;
        b=IteGXC1XwQXgaXvH8ygrFkBREy62eoKbFBOpoelBzO3lRLtBmbcmm9EGK7nGQhLNkK
         Xfm2bjceyZ6ZCeXib9DCBZv+eo7a18kYhD7MHUd4LISjfmrdx1EiQsBRsNVXIbPCjyYh
         X3C765O5qLdu0mSyUgHBjM2xuNuMiPieCLIRpHEO05e5r7KGoOOCsYhnxwXKa0lOwGx7
         UALEo0YRZGe9RGrhGDxmld/ckX9cZNgxoC6NIG1eWtD1TE7VyOKfnz0rgkTZZkAKem3Z
         GB9iiGFC5c6rtrSKMmBQ0w3w+23fL4AjCpl8aN44s/318q/HeTygOMap2CjxeMQj1/rn
         AJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497820; x=1786102620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=88fGtlotIiUSgMJVrGrIa8cGFo+gZlVN06W7NwNhiU4=;
        b=NDPlprQW1tnyXDxYcVNMNqp4MNdLC7jLZxepNwmXrPc3OM68si+HO4F5vwHE0dneNd
         iCn3FP2ept5WaCtzNONHmTdaQ2g/u/Um4Uj/B/UwRhn7HnXPFZiT1a19msLs0N12bs/t
         ZQh9dfj7byHisimIb7VpW15404z9gIqx4U9wgmw4OAOC1ONlDYXPCGXwB4hRmNmnEQNz
         pj5r1MOPZksK6pusSlEk2Hh9jQw0/cifTMK+CgqP8LJo6c53a1dpUoyyucUZiD3BHzVu
         nEQbLbliD694huAt6KgSJHwKzh8vjTewq1ggKKlBsgyUoD41XY6pJAhqh4ruyw/+ZV5q
         2/YQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGWa+92ijI4fRv32iL2DdsMn/1fd3/I/pRWkh3T29M+YT7np8a/zCe6CLKBBVHmI42YfH9ZsTh8TXPVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrnDeX4bhUj+8OyHaud53mbe+zwLsgMMCREr20+UNdLrNNOzMo
	u2oR8EWuOMZUZ3pIBwOsMhkR1oWOfiErSeOWBzlaG0DgGkKW0EpD7ffk
X-Gm-Gg: AR+sD10mkaGqgjTjEU7wD3l7lwEm1KlINgiNXo0POVbZWu6buYT33U7Eek4yka4pEB5
	+PGO7CTg8qTSKidyV2NdHvUWkyk/bS/5dT+DTAfYbS1Oz3yUA+HdrW0QsmIVKr46216Htn7G8Bv
	FWObIUKT1pmj5RMI2sRaEzXAKbAQdYJigUPT5fUan9fgweBE1EIHpQj3WE3Vyk++nmqNJQH624X
	R2R8nb4G8qEl8IPqsJM1aDJXjtA8+WL/d7bmbZgYBByR6p4lKAT6fk4TOEG7TS39fw5mk657osc
	1hJpNkoYzrGLEEt/MY9YR5kXxw2A0RICAN1/uWdPWEQZWb0fLPUV/N8OeG5624A7UbcbzlltdkY
	Yr74WXsgh3/uQWUKRuwpKQW/Gj1QDHUblSiWBBwLHy1K4hIZpBa5LbOhtodw7k3vGKv6VFkAYhi
	pSERJZdQY06ww/BE7SqmGFun6Mlwtx4f48APicTtiRUaKgPmdgMBBL4hSjRhfga/vpbey46kzw7
	24XW9tkHA==
X-Received: by 2002:a05:6000:41e6:b0:47f:9171:c59d with SMTP id ffacd0b85a97d-47fd2b30babmr3903817f8f.32.1785497820326;
        Fri, 31 Jul 2026 04:37:00 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:36:59 -0700 (PDT)
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
Subject: [PATCH v6 05/14] iio: light: lm3533-als: Remove redundant pdata helpers
Date: Fri, 31 Jul 2026 14:36:23 +0300
Message-ID: <20260731113632.158440-6-clamor95@gmail.com>
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

The lm3533_als_set_input_mode() and lm3533_als_set_resistor() functions
are used only in lm3533_als_setup(). Incorporate their code into
lm3533_als_setup() directly to simplify driver readability.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/light/lm3533-als.c | 56 ++++++++++------------------------
 1 file changed, 16 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index a9af8e2b965f8..55c35018704c8 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -708,55 +708,31 @@ static const struct attribute_group lm3533_als_attribute_group = {
 	.attrs = lm3533_als_attributes
 };
 
-static int lm3533_als_set_input_mode(struct lm3533_als *als, bool pwm_mode)
+static int lm3533_als_setup(struct lm3533_als *als,
+			    const struct lm3533_als_platform_data *pdata)
 {
+	struct device *dev = &als->pdev->dev;
 	int ret;
 
 	ret = regmap_assign_bits(als->regmap, LM3533_REG_ALS_CONF,
-				 LM3533_ALS_INPUT_MODE_MASK, pwm_mode);
-	if (ret) {
-		dev_err(&als->pdev->dev, "failed to set input mode %d\n",
-								pwm_mode);
-		return ret;
-	}
-
-	return 0;
-}
+				 LM3533_ALS_INPUT_MODE_MASK, pdata->pwm_mode);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set input mode %d\n",
+				     pdata->pwm_mode);
 
-static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
-{
-	int ret;
+	/* ALS input is always high impedance in PWM-mode. */
+	if (pdata->pwm_mode)
+		return 0;
 
-	if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MAX) {
-		dev_err(&als->pdev->dev, "invalid resistor value\n");
-		return -EINVAL;
-	}
+	if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
+	    pdata->r_select > LM3533_ALS_RESISTOR_MAX)
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid resistor value\n");
 
 	ret = regmap_write(als->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
-			   val);
-	if (ret) {
-		dev_err(&als->pdev->dev, "failed to set resistor\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int lm3533_als_setup(struct lm3533_als *als,
-			    const struct lm3533_als_platform_data *pdata)
-{
-	int ret;
-
-	ret = lm3533_als_set_input_mode(als, pdata->pwm_mode);
+			   pdata->r_select);
 	if (ret)
-		return ret;
-
-	/* ALS input is always high impedance in PWM-mode. */
-	if (!pdata->pwm_mode) {
-		ret = lm3533_als_set_resistor(als, pdata->r_select);
-		if (ret)
-			return ret;
-	}
+		return dev_err_probe(dev, ret, "failed to set resistor\n");
 
 	return 0;
 }
-- 
2.53.0

