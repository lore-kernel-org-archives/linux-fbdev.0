Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DCC1D5166;
	Mon, 31 Mar 2025 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743411223; cv=none; b=FvrAc1AxWpkXc0kKRQ+NcF/kyGTWJFfPdUVRAlSN5AWfygfs6bRvyDHehhTJKsnIAbfVrZLnA2eFF1kcB472tZsQz7apI+vmajw4IfKaLPL1MbahHfscUgTdm+Qy8oFxhIUTIWKKQ8EMvph59NgUG73zV8Y5N7hHfQkVmoE3M/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743411223; c=relaxed/simple;
	bh=5EGtzJ1cMbOymkIecmlDD7A+m6NCguni7LbhMLAGmKM=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=ENzmtpzUggoWcNbgdxrwOorhWk1irhUpIzxl1pDURrmcFBjC+rOlBWNlszg6adEl0AJtA5Wjik0EXFvW0+V6H4jYMkT+n+gwDe6u1p1ho7HGQO7YkGS49cYi0QX/1nCySvZFXvMsgYkx5unsu7lhTLUnO7YkwLErkqZPVlk5LzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QH30cafp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH30cafp"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso516461f8f.0;
        Mon, 31 Mar 2025 01:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743411220; x=1744016020; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PtxUbrlQcpIDc0UcOWH0EPLAdbTyQEPVRfkNKbeKs9g=;
        b=QH30cafpT9lTXYrYXAuOwda8t9uqbb7qYZYHLNdM/AaRHISMlu8UYlRPSInS1cKVF1
         xT2y9MDY1/7FtZCLMfqxamXKPH4NgX6vlfjbsEWx3A4yIKx3ez/+7AfNHoXXbDeAbo3B
         Qbog/636DG96HXKrb9OICUnrk3/l+zpxB6BSfU+KahEbso3QGn7a8cYw8c99O/91dcX1
         AcLv5/+C6/rTD4lIuiPgyxHmz2EIpGwWCKxeRpOVzSFIjz69oMD5o77Ct2+fPLwO7c6O
         KvFZKatgNPSJy15phWIAThuxfUdzyoKabv4ROIB7vkse2flRhS8UBdH9yzXs9dlYgt0o
         tQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743411220; x=1744016020;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PtxUbrlQcpIDc0UcOWH0EPLAdbTyQEPVRfkNKbeKs9g=;
        b=GSM265i69uEmH5z4cTSrkB8kqLVniYYqagfqJ9veiLpJ6BWmB8g+iUyaFc6TPpMZFz
         lWWzVTPBybHUumithHyobO0Z1dDKdBGUwGoq1S3e3KKgqDkDch8oRBbXV79Nb+aJUmhG
         rYeXullJiLf4XvLxNIhSCZE2dsXu8d0qOHD8oeZnsZCPEi4+D6YDCtcRi399wWEbNV57
         TV8ds5fBAQm0LIpMDZWM9FutwllCq04k+6HYgM5eZawLDl3X89PHdBECuoYSBZR48ILW
         PJMLG8v6mvCrWWFx+R/BkB91NmzJFT0TGxfK/P10p9bfAvIwQQ7MKb2AKbYAVOHYDOvQ
         94Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUokMztA87zBf5c/6eOdRQAEtYGUEaokvkFpzIoyNIiEJjv4i5nVZOp5Id+fFbSJ9xZBEgxnFCdRYJ3SQ==@vger.kernel.org, AJvYcCXla00bY6puuMUrxDudEsedFeIj3ceJRfX4tDW3c2VWvEMG/VWiyIowIIUt35sc6Fil1Lav104TrchvqzvU@vger.kernel.org
X-Gm-Message-State: AOJu0YxIbmcy3pxTYLjIMlUGWr17f/mzwm+NzLMJzUfd2hcEk4Je4QvG
	ODefhn/qjYXSu9W0QhlIkXkdlO8LYghWIkpUDA4UvP/yRCkymM5SPFofagBs6a5bnw==
X-Gm-Gg: ASbGncvf9Kwrh93lWVmOCMzQLkmhKPa99UnjolwcbTD5kqRs+f4O1o7FoeZb/wW9CYj
	MR5YzmkNPd4oFNdyHNNlb1oW3tm3QLx+P9KAE0R/wlZi0nKGY0eWIlACrKoTdeE2/uj1p56rFh5
	99yLRK+IAvfoygXdXOI5GlvOs0wnAmRKH57qCyAHwl5EnJjj761ZB5zuqWQb9ZpsWsXcqzYyq9q
	ljL2B22HbGnurbXPbcLS3WikiMQlXz3s/PpHbOTqhViI284sAX1ni1/FJfesdfJrwtm9+Xg3iNR
	DgIi8yUxcZ6hlkw+Sk/ltaNOoQ==
X-Google-Smtp-Source: AGHT+IHwvB74wwNeidy3mQa+dv6lV/E0/a4qIZOa2bnY/+0tds3rmfJTIzcrSfjdOjcosUvg4F39WA==
X-Received: by 2002:a05:6000:4282:b0:392:c64:9aef with SMTP id ffacd0b85a97d-39c120de0d9mr6626741f8f.20.1743411219944;
        Mon, 31 Mar 2025 01:53:39 -0700 (PDT)
Received: from parrot ([105.113.58.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a4200sm10813538f8f.96.2025.03.31.01.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 01:53:39 -0700 (PDT)
Message-ID: <67ea5813.5d0a0220.293276.775e@mx.google.com>
X-Google-Original-Message-ID: <Z-pYEL_knf6sSfZF@princerichard17a@gmail.com>
Date: Mon, 31 Mar 2025 09:53:36 +0100
From: Richard Akintola <princerichard17a@gmail.com>
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr, princerichard17a@gmail.com
Subject: [PATCH] staging: sm750fb: modify function name to kernel code style
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Change camelCase function name sii164ResetChip to sii164_reset_chip
as reported by checkpatch.pl

CHECK: Avoid camelCase: <sii164ResetChip>

Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 8b81e8642f9e..cc8ff3978d42 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -18,7 +18,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.get_vendor_id = sii164_get_vendor_id,
 		.get_device_id = sii164GetDeviceID,
 #ifdef SII164_FULL_FUNCTIONS
-		.reset_chip = sii164ResetChip,
+		.reset_chip = sii164_reset_chip,
 		.get_chip_string = sii164GetChipString,
 		.set_power = sii164SetPower,
 		.enable_hot_plug_detection = sii164EnableHotPlugDetection,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 2532b60245ac..795f8c86e3c0 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -250,10 +250,10 @@ long sii164_init_chip(unsigned char edge_select,
 #ifdef SII164_FULL_FUNCTIONS
 
 /*
- *  sii164ResetChip
+ *  sii164_reset_chip
  *      This function resets the DVI Controller Chip.
  */
-void sii164ResetChip(void)
+void sii164_reset_chip(void)
 {
 	/* Power down */
 	sii164SetPower(0);
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 71a7c1cb42c4..a9edc9474f87 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -31,7 +31,7 @@ unsigned short sii164_get_vendor_id(void);
 unsigned short sii164GetDeviceID(void);
 
 #ifdef SII164_FULL_FUNCTIONS
-void sii164ResetChip(void);
+void sii164_reset_chip(void);
 char *sii164GetChipString(void);
 void sii164SetPower(unsigned char powerUp);
 void sii164EnableHotPlugDetection(unsigned char enableHotPlug);
-- 
2.39.5

