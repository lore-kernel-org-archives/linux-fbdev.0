Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1029A76033
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443021; cv=none; b=p8yAB+qhnWGbBVxxzdQrlPGnfPb7bktQS5+C9WkBAQyEAYd/iI+bM12nK7nUUc2Uq2b6WR3gGY06n45Bkq8g8GZMm9o8WMjWnIN5uYht8ABw4xl/qBwhMHHwaZoQFDtr3osB07y4WAdxRQSlo0o5ZJpPXaqn5H6/+rjVxJ3fmDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443021; c=relaxed/simple;
	bh=LdGB2B5rFcC5/PxIMzBPHrC3fcULAF8gRB14YAlPNqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUAJQT30H5vC4nQjcWAgssJN8kJGBVaUzAnXhvWSRLgeVBCkoQ38yEpO0lzZNd6t25lV2NdVSrtuvVR7PXYiVPpFUbwSSOVnVKtKE0CMt0fDy7ayFUeQcT1Mm5aIHK+eBv55K6rphg7S5+9c2eLAr0tJ1MB0lu4ykuFTHAh+0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tpvqg7iM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tpvqg7iM"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4127109694aso3209635e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 07:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708443017; x=1709047817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jrtujh/LnXfvYMR2N2cwo9zSO80+VM2HiXhsn02tIjQ=;
        b=Tpvqg7iMV5q63sBjULxsRtuJNDWaVbWVaL5CRBP3rK5EfzIeacUE0X4u6Ylpfj65cQ
         ah11inTbgBoCa5Lk4RhKEBiwtAcdJncti+HNMZYvwav9tTdLzcCrWGMcUpg03PyfVbVQ
         kJGXvvd5o5PBNV6s7JPKbTjcxGzDtdcOaibFmsy8/df7+PW08kZ2I47Q/zrFcaYAb1rS
         jNQIxlIK6OR6RB2/EKcFBNPGn/zyuYYkudEELljX/YoATJiiukcimDPd5mW/GplMxD5L
         RIxvO5Z0g0AyI9Z+RIgdkN+HOCN1zxsBz0wowQfunZUU/42Rje9uRsV6zNy8EzjdMgZ+
         P3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443017; x=1709047817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jrtujh/LnXfvYMR2N2cwo9zSO80+VM2HiXhsn02tIjQ=;
        b=cqOrSIWMkMZiaLsOffpWbWWcwj//eJ9ihzwac3bP93ilOifgbzyEdlilfXw6mPQKCw
         n+4z3/+k4gcBbxSj07NnXfvDHWG5oTW9Z40MOk53stEOCPEAXOf/F2P4TUnh/oS7Zcm0
         BlHnstsFGtAkWkGX9D2qXPQ/otuFkp8VPj7Jl6dcyYR0YyBX3bcfSUJzxhgyGeZdy4tQ
         WXmlWmey2OSvkRz9w7Oy34j0KCrnFGKDK/9F0k6TxkxTRRYeBJeqOBTGWqoIlPxGAMfE
         kuOk29hexa+u4aLSTrq3zqIdOzOhvdkZrPbiSQXTaDAOZBUFiRlgUJpS5dcUFYx7xTlR
         fpmw==
X-Forwarded-Encrypted: i=1; AJvYcCUkCRJDxwzNCCrZzapVxvOPbGWwkisYMQXZBD7MXe/3lfcj33I1Rs0IYk2oKVv2zJy2+9CHiplXMW8M/bi03xXkM+iQzdtdGy3m5LE=
X-Gm-Message-State: AOJu0Yw7uq9XTIUZs+ClDjxaSp/Yg93uIxFG5PTLCBM+49uofEO+EfMR
	p9GS3jQTXzZjfMsLF5QEGI1eecoLpxZ2aDTLpwrIX+GgHE9+j0H0eQi8THtuxZizYc9tICBfgpp
	EC8M=
X-Google-Smtp-Source: AGHT+IFm14DobYCPmbNLGol/rwT+mRhKjIrwciaLuFCcheE5WveQ1xwJForozYxveJbElFbLbjVPiA==
X-Received: by 2002:a05:600c:45c7:b0:412:63fc:1c4b with SMTP id s7-20020a05600c45c700b0041263fc1c4bmr4848698wmo.10.1708443017431;
        Tue, 20 Feb 2024 07:30:17 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c280400b0040fe308ff25sm14691564wmb.24.2024.02.20.07.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:30:16 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Lee Jones <lee.jones@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] backlight: da9052: Fully initialize backlight_properties during probe
Date: Tue, 20 Feb 2024 15:30:05 +0000
Message-ID: <20240220153010.76238-2-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220153010.76238-1-daniel.thompson@linaro.org>
References: <20240220153010.76238-1-daniel.thompson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

props is stack allocated and the fields that are not explcitly set
by the probe function need to be zeroed or we'll get undefined behaviour
(especially so power/blank states)!

Fixes: 6ede3d832aaa ("backlight: add driver for DA9052/53 PMIC v1")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/da9052_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/da9052_bl.c b/drivers/video/backlight/da9052_bl.c
index 1cdc8543310b4..b8ff7046510eb 100644
--- a/drivers/video/backlight/da9052_bl.c
+++ b/drivers/video/backlight/da9052_bl.c
@@ -117,6 +117,7 @@ static int da9052_backlight_probe(struct platform_device *pdev)
 	wleds->led_reg = platform_get_device_id(pdev)->driver_data;
 	wleds->state = DA9052_WLEDS_OFF;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = DA9052_MAX_BRIGHTNESS;
 
-- 
2.43.0

