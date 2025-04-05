Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144781F12F2;
	Sat,  5 Apr 2025 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743858234; cv=none; b=qYgNZKdwZIUbA1CsRum4kaMuomqL2zGQLm2NXH2zNK6E8yfLba2M4byP9hjvMI8vfwtjLd04UbvPlhnw6x/C8RrM0tmwwwYCEBHAmU8ze4ClHOawKqwPZGWMRWuJfQ2dXxukVjYUQh2CWfYGErU0KbHcYXsMUZ339pnG3TsYV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743858234; c=relaxed/simple;
	bh=vQj84IzAyMbsqXmdqTC73l509pCAn1/REbFySFYyqoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S5LSK7aT6jSyZQmePcXo9cPJPHp2b7zoyFQOYBoxoMkDhD0Sx/LTPYrAJ4/fJIgwJKFF3qVpGvHT7z+C1f8p0Bl5ArOMP7qCu7Oz430XENSS+9nvxwGAioXlflXxNp36mGiNviNNRgMnkhWo8Wig1Q/JhCmR3EL8XBtb/pNxc9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv25UaNM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv25UaNM"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913d129c1aso2019401f8f.0;
        Sat, 05 Apr 2025 06:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743858231; x=1744463031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zir1NDA8An9XMiM9quRa114yNTaeYbAjAw+vpjLNbb0=;
        b=Hv25UaNMPijp0CWVOSDPsJ2E+Hcc9i6nkdq3ACI+GcmV3VW7RHofEjzuoKQpaqjDxr
         7UL5OZxf15pDNxHEVlrSGrKMg3bu89dgaH5hK1xJDA87rOcbEk+ZhtEhb0t1XMHnE2Z/
         rfW1a+c6oc0Hm0kS2G9yY+kJZrbZGWBdiufmlQ+5i0rzr45mV1HXVX1qNZieYF8umt0t
         YLOxxIGSugfxzP01HoX/HIOU2p4sN2iR08sq/w8R0mSzwVwlGJ/MEXR3E90VVUvxt80h
         QOhbu9/glcK3yJ8PHf78oPwy6KKk/P//b6v7cN1yFXPSqNt6Xay4vEnvEg+R7nC/Z+nA
         FTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743858231; x=1744463031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zir1NDA8An9XMiM9quRa114yNTaeYbAjAw+vpjLNbb0=;
        b=UQTUgSe9xlXj8SKjo0joYu/fOZ7MgXSUAqATYDzHOYXY6S3q5a9jN7tqjVWy36Eyr2
         MK3rtyXiq8M+x6IIAZ+DbdWcHOWrwZhwimrdOUkVpn8q2K3GNVLrtt7CeHatgCymNTWj
         Phyw5O7QO3KNOXwNqflGTPEMIeR6Sqr7EaKFkmP2QuwpsSQSsXNEjDW6Tn3BxCSasgTx
         pHACAzLRWy86DE9n8uWUrQpyMPI9XjDNO8eRCUQFi4qtQ7MQcH7mKtkaZN2GPlbFSZMU
         G7BHeE/ZQq21GG3MyHNMvcBuvcWGo1vqlH7j6XSUESOuygp0QnoUZDaj98TpWOt/c16o
         ckpA==
X-Forwarded-Encrypted: i=1; AJvYcCV9MH/Zp3U5Xw36DM410WMgZn4bqiEP8Z+ORf3A9Vp2ioGnZ//7kJvC9mblm+PkWui48WWlbtWLqSMOQQ==@vger.kernel.org, AJvYcCXxMZyRPkDr7w5vt74GU8QYIDqcX8RGHakwA6Ia99Z4Nmu4KurYylETpo89LsCZr31bufUKHunnR7fryJM/@vger.kernel.org
X-Gm-Message-State: AOJu0YxwK9o7epdh2Qkjl1BTkOU5wZJLPW/Mm16aOLQPQYC1W7ova+8y
	xCcUKijFWo2+uKKOth+zezreUZ3hdcaZQ7RsivSl2Aqffr1FSKQk
