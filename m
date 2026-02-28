Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C849127FB35
	for <linux-fbdev@vger.kernel.org>; Sat, 28 Feb 2026 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772310433; cv=none; b=RWbr7VJsJ/1JFanGH5Onq0WXyXu+n4PUzqYrYVI+0KjdFl0FqU2jo95rCMPajPJKpNw1mQ/fq3oTgphIBHEONTrnhd/r5EeE0cSmMCaGcDIT6xBPEPIk4kdzfTUF7Hf66P12PURm2vFv9UE5FG7DaaeeVycGH4VneDYUaTchsQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772310433; c=relaxed/simple;
	bh=aYp4smBf5B/m1My73xjNkVi3QPyMBWYzajkjVuSgSlw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PStN1ymJUxM33ZnMyhagthelDO8ae5JLG8Y2n/mmF6qv0PgRLVkOGOJM2fvS2k9coKVk7uhOJV/RwYABk099siyfH3qsnOfRUGEfqLgkHIw67y9FkjGrQZKZeWwsC+prcq7juH3Uz7+xuyOyyUDXsPw8TP6xTfZenMGNdbMlNn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mw3uX8lY; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw3uX8lY"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-35984626dbaso3264a91.2
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Feb 2026 12:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772310430; x=1772915230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hbY6xLWGKXtaxrC528rj/sYRbGkuV5WfacpZcBywgMA=;
        b=mw3uX8lYU2wGBB5KBrbno5i8W9uynI96s2wOJzOu839+4mY8hamu7DyuVT69o5kAME
         ff2Qfs0n9Is3QshWAtwltimVcbsnKmIkohugnsWJDpIZAMVbGzga0ayBSYfWXSxQJCRV
         bH2rTSqqjvuaua6jmWXmYxGJhjnNxmA5TEB1mqql4RWyj+2s6qmnSdnELnI6Hj+/fCCn
         ZieqJg3JTJOPQMghKoQk4Pi0Ta/ETJPAcbBIWJvJtcD2x/wqbAkUcWEQtWSTkqIe41Da
         1O9hTAtgFTJ7ROI5H5GidPOzkWzSIdIBfUH5E4MuYtqR8FAUc4pOp5jC7WxAPDD7jkZY
         0OOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772310430; x=1772915230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbY6xLWGKXtaxrC528rj/sYRbGkuV5WfacpZcBywgMA=;
        b=tuEpES+duYKvCtPwaL1vV4XbOTsLxzM1GGc1PSebgiaKe+prt5Jvr83hCd6d0CRpn+
         1gVSf1OMd9X07LMvNhz2XeDAKMl2/zyAe7GB56rCbi78IyGgoWZsf72Mlr+Pew/TQwCo
         ibJRbhcwRIwJJA5lBeQGC0Xn+pyVIopxRLr4VOaRD17CbRCwmxlfE1mSzNrfwj7Myy+e
         +MnqFsYNRcW153QCTJNBiPKYOYANujwQroqDZpjw0HMiY5Ax5K5P4DzM6a1iPQu/e7zB
         3NjlJHIt09P2GEuGBW51mWNUpP6m1FFlCy5E+DojFrm3mptEbPNxgXiYxHiS2+HOk252
         Wxyg==
X-Forwarded-Encrypted: i=1; AJvYcCXGEBK5Tr4fmQzVTiO/C8tB/ydpkGqQlVZGyf4XEW6bPym3VxV0CyeNc783O7C4v7AgYO5Pr+WZYO/L+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSsKv94Vx285Ur18wYgTPR9cRSOO9XIFa2tzvAZxKnmRKLs1Bq
	HHsavNij4hdfh0KjjL26LxVAHN3qyhUjCwfEpz/HumrU3+UM3lzenddY
