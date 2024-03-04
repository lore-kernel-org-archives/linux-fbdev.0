Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F84D24211
	for <linux-fbdev@vger.kernel.org>; Mon,  4 Mar 2024 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547123; cv=none; b=UoMLK9beMFo4XdSwbY8QBDRFetr1YEA05VeZ4rRcehj75El+Pw8rA3rsZDGu1SdWGP4H8IsK2BRXpKrpcXgPzc4dAqyQaGhG/qipBxkfZhxv4yWHk54Nokhxwy4IhxESds4nPW4USftcYRD3B0LHwPgwsvMprsOnZ6G80dSgKCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547123; c=relaxed/simple;
	bh=l2zBfccz8Tq6SqYayq64DiM3PIARxZs9iJsKbpWBrMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U81UecHk43XZNzCipa0JzooYCbo7QIR85bP1dzWNFtY15q7rJbBcbYXXQ3KrrEZelrXhgyxaRLgvmd3sOci+r5/GIKQCd/WJgrG7Dqc46dFefWdaBqpd0bEz6qIPUjWRgntxmfyVtUbo7NdXqeXEvfWrici4/zEQR34km8b9DR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o5czkjK4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o5czkjK4"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a36126ee41eso651991566b.2
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Mar 2024 02:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709547120; x=1710151920; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCgoEF8+45p8Lp99q3OTs1MMW8tsgAmVbVFGKP9cQEM=;
        b=o5czkjK4RSpVBgK674czx0Y0UZmX5kVaW/jTxUXaCAyczOZkZ2SaORIty/SCURHMFV
         YW55PyysoOeMKdydrffXIL27VtIuyJr3qppTt4O6rbGJr89hNaL9TBCbkWCxZwrVf0Ta
         3erACEIhteBJCzb/Ky9xUCk+IEN9fxbLyFpn+4jjF+f59nKXvMRN5SYRg7Ki/kTbF5wr
         M/Bc2sFk5rdV8NaU2x0HZcf3vSj5sFoUWGu0Wl7ZzbYk8EnNCgPkLrv7I4kNywzYXzsa
         lwA+77MQcpZ1Zz6WZAeWW87oUVQl8iM7DZMd/WnK2hqBelWa4ouorRFRDAqdReSxn4l2
         Xgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709547120; x=1710151920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCgoEF8+45p8Lp99q3OTs1MMW8tsgAmVbVFGKP9cQEM=;
        b=izksVLBUvGA7ucEXsdOmuJqBbiX6Cz3nEN7E4yzLcKl/FPJVDcO4dkxSlg25MlUGfq
         buPflUEOgXNMgZkda81tuADNyMLMOFxfXTdZ3mTDv5bwtK939F9wumuNE0LGY+Wsfr2D
         DIDOz0Td392nRGZ0ZJTBf64ibIBTOi03N4MnEckyUwqddAP92GpVX/vaaUa6rD8b3MNP
         EacdrcCRKuADprrIA/WrufSq2QB3x0wfEaorXBPR6GYsH+76noO9/M5NNeEiWPVGJ1ib
         xeTY0d22nW16sPmut8V1hU0g+lhdsDSH3ka4aD2jXFUCENqoulZUwSW1FysMgwP9Zi4i
         mrCA==
X-Forwarded-Encrypted: i=1; AJvYcCXqp+gNxapNNyCVR4kHMfCrq6IaOnHpUwM5h7U41vdS3OkK9foEfNkEMjm+r05SpAvV7Fd36Z/JkEUbH9bM9KEdQfn70Z7yw0Dkvhk=
X-Gm-Message-State: AOJu0YzhamyKmP4uINNtD2h5lKRbuVhlYqA8HM7UnDRD9OCaRoaKGHhE
	qgtPyJxtePV6jC41l3Fvj/pIK1lsiCyUqnj60MePSZFtdLsqBWC3rNWEWvQKblrszzPqrVn7yMv
	T
X-Google-Smtp-Source: AGHT+IHMXps/Sdsau2lL4BC5kTEGautlKze0rWGzpZvXGJF/HaAiRzHSpujG/+PG5cV0scGrNC4GgQ==
X-Received: by 2002:a17:906:c318:b0:a45:2b2c:8968 with SMTP id s24-20020a170906c31800b00a452b2c8968mr1743474ejz.20.1709547120032;
        Mon, 04 Mar 2024 02:12:00 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ef11-20020a17090697cb00b00a44bc99cd89sm2938481ejb.42.2024.03.04.02.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:11:59 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 04 Mar 2024 11:11:42 +0100
Subject: [PATCH 5/7] backlight: lm3630a_bl: Handle deferred probe
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-backlight-probe-v1-5-e5f57d0df6e6@linaro.org>
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
In-Reply-To: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=l2zBfccz8Tq6SqYayq64DiM3PIARxZs9iJsKbpWBrMU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBl5Z5k1b8EW68f6XfirNTSL7SEI9ygTM0istLZw
 TdhuvuJzgCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZeWeZAAKCRDBN2bmhouD
 13BKEACHkxYLvnrmNqz2S2EAVq1squYd3iDN3nmrgGmHzpunYRmnlsYHaCQP1Ne+LT3Rzk/0DT5
 2kPItHRavwLGtfzXlkwLcdWIJ4O1tCilY9lQb6KQJG1N9EjK6+Vipl/8WV+iF6plMs25+pTlU/b
 0nf9uT/r5IL5cC3Rf+Sg3s7hDFKjeEh0aH78KMaIeMolZlM+QX36Ud6sxRYH4lQcrewimowQ37F
 BIWqy+6khodGvB7Q+qGPFYLcXGHewXmq2xJjqhlop6PNPMNCwi00HZEodZCENGKrOnSTKLKyd7j
 kr1Y0UwfHgcnT8G4v+VJum0+eWAnptHxA/FwqhO4AQZTofuq66Y4gDPQTF+OqXheDd2ZFwDJ7JU
 78vL843x5VMZVe7AEfJSkfOKhHTOXFr6HyP1klsJ5lY29G454mNYhNyMDN/erwKwx3w7/On3XMQ
 5c1r0t7sXFMBBdRJpi+0/JjnEttDlF7acH7BflLiltf6atwGJWjBHKQf55RFYLRofb4Pq2WB24U
 Wymjysgg61HAlduM+RW7/OFURHUF0JWU81CR/GKmWfT21lmhjUsYGtbkS/qVftIpVhVpBW+xuCy
 FrdNSxjgUhfOPA9/yU645iXlG+RRMoc4CYG/aWlJyTaAo7Wu0meTzCE7rM+06ZSRWJY/FevD3M/
 XJeQstxrm5vdEtA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Don't pollute dmesg on deferred probe and simplify the code with
dev_err_probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/backlight/lm3630a_bl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index a3412c936ca2..93fd6dbccc28 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -563,10 +563,9 @@ static int lm3630a_probe(struct i2c_client *client)
 	/* pwm */
 	if (pdata->pwm_ctrl != LM3630A_PWM_DISABLE) {
 		pchip->pwmd = devm_pwm_get(pchip->dev, "lm3630a-pwm");
-		if (IS_ERR(pchip->pwmd)) {
-			dev_err(&client->dev, "fail : get pwm device\n");
-			return PTR_ERR(pchip->pwmd);
-		}
+		if (IS_ERR(pchip->pwmd))
+			return dev_err_probe(&client->dev, PTR_ERR(pchip->pwmd),
+					     "fail : get pwm device\n");
 
 		pwm_init_state(pchip->pwmd, &pchip->pwmd_state);
 	}

-- 
2.34.1

