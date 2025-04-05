Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E111F3D49;
	Sat,  5 Apr 2025 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743858239; cv=none; b=qUXIP2fazrZTFymLrEsPKAQwUd+afSMNLDWEazon5uAzwEc3ejvtGW/6cpcZsDvWXQVTS0/exuFM2NS7S2h7MnY68+NpzLg5RBWy+A7efaqE4NHnLDaOqx2775N/znnOyBqUePJ/r0OCzxRs8buC8MNyC3H7YrdgFb3q0pdLyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743858239; c=relaxed/simple;
	bh=+7dT3tL82Twj4medpCe66/0q0Wl1ZErhjrtaxQu867M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i54lLmspTadSAUGd6dJsindT7rNSWrqHsehumSW/madS/ebdLikjG3FzfghEw26KhrPZ6hjNKKxGVixG6LohirVzE6t7jwpIY9fqXilyvki3FRSceBc8h7EaZXn3oPXJgtuAjLOtilePX0F2k7LqmRImBeLYGZOK3paIwCmkUuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDQvDF+g; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDQvDF+g"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso26268545e9.2;
        Sat, 05 Apr 2025 06:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743858236; x=1744463036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4QDk5t1ncy92IlUqUOHalwkPhSsIRI8ajRfXHeyssg=;
        b=EDQvDF+gSf4nL8i6Ke2AjQgC7wAEMONxo844oSZCVsaVna2vBc2lxstNuMfuHvyXhd
         NpvzQPxXQw5OlE8ZJoczlcMROxp8/3qnfquXRRdjsF+2Nrlc1rcutL6bFPnrZqihCaaL
         WTuFh7TTD+iUpRxZXNB7dCgj+wILF2muxHMzPp+RkplCHTQKuITu6NqnwrZtJ7pgKuEL
         V6OxHD1wewWnrQJoY7OoCblFAeoDeTMEP+3pk4GOXDA8aCn/3flmZ2krf6OdL3jsZCdl
         /AJMcLmN/E+kkc6kb77zZIYUMqYhWoNQ/Sr9Th5rQbPv6FEq1OYIu20LFlWj9tyo2F8D
         nKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743858236; x=1744463036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4QDk5t1ncy92IlUqUOHalwkPhSsIRI8ajRfXHeyssg=;
        b=vz6KJZW59xqwvH7T2KIRFj9paKajqNVVKQtM6gppABz6HRkzXxHzdKttykErsp/xj8
         +KBB4pdSqQ3jxuUuaxVxRyofZCkY8DEszJHO4qrsADka1YpuA4udIudfgTY93SUTlutq
         rwHfJVhfqWRuiKYyUhrWMjHkX42mWIliptl6diY+fBZ4ieBYSQXsRTMK+ilBc4SL5kqf
         6+zoK5nNBxQfQFcQpP2vloSVrSWliVSxRv4DFpWyZHhQeIXrUEfT6GII5+4I8EvvRNBL
         pcbt6TCjD7Z5k7Chd99SLqymF06AoLkyvw9nRccVDAQJePcrOzhejCzWWC8DhMe98GDC
         wQ1w==
X-Forwarded-Encrypted: i=1; AJvYcCV1vgWeTPNUb4x9+IjK3q4ibqMSHfHzLMSjEVrltmS9BItZZ3uySpIBL2zKyoFwKB8jXmGRX5xgyPdX9lIb@vger.kernel.org, AJvYcCVYSPz1x4ftP6hdAUpO0ysZnGzkvDZx3d5IwR3DMn2Q/8lPdfwHhcINbUCys1gQn86+5tDhfPqKFQBb4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh1dE6ziuuZkHxg0MZKyVH8wtYqwy0CdivU3aCGD8l/XwSJpU9
	AGXTJv4vZzgHsMbhOv8hpjcn8L2iCkqU6LF1AGrCWGsXmm3pYxbL
X-Gm-Gg: ASbGncuMplEPjKbIkbgJyA6n4dmO9SfmN9i36DF+fOe4C9QGNZGmfWbXarBjHRR5mv7
	1vw1ZgDWhs5vq0XnuNGKxnR4SJqK/BUqoG0W5cyN2XHkd9mkzNP51qFBilxkKMq6JeV8pJlzqgr
	8LPOi2W8E0fmiprQSvhAlPzqDUPE8u2hw3oOYOLvO15JTRu4CrucVy43Gi6vmfJpU3L/FVZIYEl
	uNQJzzWLaln50SCRqQMHtMW8WPkwjLSFFgx8TwoqF/jhW83fkGiecc4slDTP30ObcR9KMFAmfnf
	BmbGTcu2Qb5yElvW7NaSIzRT4w==
X-Google-Smtp-Source: AGHT+IFZSIThJAHBaljJXxy3PJ/DYBCGCmV6gC6qirDfrgNj2dih7G6GpjFk0tQXaIzgS1BwdpPKWg==
X-Received: by 2002:a05:6000:2908:b0:39c:1257:cc25 with SMTP id ffacd0b85a97d-39cba98bbc7mr5544209f8f.56.1743858236019;
        Sat, 05 Apr 2025 06:03:56 -0700 (PDT)
Received: from parrot ([105.112.71.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226f2bsm6912512f8f.96.2025.04.05.06.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 06:03:55 -0700 (PDT)
From: Richard Akintola <princerichard17a@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Akintola <princerichard17a@gmail.com>
Subject: [PATCH 4/8] staging: sm750fb: change sii164GetChipString to snake_case
Date: Sat,  5 Apr 2025 14:00:55 +0100
Message-Id: <08eb6104c7b82aea32796163421a7e795d3d8964.1743857160.git.princerichard17a@gmail.com>
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

Change camelCase function name sii164GetChipString to sii164_get_chip_string
to conform to kernel code styles as reported by checkpatch.pl

CHECK: Avoid camelCase: <sii164GetChipString>

Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index bb7538682b7d..c12df1f9fb00 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -19,7 +19,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.get_device_id = sii164_get_device_id,
 #ifdef SII164_FULL_FUNCTIONS
 		.reset_chip = sii164_reset_chip,
-		.get_chip_string = sii164GetChipString,
+		.get_chip_string = sii164_get_chip_string,
 		.set_power = sii164_set_power,
 		.enable_hot_plug_detection = sii164EnableHotPlugDetection,
 		.is_connected = sii164IsConnected,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index b96f9369fab4..d0b80b86a4d7 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -261,13 +261,13 @@ void sii164_reset_chip(void)
 }
 
 /*
- * sii164GetChipString
+ * sii164_get_chip_string
  *      This function returns a char string name of the current DVI Controller
  *      chip.
  *
  *      It's convenient for application need to display the chip name.
  */
-char *sii164GetChipString(void)
+char *sii164_get_chip_string(void)
 {
 	return gDviCtrlChipName;
 }
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 45a90489c95c..c15cd6a5d53b 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -32,7 +32,7 @@ unsigned short sii164_get_device_id(void);
 
 #ifdef SII164_FULL_FUNCTIONS
 void sii164_reset_chip(void);
-char *sii164GetChipString(void);
+char *sii164_get_chip_string(void);
 void sii164_set_power(unsigned char powerUp);
 void sii164EnableHotPlugDetection(unsigned char enableHotPlug);
 unsigned char sii164IsConnected(void);
-- 
2.39.5

