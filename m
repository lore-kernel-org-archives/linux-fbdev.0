Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6549E2FE582
	for <linux-fbdev@vger.kernel.org>; Sun, 12 Apr 2026 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776015205; cv=none; b=PH8wAbnz4gBaDVF13Q05M3kmfaiJU6wyKFUlJtd3q9IivRdfFucwNhv8UsmtUG6czi1XnsS0dQw4wN+jM5cQyQ81y44lmAOutSs5/J25zzpTfNpGA1/gqh5aZStzUu2gRRPMcWDF4Jd5XYYFtd8LpIWAdp7GTwc5H/EiJZkDFCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776015205; c=relaxed/simple;
	bh=/fq4vDr56CO2k+npiEa+6hwzqLAU9ijIhxkJrtFIYjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JghaPdzrti2aCOjO1oBhOJdUfVhuUW0hPD9XMuBdmswUkMC1UsZ8OOoqTXVTPgSEigH4rd6bVKWtA7tAtLjAPgTKmcTt0b3Tld+ZJ2DxLOR0KhKFP+yXYRfYnSQyj/IpK8KS99+4AnMLCv3ZNtlQVFOA9YShGwN3t+nmBs+MnRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdmLuY7b; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdmLuY7b"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so48855855e9.2
        for <linux-fbdev@vger.kernel.org>; Sun, 12 Apr 2026 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776015203; x=1776620003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zY6yfZkHIbKAhpXHmyMs2cR3FIwM5tf4pW3ivO5AZFE=;
        b=DdmLuY7bF6UPcrosNhlEVxY6LJ/FAMbakmzO7d3UUBHq9QMUq8/sMCdFD6DjZ009y1
         qTer9Rb73A7305hfg2nMfIEKvdb+2BcDFDsRoMcqyZYRbHKvMEVmk430DEwaCc5X/qeZ
         VCpbvuQbDEtQTUYShQ5qxNpebbNoPqThhOzJUN99iW/t318ENUPe/7yIoqNpeahS6yG3
         rBvk3zbWJlQ5tFWhPzM47V1emrtHIlD3VcEaqCBUi4lsb3/GzckHe0MIooiDqv+kaxxq
         GBZxgIXO6gujZ8rlEaB7EzMJ8HnRwKBRMbijUEjvv0/GiXy9XKAv5BDJt1Cu4lqSKKtk
         LmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776015203; x=1776620003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zY6yfZkHIbKAhpXHmyMs2cR3FIwM5tf4pW3ivO5AZFE=;
        b=C1xiwskJ8EwG0XuMf+A4lAbSX3xTYYodkObolodYDoizjn+M69DH0WNQoZq9Vqo25y
         u5NL9KK20lHb/xx9Y92fyABAm+/UzrgSpKJy+ivhXq0wxMPjO16diSlpNOffvYyEqSRB
         F9TrS5/Hs9hOUW5snBvQbDuWxJVNJA+2QNcYtixOgbyMpCiQQHNcbFEKaeiSv9b3RqfR
         pWkgWOUppDfd2jS7WQLCcMhwMaqBKRziCXaWvk7e4ZXqsqQyEzqOa1Y4h+KBHrXfqe8L
         Z97Uo7oQRFiZwpRuoFTho+aX5kpo61zPAkElhe5Vw2onslmZg9whxqJMVpj8d5O/rIJX
         cg/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZWds/AqpuODJELj2v/aiWUU3SbGBmpeZg0OtCzeLWUY/1yyo8b6BCJCx2CZNtRGbD0FDMotiruSYZ+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7rinvpLU2X2k+uI38C4dBc8fw75IQrvzGA+fUsVNX3fGN5rZX
	p2RejsIFWAROG4MG8KtaQix89Mx+KS10uWOqf+9Dje1886UJxiBvbSUrP1K4QalhD7g=
X-Gm-Gg: AeBDieuSQl0k8Q1Q3dxPUzfkWD2NwUMcw0esRlBJ9JzlAGHYhYk1sk9EZ/k0W+fYs80
	6WY/cBgUIsD3KjfXNcfwVUHSGLOoqJAtqbLTlrNxPs2UG/M8+A5NGfWQqXh/N3oyyh/Hte4hgpB
	klTiqMqFXNMVSEsHxu0BYOX67WvjuG+/xdib38WsM4STdoYlyoOMgK8i2hEGYAPKTxO+dBpzEDB
	NXn2HTOgLhFg8bjXlxl/bQrFkE+XABf7RlbGFnuMaektASy1a4zGPIf66xJwtgXsuHAaVShaMxk
	eRQRyeZen7c1C9JWSUPTdRL2a/nmmtlxBOOQM8v8e4zLeSm4R1JyUiwR0LdHXkBXgFEg3sMRg7h
	JVYfAhfME7ryKjpGRH3p46hQKyQn/z1NpwOGJ5jX5tHl1/PPle69lsEe3iY3NSwc3HGYEdPFnAJ
	2u0/+dH8y1ncqVFdk6ZSw9
X-Received: by 2002:a05:600c:a010:b0:487:300:d9ca with SMTP id 5b1f17b1804b1-488d68af201mr154253175e9.31.1776015202671;
        Sun, 12 Apr 2026 10:33:22 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6c0:2682::3d6:8f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d76eeb2d1sm5499983f8f.22.2026.04.12.10.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 10:33:22 -0700 (PDT)
From: Baker <mzndmzn@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Baker <mzndmzn@gmail.com>
Subject: [PATCH] staging: fbtft: fix coding style issue in fbtft-bus.c
Date: Sun, 12 Apr 2026 12:33:16 -0500
Message-ID: <20260412173317.3329-1-mzndmzn@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove trailing space and comma before closing parenthesis ')' in
define_fbtft_write_reg macro as reported by checkpatch.pl.

Signed-off-by: Baker <mzndmzn@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..409770891c54 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.47.3

