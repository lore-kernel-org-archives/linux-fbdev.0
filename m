Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F022E26B0AA;
	Tue,  8 Apr 2025 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107672; cv=none; b=aLQIRmIHrpucxvgMuF+5FfJwvmy9H/8aac8V4uW3xmiYWmz0J/j+hNXSLNaasWETCX7Gn3E/JgNOrOMf3q7XPAre8ghvVdyBreffAB3wlk88BDm6rqaa26K7E7RBgIy2DjriA2kQ9YpiSqCToK/80b1V2dsrJYkHABwsNAYFjL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107672; c=relaxed/simple;
	bh=z46nsSq1v/0fvClzA4Zas3TDcqFixPfx6NddUMaqlWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iLd1UzvzLfQPmBHnlIjBtbF5UkPePkwM/yyNcLaTCI8sK8mDE1xwuVFhFb8CPXNdMyXP+K8ki35Gam39UQkVrd9SXPkuuI5SjB/24JIzYKsrngMYWapyzdnsYRhfCB6aOqKO71bP9msiXmeTkb+Ldn3tV59Mz8J7bH7hmVtgBIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0SG6J5G; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0SG6J5G"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d0618746bso38762295e9.2;
        Tue, 08 Apr 2025 03:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744107669; x=1744712469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pxfh28JgrgsZ43718+Rog7hGuSrWMc3dc3Cy5VLEAE8=;
        b=F0SG6J5GQXOQpVLTHeSm7VgSdQi0aOEXmE7E929M2YTqb/5raDR7ckBS1H+J1FxAhC
         KuQTrGpVauIvOlACiq1hcXDRU35w853BXiSpR96cOgmt983Ls6KqLHcPvHWtpvl/iJtB
         yaH+A1s89jkNT0IjsCVN4NcOaU6LLVcXqyChioSaEpdT2BmjQm72CFkDRbkKQFf3hzD8
         7R5QN3SQY+AHsF4PJ2zqo85zTGV1noI1BHHKbTxOd9uXpiVEAS5oVyIZtFimB7HHczr0
         xtPZNxnTufInGYxLzpZhu4EIGPfNlA1wAnqOMm2hkDGm/YAoktSj837DP2hrvgb35Z9p
         nfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744107669; x=1744712469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pxfh28JgrgsZ43718+Rog7hGuSrWMc3dc3Cy5VLEAE8=;
        b=UnC9KOoBD/6Fw96HAVkqTp/xggh01hXd3jA6oTidOpAMuM+lkaqZhQRVsnj/tRV4tM
         oLsbUJ7zkpEs0e0augv36mYWyRtCXkzHRP5qYTIA9sL0zHkdDZbbYEtKz3qt4ICTaCtF
         JlXgyM6qm775pObiPLKzmdyX9TXJj0qePmpxoUSXj1oITfvQw3zH9XkQ1JfSixJdK2O6
         EQAngu2pbiy5uuDW//RJHoPhv012R+G1kmoUGlTAyaIYTMDGqECfCPk9P2rHQxn9e8Jk
         xbPfEFsJ2VnF/9HTmylek1zzQtvxce3mwOrMGvY+NMu9DwECFmVR5KkPBysOf5/j1oPM
         jM9A==
X-Forwarded-Encrypted: i=1; AJvYcCWIdTHjiKLvLr9CW+jbruqK4ZEsRWPKAB34E03iz63gG+hU2+Myfg/MGiU3NF6kwAUn25nqSPeY3kyszQcs@vger.kernel.org, AJvYcCXBsKNrPmsjx8QIZipnXUlFKETw2W4SQQcVIgzQoPmXV0RBLZ43lRfUu7RrbwQMLZALkGHFRJ99/WAosg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYmChUgObJQ8DI+w6uPqCLHeNBaC708vETMPUAlQ6NuYiqV06l
	TjZnf96M5OcH+b5HS4uhw6eh6wbxErj4MJRWhPSNU47EeLogNKCe
X-Gm-Gg: ASbGncvbNldIy40mrkCksANFmKUhm+hE+XvshRHu8LzGol1p+3vppEGyjeQfFySXRnL
	MWUItedzFVNmM8WoVVLOCfqUemgfYrXdMN5sl4RKKTu0Kx8lNsdYpmz/M9ALRU2VYBK2bqcgVfV
	74x/xa3K+lLw8Rq1NcveJJMrBREaDfpjoaud0bhHXkw2pJccAvim0fzFlmwsj+t7lDte7hegnkf
	f5O2SQ9DD4HShYxkg9fxwypfEfIQFPgq+OOW1Mod4Ie5i54ajbyToK5BF2BdYxvPFWn3tcafFDn
	ckjQpxFCfbZbFwc3rt8Cf7iH3npeq2T41qENGQ==
X-Google-Smtp-Source: AGHT+IFf6CCKvSyFrEYGPGQBPp88hffbcUboIMSgf4Sk5w8+BNkWkOTjOCzvdY6zQ2+FNkJ2K5ILeg==
X-Received: by 2002:a05:6000:1867:b0:39c:2688:6edd with SMTP id ffacd0b85a97d-39cb3595c48mr13429981f8f.15.1744107669289;
        Tue, 08 Apr 2025 03:21:09 -0700 (PDT)
Received: from parrot ([105.113.112.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30096889sm14331737f8f.2.2025.04.08.03.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 03:21:09 -0700 (PDT)
From: Richard Akintola <princerichard17a@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Akintola <princerichard17a@gmail.com>
Subject: [PATCH v2 6/8] staging: sm750fb: change sii164IsConnected to snake_case
Date: Tue,  8 Apr 2025 11:20:38 +0100
Message-Id: <05de0fb87ed53015cd01ef9460996597ef1e09c8.1744105389.git.princerichard17a@gmail.com>
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

Change camelCase function name sii164IsConnected to sii164_is_connected
to conform to kernel code styles as reported by checkpatch.pl

CHECK: Avoid camelCase: <sii164IsConnected>

Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 1ce44c50617a..ac1aab77da28 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -22,7 +22,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.get_chip_string = sii164_get_chip_string,
 		.set_power = sii164_set_power,
 		.enable_hot_plug_detection = sii164_enable_hot_plug_detection,
-		.is_connected = sii164IsConnected,
+		.is_connected = sii164_is_connected,
 		.check_interrupt = sii164CheckInterrupt,
 		.clear_interrupt = sii164ClearInterrupt,
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index c8db6ceee9af..6ce15b7816d9 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -350,14 +350,14 @@ void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug)
 }
 
 /*
- *  sii164IsConnected
+ *  sii164_is_connected
  *      Check if the DVI Monitor is connected.
  *
  *  Output:
  *      0   - Not Connected
  *      1   - Connected
  */
-unsigned char sii164IsConnected(void)
+unsigned char sii164_is_connected(void)
 {
 	unsigned char hotPlugValue;
 
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 9e289bf4a78e..90b7ae823a10 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -35,7 +35,7 @@ void sii164_reset_chip(void);
 char *sii164_get_chip_string(void);
 void sii164_set_power(unsigned char powerUp);
 void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug);
-unsigned char sii164IsConnected(void);
+unsigned char sii164_is_connected(void);
 unsigned char sii164CheckInterrupt(void);
 void sii164ClearInterrupt(void);
 #endif
-- 
2.39.5