X-Gm-Gg: ATEYQzyyDsLlAbzaxnP4CpjOvg9F2vIbwpdhPNS1GPoBhAvSb2lYFjJB2aUzynde6xG
	I5pF6Cw8e5vK5d/yEdq66+bNY8/fkDSn8uKw1MDgS3XUgmu/ofjL3cqbNMJ7MgR/M2gPuVIy4mx
	b0pII6fFo8dWgMkhtX05Q+K4ZHdbFlVRosPr1TG1CgcqMNWexYRKpC3cciUktMTXPh8dNe9gV8l
	Ah3Mw2AAX1zxksAce8u4OEqZ0emx0de3PqM8SAURW/naT53KEwC15rLDNisL+q/pUlTIGv7Tcka
	7vHICCmTO9p+e4mixBuvasvl/jAG7IO0B0fk1u4fzlhiJrO1MRyjDDBAk1Xf7Bymsjf04dW166A
	3nGkjndIzlcX0qsmIXV0RScJy3lAjUh4+xUzIugqxwjxUk2NO7im8dsl8cO6t5q+3nvJSAUw/M3
	Z2P03aaScyNnpUD/VF0DVR0vPvyJ4wLCv2Jfw4gberJVFvmFz9TiumRdyS4W1oXwaELPdeZd/3Z
	3zPLK3cHjsAQqU=
X-Received: by 2002:a17:90b:3fc8:b0:354:9dcb:1935 with SMTP id 98e67ed59e1d1-35965cd26bbmr4906008a91.6.1772310429803;
        Sat, 28 Feb 2026 12:27:09 -0800 (PST)
Received: from cute.. ([2405:201:31:d01f:37d3:368b:370c:c273])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359834ac606sm557872a91.6.2026.02.28.12.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 12:27:09 -0800 (PST)
From: Soham Kute <officialsohamkute@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Soham Kute <officialsohamkute@gmail.com>
Subject: [PATCH] staging: fbtft: replace -1 with proper error codes
Date: Sun,  1 Mar 2026 01:57:01 +0530
Message-Id: <20260228202701.43337-1-officialsohamkute@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace return -1 with proper kernel error codes:
- -ENODEV when SPI device is NULL
- -EINVAL when display size or buffer is invalid
- -EOPNOTSUPP for unimplemented functions

Signed-off-by: Soham Kute <officialsohamkute@gmail.com>
---
 drivers/staging/fbtft/fb_ra8875.c | 4 ++--
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 drivers/staging/fbtft/fbtft-io.c  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de6647d0..c2e5c6276415 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -29,7 +29,7 @@ static int write_spi(struct fbtft_par *par, void *buf, size_t len)
 	if (!par->spi) {
 		dev_err(par->info->device,
 			"%s: par->spi is unexpectedly NULL\n", __func__);
-		return -1;
+		return -ENODEV;
 	}
 
 	spi_message_init(&m);
@@ -144,7 +144,7 @@ static int init_display(struct fbtft_par *par)
 		write_reg(par, 0x1F, 0x01);
 	} else {
 		dev_err(par->info->device, "display size is not supported!!");
-		return -1;
+		return -EINVAL;
 	}
 
 	/* PWM clock */
diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..9a87bddd7d19 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -181,7 +181,7 @@ int fbtft_write_vmem16_bus9(struct fbtft_par *par, size_t offset, size_t len)
 
 	if (!par->txbuf.buf) {
 		dev_err(par->info->device, "%s: txbuf.buf is NULL\n", __func__);
-		return -1;
+		return -EINVAL;
 	}
 
 	remain = len;
@@ -217,7 +217,7 @@ EXPORT_SYMBOL(fbtft_write_vmem16_bus9);
 int fbtft_write_vmem8_bus8(struct fbtft_par *par, size_t offset, size_t len)
 {
 	dev_err(par->info->device, "%s: function not implemented\n", __func__);
-	return -1;
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(fbtft_write_vmem8_bus8);
 
diff --git a/drivers/staging/fbtft/fbtft-io.c b/drivers/staging/fbtft/fbtft-io.c
index de1904a443c2..2144f5257fa9 100644
--- a/drivers/staging/fbtft/fbtft-io.c
+++ b/drivers/staging/fbtft/fbtft-io.c
@@ -19,7 +19,7 @@ int fbtft_write_spi(struct fbtft_par *par, void *buf, size_t len)
 	if (!par->spi) {
 		dev_err(par->info->device,
 			"%s: par->spi is unexpectedly NULL\n", __func__);
-		return -1;
+		return -ENODEV;
 	}
 
 	spi_message_init(&m);
@@ -231,6 +231,6 @@ EXPORT_SYMBOL(fbtft_write_gpio16_wr);
 int fbtft_write_gpio16_wr_latched(struct fbtft_par *par, void *buf, size_t len)
 {
 	dev_err(par->info->device, "%s: function not implemented\n", __func__);
-	return -1;
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(fbtft_write_gpio16_wr_latched);
-- 
2.34.1

