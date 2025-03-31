Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074FD2CCC5;
	Mon, 31 Mar 2025 04:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743395923; cv=none; b=Rk8Ap6wCq2CAfoJa1PTCMtXY/jjGF+Y7LWEENmD6aXdR70HQBaUckt+KBHhgI/DlT77LisQO78jqFImSOrCwn3KrEB2F8A6Z8A1jmX+BQq7YYb7tfY+kxXvH8JeKxXgaQGqc+dfo4K3K1AzAF+iaGyg37+B8dNtyse/tcslKRO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743395923; c=relaxed/simple;
	bh=TtjY9Wzkw60oyefIgqV6BsR5lP3P31nmpIUBDv1LY0s=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=BVR4D2/ikdymZ/FHCJnvcsi8/JNCqnSXIbItJDoQif//oo81juSHFLfyOR+MBSqbA6DwLHWCSRDGuJBZFOne+lAm6uwndpHU92Gc9Yrpw0X4Rug3gPBEGIQoPr8l7FM+/PP+549dh7EJkRMpNKbdU3aRPagsN9GhA444O+I2UOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gR2LLbAL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR2LLbAL"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so41004795e9.2;
        Sun, 30 Mar 2025 21:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743395920; x=1744000720; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v+aXTy1NLfcdVoSzh3r1E4KeMRGPMrOizren/t4vs+g=;
        b=gR2LLbALHGZysYQ+Kg8rAlhug2GInI7dcreWzuqCcw5T9jTt5tD42UA2q//SQfGJS5
         1ngl8uncO0oM/uxytuPSYKST/nc49DS+ND3utsLoa9QR1uWzd29kh2oCr/Cu6RoWd8X8
         mGBM5w6whtyCqzei3vj3K+ZqQ/fCCYKSHCEa0wiyGZWiXVHyiFDGJ43cveidD6RDpha0
         351X0cHHUO+ptCxEKdUteY2YQyl74AgrzivGy4PvRfcdClSTCBIUYCod1rLAJFGV9UUO
         ZVsgNwSWbk+3V47KfybjnoG5lUkuDSYKvJzbTIKkz9K3mqfnz7Obm9FBkOjoY+Gm+deW
         M4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743395920; x=1744000720;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+aXTy1NLfcdVoSzh3r1E4KeMRGPMrOizren/t4vs+g=;
        b=SCbO9F15kOBQvmjP6v5+ix1kWIbC7MjsGgbjlCITkavVX7MqAKc2ERBNM2S1Qltu4v
         1QLZj8JM5SdzJPQEt4hNTM/kSSbQqYCQtyliatdaGQxVnQYszZEQ97FdUvVYkI3cihee
         8NE4fzDEBoGJYQTfjXYDch8TfslLyBNLqyXH3yiU9mrZPPePAPHEO1XBfdwb1lHnxFM/
         FEjuwZjjE2PrFVA2xzXLWkKGpK7DjDsa+RV++Gc7I6640vZF48hqzwxcF3SKI0WxZScD
         k912IyiDPbF9Lh35i1dKXmlZHD4xVlrvHwGw8GlV91/4k2ESL8PIjt0KrqlPjACAugJj
         crhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVguh8da/vD5REkso31cQzEYBBqjlzjEFNi97jD66wvf5UmXM9AKCwNf2LdD6KkQ/UcGLL4V+7K4v8JNIeo@vger.kernel.org, AJvYcCWhi5tjfZ+7IM2UaD0YjjH8SVRUJwzmkbo1+/YLZpksOZxACqT0WYWcuXf8Tttjwy59cbLnzOeL0H+9IQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUMGURCIh41tAYQB9cMeJyMscfWrdAmN1wd2VmInrm2HOYYKwC
	I8fHdh8r/CBfPJBWLXEFzAfcz2miT32IFQljJFngWvhmQ7Si+MOJ
X-Gm-Gg: ASbGncsL24FPEOzS3dn4UwacYrQ14KmAdr0Tw8ZjM5QWrkzDGYjwH2b2cR35zERa1fl
	PcYB6SD9GkPXhP85VEAvH4imfHgCneKVwr5gGh8Kg/SsgIeYSRLQzr4hQlf0RBVW0KwhZicXV6m
	9A89fwMP6OTnNkaRZwy9SttqO7em4Ri2/NAzHPBanB0MDYTPo785ADJd3lH04WZIH2a19Ibf172
	7mbcUh2hPVm8+0NCyEdGr4IPS8jVPsT4uBFGaV7whAQtBMjYgWMaoYitJgqlw8i4gR5kFVctmFf
	MKrbqeV8ZQN4WvhfUv+tzyaj+pm8DzS8w5rNE88LI32mPw==
X-Google-Smtp-Source: AGHT+IEW8oi7KoyElo34NgNIBd83oZY1zutO8TKygkw+BTaZnofnBPjZ4iGfPTgKHb23i3nSxmztvQ==
X-Received: by 2002:a05:600c:3d0d:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-43db61e0584mr70709495e9.2.1743395919970;
        Sun, 30 Mar 2025 21:38:39 -0700 (PDT)
Received: from parrot ([197.211.59.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82dede98sm152633395e9.6.2025.03.30.21.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 21:38:39 -0700 (PDT)
Message-ID: <67ea1c4f.050a0220.29e327.3bb6@mx.google.com>
X-Google-Original-Message-ID: <Z-ocTGZOZATD1Nbo@princerichard17a@gmail.com>
Date: Mon, 31 Mar 2025 05:38:36 +0100
From: Richard Akintola <princerichard17a@gmail.com>
To: sudip.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Cc: julia.lawall@inria.fr, princerichard17a@gmail.com
Subject: [PATCH] staging: sm750fb: fix function name to kernel code style
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Change camelCase function name sii164GetDeviceID to sii164_get_device_id
as reported by checkpatch.pl:

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
index 2532b60245ac..bdf270f38884 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -48,13 +48,13 @@ unsigned short sii164_get_vendor_id(void)
 }
 
 /*
- *  sii164GetDeviceID
+ *  sii164_get_gevice_id
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

