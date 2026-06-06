Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7760C309DDF
	for <linux-fbdev@vger.kernel.org>; Sat,  6 Jun 2026 04:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721901; cv=none; b=LYsWOh+Xc+9GCiwBVCjVfOiD7jfysX5FBhagpSnByFaTyEz9kO/W+yktL3NQNgZc/o10LUVChdxI6OexWLbqAxrscZ0QOhvzGRs9ChGh5I8wrOOmvCBf/8/eVvu2D1HLCwjVTxx1x6F79hVBojmBomuyRNhwyxzHPl6QIGqyKLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721901; c=relaxed/simple;
	bh=YRqN1j/Uc0jI/GiT/Eg6MIuncKpETtLQTmH4/MsCOmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRFprPhdN2EO9AV9XYuwRi7r/cBSrFHa2nsFpTnKh148lVE/Se1Q8a3bbvoQ5uvE1WjPLzBqQ4sJOhfSDu0ucr6F/1+aDsKJTm/335P520z7fd4LH7RSTonrwrLmVDebNb8X0ipmpp146N2+7/5P/3zrGvTV8LGXqstFXoW1hi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGpYP5Ht; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGpYP5Ht"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bec49f7e35eso353326566b.2
        for <linux-fbdev@vger.kernel.org>; Fri, 05 Jun 2026 21:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780721899; x=1781326699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqXfwtTZgGLv1WLyA0/ZZTY8n+25azMFw/42UfL9a9I=;
        b=GGpYP5Hts8BID/r58VqOnLfMhLRly5Vmj8qSNLiDFFwEjswkhc4HCDjOXeWFWatmP9
         yvLiQ1jQEV19MU+UnmyL9bjo4v5y3gJoOHPfBQgkHeUe62rdHtEALKm4HQ9o6Si4sewa
         hEfT4buYJVM0PY+PJlsvN1354HUW7TXzqzBDIhoEeZbYJ/TMUAZbKw27D9x3BdJhHJha
         yRa8K8xdVm4riCMEmGygbHMNB14wxud/CeMNz7FKnrc/y9O3g1yTkTMfnpbCWVqjj7ex
         ZXqJM5TGr5fp9+V0M2ui5TvCWRVoLnSwr6aLn1iV5lmcHyjyeU8qFrU25Xm105gdl6Q9
         Dwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780721899; x=1781326699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YqXfwtTZgGLv1WLyA0/ZZTY8n+25azMFw/42UfL9a9I=;
        b=jRgAVpJRpdTVvw35IMuY4Ejp2pc7y+YCx2cx3mzzJc2W1dXcF2owfh71zEObfapY4Z
         oQCzrgTVbL84/6+Masm7rfnwYwoKRPHuiuLn8Aldl2eJq1OwTdvOupj5ttH8gz8Ey8yh
         oGFd0TPEtvuaCJfXDr1Wb97RaCHzHM/rroJHjDyQOHE2s/yanmmR3NOoGcFzU2KaMDj9
         OwzW/HM/jQ/DNlvacThXTpuaqSZnvOTyW8tb39i25r6WLsFjIdKiVPpMoBHji3kAsECL
         0K+hnbmItJXIoRybL/qRpYCy4yIFiab56gLXORCAWu39VDNMsaGd/0oABK1kBQWmUAvF
         582g==
X-Forwarded-Encrypted: i=1; AFNElJ/FmkwbirETyVwRGODRByvwDh2xnmKXmQr817h7apQ4YmisZ9/nGIvJbMHhrxOt+UlroUVbWj0Pvm+kvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsYZtLmyqUa7VTwZ2HdEagjrxp2VPKKg5Ki8vNcGIMMgnsBrd+
	hMCcb1YmtVqLHZFx0a2kWxhU5cRAXiqKnBaSavYA4adoOY4ODdrIyuCr
X-Gm-Gg: Acq92OHBIhR0NEL+RN0ZczZrgEOuZ8+MkPNwsQGd/cHEljO32lmauWf23CPDAotuZFb
	5h4S/lBajEPhNUPpTIvjaA+GKkUm67ycTUu9v+ZKfX9qQll3s8MGKTFqTMrb5A3FEgnqerYJGu2
	biCW9Aab4n+2G4to5fabBz0rXAu7lOHcu3Ooi5JGSWgVA1zsjpyJKMsiyiyFBymQh1XS18q4EK4
	smVaIR/RaIZ4Ga6122Bnr6mKz4+TmYGCfkbpWTwHFrImFUmO6YgPyhhxDytQTDgYUT4W/l4TGsU
	glnVe+L1YE6ghRoUKKslN/1BZCQcp1LuVoweVNCpwdiAVuSr1YvpkhgK0SjfwN1BCEAOzt8L+4N
	hKuNK4JIR4Fpq1Hbbn7hh6Z+jA8IIhJo0q62wIKMvXMuFs9v1t+xB1LSv0cbzSXChZWqGzQt0A0
	gIzGcnrtvaaQsRna4UYCZO408=
X-Received: by 2002:a17:907:60cb:b0:bee:4562:32fa with SMTP id a640c23a62f3a-bf3708686cdmr334213566b.14.1780721898847;
        Fri, 05 Jun 2026 21:58:18 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 21:58:17 -0700 (PDT)
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
Subject: [PATCH v4 05/14] iio: light: lm3533-als: Remove redundant pdata helpers
Date: Sat,  6 Jun 2026 07:57:29 +0300
Message-ID: <20260606045738.21050-6-clamor95@gmail.com>
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

The lm3533_als_set_input_mode and lm3533_als_set_resistor functions are
used only in lm3533_als_setup. Incorporate their code into
lm3533_als_setup directly to simplify driver readability.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/light/lm3533-als.c | 51 +++++++++-------------------------
 1 file changed, 13 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index a9af8e2b965f..c4035d1c8d57 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -708,54 +708,29 @@ static const struct attribute_group lm3533_als_attribute_group = {
 	.attrs = lm3533_als_attributes
 };
 
-static int lm3533_als_set_input_mode(struct lm3533_als *als, bool pwm_mode)
-{
-	int ret;
-
-	ret = regmap_assign_bits(als->regmap, LM3533_REG_ALS_CONF,
-				 LM3533_ALS_INPUT_MODE_MASK, pwm_mode);
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
-	ret = regmap_write(als->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
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
+	ret = regmap_assign_bits(als->regmap, LM3533_REG_ALS_CONF,
+				 LM3533_ALS_INPUT_MODE_MASK, pdata->pwm_mode);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to set input mode %d\n",
+				     pdata->pwm_mode);
 
 	/* ALS input is always high impedance in PWM-mode. */
 	if (!pdata->pwm_mode) {
-		ret = lm3533_als_set_resistor(als, pdata->r_select);
+		if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
+		    pdata->r_select > LM3533_ALS_RESISTOR_MAX)
+			return dev_err_probe(dev, -EINVAL,
+					     "invalid resistor value\n");
+
+		ret = regmap_write(als->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
+				   pdata->r_select);
 		if (ret)
-			return ret;
+			return dev_err_probe(dev, ret, "failed to set resistor\n");
 	}
 
 	return 0;
-- 
2.53.0

