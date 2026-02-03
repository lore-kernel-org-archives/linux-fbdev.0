Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A741C6FF5
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Feb 2026 04:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770094067; cv=none; b=PJToMp8H/zy0RqOYtPuzk8+t9jOKItMKN18acYks59R0OzL9v3wLdWQ9IS7n0keANky5IWOzwZBvOFK3UeieyPi4CiqR7R8sq5MOrdZbMLa2QrxELfcXUwku4dZjqtuv9xhA3/raQB7LEjFwt9Kdm24qbiuuXUKAifXUX+vnTfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770094067; c=relaxed/simple;
	bh=hwNItnnw9ihKndNzU/DeMWvoMF3si335m+ak60VRNN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R6AwTzn5Un4Odv5/jxtDho/PhM3IjzSsXSDi67y9BVk9nUX6aajYWKtM0TvPCzpUebcOLi2P+sZzha1yIwl98zAq/BhgJWgiZHZk/GsLF4ZFSRLJGh2V4HIpy2ISNhVIdJ/itS/KC7q8wBEeCiNilc2D9rgwFaQjSXE4uECUlEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbzdqzFH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbzdqzFH"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a8fc56a9b2so21234045ad.0
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Feb 2026 20:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770094065; x=1770698865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=doaACG/D+VS8vv3mxSVPzZpMTEXTnbMFWjr/fZXYyuQ=;
        b=kbzdqzFHb1QZSNFnmT5cGppEAvmz4zqpplo6cN9gCG49yXApZPqaqI9Y21Na1dxVvI
         2ppFDzbVfNc/fmvFWMlcYZ//8Vci80QpaTH3c0ZGgCULkLWER39KaeHereZteilUxF54
         6nvLB5dBQLmGWKAH7NBX1lk6Yx1fGWqfd6aULPMX8cFMA/WljWdVGl4c/g1zA4QoZLxz
         7vmUzZ2CsBOXP4pj6oShXSdAbpy/gwlfTAcHoJqGA4wWfU/ILbs16EBUClobpFMI38v9
         /G9zuRYDYZ7t8C6szl6dBPLxVQt4ZB54J8Lfsfjl3emwEBLZe4D8f9ckL7h2AetQhOwk
         mRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770094065; x=1770698865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doaACG/D+VS8vv3mxSVPzZpMTEXTnbMFWjr/fZXYyuQ=;
        b=tF3V2NpOIpAesQN+pVFIBDM6qU4cu80wdflFPBXH89uhfs/2aA2WttdtVJnxbiXaj0
         l7+FP9YUVt20PPbw0ih64EA720BqjBDgrS+G9qagOdRU1dEbIrnhyvrB3ZqLdbisB2Fd
         j6kpdJK13hWeZQPqaVRnKtij+4OqBIWZ7oJrawji93r96VpU+xn4yK1bP4QBYXsOo0YV
         Jo0qKx30u0oQPBUFB9kqM3L3ZJiEhw2FMSGCGw4ERoU7cdSVak1cJTTKhJDomI8p03iQ
         Zn2Dw1zGaPz6p53rBowNew4NMMEZe2aLh3eobsftXrhCbTsM5sm1LN4mRPdVdr+kb4oT
         lKJA==
X-Forwarded-Encrypted: i=1; AJvYcCV6v/3a1ngPozkjhsN9w9yrprXwL5imXqWOaAqQbtIpmGwzk933s74wEaA4xJHwwdFpeTT/4TcI7AjRHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVQv3zTUeFbR9mONrXwgI9h0PaNKGO96D32S9iatWY5/wX3CJ3
	FNKOzXGCfXQdrH7Bsx3A3t8dJY+dGGpRlkkXAExXBjvqNKTjCyEk3UQr8D0wZA==
