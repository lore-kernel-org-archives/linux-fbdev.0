Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8949880BF0
	for <linux-fbdev@vger.kernel.org>; Tue,  5 Mar 2024 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626347; cv=none; b=BXSLIdtol+KXqbpi4SUsxoZyBb3h0cMjdB4ENU2mI3PqHJWNwTkUZ3euhw7vSR2I2+iAkHStyy5ujfohxYSTk6CyooK8+RVNOC0WzGpHcQn03A5/svhiMfsXnJAEdK5MvcqCysIcIg+dlnBqvTN5qLxGuFIQ2p24weI8n2KpCY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626347; c=relaxed/simple;
	bh=YHeoQ29NKf22XZpaybrdYUUdK12wkL0lEB4GhWf8FTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O9K2R6of0CU+NCas8orSX5FzQD3/o5EDyU7r21/3nml00uSEEC83nm8+JiOO/AUc3oeG7eEHczUGf0tV8Og4DcPKcfMNiNpyBvHK4hrp6XSyb3Saki7eYY9gpMBz5FppmtmZiizYikCbHXRirbGcCg8csKnHq0AbNjvk//k1z4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pILB9NXn; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pILB9NXn"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56698eb5e1dso6987437a12.2
        for <linux-fbdev@vger.kernel.org>; Tue, 05 Mar 2024 00:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709626342; x=1710231142; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Fm6lCHtlVIF1F+K0N/OPMuiMCrX8DVXWnanpZaecTQ=;
        b=pILB9NXnIhHFh4XQLaoHRn0HXZN7TLGIwRq2XAjNoL6bb3QGlYLFEnZg+8KqnqCmY1
         Ok+R1MBNIZgnzjKwAWcdEWymPbiiUtlghQ5rKzXEpT2reZZtzK7xVT+wi89Vc5NxNtwT
         /YaM51xik8wIqw6c6wzviYPHszIx3fYtD5M+TLSwcNlUi0NPP9RUXmClqV3Q7hY7ZIqW
         xyWCA73FrX7yJgvuJINRIDuNAuhsu2Bwue58srH0CXCo8UnCVWQsWgx/EgeMl3J/QLMQ
         eaHgaOrvijdqUSMlq5jfalJsLBPwIcFWj4UpXDw6LqnUOkYCEAKRt/dmbb8YYpra8KB0
         Xc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709626342; x=1710231142;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Fm6lCHtlVIF1F+K0N/OPMuiMCrX8DVXWnanpZaecTQ=;
        b=d4osJjzHj95wrCI9tsR1txiQ7hSDW4dtfkn+WfFX4w8zARKK1iIb/IZk3oQ9VxxE1x
         W+7oMKjDwaDXUdFSV4/tUJaN2YPri8HwiNlTlwKyy1Yx/etl1MkbI1nZAzApBbbmjRfV
         aYetOLzT9Bu/rxfyZHy6v0lFn1Cctv0DYUp1V9n627b5QJ6ZoDQtNDwIOl2ne07RDthY
         0Y8ZxSJxR45aX5kMQNGk89QYhHPbFABjMkefsxtZ2w2xPoq6faNQFBsp6RvXroFp5kJ7
         BF9ISnZt9lTgqpZ9ZM+AEb8m+qMs/wX55qOgPe2ztVy24EONROKft2gulla31kHY3Hu9
         Qfpg==
X-Forwarded-Encrypted: i=1; AJvYcCVxYOKa7Es9OCMChV+OfK734fr0bOV+B2+Kw5x8oEgr3xMtP/8XHYUMFvaONHYVg7ggy+zMiS49xdp48+5vsOdbujgRi6+mLMhZxZw=
X-Gm-Message-State: AOJu0YxB59SAcnnYC7R/sOijQmmcG6ZIgLfb8HoGhySNdwdeiQLLv3Fr
	T9gX2HPsn1NMoyoeXBdTxJ9CqWDNpa6if70Trq81B5CMTVcsUr413BAUgJOHat+Zv1DF8U8DGZh
	l
