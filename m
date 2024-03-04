Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EFE250E2
	for <linux-fbdev@vger.kernel.org>; Mon,  4 Mar 2024 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547121; cv=none; b=e/7uqB7BNHFi2XSKMKisEUfxnVOKJHlW4mDxdVeXxqnLj547GX7XtWoUgwDeQco1200lafBNBZkv70vNQyx73BBeEcxgsPgNu8h8rX26H9j6yi6Y+NrEOTedV+ScVKuP1aiBhXUV7QicrC8JEBO44W7lkSwtbQvjRNjoJy4LJb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547121; c=relaxed/simple;
	bh=oBEkNwxibRPgfDk3iSeQlCR1ZXaxiSrVLWAc+9a0T0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKbRb3lJRRLQC0d0kbSyn3f9BepBVdl/8XngFOSL5RR1GnG2pDKXzbs0MHnq0wu6W1IQLPypLfEN+KNGQpWsJqWsjoeLsS2owgk/Y/y5RpnEDYCplnfmoEglPLF37BQy2EHz6Sw+cUamTtYh+WX1rn8qqjlL3IHqa6NitokNTM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MGKlp4T+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGKlp4T+"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so880912466b.0
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Mar 2024 02:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709547117; x=1710151917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ne2X+cO3epNXe9ln4awOX17bBGBk21696xx6GBwAIpM=;
        b=MGKlp4T+rbc1DCnqZx6QpHL9zm2bziiHgQd+WkO/1y8knm3GLNLpdY3zOXzQw3f+nW
         36An9kwh8NemT8OEml8ZFK3j9IfhN9mG2k3o4gmG4eCGzGzJXCPsAna35W5ptJQREDyG
         qHqc50nQARL7t7RSgYDeCx6Wm58fAOcF1QG5AEyFwoBw4rTMEvFOA8H/VGNTmKZDj7iZ
         hm/RVxobpgH9Sa8dIKvi0D0wI4syM/E+chppnDhHjBQ1EzRvfYHnwz0HeL4WmAm2uOPW
         cR5Co3rIKU6cQxBHg9hBLEbGUeQJZOrt+8vzLe315lhxvWKHIVVIFq8dUBZVNpsGq1Em
         fUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709547117; x=1710151917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ne2X+cO3epNXe9ln4awOX17bBGBk21696xx6GBwAIpM=;
        b=t33OhUtg4JvI4r97BqyACQZpafEglyZZOG21MW4nQwfjDxyldgiBW+xLo05M/d4A/q
         uRj8NPqJpPdQ3eUuJGJ7Oj8MQP5VBxmyE/y/IOOeIvuel4A4bHIOSJI1zQiKew5A3AWE
         Idoc88cCQX6dGmTUDzcoEnH4cpKDCyyo5oodWVOPIew/fG8+F7ngCKvqRHMYROw9CXaX
         k14vjSyOlTkT5OmAxQqpO4tLwt5IvpCHyT/nQORzHHqaRp2BMFpBFphOzThUcvUSZ1iY
         EnqXRSKZmmmRiAGT5zpfVpuhI0c/Saj3oQFqam8Xw+Xpc3sY6YZjEPpseaYeoFu84Is/
         LoIA==
X-Forwarded-Encrypted: i=1; AJvYcCUICyhec2xzZVceXo92HujNSaZFvOzKXppceNG9IDHCOJrI8oQRql5woYV4Z1cZ3kjS81OghRVjtn39Q+o6ygYpJZT/dedTAxm1W2k=
X-Gm-Message-State: AOJu0YzA2hDo9WBTzm2lvXZAePY5fFSr5g/lWbRqWs0eiBoiR74tO3Yq
	N8erZqOb9MOd9+I0vqlqen49Pe+/b8Rqd7f17uaiV5GWT3wiRSnb26+wvQ496UlvGj+4Kg5i1VB
	J