X-Gm-Gg: AZuq6aIg1HWerHsQWBxY17f8RwPHiuwSUhFXSUwlA7edwG3GZVz3v5NvaHI5m+f5ZIP
	11FscNNfd4FmgGbSMmJgHPOujZfEZ91nuH6wiVkWlaxTfSwQXxXVzp0PTsRzjWHQPDhKtjajUYT
	ZkwdElb/1x9Ar2CjfgdGO5H6yBmPdMlkUVxCcJMcdlmX+boxyRBayItLvW7qeoZOSf7uWGVbS/8
	fig17j9oJXJpDNS4VG88vE9d2WzH6N3DGjUG8j299g3FEcZ5kJ+rRcZvDEsaHX8ImD0BafaxdHV
	aTb+c9JqJH2YVfWy8kxaJ/8id59jW22FjJ17u7ninj8rmoRvPd0XawCvvLWNiT/mekaRLaZ0Y2P
	vu9Zrdy0zSsJeQDIWF+cgV7PagEMUJ9P1z/DOhCEZdcIzDiZCbzlYeY+Odd9ExlqGY6RMchTBh1
	e6JU2/lXIi7e4bO1wddLPlPtzskA7FPh9BGw==
X-Received: by 2002:a17:903:1984:b0:2a7:3db0:6e1d with SMTP id d9443c01a7336-2a8d96a6af9mr100225895ad.9.1770094065094;
        Mon, 02 Feb 2026 20:47:45 -0800 (PST)
Received: from krishna.. ([103.220.210.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8ec56da60sm85791515ad.38.2026.02.02.20.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 20:47:44 -0800 (PST)
From: KrishnaAgarwal1308 <krishnaworkemail1308@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	KrishnaAgarwal1308 <krishnaworkemail1308@gmail.com>
Subject: [PATCH] Revert "staging: fbtft: remove goto from define_fbtft_write_reg macro and clarify empty modifier fbtft-bus.c"
Date: Tue,  3 Feb 2026 10:17:27 +0530
Message-ID: <20260203044728.23774-1-krishnaworkemail1308@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the goto-based error handling in the define_fbtft_write_reg macro with an
early return while ensuring va_end() is called on all exit paths.

Also add a short comment explaining the empty modifier argument used
for native byte-order writes, instead of introducing an identity macro.

No functional change intended.

This reverts commit 6eec69e273e124dca8549fc52b0958b2953085ee. As per maintainer's feedback.

Signed-off-by: Krishna Agarwal <krishnaworkemail1308@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 41 ++++++++++++++++---------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 0ab4f5c4f886..9b9df0edc158 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -10,7 +10,6 @@
  *   void (*write_reg)(struct fbtft_par *par, int len, ...);
  *
  *****************************************************************************/
-#define fbtft_identity(x) (x)
 
 #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
 void func(struct fbtft_par *par, int len, ...)                                \
@@ -43,28 +42,30 @@ void func(struct fbtft_par *par, int len, ...)                                \
 	*buf = modifier((data_type)va_arg(args, unsigned int));               \
 	ret = fbtft_write_buf_dc(par, par->buf, sizeof(data_type) + offset,   \
 				 0);                                          \
-	if (ret >= 0) {							      \
-		len--;                                                                \
-											\
-		if (par->startbyte)                                                   \
-			*(u8 *)par->buf = par->startbyte | 0x2;                       \
-											\
-		if (len) {                                                            \
-			i = len;                                                      \
-			while (i--)						      \
-				*buf++ = modifier((data_type)va_arg(args,             \
-									unsigned int));   \
-			fbtft_write_buf_dc(par, par->buf,			      \
-					len * (sizeof(data_type) + offset), 1);    \
-		}                                                                     \
-	}											\
-	va_end(args);                                                         \
+	if (ret < 0) {							      \
+		va_end(args);						      \
+		return;							      \
+	}								      \
+	len--;                                                                \
+									      \
+	if (par->startbyte)                                                   \
+		*(u8 *)par->buf = par->startbyte | 0x2;                       \
+									      \
+	if (len) {                                                            \
+		i = len;                                                      \
+		while (i--)						      \
+			*buf++ = modifier((data_type)va_arg(args,             \
+							    unsigned int));   \
+		fbtft_write_buf_dc(par, par->buf,			      \
+				   len * (sizeof(data_type) + offset), 1);    \
+	}                                                                     \
+	va_end(args);							      \
 }                                                                             \
 EXPORT_SYMBOL(func);
-
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, fbtft_identity)
+/* No modifier --> No byte-conversion is needed, data in native byte order */
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, fbtft_identity)
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.43.0

