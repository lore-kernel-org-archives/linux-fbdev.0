Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932126A0EB;
	Tue,  8 Apr 2025 10:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107656; cv=none; b=VAat/6mnuZ8L/tZBr0RHUciDBhiy+Na/zQHpNC3aLnLpiTSDk/Oe3RfLKOWYxLTGYLzc8hmaflh6ljXFmAyzsVeQV98w6UzS/c0k6mSPF6sWVtRpiM/GFv+7mseflKCHkwRlAMr3HmPai37LSqC/VMiw/yLnJXHFZiCX8uuT7WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107656; c=relaxed/simple;
	bh=Z6xq/h+Qly0PKUGsSPTgPJbf66WR5pT+E85G1cdl378=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aaYxSqeLl6n9xnDVrF+p4MgOlV+Tc4do1JEdtk5IdpvOZU/QZJYavz3kl2usBb5zX1ovW5Uj+4wQmA1WN1LV918/QPvSPmL/lkMmXlQ/lC+YOhDk2XONL5ypWYPz5cGeFQq57z+gHPNySMz0u4n+oKMyBCFc4x3RCNPhFFq5eqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebiineyz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebiineyz"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso34391405e9.0;
        Tue, 08 Apr 2025 03:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744107653; x=1744712453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVTlKXlj09u3x3cF5cGmCUxBsTXjfJU7FwaBPii2bKY=;
        b=ebiineyzHhLHCFAtvzazjkyP6P3yOK2qI+JHizdEyp3Rt2GW0BkJo2NQ639IqVP0U4
         xMILw9LA96m9xpzVkfpzeYddyn7aSRugEqYGNuo4kyJlDsbTIQ3naH0ytXUT/5PHjWQ1
         3UPpvTDuFpYSbTgPpiHbK5i2YdpWbJy8QQfqE3BiTQ4x06hypjEa5ae9B0M6cHZSyLUI
         3Uhq4Owi75EbuCT9qRt6XmGzJCQoX+RuI5jRVkBZU8AmBiM9GoEXg07siN8aRp0eizSZ
         aW13vX7/5FTEfduj94SshdgWx+D5JxpyLckiKFX5Y9fyG3UGf2GFKpMCjOIGBA+hLKCP
         a4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744107653; x=1744712453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVTlKXlj09u3x3cF5cGmCUxBsTXjfJU7FwaBPii2bKY=;
        b=Pp5nO022ME665lIuvLpvKZDLaUNNwWufgf6Ed3Cw1wJ2Bs7GAhbR8JTa6CQaO5Wg88
         7tbjC77PbMbJsxNwbmZaL4aAa2blcwx4lv49XMvn4FP/a0fNQJo4x4RbqNM+bH3WABHT
         aogO8twcNQ1K2sV35s1gaKkn32Fh+BaipGJlo6rEIrkBNJeQX/5eLxq5Ldism23o1Z1b
         FG86INcvzlj7TDbPGZIcCNdrFrn0XeU65E0jC0mthQ33DRkVPQ16ae7Maxk15u1NhhbM
         o+scbxmDLSaQl5ymMb0JKT77L/ZYDqDaxto8iaWINcutrfnQOmdclsLnNGkzB6oNJMAI
         y3YA==
X-Forwarded-Encrypted: i=1; AJvYcCURbRRkeTWUOd8ffpXnixIWA9SRSpj2umOnfdh72mE2uWeQ9DikkpnlSo4YYbfpCdmpVxwo259Sy8hnz+93@vger.kernel.org, AJvYcCXQfvbXP/BZO92JQJjuBErDpx63ANa4sjAcXXYEqIvUaaaxOqMm/5w9IDPnjyOfT1GBi/KaFeTWDngUOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGpIowpuxLvqihXhjI6XwMuHTyqi+ZmGEUE09r0Kd7hl2+/OEj
	qAAN/705OFlWlYn2hIr52RT52KEY0q+i6JEGAUrN/MiAEJ7GnAGn
X-Gm-Gg: ASbGnctUcYq0rJL9+3wtWQVq4m887CDxB8Bnjg7udAcuIb2P4bmX2035XhVraarjfiA
	g2wBnc4KGf3vLF/O3Aoo/OC0/g+TWIIrU0w5ozedXpHn9xBQzUc3rDSc16i2h6u14clROZrRIV5
	RR+7w+F5tGDxVwF20/dVcg8HJC/dma9c99/S5e0658SxaqL1nqY77p3MYuMRFLLHORhPchgtQNA
	pdN7P08iEBNUANqB5Ey4jc2D/DWok447dFse/ZvD6cj5jygsJo2usOtUG+j8yHPFgxX7M58PCOa
	AsybHmbT/LDvTTBEybbmWEqLqms=
X-Google-Smtp-Source: AGHT+IHOhiNnnO4EaV6sI5ESIPgJUmwbinoaJiAZCW3uhMqgUq8ursO9drijAzFSMgZi7VeGHW4SAg==
X-Received: by 2002:a05:600c:83c7:b0:43d:fa59:cc8f with SMTP id 5b1f17b1804b1-43ed0db6d58mr135824605e9.33.1744107653008;
        Tue, 08 Apr 2025 03:20:53 -0700 (PDT)
Received: from parrot ([105.113.112.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30227e3bsm14309136f8f.100.2025.04.08.03.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 03:20:52 -0700 (PDT)
From: Richard Akintola <princerichard17a@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Akintola <princerichard17a@gmail.com>
Subject: [PATCH v2 1/8] staging: sm750fb: change sii164GetDeviceID to snake_case
Date: Tue,  8 Apr 2025 11:20:33 +0100
Message-Id: <16e6e40930d67bb6481638982da13fc32fb88f10.1744105388.git.princerichard17a@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1744105388.git.princerichard17a@gmail.com>
References: <cover.1744105388.git.princerichard17a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

