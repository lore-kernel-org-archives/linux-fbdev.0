Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC73D9034
	for <linux-fbdev@vger.kernel.org>; Thu, 25 Jun 2026 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782387756; cv=none; b=DGccx9T7m8t/ZZTr6T9SHOmbrvjsfB57FyOTlK2p/7nkO7yB4nVaDI7qvY3OJDxV1dyaumvu3qQHfGgiz9zSuFFRjwgV/+iBWTz76cvke5q5gGJ7hx8CX+PC1W0CGrjmVyn0kAnagUVRkHQGtMX1xtyh2lUDAPzsflb1oep/eto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782387756; c=relaxed/simple;
	bh=cq9o5A8vNpt7ZzVGQWLlQl750vKY+6ATDYniEMBZDfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQC4C8LNOk+Pc1+oIGDrjBBNWVCSie+XZbh1LTE4J2H5Tb7LpCJ2keN0WT1DYMjwchg8YXvhk74lHrVSP4QzPI60xfK3iJQoalhnwvFyZ2DJyTXfoERM+XderI5TW020AaPjyse1SPDLcHMq6cF5eJVhj+NAtXUmV5hYt3HUFtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0AhiL0o; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0AhiL0o"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-139aff562e1so2972796c88.1
        for <linux-fbdev@vger.kernel.org>; Thu, 25 Jun 2026 04:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782387752; x=1782992552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B73dDp79EG28EytJ5lKOIpIzktknebQaTwhx7eBVLTQ=;
        b=K0AhiL0oAybeGvh4kGOcQN7oDAds6TUoXjHxKxUwt0cgNjK+Hk14GvZbM974oFysmK
         3yzHG4EgwuFCyzE/klsNi1AQ+r4xXzQetDI46wEFdD8kUtPUYQR7sYoRDpYsljQwYjr3
         2STQtGBc/3a58rZgiUY3yYGGsU9eVVplLyFbjzlaOF6/qqhfcnORMyPKME0z4X+2xYz1
         U7NqdEq12qjQ8eBVrj6chAb1V0I+ta6+LxtHcXRIpEacnn60xkhp/xHGPbulAPZ3lUfN
         GxaeMyo0X/11qpcawiV9Jd5x17T8I4sFXEv8f+wZkT3L5ImoZpUQmwYZhJ/JaQgh2mdU
         UpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782387752; x=1782992552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B73dDp79EG28EytJ5lKOIpIzktknebQaTwhx7eBVLTQ=;
        b=sExLv9uFHTfiF3QScG83/wB+++4y2XgJw3Q7jQJ3+naBRZL5ankrKG1h7WGZWU/6eM
         MxTha+wIAinV6/6ibW5TVWjyrqG6zdrIkSGKyowagyV2huNufqP1OYxFbHc+JYhT03+4
         Xem7jxrgofD3QF3tByi0QzHy2doWKFDD2koAn10kaMEZJ476tlOh5JIUszKV+XXNoCi5
         wIRP2kKHkYT6W0wzJKWWxWKcUsFVsN8Fo12dGW/0/Q4wCfitSFRjB0EAKUVdXP+6cN+F
         717wTGhri0nZX9QcZNutK2kt+zN4RzD7sc17Zso+2s0jw5PmGVU1d7bg1m5kzJOsetfc
         m0gw==
X-Forwarded-Encrypted: i=1; AFNElJ919xMMUnS/W7Yy1zOiDQ5xSEjK8OS+WTBkI/rWNjXg9ulexyl7+wR4yLZNC5DBYOkf4V/RgDF4L3JX4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyvwDFylbogG9ltNtaGTsMeIlI/ZB+y4ECKGeTIiIAEReNUXGZ
	hmJ+VrfJd3ExJijqMb/Vk2tSQNcA5pXfJAvACZjqbjywwTOO4zhZDkKa
X-Gm-Gg: AfdE7ckD/Uta62uVlWiEXPMQZtKFbJi5oMBoqsK+u0mnRlRSCQz79GvlScxFArchSwN
	vAq22QOTZOKUQvugGh6Npx2WeQBr9eM9+DN9mrMHudS+ntDH+7Cm95cKb470UB3Fgj21i7WngFl
	cSn60CWUhZg6aWC1bD2qT75qf3kjd/dklkE2a4fheeloTpHh4pZY6DX9aa3CFR8SZCrtqvSi27l
	G5aPP34FByDBa89iZp0AimSiuBniCIMtmxdpGUSqWturkW5P0ZtNLFfoDYV6PYu5wIluCYpj5Rx
	aMIFkgZrqwfyAFll6FwB3AVL9jdXsvqqFYo/35pGZKcoh//WxSmvDjxFjsPMX8K5T+EW3ssN7nL
	+v5AlqTQs7q0S2VC8R1c89BbrjsaIYTInxJsRAiXBKBIuGz0R5Y133nVzUvwQNjLCxWsTOCLKyH
	Ppcl2f8aExRrF9hCwVK7/nJAjU0GKQL5oL4w==
X-Received: by 2002:a05:7022:504:b0:139:dab5:e2bb with SMTP id a92af1059eb24-139dba4ac87mr2092744c88.15.1782387751916;
        Thu, 25 Jun 2026 04:42:31 -0700 (PDT)
Received: from 10-86-27-11.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d912197bsm12312296c88.15.2026.06.25.04.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:42:31 -0700 (PDT)
From: suryasaimadhu <suryasaimadhu369@gmail.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	suryasaimadhu <suryasaimadhu369@gmail.com>
Subject: [PATCH] staging: fbtft: fix unaligned access and txbuf safety issues
Date: Thu, 25 Jun 2026 19:42:15 +0800
Message-ID: <20260625114215.325973-1-suryasaimadhu369@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625111602.438761F000E9@smtp.kernel.org>
References: <20260625111602.438761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses several pre-existing issues in the fbtft driver:

