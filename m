Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03671CB518;
	Sat,  5 Apr 2025 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743845892; cv=none; b=XE9gfaRhPLwvw/OUq+mS1TBhMyQk8Oz9tyC2v8EfdSbQpLVuaUyTP3WT+UCnnpQK59uW8MKjKv/mXWvewPTpzhx8AiN0BxfWBdXsHhtELqpRYpVF1VFA2e/PXKiSpV4Ue8i6cYbDYFQH4Y84/e0wnSgYbkAFmEMBPLbbGwuk2G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743845892; c=relaxed/simple;
	bh=nhp0kQBdBvzm61TCBnE5PQzUBlWBFK07rS78WI6dAtY=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=lESiy17LhyCnlW6JF9MIzA+iiAWIpLzmFg9HMvPocmp8QRqnaXd5BfgrCJ7v3ALe3CCY+bgI4lEvYZQEC390OAKEb1kYy3d15Hvxv5CnUu+Z3jvAd9NXjG15v+lvhkdygyRcfhh1TaeU0P41wH0ZOnTyPgL891bUkGQFcGKLe9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxF/a9Dn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxF/a9Dn"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c266c2dd5so2370197f8f.3;
        Sat, 05 Apr 2025 02:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743845888; x=1744450688; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Z+grPb8I7BvHVVGAjeZ+6sPEqrTjykvJDq5w4Vs7D0=;
        b=BxF/a9DnVSiYKQfQpjdNGjKs5tMcGCCBXBKToxMnT3FVnF2IBADobqFVcWB060SXkY
         ROApWFKlZ6pbnlJnWlwh9zdSHNBRG2XUOzjwoaBIvvqhZUPCF6dpzN/85WKZExg8DNBW
         oJ1LH/TRGafLsUpyk/Qn2xhW61a/za5uqdIhibLxlB0kWzcNxXUdQkik72eNIYs9home
         Zvg32WVbAS1jD6cFrwWvr/QnbAKSCBbHYMEo5keXtfOSEVRY5PmXVxKM4Ro104hVLKKn
         CbJB+K9VfdWm87XAnnYONiAAEcoH73GsXDmTJZmyl3LjG52jOnrnp6M2+GQ7cEqS2pjt
         3zhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743845888; x=1744450688;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Z+grPb8I7BvHVVGAjeZ+6sPEqrTjykvJDq5w4Vs7D0=;
        b=TnLcGWwhs4Wy4XhzJ+5WG6g+0dMTBpcvI74VglN1r3kQSLTAZE43Sdt8nDWWR7RN99
         McS3PMb0i+ACNPM+O4lGXNoVp2nSjfos0WakEVOyeqc3CKXx7yWFobKSu6u85r/OwUH6
         9A8ix1ia247+d0LL1gnEmfPlM2HMCkE09GMM8pHwF9dPMZ0/F+v1zLr6njsi2hCoYa69
         5CSbj5oUynwP/wDuSE9eCgS9YNd2jIh/d9byfKbpDju1b1udT9uDVCl+68x78KNZLhXJ
         vPmGF79iN3vOK27xg+UZYgE8gC94oKkgGWJT4xFZ9/DW1sAvMIsaTKcKIcFIlLQOX1NF
         T5uA==
X-Forwarded-Encrypted: i=1; AJvYcCU0MffDO6TyE1Dk5L18zaujpuU/IcV0X7VlCmlV6wDIAuORKHwgBfjSAgl5lf90rxcpuHj33yYdVJBVBg==@vger.kernel.org, AJvYcCVKfaOAO2S87LERQqIEho7u4H/FX1b/GkxUVwYRjRRJZHMYdzFi7KaqQOfrwdFZAkc1ixTMyCba72WYd0SF@vger.kernel.org
X-Gm-Message-State: AOJu0YyJy6Y1G9u3p4xZi81XuO1SSUZu6HefX53tDhbS6vlSXphMIg0J
	ro5hHgxsu+uLgMBqpb+i6ifueKTO+lPs3ASwjVs9EBac25RRpltOtzW9f1E0KQg=