X-Gm-Gg: ASbGncsG80pLcsvwpPbeLI81N2mraV+4dqiG23f4IlPmyNSP7H5Dyl0NFblb6ylyy6Z
	rESHFfHkdRXjbhW5YfwRDkwHFFuNQnwA2O25NFaMOg5tZETlY5yuNK1qKP/cAeCL4EianQLzobo
	eX0diQitkZNEdYfLngPm1CNOcfjjFzrLx/qUVCq5kzm3HdN+HNvDDIXUffpEV+vrQxknC3/VSoQ
	qQ2W7cDSDbCXroVLDuCB9CyLcpJlSwcoPk/BdZVBSggrhS+cLQZIa/mqWkiKecZ4jfzKt/HhlPP
	6WhyNku5cy57dB+fn7JFxiXCcA==
X-Google-Smtp-Source: AGHT+IFM1faHsYRlRseTZrJNYEdeiohp0q3i/meYKhvosYgotdtEcCLj36yq4TgoJ/KS/8BgC8CL/Q==
X-Received: by 2002:a05:6000:2411:b0:390:e535:8750 with SMTP id ffacd0b85a97d-39cb35aec3dmr5109957f8f.9.1743858231312;
        Sat, 05 Apr 2025 06:03:51 -0700 (PDT)
Received: from parrot ([105.112.71.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30096923sm6955182f8f.17.2025.04.05.06.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 06:03:51 -0700 (PDT)
From: Richard Akintola <princerichard17a@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Akintola <princerichard17a@gmail.com>
Subject: [PATCH 3/8] staging: sm750fb: change sii164SetPower to snake_case
Date: Sat,  5 Apr 2025 14:00:54 +0100
Message-Id: <90f9842254eb83c2dc19abcf5072aab9549026a9.1743857160.git.princerichard17a@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1743857160.git.princerichard17a@gmail.com>
References: <cover.1743857160.git.princerichard17a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change camelCase function name sii164SetPower to sii164_set_power
to conform to kernel code styles as reported by checkpatch.pl

CHECK: Avoid camelCase: <sii164SetPower>

Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 8 ++++----
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 6dee95e60a6e..bb7538682b7d 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -20,7 +20,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 #ifdef SII164_FULL_FUNCTIONS
 		.reset_chip = sii164_reset_chip,
 		.get_chip_string = sii164GetChipString,
-		.set_power = sii164SetPower,
+		.set_power = sii164_set_power,
 		.enable_hot_plug_detection = sii164EnableHotPlugDetection,
 		.is_connected = sii164IsConnected,
 		.check_interrupt = sii164CheckInterrupt,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 284c32f7e9b4..b96f9369fab4 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -256,8 +256,8 @@ long sii164_init_chip(unsigned char edge_select,
 void sii164_reset_chip(void)
 {
 	/* Power down */
-	sii164SetPower(0);
-	sii164SetPower(1);
+	sii164_set_power(0);
+	sii164_set_power(1);
 }
 
 /*
@@ -273,13 +273,13 @@ char *sii164GetChipString(void)
 }
 
 /*
- *  sii164SetPower
+ *  sii164_set_power
  *      This function sets the power configuration of the DVI Controller Chip.
  *
  *  Input:
  *      powerUp - Flag to set the power down or up
  */
-void sii164SetPower(unsigned char powerUp)
+void sii164_set_power(unsigned char powerUp)
 {
 	unsigned char config;
 
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 7a71f94a1e9b..45a90489c95c 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -33,7 +33,7 @@ unsigned short sii164_get_device_id(void);
 #ifdef SII164_FULL_FUNCTIONS
 void sii164_reset_chip(void);
 char *sii164GetChipString(void);
-void sii164SetPower(unsigned char powerUp);
+void sii164_set_power(unsigned char powerUp);
 void sii164EnableHotPlugDetection(unsigned char enableHotPlug);
 unsigned char sii164IsConnected(void);
 unsigned char sii164CheckInterrupt(void);
-- 
2.39.5

