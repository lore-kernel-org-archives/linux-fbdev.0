Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFE0224EE
	for <linux-fbdev@vger.kernel.org>; Mon,  4 Mar 2024 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547118; cv=none; b=mONDF7/V9wo0UzXaJ0fjNNXkA7Kf4WGuXExk3ffRxmaiHmKnAGlYziWHHxHPzCIJgIDOeO2wD8QnRJGA9ZVixzPuKdwk8gbeX4Z9/3jT+4IEp5TMlYHipfUjTmFHK4adpcQC6oIpd4hD4uOXY/d0sJ+wCxNonDN8RpZ703pzhrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547118; c=relaxed/simple;
	bh=L1gsWac4GlPBRR3BJYIkKHgN/RCN5L6+vXyGAdt7/+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BITybuMuDqtCmD9cKX1Fe3mmXv5Ud9FKaEDzWg1q7q0Q5RCISIdFyl6hML9D8G1nrw3Ozs1e76Coq/BZfQVx3WgB3Fcn0v6TvTygdgpSUUBwcgvMv73rxkg1lHNkOzORvgR7gbEbwAMOSYOpei/38P1zJeYJCAbEjLVv5EU/ul8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FaixYMHg; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FaixYMHg"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a44cdb2d3a6so237957066b.2
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Mar 2024 02:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709547114; x=1710151914; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2l7UpgtGLmRWEg57s509hO79ijY7GD7vXKq1B5m81jQ=;
        b=FaixYMHgXS2yUzge5gKjfWneC0/ZlCBYgnmPsea8XRPIMJ5trYiJ/P/tC9hbbFsrxZ
         OBH2SxhPmDKbmaxy4ZlU30UmuUiMzRFnUtpn3NyOvWQvHzgpFXG3GG6Xr0lHhoovKfU2
         Lc2WPeDw1ZHPLlFgWugPHtgZ/jDUMcdEAOPZwzzyRrbi7crrS9iXDYyKjW5ieFlEWfmt
         HayzcHVnCeCIgrsBfXQN8eE1ZV+qDiPL3JC1c4QKdRxrx0cPQsfUap7ofPIdpvoBd57/
         mb038C3mlOG0nNxFVt+lg6jybNzdq+G4qVMwnoUxDebocUGe5+siXDlo+XX1JV0UZ+wj
         dtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709547114; x=1710151914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2l7UpgtGLmRWEg57s509hO79ijY7GD7vXKq1B5m81jQ=;
        b=dMwprqpxwIEgjV0LSFEwf8fXaLtZJebXmzSYKRgphP0C/s6YXi2de7yLOgpOT3Wsio
         urgI9Ols/wFR5VCbdVXJzVs5/8mUITtLhG3vcuTEFioIYcHIq9Lb0HLMtk4gc4pUrf3n
         ImwumsJkiC3I3hDZUu7h8LPhQp6HVTvXnHwQn7fKgjiUwUTHRUpRc7vMslmgrGAbMVK5
         qY6vm4dAWj2Lt+dj/0GlB6Ln/edRncEOMGde/WM+Q1xtjhLo8SIWp88kI3q8X8dV6haf
         dOiM8nln60hhxJWOlY9opCBSS/HKZEnoiv22NwJxa18iX3oZk+ltXB2dKrPlRC7PQ0ok
         eP+w==
X-Forwarded-Encrypted: i=1; AJvYcCWA4CQpckdPwZb+6+1CLD2XA/N2EtIm6wbhVKZuXKARCg6f6toLTdwTJo/DyZ5wTiA4IlbQT21Zq5nUySCIyzHaKhKWjYTbmiBZCOA=
X-Gm-Message-State: AOJu0Yw7MvbHQ2P2s+opjgHTyytA47xqEK4LmBoY8n+Fu0ttbKz71UHH
	UNbvVEmAzwckCHE398WJukpUd7K9hz5xrbGO9jOa+4WJ0XNRal724gHFK5ftYzo7ax07QZeZNdF
	o
X-Google-Smtp-Source: AGHT+IHrMdwkW1PUb9mRl/nOw9W89HypdtSeRHnOOx6YuKOHBeKBikpsljjl7tT07UnolQyMcxLIZA==
X-Received: by 2002:a17:906:f8d6:b0:a45:2e21:c78c with SMTP id lh22-20020a170906f8d600b00a452e21c78cmr2053919ejb.13.1709547114198;
        Mon, 04 Mar 2024 02:11:54 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ef11-20020a17090697cb00b00a44bc99cd89sm2938481ejb.42.2024.03.04.02.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:11:53 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 04 Mar 2024 11:11:38 +0100
Subject: [PATCH 1/7] backlight: gpio: Simplify with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-backlight-probe-v1-1-e5f57d0df6e6@linaro.org>
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
In-Reply-To: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=L1gsWac4GlPBRR3BJYIkKHgN/RCN5L6+vXyGAdt7/+A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBl5Z5hj0XQi7kaF+7e81MFcwlKfdVr65vaHpPDi
 MjsbG2Is3OJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZeWeYQAKCRDBN2bmhouD
 1ygRD/938KcTcARGYikW/nyTzAfcX6ZC3q6UvmWTsLjqnFXltYckmIM/zt+gzWek4+bhQ9S1KS7
 Qmd2iAiCs6EU8ne7ebg+KIqQO44shqs+JFKqcyukBmdZ5f3P9ijrQk45S6KhhX0Z6PPohIoi98W
 GvTvFNX35xb/bjClwx8vtCuk8hJo6PolwiWsStWd2eenHGpk3qbOIiLVSV/NeF4TOsyVWpkNpET
 9BaDnLv0gBXAePVN6cy9mRLzD5JmzucY8gGBktV+zPhsbpNrTBDOJ/TNiydgwTxSVnJ+q24kWkl
 saS6lwMG7z2+0bfaiYCq/Aw+MicguWKUDtkyBTa2qqvmhYpP1URYMiOmjk2+aq1t/fpHJuvqrP5
 BhpZUHSlr+ck2ZbOJ2ckKXJ5SN3E1gVNVBYieebwzJ8G5m3mXZBKqOOvfQNMeSNfclN94ICR2QL
 nQIXGnO9EV/OwjRtKLapX9M5FYXsGLYvjXSpP+Af3WU6JHlkhnjGTOSnFBEWujD5yINuJJEF5/a
 qqopAv0qk5pujRsYiT85L6ZtryQOrZjznB6t3TdaO4dWZPnx8TcRSDulZLen4+WD7vcwUlw3yQl
 L+GrxwPMuZbqP03xEch1aBS3qvs+KFKTbyngpjIdSk7pFs8yUL+CTQ8q4+egzW+n9eEhvoBjZiB
 UtT5J0qdAwvwdTA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/backlight/gpio_backlight.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index d28c30b2a35d..9f960f853b6e 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -64,13 +64,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	def_value = device_property_read_bool(dev, "default-on");
 
 	gbl->gpiod = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
-	if (IS_ERR(gbl->gpiod)) {
-		ret = PTR_ERR(gbl->gpiod);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev,
-				"Error: The gpios parameter is missing or invalid.\n");
-		return ret;
-	}
+	if (IS_ERR(gbl->gpiod))
+		return dev_err_probe(dev, PTR_ERR(gbl->gpiod),
+				     "Error: The gpios parameter is missing or invalid.\n");
 
 	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_RAW;

-- 
2.34.1