X-Gm-Gg: ASbGncu//QTZ4z1sUVDMj4Fn66bJvFQcEXcNE1PfGHqRCHjDIBn2SNphLW19t3cb0un
	+aO7XX/YwVe94jnC5ch4MDQwE/9Vcj66KAQ+c4B5TcfoiAMwPolAR1zqGU6M75YPe9g9cgW4g1Q
	6RbAoRjA93HYDRFEkcug3Y0HnaCshnpxoq1u0Mvv4OV4yOcp+OoyO757wyT/YmBq1UNWWNtbGeQ
	DjoZKIvCWH5u6UHOSkUdVqRVIx9WdT3cVv42aF7trtYcyMiCS31Vy8NodS+7AI5OwiFLNJiIm2i
	6MYoGCkRE9BShcfFM1dbIMrn5g==
X-Google-Smtp-Source: AGHT+IGIFJ/B9HcTfFsyw3jLL0mVGCHmD/FUbG6bazt95trNFXWXG4lipr0vJbpr563Oru3iHKbbHA==
X-Received: by 2002:a5d:5986:0:b0:391:466f:314e with SMTP id ffacd0b85a97d-39d0de17029mr4637918f8f.16.1743845887913;
        Sat, 05 Apr 2025 02:38:07 -0700 (PDT)
Received: from parrot ([105.112.71.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226959sm6263884f8f.82.2025.04.05.02.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 02:38:07 -0700 (PDT)
Message-ID: <67f0f9ff.df0a0220.33076c.f0e5@mx.google.com>
X-Google-Original-Message-ID: <Z_D5_KrpCr_K84vh@princerichard17a@gmail.com>
Date: Sat, 5 Apr 2025 10:38:04 +0100
From: Richard Akintola <princerichard17a@gmail.com>
To: sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] staging: sm750fb: change sii164GetDeviceID to snake_case
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Change camelCase function name sii164GetDeviceID to sii164_reset_chip
to conform to kernel code styles as reported by checkpatch.pl

CHECK: Avoid camelCase: <sii164GetDeviceID>

Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 6 +++---
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 8b81e8642f9e..3fb14eff2de1 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -16,7 +16,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 	{
 		.init = sii164_init_chip,
 		.get_vendor_id = sii164_get_vendor_id,
-		.get_device_id = sii164GetDeviceID,
+		.get_device_id = sii164_get_device_id,
 #ifdef SII164_FULL_FUNCTIONS
 		.reset_chip = sii164ResetChip,
 		.get_chip_string = sii164GetChipString,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 2532b60245ac..223c181dc649 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -48,13 +48,13 @@ unsigned short sii164_get_vendor_id(void)
 }
 
 /*
- *  sii164GetDeviceID
+ *  sii164_get_device_id
  *      This function gets the device ID of the DVI controller chip.
  *
  *  Output:
  *      Device ID
  */
-unsigned short sii164GetDeviceID(void)
+unsigned short sii164_get_device_id(void)
 {
 	unsigned short deviceID;
 
@@ -141,7 +141,7 @@ long sii164_init_chip(unsigned char edge_select,
 
 	/* Check if SII164 Chip exists */
 	if ((sii164_get_vendor_id() == SII164_VENDOR_ID) &&
-	    (sii164GetDeviceID() == SII164_DEVICE_ID)) {
+	    (sii164_get_device_id() == SII164_DEVICE_ID)) {
 		/*
 		 *  Initialize SII164 controller chip.
 		 */
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 71a7c1cb42c4..a76091f6622b 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -28,7 +28,7 @@ long sii164_init_chip(unsigned char edgeSelect,
 		      unsigned char pllFilterValue);
 
 unsigned short sii164_get_vendor_id(void);
-unsigned short sii164GetDeviceID(void);
+unsigned short sii164_get_device_id(void);
 
 #ifdef SII164_FULL_FUNCTIONS
 void sii164ResetChip(void);
-- 
2.39.5

