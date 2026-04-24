Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F6249620
	for <linux-fbdev@vger.kernel.org>; Fri, 24 Apr 2026 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022999; cv=none; b=OruBivtjbCsXuAJRD8x5acgkyYEpVpHPS5Zys2OEQg3ZQq21RMpA+RevlbJ4t7gJgyX+oNkRujpwbK9/YY+BGViZNkET1mnlvK7y7w7oL027yrPzfWhkHLoxWoV5jKH7Is9N7699jIsN+rOaB0yCAHpugDIeLu4U0cqzQKtFTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022999; c=relaxed/simple;
	bh=/l2cqmROFQs33BLokVYKJp8GESRrYrFjRXiK33lecRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZB9g0I57SneDF9i684wd26IlNSIivjpZe97Qe0zKOpJScIT7pRZpPA5BPzwPH1fgD/YToEXW5Dp+RNmSyyya/vgFujUI1Q7I1eRtzExotfu3lRD+bb2lMiCAQHs2zjGzOgssuX6nzUVWQmJWVVv0u59vQprFpn1fIH/bwmlI18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUNTdQks; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUNTdQks"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891f625344so62448475e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 24 Apr 2026 02:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777022997; x=1777627797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PRmQYDLWnbQPdXE28Inb8Q/Xi2npOv1Gc9ccDpPNZg0=;
        b=rUNTdQksieiKJpY9dx96Aa/onR4mw6IjN2HXvyl98BHzEAnXgDcca2S3DlKJrUNoBZ
         023OXmVqGdrE+y6DR5Edq0UVytwBGoVVF767e3Tqy7uAKrDRfVqxpyJ3hOVwJ8riqX+f
         dF7HiZNJF4A/jM3JMJZ857iRuhXT6JjDpk94oEE6Cp/Hg6G/UM9zTjxtaxYRdZ3sCzzp
         v1ZFbYXkdLVkqvQEjxpvFjdud38f4sAPY8r8TOudKDMQ5x3BiHa5vnC8XiBh7u0lr72c
         32cWC60SskFBIuZp3e0JyrEvt0jZdNL3w+9AYnNelgN3GvGJhOVdtsdV3e5Src7drp37
         fCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777022997; x=1777627797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRmQYDLWnbQPdXE28Inb8Q/Xi2npOv1Gc9ccDpPNZg0=;
        b=X6h7d6Z7smIRMKgQtJ5hHuKuPes8nAaW8BkWfbc1g3bOYyXQaHDxio7ZSf+Gqg7VH0
         hBKzEXjsryppCJbASwWBU8ww2fVjJFuIQPu36NWWSkR5gwA0ZQv5i1NCAOs0ZE7ITepE
         hIeGXAoUAHWtB4FF6xHoHYREODll3lD8PYE+xRdwB7YvjeiZKp+ogmSosBoqg4fNFTle
         TEvLDiyNiJ3KefGxeD8cR7UXqaM+K1qkcluXKwJeh73jB8Ys0AnarEe9mS/zQJlZdpch
         r0FOO3Hj4mo7qsgczuWZnjSJKKWucITB/BLgJpaOjstiWNS7PYSEvGSXI537mK74A9FC
         cB1A==
X-Forwarded-Encrypted: i=1; AFNElJ99JroGA1dW/PcapgOk+MxKln/G6SElMi8A+6QXHfBkwh2AcmYCF2DwQsBaWT/Jaf5rolWr3fUNl5RqgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwW4m56OAfmVqCZyC03IMCG5gxb9yb3P76t3HFZBMopMdiQY1Jx
	BuEX59h3IC/fFZ65WaZN4VGbhQ3TGZjLcgult/YrqIATZhUahWc/yBoT
