Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F51F19D8BC;
	Sat,  5 Apr 2025 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743849287; cv=none; b=BGdTw0jhr0dINQK5u5qqdKlfOVbZdBmEuJHviauloXuYXRBvk/WA/kqnmJ5LM5VkpXcFUB006HLhiv0d3r1SB/9sE7gL3M+jVl1QtfsIwXsSmyesRLPAgTC2i3dt63/09vx3sDNYU3sm99Ed+e3g8zNUSsM0UI3r29WzJUomrKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743849287; c=relaxed/simple;
	bh=vQj84IzAyMbsqXmdqTC73l509pCAn1/REbFySFYyqoE=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=BdxmOwENpyDIWY93EbQ2e9PxcXpQq4UY8EgXDC8B+ep1BvOK7CE0ZW2kFzlkYPDs6OYrkOkiTZg8x0dxHfT3YtchRZULWrsK5mmEvCf+mv/3q8XVcCRQTCUTefKa8BdLj5TJlapH9INgmDZ0T06j4JmEQB/dccRT+m4WZVvbdVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEGzPu0e; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEGzPu0e"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so28228865e9.3;
        Sat, 05 Apr 2025 03:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743849283; x=1744454083; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zir1NDA8An9XMiM9quRa114yNTaeYbAjAw+vpjLNbb0=;
        b=YEGzPu0eiqv7wSZyoPLb3JdunfIRrGgnEU3qzGFfFjluj1QpUIQq3yAhbYr7zGkd99
         7Q+u5FYz9OUrHKf1DanmSZGzlT9xmkT1N7c/BOugNdEDHKTGYU61ks4LgDN274/nmG4w
         mneqMlvSyzSbRYstmiHWAzwhIInTQyoqZuE8cfl2PMNmcmmyHDPlAg7hfo73r4NI8asx
         sx5jaPm4v8Bs6bZDQhSf3NwTU0VmpDfdIqU2BkdvTSCVX6aj+sY3jyp6QN9U1VOz4TOy
         kDDlg7trrkCYSb+/f9NyLxmNLI5umJfHovzXP75XAaUrYMc1nnByTWOktqRzhXgo8r57
         3VGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743849283; x=1744454083;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zir1NDA8An9XMiM9quRa114yNTaeYbAjAw+vpjLNbb0=;
        b=f75OR6hf9qTL9bZKhAEI4vnRm7B9zEysTpbHIQpigA0Y+TwnOkK+0RECXwyy7DTxiT
         eUFRSDg/s2wIdJ1WSTDtVa66wig5u5TgPJ/lhb7T+JotbXd0gZcgLcWpNl3h4/jG1EQ5
         Ll+cQSI+NQxKEJahb0evEz6bRhBZzpQ9iX3ZgQck9mAKAx9f1IGxvghlTVJNGYFBaA9v
         vx2U0KpVo+eTDQ7C7aAySTSseu5FMbapk9OCQ+G31Jb75Tghu0apki/zJjMLchO4BOBE
         E6rKllfndXwhlJGevixTN5xl5ptX9s67wBylf1iFJJ97LfnQu5sGXA9l+c1J+zNj/D16
         m/Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUCA6XC/8Zm97WdpqiBrpxRIeaFeY6KcwxgI02QTIZo1DCML+TUp6Lw1RTuZGWTUtpy9sJmtb97c7YiSIEb@vger.kernel.org, AJvYcCVg49HmgdHedRq7t1JXFBjDn1+NhH1qqv94emr8OOokuUP+0ptaggo+VMtYmqquBhCchYKEGGgG4LrZbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVze+T9fz97lUER8btYeC1/iNrGtO2y+YGVgwdZPChhQQsTtMp
	g51hQLoCWy7UmU6gxMTCQRv/aJ71oTUrnza6SajoiYAoD6USK+gc
X-Gm-Gg: ASbGncveq+xjbh1tWHP7qObd5D7A70tpIcdEL6vcDicLokb8oU2qes0GpdxId6Um67x
	FNUgV8DDYHJ1sUqQegEgmrtJCNscgef0ynCPqpYM//6fTZQ13WQWFHosXVuSs0noPRgLtwaoOUD
	mTPMzGZzkQRLsioDN0/zG+r8lKd3iDmlZ0krTlDL3b/fpGg9PfpaCMZVGIYjFrEB3xaPb+42gMc
	36z4cfq/mlq6EyreZ3KeGBZBoM5YNnWy/VlM0iptlMZH4j/anOk1bonYcwSwYbuCz9ZwaBRFF4C
	Fv+yUGh0YgBsssaOfz75dXaRtA==
X-Google-Smtp-Source: AGHT+IFW+PCxU83RMGKoX5jqWZE3GsGc0tiWA4M86TTqRF8tPreBQsld3XTsJZwtSgX02+c9xwwgWg==
X-Received: by 2002:a05:600c:3b08:b0:43d:b85:1831 with SMTP id 5b1f17b1804b1-43ecf585cacmr61148015e9.0.1743849283522;
        Sat, 05 Apr 2025 03:34:43 -0700 (PDT)
Received: from parrot ([105.112.71.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34bb7bfsm68117315e9.17.2025.04.05.03.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 03:34:43 -0700 (PDT)
Message-ID: <67f10743.050a0220.34c5be.0d2a@mx.google.com>
X-Google-Original-Message-ID: <Z_EHQCIv8tl1ff0x@princerichard17a@gmail.com>
Date: Sat, 5 Apr 2025 11:34:40 +0100
From: Richard Akintola <princerichard17a@gmail.com>
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Cc: julia.lawall@inria.fr, princerichard17a@gmail.com
Subject: [PATCH 3/8] staging: sm750fb: change sii164SetPower to snake_case
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

