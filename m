Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9361626A1C7;
	Tue,  8 Apr 2025 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107663; cv=none; b=tfF5aKSha43R3DmMfeDC26QgzD9O8FLxNlrq6G9W9U7GfLaNJjZK7M5gq/d3B9LoSBN4hKwkZk+yklEDZFHJ1C82XGwgy8w8t8q7zugVwVl3lO59uL2ycHqZk4XuLx+ROqv9H6XhWoMiraMOynnz9X4v6YDYrujVhHSwd44mh54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107663; c=relaxed/simple;
	bh=vQj84IzAyMbsqXmdqTC73l509pCAn1/REbFySFYyqoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IljFcnul1PZxgf1ic8Apzt6Iz7xZrV8INodtHiZ1iBVjX0cHXXlu5urBa19bHUz2vk+2vlBtEYVtrVZTpz4yF+SJiGlS7rnM0bpnXoV+9JDuevn7h99HOwQOuHc/ZImosnSc6fakeMMgRwJb0Cq1a/WBqA7Lnq1QCPOcRGeq5yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR5pLCrc; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR5pLCrc"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c266c2dd5so4668082f8f.3;
        Tue, 08 Apr 2025 03:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744107660; x=1744712460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zir1NDA8An9XMiM9quRa114yNTaeYbAjAw+vpjLNbb0=;
        b=HR5pLCrcriVKU9L6iGHF+YoFcqzjYcK7heJYoYTMo5zqyzyb6F7UI+ggXCNHlCKOPk
         IdtnqXwSS9fV3Q8yoKECM8K7JMR8O+7lXxweDFMkO8oMQhfCK8VsLj0KFx7f0UFcImTX
         Wzquux2u0/7Q1CiMxnhoSnI8GVB6TETlizhdIMPbL0iPXMBpu5fdCnXNNahUnfCrju/j
         8II0FdgFDyoqO4VM4DNwscPEDnJEQQAP8UWt33B7X0AwvqtozW1V27CslBJlMXH1ROiZ
         Juk6+eVUdd/ZqlQRp8WsXKQkuTstagfwLrKFJm3kkky8TbdoBHmgp9BbogApt8/kIRu3
         Flkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744107660; x=1744712460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zir1NDA8An9XMiM9quRa114yNTaeYbAjAw+vpjLNbb0=;
        b=iZVrSQGZ1F4H09DJ8M54Is33+WJPUevawFM4aD13VIE6XPOlBTlAkL8XPIkKeqZVm1
         WxayuTkeBsYm4i8AgNudFt2t0VSg3ZMQC1OVvZTtzbZfHiKi67PIeF0fXulv2zV0oAwg
         q2hN9uqg7vzFZ6KC8t8wDaopE7q4tr0Zr0GtRhKdPB+ZKqtDvsjHWCFimHND27q57Yzj
         5RSITkvxLeTQU+44KIKlTSFMm/vy4zH1bj0V0Upx/gMDkqcn+l8zowKOYrWike/Mqiqk
         miJlQ+TBakTcDzuW/WRmZxFiOuJ4PeSwCRcFWn9kx+x8U6S/fDwQVfGuBkj7jimB+u3a
         8U8w==
X-Forwarded-Encrypted: i=1; AJvYcCUaCVmcL0mHlObig5mqr8/XSBuLoAOLNT2SFj0V6Z9XXW7W7uikmEM/6rUSu3FNi+1yS7a0C8oCnQ+iZ/R7@vger.kernel.org, AJvYcCVLzrDXESwYgbNydwyM8bAlnM/uSjHN0wj35A5c9ZaJsqjIKmE81zS7sc9JFF08zdWHialgyDkqfTCAng==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZH2JoDQfOJSRKeSeman0G7gHGYm8CspD0Fx+txsNBgZyk73Sv
	cVz+Pw8pHNd7u8UVmD594kecN+lfpDVf+bun8pHweOE/OZgMo3Op
X-Gm-Gg: ASbGncvm3ohnv02tjtBaupi4i8Aab0eobJi0iyjh7Ov046ql+4NcZ+2FLofNwzNVIdB
	fhg9sOjbTcAWgWrNR0g2h2DEYy76CBGL0z4a7m0vhUYhXfje3ij0XfqElrAz474HgcNbQfIsweC
	AGXV/haBV/Htl/HXqE8nkdB3yM7vZpdA9nwvLN3pq2XHqmJ7x679Vz7vcFAxEeHaZ5MrHCneTzJ
	aJvEIn1K8xLmV6U8RyYesinr1slFFKH/x4LvGbAT9PTFLzOWF8hXusvMwnyEXalEGMKY0jqc2Ce
	U+qfJ++B3ti3aLm8PjW091mvV1w=
X-Google-Smtp-Source: AGHT+IEu2euszzA8Yiv9jnmNk/SqKLPj/4vJpLQXYyX1OdPyxjTTbritL26fMZaSdOJzhMqOhM8lCg==
X-Received: by 2002:a05:6000:430b:b0:39c:13f5:dba0 with SMTP id ffacd0b85a97d-39d0de16c5amr13236038f8f.13.1744107659699;
        Tue, 08 Apr 2025 03:20:59 -0700 (PDT)
Received: from parrot ([105.113.112.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020da17sm14592160f8f.64.2025.04.08.03.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 03:20:59 -0700 (PDT)
From: Richard Akintola <princerichard17a@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Akintola <princerichard17a@gmail.com>
Subject: [PATCH v2 3/8] staging: sm750fb: change sii164SetPower to snake_case
Date: Tue,  8 Apr 2025 11:20:35 +0100
Message-Id: <90f9842254eb83c2dc19abcf5072aab9549026a9.1744105389.git.princerichard17a@gmail.com>
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

