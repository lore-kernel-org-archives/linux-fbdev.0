Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B93F7EF18
	for <linux-fbdev@vger.kernel.org>; Tue,  5 Mar 2024 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626339; cv=none; b=MoM0mjGFr/2thvIwYRJJLyAZrjw3q6yhbWwOdHzZM130U9+uC5PWSyDDYVXwbcP9aCWR7TvUehp7hX8B44u2Lla7VXaMJTldUTO37I/3zFGavevXzynoWGKO0Zu3tp4d3Xf1q0t+PosIdHCBoXfFiYHW4/nPXkj7RDyYTgIVG5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626339; c=relaxed/simple;
	bh=opt8++1g0VChwtIB/Fz1GiYx24pMTFMe80pujvPzm0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HQNmeaBKqF+QbvqFvPdjISbP7z09EjD+kHlZ7vW8ZhCWVhkXN2G9RcQXx2reQ14hj+QcNbL+DzMM5gNQwu8nH0r034cW7xQzmTXADM4bNkzMKBqfCdNx1yD8v3g/SUpaqrw51ag3ZxpKsxAZPBBhQKIhkXVDPv/0u5uLDT1+PjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mMSoDi4B; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMSoDi4B"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso6150574a12.2
        for <linux-fbdev@vger.kernel.org>; Tue, 05 Mar 2024 00:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709626335; x=1710231135; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZhcPKgdyjL8bhk28jJde1fP1o5dZ8nODM9Ogpw/oLw=;
        b=mMSoDi4B0ScoqRdIq65JbZqWxhBN2tGRGDPmnZFCLZcMnk1dGHvUpdXTKK23eQS1rz
         14hBX01gsecwrSo9qQY34bm5BEPuGzI+7yAF6/ZzsCpkJcQn4FuFXGIxGX/crNeULE9D
         wOpplKJ6hPI3swtCqMVb7Upxwyo340RSIoVKQHaEj01izNvgQ4vv6hQU+JsQjQR7yw4a
         Ep6Nr9IV6oxcZc0uYWIPJjmbtnnhtsi/CosKkJp5xzAOpLW2MlEmnCddwFzeEry0YvdI
         Gel5BHDTg/VyIY2rkqgfpdUm/QI5IIesm3X7NphtJN3wKSukxbsQ7ril6MDuRBpoxKys
         b4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709626335; x=1710231135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZhcPKgdyjL8bhk28jJde1fP1o5dZ8nODM9Ogpw/oLw=;
        b=pN+nG/DiSzyycfyfMalTxiTYqMLVVkQRcz8OCqGeUoTY1Ek+pLmuGPLts9XOf+LKc1
         AirpRwj0m9Xfm8uq0AetRBVzN/vcUNkETPAV+pm3blr5o2CJzDHcyHoEvcC2Cx7F+2kB
         JH7XtZ0FPfkQUFx/5VgyvOyiPaozd/OLdCZmFFycrkhK44z+emP59Gtkm+rVCcen5aJq
         XqrnYLNDt2U/CxAkLMeW+GD0EfMBNI2TMAwbst1tjjy9qkLlonx0R8yOpvbfGAbjRIUi
         7nW/P/mkbn3HyaeirY+HSC2Yk5MZJeZnX4Vw5wQYajjYP9N8/YJVH//U9MBBGBzHyYEN
         O7Gg==
X-Forwarded-Encrypted: i=1; AJvYcCV37Z/0ZsjR5YwhEIvp4H5GSCK9AGhKvoeocMK79w2veVd3skRcDX4Qg75sBuqmUWfJcrAEoObiqB2yRAvz3US1NztPn0qoJwSJSLQ=
X-Gm-Message-State: AOJu0YzogpS2bIto05NHFzxFWjqXMLDeyiFFN554Hdio8c+/WHPRo3BD
	+3u/QQkOixFAPSuXyz4s86u5IxL5sRdWskyvVGSmvfchMwbJzml/WtqkzXKE4R9/DMEzXopl8iS
	+
X-Google-Smtp-Source: AGHT+IEuX6cKf625yCSFdJGJles12Fo1Zc/Eyc8YTMuYE42QgS4ym9vrzIj3xWMG/qe66D6f3pwLmg==
X-Received: by 2002:a17:906:cc93:b0:a43:e46b:7a80 with SMTP id oq19-20020a170906cc9300b00a43e46b7a80mr7105432ejb.43.1709626335333;
        Tue, 05 Mar 2024 00:12:15 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b005672a346a8fsm2761557edb.57.2024.03.05.00.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:12:14 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 05 Mar 2024 09:11:56 +0100
Subject: [PATCH v2 1/7] backlight: gpio: Simplify with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-backlight-probe-v2-1-609b0cf24bde@linaro.org>
References: <20240305-backlight-probe-v2-0-609b0cf24bde@linaro.org>
In-Reply-To: <20240305-backlight-probe-v2-0-609b0cf24bde@linaro.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=opt8++1g0VChwtIB/Fz1GiYx24pMTFMe80pujvPzm0s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBl5tPWa6sw7b/TOSWZwZZYFLYG0BNvTG0TlbZoC
 8bMfcQFWxqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZebT1gAKCRDBN2bmhouD
 14vBD/9cqYKdrTAFMz6KcpOJxJ61CvuYnUPyihjwAG5ODNJ/TVWyi23DB4xZuL9d5a1Ff1xPt0K
 xenDTpvWcGV4PuNDjXe+sLUd0VWaBr/u/qSnQgDEhzYBbP095TSe7svObyzpsA6qK3c6YpxWv4J
 jRHXI5HShKxxPH2EqrqgzFx+xQOhmJAcBuWDyOCQDkJwGjvNShtjm/Bucp04ehxnXM2pmmdSTKV
 uH20IKKiZvxuOfnllFf117Iet3e0cK7KCMmcAy4CNi8N4Fyyo8+KcX1o2jwaYEJBzGqjSZJfHEc
 vRjVzwLQg2mBtty/lc4PwvvKabGqaIqiW9nDsqg7s8StjZZ2C1Xj6tWBgvGJiPJrOPscB0anvRo
 //2hXe/fq7N4168QtWlzL4qnPMBVMP7xjIFwwXCFasHOgBBuaYcWRYSmydbuT+8E+Ca5g7LWTSx
 Yt+0Nk5JLCTQ2cRZVdB7GYf93YoNlJ3mm2LS/bSDlBWQWuR5RMeuGTY680tY+ZGlCfbWp+mZxyX
 brBg1fFJMyxwb2hPg8YaH8BWgaqQHz2M/jMeap2g8W3xYqSJcrwk82QrnNzfw95/w0o5ejrpADE
 KKV05pkeESvkDdw0gNi+Jl++3PUHsLFtdS/Zt0LRqULopfstN3o6duCsIifq2E558izCkBczLjg
 m6Eh1t0XIs2hpyA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/backlight/gpio_backlight.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index d28c30b2a35d..e0c8c2a3f5dc 100644
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
+				     "The gpios parameter is missing or invalid\n");
 
 	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_RAW;

-- 
2.34.1