X-Gm-Gg: AeBDiesjwUFA7gbRfTAMVzMBpKO1g/AJRyMLbOtGie0jE1Bf4fJZXyCm+HSzBoutK5V
	MqRZrVOfD38blM/2IEKDl7L1ECquFYYnCQYXfNDCLguF05vit6x8NwcP6Qw3LJ0mDciSGuDiXfS
	ugO4GyxOk4WArW7y0FQfJmFlyXTp2wrkk+EJm144++TCfomeMnZjpIT6u/l6Wkq5z6J28x7Dufk
	PuX6HNIBbpuyhTwVg1p/Qr+rJ1hQJ07F1bcZiYFBQl6F9CvSu103Xkr3iDCqTEYYlUnDiBIYbPW
	Nb+67oEiRrP2QU0p9jp2J6eCoQ9xQaOP6nAzNkWyBRiww4hgCWew0OBLQP2nqN522YVdIifF01W
	/d1wMVBOpxHQBVVEQ/DD288TlOXDarMikiXF2FXG0FdUyAV2HMgZMXyEk2fbcSvmDH3+2yIRRDr
	ovFkD5oYwmtsXppzg/Kj88O+TxiOk6kJothuLukZ39RtzuNk1m6LFoHB7feqkvjB2/1GGXmBGkZ
	tDb8cSoC5fImtMOGK5XuQzGwKGzt1JvBfI/pzi/w728HX5jMtZiU8pcrdpiunK/YJdK
X-Received: by 2002:a05:600c:4e0c:b0:489:1d7a:4537 with SMTP id 5b1f17b1804b1-4891d7a463emr288514125e9.3.1777022996567;
        Fri, 24 Apr 2026 02:29:56 -0700 (PDT)
