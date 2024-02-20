Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC4276031
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443346; cv=none; b=U7YH89bzgKt3kM3lUyQ2PXzYNH6R/Fd91cY19CMVuynEGULK53zyP1R3MZGf0eaiIjEwHjIP5f5vbPZCKwV+JkzJD7EbiNNT2EzcV4h9VTwUs6MWkVDMIkHFzSJhK+Y8QydBKQPm67A6s7BLqTibRURVP6tMjQ2EmQnFv8f3FKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443346; c=relaxed/simple;
	bh=LdGB2B5rFcC5/PxIMzBPHrC3fcULAF8gRB14YAlPNqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOoK4nMm0RXIM9PS0oSoz9LWld3gHr619pvN4JZOrv/M9xDH6B6ZW3kf/ew2patgnebvhvjhJYLd0xK2x1XNS9DOkOL1njSnVwU1I0g8DZ+8SuQDskW8PNwLKwpd0HuFGShMerljxaQq2T0NIui1QTNcQ3NMQfMaylFaVybuMEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kUY0i7lc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUY0i7lc"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4126f48411dso4690275e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 07:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708443343; x=1709048143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jrtujh/LnXfvYMR2N2cwo9zSO80+VM2HiXhsn02tIjQ=;
        b=kUY0i7lcs8xyQhIGX2nEAHG+cGiDpXoOnGMtCs6PDATpuOYWewp8T9uGie7EUa2Jd6
         BiayhkagUFk0ANspLxlfiW23DJdlif8RH/FpS2jZ7XMlZKQAETitfYvEDUlabOPRYvfs
         v3uEhHIzyx/WUiltYlYugYmUJmOI5kkRoaNSOipLUJzrsj0Oq+c1jWmq9xyfdnQCMR69
         6J+ofmKZyYOL5XZJs0WwU5LoZVmu/LNpmx5vI67agWGfdrA5J9BJd7Guf+pMe+eCM+I8
         yS5qGuUxZsc26jPCBotqYJ2vGQJjdZ7AN65qPzSf5NlDydRLii4/eg+iKdyvW+NKLTnd
         uCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443343; x=1709048143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jrtujh/LnXfvYMR2N2cwo9zSO80+VM2HiXhsn02tIjQ=;
        b=FmVy/ljgGpHOgH2Dl+VLID2O0OVrYKe2BRm8n4XV3+jsTeLrRF2LsZMqEoBlWaN4oD
         21VbYjE+gUdSjkaXonJirXU8RJoPSjbYuHOgHVSQPl2jroTUw+FoQwxn2eyXuWsY3g1D
         VCakkSeFqbJ78bGTLpQWpwUBpQHkW8H4ChLJQf6rJ7RMidf5Jj7V9QRaCnIAnAnbdtVY
         BLwRf+Fjje+TFPXWEe20vXzFWMAW2iiTh3vpeBjGanQ5pdu15lfZOihzoDVOYfQU2pzR
         0FrAkf0wtSNb8VZ58zXTWm90BB5RLqyzKUn5Q7MFTFudadywQgnW2qI8uAWHWJDJ1+l/
         PR6A==
X-Forwarded-Encrypted: i=1; AJvYcCXHDOsqb5jOXjTibsPLVyl+HuEwoejkDt2LYX26F8LVQLlyKDh8XO2GEGi0ZSCKbGUztrIrpCRZIrvSRT9RoT1bkGZFMO+I3kMxrEU=
X-Gm-Message-State: AOJu0YxlpC8rGlenTlmvkXQeu6d7bhUKh2RK5Yh4tSrAqVTNVvciFhUv
	QEwMP/LLPqfy+B0DQQuW5PzsZh2HgGNARB1xt1mbuhBQtMRNdo2rcxuk4wOe1fI=
X-Google-Smtp-Source: AGHT+IFDWLykrLrTZHAk/OiKu/p48Obi7ksW8/C3NaF3BGJJllJTfI+C8R5qCg4lbmEjSwL/2SNd8Q==
X-Received: by 2002:a05:600c:3ac8:b0:412:6ebe:9ecd with SMTP id d8-20020a05600c3ac800b004126ebe9ecdmr2032288wms.3.1708443343086;
        Tue, 20 Feb 2024 07:35:43 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b004126ec2f541sm2444905wmo.0.2024.02.20.07.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:35:41 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/4] backlight: da9052: Fully initialize backlight_properties during probe
Date: Tue, 20 Feb 2024 15:35:24 +0000
Message-ID: <20240220153532.76613-2-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220153532.76613-1-daniel.thompson@linaro.org>
References: <20240220153532.76613-1-daniel.thompson@linaro.org>
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

