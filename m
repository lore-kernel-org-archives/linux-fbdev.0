Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1698876054
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443347; cv=none; b=n43qBr6mqzXxslL7i3xUzmPuFmjO9WsD7oBHJe2VQ++2B4QiSmmblK/y4oRzj/1n0OWJhRWqBl2Fh4ENwviPoLAaxCTpLg3tJgTtumk4VCNCi8weFABol4wZ/C8z2MfHKLykK4Ce3+yRxqTtIRGMTBap16TTBjrDgQibmYvPorA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443347; c=relaxed/simple;
	bh=Bdr6esLRbtemkpFIIDa1y5ugHKxf8AG0iRZ2eQuhhuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P46+E9zL9eSEC0loy662ugHkakzYFjAi8qYKz6EGoUJemXvqF24eRpzaMwWWPGlkCJDxn32ugvrCEbrK1ODM4zqJsPcqB3GSU2vGpJpyaon9OcpnNoZdiIq/kdFgVSylp5hruDeRW99la84ugc6NA8f6wOnMQCaOfBQjoPmA+1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PgAcGyS4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PgAcGyS4"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41272d42297so654095e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 07:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708443344; x=1709048144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcW5EHUKgbIlTJ9AkvlcTH/1qNEKLD/WUfYuV6zpMeg=;
        b=PgAcGyS4m3MARmG7Pf4cdSb/D7vA5SIgtDC3mkRGsipnpN28tjNxL6hr4TLddZ67+P
         owTW1oZANz/ZlKYkHO/5e3704isLy+NMOwdchknQfdKTobcFnUZqwq4vQWsuNpsyjy4+
         kOqbbbrifaStO8sjkSDeKL6PDPtYkA9/3XcbYeP+AwF28r4fwcKVHdSmIFWArQ76I/aK
         KUWiYgIR7qElJzu829Qr4ety3HPG3HHObTGjuieMREW0xD+rSimDmwazbNqkFZrPzPMH
         vQshWmrTkOubhq2odNcaQuTNYK2RtNDLqKnkW5OXcsO1j8nBiLreHYjjqzFeFjzvnj1I
         hagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443344; x=1709048144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcW5EHUKgbIlTJ9AkvlcTH/1qNEKLD/WUfYuV6zpMeg=;
        b=mBgr2GugbCNF1OzzfLiRx2eDXpJfx1fSqdV4DUUZq8xqa4apsPsOkBXD6krxI9FsFR
         aZWsgetCWY/XU1+xB5BprGIGWBhR9vBMmVUK/ursLO3q/FVaoR/GosIZjuseiP67X00J
         4PsAMbgmI2nFQOpauH2Gd/jxQuyNgqnt8a0tV69P69JX98V8pWSpFGWiBosdoTIF/OE0
         hfe7dSzBh2qK57LHsjOtuUHKjjm2XDI8loLhLpQYsm2MfkjWtGLjTk6Y+4RdOGkKddNa
         PkApAXR5/zCqsKgf9M54vFuSpWa8jrnpnCq6Vo/O76yTZtE+lm0zASyEPnaseWQMJWy3
         DBrg==
X-Forwarded-Encrypted: i=1; AJvYcCXVv4YN3lhXVuBTBWl6+hmVNszJ1fUlgDIL7kxbnuZ7TklsWFstxb4K708SduJ5da6/aREOGtXCKYDGMabRRcykCGrmeyGKzEH/doc=
X-Gm-Message-State: AOJu0YwLuzx1bouC3YeixN9MyZtD5KGK8qzgd3Qkrn26NH6aig1y0E57
	bi/zMqCXHaHdPSqwpM9V0iiy4MuDfPGfzI4lxSHa9QYSd3MPoGOkoG+kEusDt5g=
X-Google-Smtp-Source: AGHT+IEpCXV6NsmkOJ9aSe37i5U0I9NvAzq/Dog4zLeK5T/NulYxyznqCpuNmqivjX1f01yhov8nMw==
X-Received: by 2002:a05:600c:314b:b0:412:71fb:7732 with SMTP id h11-20020a05600c314b00b0041271fb7732mr408200wmo.38.1708443344393;
        Tue, 20 Feb 2024 07:35:44 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b004126ec2f541sm2444905wmo.0.2024.02.20.07.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:35:44 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 3/4] backlight: lp8788: Fully initialize backlight_properties during probe
Date: Tue, 20 Feb 2024 15:35:26 +0000
Message-ID: <20240220153532.76613-4-daniel.thompson@linaro.org>
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

Fixes: c5a51053cf3b ("backlight: add new lp8788 backlight driver")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/lp8788_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backlight/lp8788_bl.c
index d1a14b0db265b..31f97230ee506 100644
--- a/drivers/video/backlight/lp8788_bl.c
+++ b/drivers/video/backlight/lp8788_bl.c
@@ -191,6 +191,7 @@ static int lp8788_backlight_register(struct lp8788_bl *bl)
 	int init_brt;
 	char *name;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_PLATFORM;
 	props.max_brightness = MAX_BRIGHTNESS;
 
-- 
2.43.0