Received: from ahossu.localdomain ([5.14.129.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a52d232afsm97787865e9.31.2026.04.24.02.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 02:29:55 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexandru Hossu <hossu.alexandru@gmail.com>
Subject: [PATCH] staging: fbtft: fbtft-bus: replace function-defining macro with concrete functions
Date: Fri, 24 Apr 2026 11:28:18 +0200
Message-ID: <20260424092818.3322248-1-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The define_fbtft_write_reg macro defines full function bodies including
a goto statement and a trailing semicolon on EXPORT_SYMBOL(), which
violates kernel coding style (checkpatch reports 2 ERRORs, 2 WARNINGs,
and 5 CHECKs).

Replace it with three concrete C functions that are semantically
identical to the macro expansions:
  - fbtft_write_reg8_bus8   (u8 buffer, u8 data)
  - fbtft_write_reg16_bus8  (__be16 buffer, u16 data, cpu_to_be16)
  - fbtft_write_reg16_bus16 (u16 buffer, u16 data)

The function declarations in fbtft.h are already present and unchanged.

Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 191 +++++++++++++++++++++---------
 1 file changed, 137 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff1..acd035203 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -11,60 +11,143 @@
  *
  *****************************************************************************/
 
-#define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
-void func(struct fbtft_par *par, int len, ...)                                \
-{                                                                             \
-	va_list args;                                                         \
-	int i, ret;                                                           \
-	int offset = 0;                                                       \
-	buffer_type *buf = (buffer_type *)par->buf;                           \
-									      \
-	if (unlikely(par->debug & DEBUG_WRITE_REGISTER)) {                    \
-		va_start(args, len);                                          \
-		for (i = 0; i < len; i++) {                                   \
-			buf[i] = modifier((data_type)va_arg(args,             \
-							    unsigned int));   \
-		}                                                             \
-		va_end(args);                                                 \
-		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par,                  \
-				  par->info->device, buffer_type, buf, len,   \
-				  "%s: ", __func__);                          \
-	}                                                                     \
-									      \
-	va_start(args, len);                                                  \
-									      \
-	if (par->startbyte) {                                                 \
-		*(u8 *)par->buf = par->startbyte;                             \
-		buf = (buffer_type *)(par->buf + 1);                          \
-		offset = 1;                                                   \
-	}                                                                     \
-									      \
-	*buf = modifier((data_type)va_arg(args, unsigned int));               \
-	ret = fbtft_write_buf_dc(par, par->buf, sizeof(data_type) + offset,   \
-				 0);                                          \
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
-	va_end(args);                                                         \
-}                                                                             \
-EXPORT_SYMBOL(func);
-
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
-define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+void fbtft_write_reg8_bus8(struct fbtft_par *par, int len, ...)
+{
+	va_list args;
+	int i, ret;
+	int offset = 0;
+	u8 *buf = (u8 *)par->buf;
+
+	if (unlikely(par->debug & DEBUG_WRITE_REGISTER)) {
+		va_start(args, len);
+		for (i = 0; i < len; i++)
+			buf[i] = (u8)va_arg(args, unsigned int);
+		va_end(args);
+		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par,
+				  par->info->device, u8, buf, len,
+				  "%s: ", __func__);
+	}
+
+	va_start(args, len);
+
+	if (par->startbyte) {
+		*(u8 *)par->buf = par->startbyte;
+		buf = (u8 *)(par->buf + 1);
+		offset = 1;
+	}
+
+	*buf = (u8)va_arg(args, unsigned int);
+	ret = fbtft_write_buf_dc(par, par->buf, sizeof(u8) + offset, 0);
+	if (ret < 0)
+		goto out;
+	len--;
+
+	if (par->startbyte)
+		*(u8 *)par->buf = par->startbyte | 0x2;
+
+	if (len) {
+		i = len;
+		while (i--)
+			*buf++ = (u8)va_arg(args, unsigned int);
+		fbtft_write_buf_dc(par, par->buf,
+				   len * (sizeof(u8) + offset), 1);
+	}
+out:
+	va_end(args);
+}
+EXPORT_SYMBOL(fbtft_write_reg8_bus8);
+
+void fbtft_write_reg16_bus8(struct fbtft_par *par, int len, ...)
+{
+	va_list args;
+	int i, ret;
+	int offset = 0;
+	__be16 *buf = (__be16 *)par->buf;
+
+	if (unlikely(par->debug & DEBUG_WRITE_REGISTER)) {
+		va_start(args, len);
+		for (i = 0; i < len; i++)
+			buf[i] = cpu_to_be16((u16)va_arg(args, unsigned int));
+		va_end(args);
+		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par,
+				  par->info->device, __be16, buf, len,
+				  "%s: ", __func__);
+	}
+
+	va_start(args, len);
+
+	if (par->startbyte) {
+		*(u8 *)par->buf = par->startbyte;
+		buf = (__be16 *)(par->buf + 1);
+		offset = 1;
+	}
+
+	*buf = cpu_to_be16((u16)va_arg(args, unsigned int));
+	ret = fbtft_write_buf_dc(par, par->buf, sizeof(u16) + offset, 0);
+	if (ret < 0)
+		goto out;
+	len--;
+
+	if (par->startbyte)
+		*(u8 *)par->buf = par->startbyte | 0x2;
+
+	if (len) {
+		i = len;
+		while (i--)
+			*buf++ = cpu_to_be16((u16)va_arg(args, unsigned int));
+		fbtft_write_buf_dc(par, par->buf,
+				   len * (sizeof(u16) + offset), 1);
+	}
+out:
+	va_end(args);
+}
+EXPORT_SYMBOL(fbtft_write_reg16_bus8);
+
+void fbtft_write_reg16_bus16(struct fbtft_par *par, int len, ...)
+{
+	va_list args;
+	int i, ret;
+	int offset = 0;
+	u16 *buf = (u16 *)par->buf;
+
+	if (unlikely(par->debug & DEBUG_WRITE_REGISTER)) {
+		va_start(args, len);
+		for (i = 0; i < len; i++)
+			buf[i] = (u16)va_arg(args, unsigned int);
+		va_end(args);
+		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par,
+				  par->info->device, u16, buf, len,
+				  "%s: ", __func__);
+	}
+
+	va_start(args, len);
+
+	if (par->startbyte) {
+		*(u8 *)par->buf = par->startbyte;
+		buf = (u16 *)(par->buf + 1);
+		offset = 1;
+	}
+
+	*buf = (u16)va_arg(args, unsigned int);
+	ret = fbtft_write_buf_dc(par, par->buf, sizeof(u16) + offset, 0);
+	if (ret < 0)
+		goto out;
+	len--;
+
+	if (par->startbyte)
+		*(u8 *)par->buf = par->startbyte | 0x2;
+
+	if (len) {
+		i = len;
+		while (i--)
+			*buf++ = (u16)va_arg(args, unsigned int);
+		fbtft_write_buf_dc(par, par->buf,
+				   len * (sizeof(u16) + offset), 1);
+	}
+out:
+	va_end(args);
+}
+EXPORT_SYMBOL(fbtft_write_reg16_bus16);
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.53.0

