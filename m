Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67AD3B19A8
	for <linux-fbdev@vger.kernel.org>; Tue, 28 Apr 2026 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384757; cv=none; b=tLwo+PJJ+t5VlUI8T4ZqzlBKFUM11g9A1cEir++IC4T2WHZLBq7COtp7F1t5zLfQ4eC+KvYoXnqlQPMGtRAcn3NbzXpjSjW5kRbi7bAzRmMXqo+VodD96OP4KCDr9RIeWMKGKy/5latIRwDUPG9fPpqgyp9agOrL3eSvJU9Sy5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384757; c=relaxed/simple;
	bh=fStomxOM1crQBf2dh5jW011uYO0a7/MEjHDN74nHXvk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GdUOUYQyp19cno+GbrYN6YEe9+77wfHdt1bBy84Rc0tvIlLi/ANbYDL1rQQSxM/23Jk9+7eR3I4hzIXyFNavOiLwnX97Qno12kEgqG0PewrfHTT9Kt86jBNX1HsyVk9DKOtN9R+fa4ZD24zycdWuv7LKnjG8+ex2VnJ8BTKsZBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KhkbB3lT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KhkbB3lT"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso158900275e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Apr 2026 06:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777384754; x=1777989554; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=udhA8FYIygeULMf2spSguXELNb0LFsPfqpfV0jbfFB0=;
        b=KhkbB3lTU6Uv5nLMt102SpEg0R+VLKCUDz5wDRE3UyKYEFodShHJO3H5TLqFEpSdx5
         WeLAL5t3mesZj0OTsf4lUrZkXRNw/9pndj9WK5zKTww3/19k7WNan07iwteZscrKCsJm
         x+ztriazgLny25x/CLPqVJTXrkH/KTbWYGU78my7zKMpRlvoQUeSffgDMe+wCR9Nje/f
         bNTJwwuyLAm8PHB4Nn3Enq5fUMNSDZFfxXEliLsPYp9n1qS8T2qJMPAuiuGGzYcZK5KC
         ByYddzpjPt3QDiG7mhWOQ5Ut2i9mppNvSptGPD5waS4twvtaAHwfQ3b7UBcUIf8qkZvp
         hM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777384754; x=1777989554;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udhA8FYIygeULMf2spSguXELNb0LFsPfqpfV0jbfFB0=;
        b=a/4GwU8KYFFii1T/sRhZzoSEJMmb7QV/gpFzSw45ZZA1XeJoN/ZEvHFkT+0dpeYi+l
         0htrYa3GLklilxg+WylhtOv76/Y3FZntdtUcgJlHRq8kyso7EyJJ/e2oS5X8tmB9N5lm
         x5kRLJEPDEReJc0BeDfaaX27GlX2gmCe6QMCG1Vc+XgQtkMNaL/E2jNR0TTlBF9/mSJx
         iCJ5ZruaBC8m74cyyvmztWKF8hdOFXaq8SmvUQ7EyvMDfkWBcf+7ec0UDLFb2lg0DQMa
         j6gXVI1UOOAJOcqeP99OgyhPBlqWV3YD2jk24e+ilGU0dUrrDRyOWNJkpiCRBfs0aDz4
         m4sQ==
X-Forwarded-Encrypted: i=1; AFNElJ+aSegl/i7PWWLZAhtK4froIjyZIk9AVxaSt7jhuWIlh9LS4hCGB+K+5QkOtoS+KS8rCbX1J6xMuKrpJg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh0Z+xfr0udBnPego/1D3JXTHAlO/jJ9xzcSNb/t2NCHd6BUId
	IAfDSbnuYykVSyDwDwKb6fy4WFMhVyNpwYbgGMnLpTah1/rg9BM027ZHd/SGLdafWVHPX8MP3fQ
	+kmkXkrQ=
