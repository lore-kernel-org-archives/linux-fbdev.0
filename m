Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D28B3715F
	for <linux-fbdev@vger.kernel.org>; Mon,  4 Mar 2024 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547125; cv=none; b=carm6nchRrR6OAGqyCF+QBPDLMjpuHE2kDsNP12eviorIpTd7J3j7H0M4Jr1T8AU7oINm57wqF45rxxPtYG/2ZAsvxCeAS4tQVxQRqT3QWThz6JL28K0ABsZ/NvpG+2puIyzOA1AySpzX5wUap+4W11QB3KHz/zkLTPjIbXzT+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547125; c=relaxed/simple;
	bh=pd2WBlK2PnnolkSqpfShUm10rFxXfMK9JJcdv/+/o+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=trqCtMi6wny3cZ73jmKW3Li/X6qTf8Ta3uA+muX1oUHVl35aXbzABWDhNuLqtIQ0JCCU/aWyYgPPDpq7yjJz7LaRp3tWUtpfYQQSIjNxYrcaiLMFzKRN3gk3MEdqF2IWXZuzGbnHRb+hSznJuwhxaFYiWnIcq/sgPJ27NwvTxUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kHQQu6xX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kHQQu6xX"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a449c5411e1so346071666b.1
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Mar 2024 02:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709547121; x=1710151921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwjyvFJUk04Z9SLWkJyPD6nPLgMovuAGzXog2OSB5eE=;
        b=kHQQu6xXN+Nc0WKREsnVp1V76abhhxtyB+2zPwvEpxtjGB0h9kT4bs5U93cF2NqSXD
         KSWXj2QonFcmtaVOUtLz4YsjyDsD5CWi4/gndEXSg0ofD40dGxitrhU2fEZVfjT39h/v
         IccSqrl9cBorY4edq66KJIdQyffk8UMGmfDeKZj1A8hvnfYfkIH1hAD84igZldS4fme/
         krGClU7pnE4ou7D72j4fdhTnJrnSAYmunC8ErXAfgSd+pKxrHzBXYBKJDv6tX+q1NM38
         lSRi2Cf7SaUEyLyZP1AISIElsv8CpSfow4o+UJIiHL+4i3TCDrq67nI/o7NFT4qmQj3/
         Wlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709547121; x=1710151921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwjyvFJUk04Z9SLWkJyPD6nPLgMovuAGzXog2OSB5eE=;
        b=LZrtv9o0BEBkuXUGE46o7f/610iZT3HY2zI+/rGX1jrZ6sXAxOIM1So+8yhiYdh5Wl
         hp7Vz06ENVZyRsZL57kPPffkc4rPfmELZZubVWSDl4lGIth/ho5zRON8WDbkRB0WBLdt
         b33PjdBR5ijKxbLFR71SXrruWR4V7msEjMMwkiajK+et47tvapCByv7YVVdUo2DGM3ZI
         AEt+ZtNTDd9DajQRotV6ZpObN5twf0gOI2ANof67dU4JbIhiqTW9/LRR5zn5/863/085
         BaM4xhLnlagxq2WMafACtCoqLcwcOlOQyljRH3cOHoFQIbh1LCPMNTftQdIY0g4se2x4
         ig/w==
X-Forwarded-Encrypted: i=1; AJvYcCXRmKnuMFY5lt3LKKV1jAAw4r5xRlFOMKoHCPBHnsTVeTIJ2DeoTPR9hPn1X+sfR0+lEG1T1DPw+cDVCZwQ5/wO/OI1yiN0DKFGk04=
X-Gm-Message-State: AOJu0YzNqkZ8oqlbv2ITq343AgRt51bK0n93+exWT1CujWQCWn8cenUw
	Q+2E9lw+9VwL/kl59GHWOk+FDuJqp+AT2lsUD67osLs+BrpJhF2ENTMjSxF4o4xCNyxKFFYebQW
	a
X-Google-Smtp-Source: AGHT+IFUzjedvr/C84chcdr3/bRdz0Po8+qn9pjVm/iLXEGelmIh6PIw2Cts9hyPI3is7lGZn4Uqbg==
X-Received: by 2002:a17:906:d20a:b0:a3f:c006:f141 with SMTP id w10-20020a170906d20a00b00a3fc006f141mr5347674ejz.62.1709547121499;
        Mon, 04 Mar 2024 02:12:01 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ef11-20020a17090697cb00b00a44bc99cd89sm2938481ejb.42.2024.03.04.02.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:12:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 04 Mar 2024 11:11:43 +0100
Subject: [PATCH 6/7] backlight: lm3630a_bl: Simplify probe return on gpio
 request error
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-backlight-probe-v1-6-e5f57d0df6e6@linaro.org>
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
In-Reply-To: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=902;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=pd2WBlK2PnnolkSqpfShUm10rFxXfMK9JJcdv/+/o+8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBl5Z5lXJ/VFjg/mpbVkfSabBfIk9lZsDYAkyfe/
 D+nlFwxH7iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZeWeZQAKCRDBN2bmhouD
 11j9D/40TMnoJeYnOPMbLd5xVtL3dXUyBwE62gtbjuZcDCQVRF6H312FNVRBLVT7r2af2vQUh1f
 17GF0ogLebzfS7zgk8oEakUcVhkyq75oe02QLqCD6dNLu3sqeDVVW3e9Fqj0sb0UeaSHmaoWJ7+
 bP36HaSjz6gKYGqCuRQDiXSAed5uhxEW+B2cx7tyuE1j9IbyXs3WPZiyimbEYPiGXMrcg2byaOM
 Z+lNdioUPzs/fdMNLFlGD2DLdBHf4MlasTvQK4MCkk1CtF4KqnyqDMkKDJtOxTrzfz4FIJ8KLVR
 oLFviGSGKBbwMWywSjHw5aYh0guqG7i+RpAsh0fCQzShk8jZEiJAFJuvvyIGiz/XwGD2zyIyduy
 BIvF9Oaco7OeswzIqZ6Wb9+xBUahYeESyrNthUD+xFaynrVx9KxONqkL9l94IyFNqUWMp2+SREO
 aMG5K4viwKrtcjepKKRHZMdds0uNiE4HC0qqocxELok9nQ9lpjifoeVULxwx5HTE3hw0ub41Q4Y
 um9RLtNuSP4cn9IWYcrVJ78ZEP9LAcef2DwfCpR/lEdtqDV2dDiFni1Yt/b6VgacmVbyvBaUld7
 Po0f1M2DCrEH7UPbHXYgXCfhZ+B1Bp/XKFsDmz1UgsRVFJ54UfUCo8RJnzySYQOPTSmGT5HOudB
 o90wSGxwVpTTALQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Code can be simpler: return directly when devm_gpiod_get_optional()
failed.

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

