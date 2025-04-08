Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4150269D19;
	Tue,  8 Apr 2025 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107669; cv=none; b=iJUhR5F9uUVYQ0ABLBDZbRM8n0scVf06VIxpCoveffvtLPHsMq8LzLX1cB1cgBaidHUYRIqn2rtIYniVwMHTnunKnPxrI4+ihQFvH3W+Dg0GwCDShGywIT7dohnrMUYKwmzuDsi0gpPxmdQ9aLDl2a4r37wLgkZGHWKYIdSrnro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107669; c=relaxed/simple;
	bh=beAf4oeKfEtWFFLorLb9kscpUFlq1Zo7hXzlGWUFp8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gh56WE6pDu3HFmmgkuC6t9mTQCNsDuNeUE4vVtGPZP/RJ0E6sd6FxCHcwUIEjQ0nNpM7aZnz6d2TirKaSZ26ZyhoaItzcWSJnO5yNg/EfhHOJch1o/JQ2oJofrvn8bKXp77LHRXbDLPVL6I9iX1UmxQBo9qEBvOLdbH+JqptJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIMyKyKE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIMyKyKE"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso35556495e9.3;
        Tue, 08 Apr 2025 03:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744107666; x=1744712466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iccBNqnE1r6LyZ+rk34ys2cg+4klAtt7ZPrU0BU45c=;
        b=FIMyKyKEjQJR/Wj9/6iiCQ5O840hVr8zJxkCES0BAGlCwFIn7/Ne/xNXqVsUbidNNJ
         H1B7pfKPIntfGhEpUqGvzUnAjIMQa7fPVPJT3GXeosKgSGcXDoCalLhl+blk7unSAeag
         DqHNkmSOX0n7fqDbHAX5l0ZN13iJ1Awn2xeNSPEizFlLlkFzg0C6FFCr1uzHJtbqj8tT
         ZfWJecLBtFKyb1fkRsDqElmBWhWFXj4baaEuv38mBQ6yMiuctOBVg6ZnCLOyYVg2iKNO
         KFNrStnUwkl2abMrRMUaTC7HGo1vlafoiSXW/t8OetkUHD+RFjcInmdMumL16Qi+BNyl
         QKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744107666; x=1744712466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iccBNqnE1r6LyZ+rk34ys2cg+4klAtt7ZPrU0BU45c=;
        b=CuGkGThy9HNDDrHRr6om4pJgbvakFJkknNMDkMjdkBBs7Tk3WYkDpWxkNmz2X1yEjH
         r+Ddf4YjqAipT4NssesJotJG+xgjcHOFayjfWKadK39ldLQhYWuwBAv4diFmWIbpNnFY
         8iAOYPx1aB8CD0juw5j4PZ1epNqbffcN4Ve1d0xiQ8NOEIh0/IehFKJpgkUk3DjoaOnN
         JDOvyusQHkmBiwf+Ii2dVkmtTqM6Q98rJDziGRQg0fKviKQlzTKNsm4U4KO4PJP2KyQe
         OpGr8G3ORqA+9bCWBtz1mnW86keCU55wf82GDSrGZYhat9dPKyEyk+Mx/fD/RyjOJu4n
         rKsA==
X-Forwarded-Encrypted: i=1; AJvYcCVNMG9zLwj/oM8qrvifbplmfxk7Fg6fyAOdXevenWUFkI4+IMoJIo60aZQzb2klIbq91YSrnyudYiFAYw==@vger.kernel.org, AJvYcCXxrsbylK7VjDAZbdr9FWjJSb1tBlo8fEIhe1gH/9mCRYjVkaQTBgtecagtlTDx4Sq61KkiFYhhjH9FKAJK@vger.kernel.org
X-Gm-Message-State: AOJu0YyRUje5v7rib4pATiVHCqoLix4EvomXe2cQcJypbFAi9Hb+7aAl
	IAZyNNq4EcD9mIHdWb7Dw57x878BmSSuFBdfq2kv/dd3uxazuwxo
X-Gm-Gg: ASbGncuxXxAcrqCjJWaoefbArtKvwSDeJNBc2PpeanmKjIETa3k/frS3HllkfafTvOC
	bv5DoJRXLTMcZOikC59BArtndlLbHzInp62GZds+9JpTjj/7VZYkBKys6EY3bVtPW3JneAWRC2L
	eizNh5KY3+fKEUngu3S/odGhvp4qG9SecG6AuvXFOy0RKV0/YSn68UssIlWh9L1EpWkSlWBnmQs
	oqn4COKUvRZuHYUnWqE0X7ZOxkevZtA1X52hQllK+qJbA8kd3IbC8sAtLlmWiB5yOxzoOdDhH+f
	cCKvKEvqnjAuWCANv1QUbn6ELr8NiIPMZJFFOQ==
X-Google-Smtp-Source: AGHT+IHqfw+UqZ9G2ul2O/tYAHTe8N/ZpMN3HMWGWcMcnHKYWdy2tbJxSZkyOVJM0MM4015QH1sPpQ==
X-Received: by 2002:a05:600c:190b:b0:43d:7588:667b with SMTP id 5b1f17b1804b1-43ecfa29cd4mr166827095e9.10.1744107665914;
        Tue, 08 Apr 2025 03:21:05 -0700 (PDT)
Received: from parrot ([105.113.112.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342be6asm161933305e9.5.2025.04.08.03.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 03:21:05 -0700 (PDT)
From: Richard Akintola <princerichard17a@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Akintola <princerichard17a@gmail.com>
Subject: [PATCH v2 5/8] staging: sm750fb: change sii164EnableHotPlugDetection to snake_case
Date: Tue,  8 Apr 2025 11:20:37 +0100
Message-Id: <04907f753bc0d1a2b2095ffba1d066516520fbb8.1744105389.git.princerichard17a@gmail.com>
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

