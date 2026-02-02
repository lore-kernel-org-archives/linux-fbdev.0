Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C6D376490
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Feb 2026 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049730; cv=none; b=DCUwv0wnrv01QGDhJKnc1KqR26DVOTl7qRrwMuKwseRZKM+eHug7AkDzbU43Sm3BuuQvmtqgXx0uif5ayzaXHr6Ts3BgIdedB5Kuz0IiAdcFhMiJ9+BC2SffBSicG59nKgotbXrlFcXQ26p7P5cTzTyTZRhFslyDvg7lv8XCUmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049730; c=relaxed/simple;
	bh=Ftf6AxmGQtAtNVtlE38F82dj2LDYE/4g8fYPDiaBt6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJVXTTiG2dR4dDgYMV4xxZ4M0U20epVviwJuca10PCEHTcotW8kGOgOvtJHvI2p+rDJSp8gVJFfrHtzW3lW1N8xufref7tKBY55Ns7jeBF3PwY2zR/20nWXN0wPSQCm8ynMAdjIQ0qFnxUzi0WnfF8+RO3gbvQQmPisia+/3SSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvzJRfY1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvzJRfY1"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a91215c158so8860435ad.0
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Feb 2026 08:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770049728; x=1770654528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sahNc25e8V/0vokuer5AdT6A9YG4/1fX8go429GK/ZE=;
        b=SvzJRfY1gluVk/JObJ9PjU5Ed8FdYyikPabNBJkSw4yoSizbnh/1J40ShyP+uT7TQb
         jE1k0wsqnSWCPSX/x1AL0gdXdDLqrluo1bbaQnswvKZkp9r2eOQqgydHxzzrKPIM044c
         IuWXk4WJo7y/Len7w7QRMuNh2TgRRjsZgUdSugqFMo7bnyM8T24G+9L9ccYpEQU0A2Iy
         GaUXtEfi8UVpaf0suX/uK1nPonQho+A3sJTBEUjMOm23N6oIsOscCmGfLqGDZ92ziD2b
         nbMhnSftR5pkZuSGq/IkWAA1vBHJ/RxXdDQyG2TvIwikPQFgOmhr08pXKSxDVWJfHWFg
         uTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770049728; x=1770654528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sahNc25e8V/0vokuer5AdT6A9YG4/1fX8go429GK/ZE=;
        b=p2bPTkd4YEPlAOUWSAXkJWOMxd+B534OjRuJSg/YLgPlzYre8MzcUIthVBcF1qsR7h
         Od4arLCmlyIiMoTmz9AA1LgrUFZUW+DXHJgZW1cjDaF58GNRP7YKE/B5xtnxMHHwUdDo
         pPtaont6U5bZ9D0Jn7VyiB2lh1afQ6gtXagjZQEJzB7250qMJJZIAJ+W/YNVB+lD6fgD
         l0z8H/1euEqPYHMkdHeQC9RFGuTpD9SkPNYqwzf0NN5Cy82TBq462D3bS+KzXBJtbe4/
         3E81abMa8ewxbGrsvMVLqbefHAUfcaLFsb6xh5qi8gD9FCQFOLtkjRwjcJbyXVNQte1P
         9bPA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ1MQwGHDvzIK76le/foHBwgM/u+Ieu9OvjLr6oFVsVqFI1K8ok7ZvyI7jBh2ZRtp8t/TM/amnlzC4Eg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+0hfC/lGnr8BGabNFMrTYwFU8br3urn0+6zhobzP8vHuB6K1n
	/OqkYJbQImkMtvyT1i9dQdOlsZq0WM9zXhFJ4AaZUPZYeIjJAZ714ZR9
X-Gm-Gg: AZuq6aK1N0HmU5smVYrdezwuLrrMPc3AK9t3muZsO0qvSLrh5Y9QWttCn0BxS9qeTJn
	9HBfcwvc3XSYnKikreapyEvt+idcV3ufdYn87m+Nct96GoVxAEssMbiIheuw5s0jy+benns9yDo
	UVXbSoZKNMP8ZqG59EnwQ7dpfDVvtrdDT72XEvQypv+PrC/tBx05qflujzK//jvoU02wE4vVAU8
	5PKXGhUjW3qp2uR9K7N7vzJeDC9ZbE0lJw5XomLXgffO7cTYu8QNeNPmiBc48vXR1tU1k5T2fXX
	KlU8XvhvDx63hEB+k4rUUAbUmAY70h0bo8duUaGfqRvuKDde44Zwiy0TA9HFyuRw7R4emjtHpVZ
	QcMBOg1iW3HiQG/+JQf1V58uBWpJkwuk/aDNSNYGjEs2oIIk2Lc/2iInqKNhKpFGfy8B7MjBGzx
	bqgVg0DhFlS5vEppw1NIEiMX4=
X-Received: by 2002:a17:902:db09:b0:2a3:bf5f:926b with SMTP id d9443c01a7336-2a8d818b2bemr140531225ad.47.1770049727956;
        Mon, 02 Feb 2026 08:28:47 -0800 (PST)
Received: from krishna.. ([103.220.210.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eee8bsm142211405ad.6.2026.02.02.08.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:28:47 -0800 (PST)
From: KrishnaAgarwal1308 <krishnaworkemail1308@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	KrishnaAgarwal1308 <krishnaworkemail1308@gmail.com>
Subject: [PATCH] staging: fbtft: fix macro flow control warning and empty macro argument in fbtft-bus.c
Date: Mon,  2 Feb 2026 21:58:26 +0530
Message-ID: <20260202162826.116739-1-krishnaworkemail1308@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch warning by adding identity modifier for define_fbtft_write_reg().
No functional change.

Signed-off-by: KrishnaAgarwal1308 <krishnaworkemail1308@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 36 +++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..0ab4f5c4f886 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -10,6 +10,7 @@
  *   void (*write_reg)(struct fbtft_par *par, int len, ...);
  *
  *****************************************************************************/
+#define fbtft_identity(x) (x)
 
 #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
 void func(struct fbtft_par *par, int len, ...)                                \
@@ -42,29 +43,28 @@ void func(struct fbtft_par *par, int len, ...)                                \
 	*buf = modifier((data_type)va_arg(args, unsigned int));               \
 	ret = fbtft_write_buf_dc(par, par->buf, sizeof(data_type) + offset,   \
 				 0);                                          \
-	if (ret < 0)							      \
-		goto out;						      \
-	len--;                                                                \
-									      \
-	if (par->startbyte)                                                   \
-		*(u8 *)par->buf = par->startbyte | 0x2;                       \
-									      \
-	if (len) {                                                            \
-		i = len;                                                      \
-		while (i--)						      \
-			*buf++ = modifier((data_type)va_arg(args,             \
-							    unsigned int));   \
-		fbtft_write_buf_dc(par, par->buf,			      \
-				   len * (sizeof(data_type) + offset), 1);    \
-	}                                                                     \
-out:									      \
+	if (ret >= 0) {							      \
+		len--;                                                                \
+											\
+		if (par->startbyte)                                                   \
+			*(u8 *)par->buf = par->startbyte | 0x2;                       \
+											\
+		if (len) {                                                            \
+			i = len;                                                      \
+			while (i--)						      \
+				*buf++ = modifier((data_type)va_arg(args,             \
+									unsigned int));   \
+			fbtft_write_buf_dc(par, par->buf,			      \
+					len * (sizeof(data_type) + offset), 1);    \
+		}                                                                     \
+	}											\
 	va_end(args);                                                         \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, fbtft_identity)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, fbtft_identity)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.43.0