X-Google-Smtp-Source: AGHT+IFmQXq9OqnAqZ7n+ipcdaFFZ7KEXlOXnYPr+dCB5rotQlp6U8HU8sJNK8HhuEbg+62y8KfoNQ==
X-Received: by 2002:a17:907:367:b0:a43:f020:57ed with SMTP id rs7-20020a170907036700b00a43f02057edmr7581833ejb.73.1709626342374;
        Tue, 05 Mar 2024 00:12:22 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b005672a346a8fsm2761557edb.57.2024.03.05.00.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:12:21 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 05 Mar 2024 09:12:01 +0100
Subject: [PATCH v2 6/7] backlight: lm3630a_bl: Simplify probe return on
 gpio request error
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-backlight-probe-v2-6-609b0cf24bde@linaro.org>
References: <20240305-backlight-probe-v2-0-609b0cf24bde@linaro.org>
In-Reply-To: <20240305-backlight-probe-v2-0-609b0cf24bde@linaro.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=961;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=YHeoQ29NKf22XZpaybrdYUUdK12wkL0lEB4GhWf8FTY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBl5tPaMO81r5PpyfYzgPlAboOMwxF1eOJg99FdH
 BQsx0i+aJqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZebT2gAKCRDBN2bmhouD
 17VTD/wMe9QVJLWWgoGJhpJgK0qfzqPtG2LHvEiQKHIc9p4TZH6iIk89FjqgbQmllt/sCIdLPzD
 5jCNPAb6QsYi5rBbHw9tXOW/fw/bA1XSeBdKReHR4xtnTd+Lp7ZEMe7thHzzhEXCEW+6AuW5Zh7
 vdcnvZPWJcVUV9QokX7gskQsHOTHg8M9L11ICQnn2kgJqtBvffsN4z7tRx0gFY2BFkV390IFTZa
 hHlBhzDWyYxYAp4I5M7OUld5ga37cX1lmBM8aWaC1lj+UoSNe1XCQPvo2mp/0U+hEZGCkCW9T5c
 d478MV6wl1sAsoVRUq1VmXpOYK8+oi8beiW5SF7YWtT5knT7Z99N/kfc/MPdrN8WqThf+6TE6oN
 Cehjm5fjzjvLxM6INXJn34dwTXkGgagvWLL9SQwrOtTMAx3h/PBIGINvCaOzapuZeDwCS4vfvp5
 CLS7LbPOYq/0XbEwySMM86UcHe7Is6dZHYqDXfMnEuxh5EPQUnDFiYrs01SINbxX5i/N8rT3ovc
 xaTofPHKif7mPAFTVBudQKQb0oQQwo14veJnxVLsXfapCKdnDEjrX4uqhtstonC6F3vNX9w97vX
 5gsi4DlkZSWtsii/UFMd1cohSPSSv9zx8VS2TAbTXmafKMfVKjf5caGdDisNEoGNN96UoujMDcp
 krxxRUqlxMNOQRA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Code can be simpler: return directly when devm_gpiod_get_optional()
failed.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/backlight/lm3630a_bl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 93fd6dbccc28..ac0a60e39e39 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -543,10 +543,8 @@ static int lm3630a_probe(struct i2c_client *client)
 
 	pchip->enable_gpio = devm_gpiod_get_optional(&client->dev, "enable",
 						GPIOD_OUT_HIGH);
-	if (IS_ERR(pchip->enable_gpio)) {
-		rval = PTR_ERR(pchip->enable_gpio);
-		return rval;
-	}
+	if (IS_ERR(pchip->enable_gpio))
+		return PTR_ERR(pchip->enable_gpio);
 
 	/* chip initialize */
 	rval = lm3630a_chip_init(pchip);

-- 
2.34.1

