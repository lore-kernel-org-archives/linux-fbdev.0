Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47B1C861C;
	Sat,  5 Apr 2025 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743848045; cv=none; b=L2Xwwd+G0vpS8c/kBWuNjspidgyvBaUcGWAeg6WoZ7cY2ALDIEf6vjuCnOkw+55PQ1GaLHp2X4N3Oy93GdOaiwXZ3GQUhDYpGuqc6VYzLRCWyJ37psKeiGd2ma0PCztVwXN6CW6WvJihZu7si4QPTUirePM1y4ZOCAO3pTemHRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743848045; c=relaxed/simple;
	bh=Z6xq/h+Qly0PKUGsSPTgPJbf66WR5pT+E85G1cdl378=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=lwjkal6jCoOo6H4IKoQegYDAXZEcd6pD9OclC3wnMiqRQ/D1AaPIhcDzK2omUyL0InhSmOvdFChZE7Sbeo18bsNmato6ZNJDgXvyPkUcE5bnUn/YYzhlR2pYNOMnNYDJjuA1CIrjbDlt9uHnw1l88nSDo0bliajI6rFv0z9W+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+0r3Oev; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+0r3Oev"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfe574976so19070085e9.1;
        Sat, 05 Apr 2025 03:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743848041; x=1744452841; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yVTlKXlj09u3x3cF5cGmCUxBsTXjfJU7FwaBPii2bKY=;
        b=j+0r3Oevq7yIrIfiBpNy95DerqzYUM1rZqJab1hmRaApibzd5WvN3gESJ74IRjUj54
         ODZ9PteN9wh6NQex57G7MGp/0Pdy7MCM4lorY0PI9x3o7Y/7Yht0NwNtFpGpJwnvZjU+
         udKcqQR9GIvZRDRS3/rKcPK+zvw8wC9lx4FJbfWAGMQNPEtG8xHFSgC0NNpE+8PD6vK2
         GDGYwDfEbW8VKU3QW9vHwB/h6Irh/t091sHkhF6woEkNixWd4MJA9ZQs0sYSMws2O5QF
         nHmNl3Bw4CuZdzXeKWxqP+pkpQMUSB/m2hQ0TM5lwCz74CP2AGs2Ky5JUJoRoW7L2fMk
         H0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743848041; x=1744452841;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVTlKXlj09u3x3cF5cGmCUxBsTXjfJU7FwaBPii2bKY=;
        b=QaPheNJQ8T0LIffVSqsp5El3uXGv9g1yJ1MvvkudgL54x1cM64yjDYilE7qnPk/BqH
         nY2nseUQkDSe3L1THxYDkw3duh62sWJLn64Xhb3hsN65PIoYJdNdQ2eoJ7MW8dOTrOM2
         gl1nSAsRgzk613vLTAMwRQ2TwpLs1lQo6TtzzERR3KUbohlf7PE0DeymWsSsPJL/W3WJ
         nkjbZ9CVumT+4VIfZLcHv18ndY83iyP+BVuoGmUJp6w28HCqSMPdTkow7cnA2PcgI+fP
         Dlhhk234P12/qhvfnNf6OnvGdEW+Alb8GHKUk8OOxrGArSB6ghX3Lx6A3WGbHMsZqc8x
         5gSg==
X-Forwarded-Encrypted: i=1; AJvYcCX3/8T/Ee16u4OwO1ILPDuuA/9L3oftUpHqIlh27kxSj1NLztWGvI0uCC51yqZMLYcBgueVQA6a/2dFkAWy@vger.kernel.org, AJvYcCXdvgk+St6q94ylbGD3tPhzPy/vGKp9borb0k2fvAOPmOwaCHDq9MWlM0C/8bwTlDNeqZX6fGMAVgjB+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXs3LJPY7q+5R6M9EaDuHZ9Dgkebrcn+OT5zqMfKiMfbGmjkGG
	xejM7juu12DlmkKtbtw28nyHieJEkt0SsnsRu+3mI8F97+drxZOo
X-Gm-Gg: ASbGnct/d8mLg1KILIybW/EhmFlNy7SKzUvNvkDiYgeuLY8bPNL9EH1UHYajwv0FYMU
	bxuYJ6JYKc2lP1QsqsGOjLTiNK5c+iM/GGW/LxOZcp8y0GRCJ3hZkLwfg1ykLAfG3QcNfYdstTC
	7nHrsrN46PpfNXCuovNjZ7yBpE1b5EFCJOXJMFpu92m09pCHK6vA/NtLsZTvhCzAUuAtjDXmyP4
	rTYmy+s8yDXjHLc9nGd2JTDeX+faSDaqH9Z8yLVkVtr+jCSS4mvmFYPpK785gEt6QU2AkOMJHHP
	3js46Mgz4AornJFb25MER52N3Q==
X-Google-Smtp-Source: AGHT+IFCh0hVBGoDPAG7S2CedA/2FDhHjSLG9yIfWQFMEtwHcSqkydT2iBYHe3/5ULlE8y5r40hTWw==
X-Received: by 2002:a05:6000:40d9:b0:39c:1257:feb9 with SMTP id ffacd0b85a97d-39cba980edamr5166552f8f.57.1743848041232;
        Sat, 05 Apr 2025 03:14:01 -0700 (PDT)
Received: from parrot ([105.112.71.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226acfsm6358675f8f.88.2025.04.05.03.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 03:14:00 -0700 (PDT)
Message-ID: <67f10268.5d0a0220.18864.f8cf@mx.google.com>
X-Google-Original-Message-ID: <Z_ECRdLnNb-6bR35@princerichard17a@gmail.com>
Date: Sat, 5 Apr 2025 11:13:58 +0100
From: Richard Akintola <princerichard17a@gmail.com>
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Cc: julia.lawall@inria.fr, princerichard17a@gmail.com
Subject: [PATCH 1/8] staging: sm750fb: change sii164GetDeviceID to snake_case
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Change camelCase function name sii164GetDeviceID to sii164_get_device_id
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