X-Google-Smtp-Source: AGHT+IGVbbGsL8NOOdTcpOF06AVc7bLlOHtxT+CBCYGHBhkmB+OOeSg+PN2omYlET3YAC6IP7dKJ2A==
X-Received: by 2002:a17:906:6c97:b0:a45:2cf3:6c65 with SMTP id s23-20020a1709066c9700b00a452cf36c65mr2316877ejr.25.1709547117400;
        Mon, 04 Mar 2024 02:11:57 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ef11-20020a17090697cb00b00a44bc99cd89sm2938481ejb.42.2024.03.04.02.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:11:56 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 04 Mar 2024 11:11:40 +0100
Subject: [PATCH 3/7] backlight: bd6107: Handle deferred probe
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-backlight-probe-v1-3-e5f57d0df6e6@linaro.org>
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
In-Reply-To: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=oBEkNwxibRPgfDk3iSeQlCR1ZXaxiSrVLWAc+9a0T0g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBl5Z5j77gB1Wx0xWhb8EDQs62oL63I8/c7sddDs
 CC6aYwM7c2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZeWeYwAKCRDBN2bmhouD
 1yAHD/oD63Jj+FaduY3m25CAoOSOqZrt+/dbgU985Nod7ZV2XRRMJEItdueEuA3748jPE6o2Crw
 iKIWC5h+bsPxgR4zl9V2j19cGWY/+UdpElaCU3a5y6IeK6Gibi1CCSovo+wY3sUvFhe/JPp3Ehu
 XABYIK8t+C0udLjNPoTi51pdBqNmWcTHa6zZH8B4i+mbImB+4h4wWt7zbKgAd5RBGCeSLDon4y5
 UdXbUUQ/M1VobGvTvha2KDdxmCQ0ZuItOTjzQ9eCh7aa071V1uHbF8IHTvLiCdCrQGd099Xc00D
 A6JyiyJIiOiid0BRh7EC1/kIHHbcXfogpZpcpaSGr8IxAj7bytITyUtMAIetq9D/c5t9Rlp5PAf
 WHm67lyeJxjyMXrW8BWbN4FeukFR6Qf3WlwEKxTBd8ItB3pvZ9+/LpVhRv7mAI+TST4qKnvoJ+3
 8WQlYy571QWu0kYwQfVXIz3gCS1G+lbBlT7pkydCU9TeAlxtjcUUt3W8yehDnRr3lzDlTTsH9wV
 7TgX7eMnoNQ+kReZ21Auu/HX88NDWYCNQ7rPs/VT2RckfKP7vn8JdWnc6P4N7yC4kx+mHKuizue
 mcvUhlAxB57g96zl7F0RVZ7gq5r1WhuKnIogHxHi/ZaCWVJJTSJ2o8AdIvgg9PVbHlvnM769UnO
 8X9j3780xbqzNcw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Don't pollute dmesg on deferred probe and simplify the code with
dev_err_probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/backlight/bd6107.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/bd6107.c b/drivers/video/backlight/bd6107.c
index c95a12bf0ce2..b1e7126380ef 100644
--- a/drivers/video/backlight/bd6107.c
+++ b/drivers/video/backlight/bd6107.c
@@ -119,7 +119,6 @@ static int bd6107_probe(struct i2c_client *client)
 	struct backlight_device *backlight;
 	struct backlight_properties props;
 	struct bd6107 *bd;
-	int ret;
 
 	if (pdata == NULL) {
 		dev_err(&client->dev, "No platform data\n");
@@ -147,11 +146,9 @@ static int bd6107_probe(struct i2c_client *client)
 	 * the reset.
 	 */
 	bd->reset = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(bd->reset)) {
-		dev_err(&client->dev, "unable to request reset GPIO\n");
-		ret = PTR_ERR(bd->reset);
-		return ret;
-	}
+	if (IS_ERR(bd->reset))
+		return dev_err_probe(&client->dev, PTR_ERR(bd->reset),
+				     "unable to request reset GPIO\n");
 
 	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_RAW;

-- 
2.34.1