1. define_fbtft_write_reg(): when par->startbyte is set, buf is
   advanced by one byte creating a misaligned pointer for 16-bit types.
   Use put_unaligned() for register writes and fix the SPI transfer
   size from len * (sizeof(data_type) + offset) to
   len * sizeof(data_type) + offset.

2. fbtft_write_vmem16_bus8() and fb_ra8875 write_vmem16_bus8(): same
   unaligned 16-bit stores when txbuf is byte-offset for a start
   prefix. Use put_unaligned() for pixel data copies.

3. tx_array_size underflow: both vmem helpers subtract 2 from
   tx_array_size when a startbyte prefix is used. A small txbuflen
   device property causes unsigned underflow and out-of-bounds heap
   writes. Fall back to the non-buffered write path when the buffer
   is too small.

4. fb_ra8875 write_vmem16_bus8(): missing NULL check for
   par->txbuf.buf, which remains NULL on big-endian when txbuflen is
   0 because the PAGE_SIZE fallback is little-endian only. Fall back
   to direct write when the buffer is missing.

Also replace empty modifier arguments in define_fbtft_write_reg() with
a no-op macro to fix checkpatch warnings.

Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>
---
 drivers/staging/fbtft/fb_ra8875.c | 10 +++++++++-
 drivers/staging/fbtft/fbtft-bus.c | 25 +++++++++++++++++--------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de664..06f650aac 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 
 #include <linux/gpio/consumer.h>
+#include <linux/unaligned.h>
 #include "fbtft.h"
 
 #define DRVNAME "fb_ra8875"
@@ -250,7 +251,14 @@ static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 
 	remain = len / 2;
 	vmem16 = (u16 *)(par->info->screen_buffer + offset);
+
+	if (!par->txbuf.buf)
+		return par->fbtftops.write(par, vmem16, len);
+
 	tx_array_size = par->txbuf.len / 2;
+	if (tx_array_size <= 2)
+		return par->fbtftops.write(par, vmem16, len);
+
 	txbuf16 = par->txbuf.buf + 1;
 	tx_array_size -= 2;
 	*(u8 *)(par->txbuf.buf) = 0x00;
@@ -262,7 +270,7 @@ static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 			to_copy, remain - to_copy);
 
 		for (i = 0; i < to_copy; i++)
-			txbuf16[i] = cpu_to_be16(vmem16[i]);
+			put_unaligned(cpu_to_be16(vmem16[i]), &txbuf16[i]);
 
 		vmem16 = vmem16 + to_copy;
 		ret = par->fbtftops.write(par, par->txbuf.buf,
diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff1..52a0c5c0c 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -4,6 +4,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include "fbtft.h"
+#include <linux/unaligned.h>
 
 /*****************************************************************************
  *
@@ -11,6 +12,7 @@
  *
  *****************************************************************************/
 
+#define fbtft_write_reg_no_modifier(x) (x)
 #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
 void func(struct fbtft_par *par, int len, ...)                                \
 {                                                                             \
@@ -39,7 +41,7 @@ void func(struct fbtft_par *par, int len, ...)                                \
 		offset = 1;                                                   \
 	}                                                                     \
 									      \
-	*buf = modifier((data_type)va_arg(args, unsigned int));               \
+	put_unaligned(modifier((data_type)va_arg(args, unsigned int)), buf);  \
 	ret = fbtft_write_buf_dc(par, par->buf, sizeof(data_type) + offset,   \
 				 0);                                          \
 	if (ret < 0)							      \
@@ -51,20 +53,22 @@ void func(struct fbtft_par *par, int len, ...)                                \
 									      \
 	if (len) {                                                            \
 		i = len;                                                      \
-		while (i--)						      \
-			*buf++ = modifier((data_type)va_arg(args,             \
-							    unsigned int));   \
+		while (i--) {                                                 \
+			put_unaligned(modifier((data_type)va_arg(args,        \
+					       unsigned int)), buf);          \
+			buf++;                                                \
+		}                                                             \
 		fbtft_write_buf_dc(par, par->buf,			      \
-				   len * (sizeof(data_type) + offset), 1);    \
+				   len * sizeof(data_type) + offset, 1);      \
 	}                                                                     \
 out:									      \
 	va_end(args);                                                         \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, fbtft_write_reg_no_modifier)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, fbtft_write_reg_no_modifier)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
@@ -142,19 +146,24 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 	tx_array_size = par->txbuf.len / 2;
 
 	if (par->startbyte) {
+		if (tx_array_size <= 2)
+			return par->fbtftops.write(par, vmem16, len);
 		txbuf16 = par->txbuf.buf + 1;
 		tx_array_size -= 2;
 		*(u8 *)(par->txbuf.buf) = par->startbyte | 0x2;
 		startbyte_size = 1;
 	}
 
+	if (!tx_array_size)
+		return par->fbtftops.write(par, vmem16, len);
+
 	while (remain) {
 		to_copy = min(tx_array_size, remain);
 		dev_dbg(par->info->device, "to_copy=%zu, remain=%zu\n",
 			to_copy, remain - to_copy);
 
 		for (i = 0; i < to_copy; i++)
-			txbuf16[i] = cpu_to_be16(vmem16[i]);
+			put_unaligned(cpu_to_be16(vmem16[i]), &txbuf16[i]);
 
 		vmem16 = vmem16 + to_copy;
 		ret = par->fbtftops.write(par, par->txbuf.buf,
-- 
2.47.3

