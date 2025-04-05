Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE081F4195;
	Sat,  5 Apr 2025 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743858243; cv=none; b=uMa8djZJR2RBdAgO5EthHBkBCzHbvLR3Y8g4FmGmvfffB7MDMiLtWycq50UsVQwnzlTEvufpayXeSowoFyaqFRSNOuWzP8PzJ7JTakhtkDFupmIp8Ru8LpZHMQuaBvmvdjC8KmkTlU/lInnxauVHVJNUBOo+59e8jRlcc+UjAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743858243; c=relaxed/simple;
	bh=beAf4oeKfEtWFFLorLb9kscpUFlq1Zo7hXzlGWUFp8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hACSOW6wMHkGRfwc+n4VERb5ai2XT29mvxQCUDNFTT4AuUWAbrSZ2cktMYWVinXyyH6IccMexGRNAhKvDYonggolEElgZA09Utf65aRNA1K3k/mgdQVzDj07PTQ85zp+eXURcXI+5nY+Qn7mcvr9zebGMH5jFuYS1L3j38HBQiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9IxPnjU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9IxPnjU"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso31063485e9.0;
        Sat, 05 Apr 2025 06:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743858240; x=1744463040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iccBNqnE1r6LyZ+rk34ys2cg+4klAtt7ZPrU0BU45c=;
        b=G9IxPnjUNRQP3g9xZWslRhEz2cLBrMS8frk8wyzJ8L/qKxJA5jqNalyKfiwF0soztp
         G5f2ncCge+8/LIGw8HPG/b9wjIZPfQqsWm2F56dvI7ffyVFZhjWxe3vMobn7YJ2qWVZW
         aIdh5/9Tu9kGZzJgChhZOtddfUDAojS/wSYq4ryTPgMoORh3j9FT58uGNmLRUP7G2H6F
         ml7pUde6WOlQtCDgJiCXhP1a4PbgI8tL945LKce30bWY24/dGlhoeJAxmz8kLa+tgnqu
         qN/ZWIxS1eppH3m2zh5dDNq0R6dzVv29dwIavETTvg9esuzqS+trv3V3WVE8vufQq/1y
         P8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743858240; x=1744463040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iccBNqnE1r6LyZ+rk34ys2cg+4klAtt7ZPrU0BU45c=;
        b=YtsEKPHwQc6a2eGNFHgyn+m6M4dDX82ZITUc1xVGESW/vVysu1efXe33swkxLhiTJn
         iJvWGWvjtts066rof2XHP7NZXfbS8VNdOwp24+1IbA9wCewMEvfaWNJPktjMjaMl+n5/
         dtqDT+1vxWegQFqXXm1EdoSAxoYxzBlL7N9PxTqsdJISkXcK5pMbzQu62Qrv5XCBPYYd
         Q8ZQsZGZ3sCV5ADdADXXcnTy4qe3BYpXRh9hcvEH8zlzRf+FavA265G6NCrFA3kEBJH5
         HIO9Yz/6vxlkuWiQfMVK8ovyVCupp+fqXdvxLoFfzyIdLqHMBOFVyejGXECgxQBTB2hN
         m9bg==
X-Forwarded-Encrypted: i=1; AJvYcCUxCkYlXBCk6v897IoxHoJN8v/tPCl/X6gZMqqKUidga2Ai0V9U+Qqzfmdc+OuT4EOmnjj9uv+oS/QBsFLw@vger.kernel.org, AJvYcCVUK0ky37UVRQNHOU4MBL9ER3gWYxgtgW3R9VKBjEeA8zj4WW+wanlKE84rQLCgv1kA0GPx7zWYAruSUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRcCpzwCHZCuVYkLnYWn8yPJ1D/IYn7J630a39v1u2z/RQ1gYz
	rp18mrdEAADvqv1Qk5XO0h7BO8+nVzOPqLO2O4XQozbByufQi1IBhOL0rKxGVgg=
