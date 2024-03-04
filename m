Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFC225760
	for <linux-fbdev@vger.kernel.org>; Mon,  4 Mar 2024 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547122; cv=none; b=MbVErIcPVuSsRxMXQ6V6j9nzTW/9YiiL4xlCkMrH+DJBpeOcbUolzDva6/sxT1/nz64Did10oXMcSn1km6KuVOpWcHRG6alkgeAjKEUrkCTK3fPm0gcXQw+PXyV9QmmGYuq7cb6q6uCOClxR6/xQeZifRuIP1GajTAm9F+xBS84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547122; c=relaxed/simple;
	bh=tYiRyc4GCWh0OQZcegdBJotlKUvQmMppy24vmgOYX4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oDo9Aken05Ujo699Egaol/oCrlUnLo53e0do5DPt0nbhaHY1zwYQ8eVDE3Io2HVGpg18VUGUpmL0Qvfv4pFNHyUjeVXqu0p4vEsSNYEHEiOMY1/bMcSWiaVoO8337u57LLrZgjU2ecYS4Ou3cU+jnJhc2gFTlpJiPbr/G04rTrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W9/S/NyS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9/S/NyS"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a441d7c6125so519133866b.2
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Mar 2024 02:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709547118; x=1710151918; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7jNpD8JVN2zPECncF/JczEVQcdrOC4+lvPqKzDW3Nk=;
        b=W9/S/NySWL4cFC3wUi4hMnYsusgzmAgly4dN0BY6/j8w6yyZj6HPozJfCYqVFihtWl
         Q3uzqncKkJsxqcZCKQbkFCeetXjz4nEJApFYLz56wm9+vtV0ZXH+FwJytY3HCBtFP8eJ
         j8Ac3ZwjTqPh6Djey3tSzwN4oudRYGpn0cQSQWWLIxZiy4b+yzJ/JzbL5cbk+fzVsKJ8
         sfBpNT93PiUwQGeeozWSxty+2I6gg/4Eo0FObjxBX23BqLw3Vw2LoJFVJwX0wDGy0B2P
         aCgFjC2lJ+gfIOK6ZUFSn8GnajIkCXlHli0YldFWc9qqI6VlkOA+fTf+UamJwTiSgq5l
         MIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709547118; x=1710151918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7jNpD8JVN2zPECncF/JczEVQcdrOC4+lvPqKzDW3Nk=;
        b=D66Dj4KxLWXGneDH8WPdy5lfX0D1rMsSDQu/BIIaow5+iaFaOz7w3i58Zt1P+/YhTw
         1EZzhOKV8sCYkQd6c0RT7gUZF8vTJ28IvwxDkOy2ILhMVdZwOcj8MULeoxFSTaj+fsPF
         jjqjxQZOFzqmZybFr/T5gPygEFV1hVSVPLX4Ek2u/PKwZb7MT2jnBdqwvas6wJawzC/s
         WrG4kiYUSmqHXg35PDVCGsT1r6uH/bDisglNFSwa99Ttbx6Mjz/CYbvYKC8gwz2FkOFP
         AopW++VUWZgoUvvtaHcpggiZYlwHKV71uvRbkqVhbhBm/CM3e7bKDS6BV6h4KAl6Uw4j
         2plw==
X-Forwarded-Encrypted: i=1; AJvYcCUVennLERpEYEllsmdjFQuvqyFft3A1K/aYiNZ5rtd4DrnQRak/HMTSOynxFTIhAboh/sClWTBFAnIjYP8jmQzyC58Gw+bmJrUJZ4E=
X-Gm-Message-State: AOJu0Yx9iLQY5WcSMs4B/PqK66LyHKx1ZrUpWToKPX3U7cqf1xJE4P9d
	2FbqMxyWv9Eg1UZrnNQy0F6qgxc72/EX/czXe9/SF4BRbeBqeW7FLMMMaOJQ9TuKpi4wXO67L/K
	2
X-Google-Smtp-Source: AGHT+IHIKfIPI9q/DWJfY1zams1q9M6IFh+MBVE0LB3ZesWC40W+rYmZ2rQFJmiyAV8Fad1klY2w+A==
X-Received: by 2002:a17:906:f759:b0:a45:6251:f8e2 with SMTP id jp25-20020a170906f75900b00a456251f8e2mr895177ejb.7.1709547118705;
        Mon, 04 Mar 2024 02:11:58 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ef11-20020a17090697cb00b00a44bc99cd89sm2938481ejb.42.2024.03.04.02.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:11:58 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 04 Mar 2024 11:11:41 +0100
Subject: [PATCH 4/7] backlight: as3711_bl: Handle deferred probe
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-backlight-probe-v1-4-e5f57d0df6e6@linaro.org>
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
In-Reply-To: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=900;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=tYiRyc4GCWh0OQZcegdBJotlKUvQmMppy24vmgOYX4U=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBl5Z5kf3pCwb8HgUK+ziA6YZsz55ShzwCbPlrjj
 dMl2yuN1lWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZeWeZAAKCRDBN2bmhouD
 1/DiD/9EClVTNg83B4aoTpYk6q3ArcCWKbx42PizR2X6dccHjBKLN0SzFYUPp8ZRWNevidleHfh
 hupUfnR2wyDAYPVPWV8dJtdgoXjqCxq1y/1koCVZDMh7rajI7WnOkS6+g9z8POlL19KGLVYdi//
 Namj816X6p+XoGcwG7ns1mStAJdsc/RkT0gkuAN42tg/vREKdLIesdNxqO6PHytr8lr0oL5Qlf2
 O8Spa4QNgRt9FIlVFBvPv/UGY2ZlDjhUaPDn+xoIlqoCUN843JiGiAncg6CY+xPxs4XxbyKLFGp
 k2CSN4qRLf/sdfX4PagBz5wRrLKEkHDITyx0lJZ8K9NiSCWBD5XuJAApZJF81Fdam+7DIoyxPLd
 MxNndDTpFtHki2BkCFnq4kcOzKukGbR2jN0qBgi8y3H2JKsAdqQO3kgFS7Bec5ltmWT/4Qjtu2k
 cgw3rNW0c8rrFL/RpfV7mfgnnkB1HTcrv03TWerMJVvtTZlnp2udLIqpvjLsLiFj1Rl6Uy5ugtS
 aZ7OQgZkXseN2eOnZy3iB6URxjsuYEjwfWQ2pW8y8Y/1L4Sr/qJHZSTPRXKfNNsV19TI7msionx
 gDk54z5VALicMkbhcQGfaMiLD1bzd2ms0GRYNQ9KOFTFKsIu+56uI6bAXtAnbN2p5NypV/7lJ4w
 O9o+19pX4CAdJ5Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Don't pollute dmesg on deferred probe and simplify the code with
dev_err_probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/backlight/as3711_bl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/as3711_bl.c b/drivers/video/backlight/as3711_bl.c
index 28437c2da0f5..e6f66bb35ef5 100644
--- a/drivers/video/backlight/as3711_bl.c
+++ b/drivers/video/backlight/as3711_bl.c
@@ -383,10 +383,8 @@ static int as3711_backlight_probe(struct platform_device *pdev)
 
 	if (pdev->dev.parent->of_node) {
 		ret = as3711_backlight_parse_dt(&pdev->dev);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "DT parsing failed: %d\n", ret);
-			return ret;
-		}
+		if (ret < 0)
+			return dev_err_probe(&pdev->dev, ret, "DT parsing failed\n");
 	}
 
 	if (!pdata->su1_fb && !pdata->su2_fb) {

-- 
2.34.1

