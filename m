Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0543E7602F
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443344; cv=none; b=tdMrOyD7dDmzOdYPtQkLd/Xsw3na4G0ssocITzcXWS1XHcILE2mpPh5Ml8XJIVJiMVV1xZvhXnO7/6+h+9tmJZRRmdf5Tv2HZvRCZSz4K+81DDP2QUCrPkopL6RGpj9U253aV9vBaCspPB3RZZ3eEAVte7grKU+luIthLAOVspc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443344; c=relaxed/simple;
	bh=pyywoW8h1yIIdmCRv+vC93WCa1+/b1uj7774CP3TyeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGvZ1A5ZZo9Qof5s5LAwpICzeuHU6uV8CuIi9SNBKj23RZlANM/Ag2v7J8mt/kn1MF2XTpSpyD4i/PJ0m/hlclhiXLIxzDc1Ze15HEg4yE9Kw08AxWEfhb2g+IEuq0e5yv/qz6QKrrxZOgszTeP3iOGqjDHTvt9IghAO84kKmZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nz0hobpf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nz0hobpf"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412698cdd77so11141065e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 07:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708443341; x=1709048141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0tVavBaCJCcUxEWjYt34qLoi7PjbJJd+1sJMJ7iF+N0=;
        b=Nz0hobpfvjqjmqCJm878lWj6vaLFaiOFVsy81TzbhwowcULZMqyBGEoT7Ffa+qLpSm
         +7aAgeKTObyfHPgK9nDMc+mwtPIlrPGz/hlAfb3Tc7m2tYnHxhdc6muNgoUXg7mtLTH8
         0BK7oN8PeLUDqeBIH7qXJP5WELJHX8G74zxwryQJfkk89j+kD3bN+384YwX76vENfP2X
         eeDGPpe38oPKaGfyZtPVZAsgjRSNa8Yb/xwRT9AsJljZRosbttujreY47lLPtlNHsmyU
         rkSLeWM/jaZWYeIGnUhJZpWvQbV69LX+OCfoEmMBXeaxUCP2dXucWOdVnPixzj3yf2pB
         f5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443341; x=1709048141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tVavBaCJCcUxEWjYt34qLoi7PjbJJd+1sJMJ7iF+N0=;
        b=hyiU8gTaRqcnO6jzWrsx/XB+gVtv4enhT6rVUiouclMGocgPoSIvBaVC6nBL+QM116
         k3zx1dbD0FHRRm8yMpLhO/k4esaoamMtX/6Y+TbWPoIlme1Y/Nc7PU+gnLCFlyXxgEtR
         6sPPsFC0mEIW4USvUcXmrWJ2yZRBcQVeYJ9FI/N0QVtikJZLmUkUbla/JtJgur7etoBx
         h8B8BSfOumFCRT6oPiC9JZXgt/yn1uU2v0+orFrTLA1uGtYfF8BBoZZovR2W8lckXMGw
         slZ0HOEDoXHaZ+xcglha0rgUAJbKlItCJMQWtYca6zovfPISjmOuuT5ouHf6awkd2cRj
         vlKA==
X-Forwarded-Encrypted: i=1; AJvYcCWnxj9zKXB/Q/MUWOxoA6JQvcANc5WP4q24/t7/l3CFT9ggAJSEMHgEb5fKBgeJ0xpy4ewWI8C83ArKH4U/D2pEA04qFuD0bFbfiMQ=
X-Gm-Message-State: AOJu0Yyn4wj50lAAFrt0MnWuRPzArv+X6jAynPnu6Kdjrz/wRpLvZK7x
	qEG1jZfuYcODtYMExidhqyAPMeNk+P1m7J8vL01XzGuptm0FaIx8WVJBBr98LiU=
X-Google-Smtp-Source: AGHT+IFiqAfHWzDOcl5xntoajL3gcHfJPqSV5AusJhnh+vyCTeJ8HBX2cswoZr0VJOsM6WG9tR94Pg==
X-Received: by 2002:a05:600c:4f8a:b0:412:4731:a5e9 with SMTP id n10-20020a05600c4f8a00b004124731a5e9mr10993841wmq.4.1708443341346;
        Tue, 20 Feb 2024 07:35:41 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b004126ec2f541sm2444905wmo.0.2024.02.20.07.35.40
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
Subject: [PATCH RESEND 0/4] Ensure all backlight drivers zero the properties structure
Date: Tue, 20 Feb 2024 15:35:23 +0000
Message-ID: <20240220153532.76613-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Sorry for the RESEND so soon... embarrassingly I got Lee's e-mail
address wrong the first time!]

Luca Weiss recently shared a patch to zero the properties structure for
lm3630a... and shortly afterwards I realized I should probably scan for
a similar class of errors in other drivers.

Results follow in the next four patches (they could all be one patch but
for the fact there are different Fixes: tags)!

Daniel Thompson (4):
  backlight: da9052: Fully initialize backlight_properties during probe
  backlight: lm3639: Fully initialize backlight_properties during probe
  backlight: lp8788: Fully initialize backlight_properties during probe
  backlight: mp3309c: Fully initialize backlight_properties during probe

 drivers/video/backlight/da9052_bl.c | 1 +
 drivers/video/backlight/lm3639_bl.c | 1 +
 drivers/video/backlight/lp8788_bl.c | 1 +
 drivers/video/backlight/mp3309c.c   | 1 +
 4 files changed, 4 insertions(+)


base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
--
2.43.0