X-Gm-Gg: ASbGncvhVdrIw77KHTBVgDe+AHMSsWSXnEnrn+Q3kqttq6IVvovXqmHUpItRLebgky7
	sxgKodShW8W7YfWkrHKZi+3KTw0XeHslopEjTmnVySXtzvDTqGu+iJ69tHd8ebysE8FAa7lcI0x
	IKICR3D/Glsvuelz+YpQl310U2Gw6ECRHCafWTE9Nzg6jaOO6FKc+6qlHRQ5cY4JRDca3PuudzI
	on9Qr7npd18Yv+RcWlIMNdXPaFG6M2IXwfsrRqCN4WQB+9J/twcTSjJn49jqMIRziv9zSqLhCfZ
	qAQxp4zVjFskpJPOpe8bg18H0A==
X-Google-Smtp-Source: AGHT+IFIMYrd2dDMaLPVuxugXEXg6nCMoRFIoPGH971PhZ0xS2xoT+hHYBJCiyUw8ooh4kTlw3XufA==
X-Received: by 2002:a05:600c:b90:b0:43d:47b7:b32d with SMTP id 5b1f17b1804b1-43ed0d6aba5mr52573875e9.25.1743858240431;
        Sat, 05 Apr 2025 06:04:00 -0700 (PDT)
Received: from parrot ([105.112.71.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec364c959sm72140075e9.25.2025.04.05.06.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 06:04:00 -0700 (PDT)
From: Richard Akintola <princerichard17a@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Akintola <princerichard17a@gmail.com>
Subject: [PATCH 5/8] staging: sm750fb: change sii164EnableHotPlugDetection to snake_case
Date: Sat,  5 Apr 2025 14:00:56 +0100
Message-Id: <04907f753bc0d1a2b2095ffba1d066516520fbb8.1743857160.git.princerichard17a@gmail.com>
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

Change camelCase function name sii164EnableHotPlugDetection to sii164_enable_hot_plug_detection
and it's parameter enableHotPlug to enable_hot_plug
to conform to kernel code styles as reported by checkpatch.pl

CHECK: Avoid camelCase: <sii164EnableHotPlugDetection>

Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 8 ++++----
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index c12df1f9fb00..1ce44c50617a 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -21,7 +21,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.reset_chip = sii164_reset_chip,
 		.get_chip_string = sii164_get_chip_string,
 		.set_power = sii164_set_power,
-		.enable_hot_plug_detection = sii164EnableHotPlugDetection,
+		.enable_hot_plug_detection = sii164_enable_hot_plug_detection,
 		.is_connected = sii164IsConnected,
 		.check_interrupt = sii164CheckInterrupt,
 		.clear_interrupt = sii164ClearInterrupt,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index d0b80b86a4d7..c8db6ceee9af 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -329,12 +329,12 @@ void sii164SelectHotPlugDetectionMode(enum sii164_hot_plug_mode hotPlugMode)
 }
 
 /*
- *  sii164EnableHotPlugDetection
+ *  sii164_enable_hot_plug_detection
  *      This function enables the Hot Plug detection.
  *
- *  enableHotPlug   - Enable (=1) / disable (=0) Hot Plug detection
+ *  enable_hot_plug   - Enable (=1) / disable (=0) Hot Plug detection
  */
-void sii164EnableHotPlugDetection(unsigned char enableHotPlug)
+void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug)
 {
 	unsigned char detectReg;
 
@@ -343,7 +343,7 @@ void sii164EnableHotPlugDetection(unsigned char enableHotPlug)
 	/* Depending on each DVI controller, need to enable the hot plug based
 	 * on each individual chip design.
 	 */
-	if (enableHotPlug != 0)
+	if (enable_hot_plug != 0)
 		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_USE_MDI);
 	else
 		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_DISABLE);
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index c15cd6a5d53b..9e289bf4a78e 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -34,7 +34,7 @@ unsigned short sii164_get_device_id(void);
 void sii164_reset_chip(void);
 char *sii164_get_chip_string(void);
 void sii164_set_power(unsigned char powerUp);
-void sii164EnableHotPlugDetection(unsigned char enableHotPlug);
+void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug);
 unsigned char sii164IsConnected(void);
 unsigned char sii164CheckInterrupt(void);
 void sii164ClearInterrupt(void);
-- 
2.39.5