X-Gm-Gg: AeBDietvSiApy4MkUejYavZhdJwzNqxfhWVc+kHgcoNUo7ItRtU8A7jwuh28o7XoFJ2
	ei9szpgwvZPg494wO9+32OUspDVkcLmbvzKNynaIhM1C2tYTlbDq8KxU0ysQuIQsjIdB4jetw9r
	1IC2TmOZmSs/gXrHtfYi/AFzb8/7v/3Wr/H65aYTOu2ggUZuSYtJAgZOpdYXJflfm/ctaBoHbu+
	TzPm0efwaZfPXYp7NHLjVijiew8xedKMl0mJa/dwLEP9YcN2a9qjveX2bGT/GuYI8goxih/7qk6
	a3+9xHf+7XK5LZ5KmTzBZp/xw2vFcDanrdF32B9nt/2E0jrVN8elLkJJSu/kT/e3p3LmxocqK7L
	NPFTt//+5nH5WsxedTFGGJ6zhKhfaK6KnV2JmrlAFJag+Idnvpujd1IZjB+wG7zT0WOnx7miObG
	/9J9VF70nSBrxfIFqftz992yArHTiq8goYFhPnp5EBrLw+CQEjVuSpO0ZDIKmQMt3E6w==
X-Received: by 2002:a05:600c:8b2f:b0:485:3b9e:caa7 with SMTP id 5b1f17b1804b1-48a77b19d6fmr55500725e9.23.1777384754118;
        Tue, 28 Apr 2026 06:59:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773efe04sm60811155e9.12.2026.04.28.06.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:59:13 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] backlight: Add SY7758 6-channel High Efficiency LED
 Driver support
Date: Tue, 28 Apr 2026 15:59:10 +0200
Message-Id: <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-0-0caade5fdb32@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC698GkC/yXNQQ7CIBBA0as0s3YSQCnEqxgXiFMdjUAYNDZN7
 y7q8m3+X0CoMgnshwUqvVg4pw69GSBeQ7oQ8rkbjDKj2hmPLReOKA8/WoVhDokylhzv1FAMyuy
 c9bhVXhO5SZOx0FOl0sTv3+Zw/FuepxvF9m3Dun4AbzFq8IgAAAA=
X-Change-ID: 20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-3081ee7f1e25
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=928;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=fStomxOM1crQBf2dh5jW011uYO0a7/MEjHDN74nHXvk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBp8L0vzGcnPNa1ZX01cDX2xFb+HU61fFeMMwl6DH2F
 niCN/+KJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCafC9LwAKCRB33NvayMhJ0S/1D/
 9IGhCG7NAXzhBOSkBWur+HPJ04e478uoCh3E5AtZa7bb7QZDxv2o5d6Ior4uxN4kmXwBkRB2xvOB9e
 ty9eMPNe2OUD5P8ldWalWQxt0ez1fe2MF5woGGODSG+CVmnx8TIjsU0QZHrIqZPyECCoeLgCewIZ1f
 ASbx1dFC6OBW3GD5O+Pt84j+a7NzC35fJX4AFr0LQPS1PBez1rnOtsiXbhuKQw5f7TvBf5ANjTSTuH
 R0h6a/Ob7RAAcnzg+BXizPUmGTSyFaSgyhGIl3kznUYZae5HwmxLRao4J8z+RoYUhIQOqB+GEvMWkK
 n/O5r5zqzfQkMqU2X9iHzADB1XGGAQon4RSO/znZjDtvMlNVN46/dJPnFSnKMlCL1jjPgnSkfsg1CJ
 SvxfH4G9LjLAu5myBS1wh9JNvzoYzveq4CReN9UqJLYLYEE507y/UCbhMD/8RmzqazWyvp8nm+3ahs
 gYhiO9UuVSMMJCXdhjIpS1NuLPUPDNdddaZOhOAXtXcBQD3kHDOSogHFBI15hLemEGX/GxOy/J2QvP
 CQIO2cC53n/Uf48FWz4leqpsmQE4z/0NuHyTXfV/SgAVyfOhKvn9TyB6oKAmSDajmDBprAwUye4Tbk
 9rvsoSN7ThYC75Xt2qIu2z5c5UmLJrkwqmRxH+fOVC0w/6fgmWKGP3qH/GWg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Implement support for the Silergy SY7758 6-channel High Efficiency LED Driver
used for backlight brightness control in the Ayaneo Pocket S2 dual-DSI panel.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
KancyJoe (1):
      backlight: Add SY7758 6-channel High Efficiency LED Driver support

Neil Armstrong (1):
      dt-bindings: regulator: document the SY7758 6-channel High Efficiency LED Driver

 .../bindings/leds/backlight/silergy,sy7758.yaml    |  53 ++++
 drivers/video/backlight/Kconfig                    |   8 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/sy7758.c                   | 311 +++++++++++++++++++++
 4 files changed, 373 insertions(+)
---
base-commit: 39704f00f747aba3144289870b5fd8ac230a9aaf
change-id: 20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-3081ee7f1e25

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

