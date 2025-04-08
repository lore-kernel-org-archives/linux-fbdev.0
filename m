Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9236826B2B8;
	Tue,  8 Apr 2025 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107676; cv=none; b=CbBFPtZTcDwcXMn/ROyA2nsqVISxP9Ma5/67WMsiaQVRCZv6KPzou2sZVwpRCPah5MLeXZSV20mdU+53gso3Tt7bWCSA2CwLVc4vAh/5OajfPzwhvdj91bbeB+xb4m3hS9KYyWcQemxnHcuauIKSXD5Gc7ic1ER5rO9U9xxc58o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107676; c=relaxed/simple;
	bh=JHgSmpHywThLvhaNGwqkN6rlBmIZHywWloaU6MKIwBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EiOMqUljKncH0Uwyrv1Xib6yoc4u6IfE4FZHAd5KuDSW1vDrD1HjdTWv2ztSm7tY2YIlsQuwyU0NDdpN4F5SglNbCnOeDmte7BvhogVlkLcxYUujLb1k8teg1LKYqJwKSmWhKvGL2ZMVhr67/jcj2Fnlpr6zX/mPQKaQ9HpeaAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFWOg7cX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFWOg7cX"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so58431235e9.3;
        Tue, 08 Apr 2025 03:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744107673; x=1744712473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAIrh/4WE88oUvyzDDtUAXVVh7UEV5wee/SgtjWD0Rc=;
        b=SFWOg7cXRSXcC7PIjzN8Pil5DSbloOkxycP3EwH9zpontsc0FC6fNtvqJXoiLnQh3O
         iBbjTe/32M0TFks2A08+GCYOrvvUph1bQM+emd1uNLaN5jOsyDrTV5KDh7KrgmQEICuc
         xGTQ1mveAff/ltb+8GxW1YwWm4nLTKgqasZXb9v5zrIYBofaiNIUV7P5n3tAzRGNtofN
         SICH8xB4ONdbn4CxfFvpT681sZ3P2eI1nvpzuLai1N3MZKBpWoTXsD50/HbF6+42uu66
         lgIE7QYuwN8cltK79LVLSiHOaKKhk9zyP2tnzkGiJC70Tif4bdeK+/sR2gW6hR1ngT+U
         ofcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744107673; x=1744712473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAIrh/4WE88oUvyzDDtUAXVVh7UEV5wee/SgtjWD0Rc=;
        b=nxk6ChmOw6QYG5qhf6h12wMAXuemKoOKuziDTjlYvFPmC8+GLkkY7dndjwiiQza6kJ
         eRl3oIell+d3WilL3Po1oExIGG2XJGxp/z37kRDN6kvw/76KqtRxjmQL+g8uxFhmAVD9
         LNwrD62C3syDn3HKqILvDAk+lssjU4iEPNtGqfpN+U9wWM3/CIlHbReXRfwxQ/QbVJ4J
         XCSZ/AC2+3zwRAMRjXcHEbDvEHaF54uPr/MiB235WSicjE4CI+C5V3y7gLSI3kSac29W
         7On3hJwDZePl5zEEbg4j4TEKwmx3L8TydzHTLlVNYCpWx4FbsHQgBledifB3/q/NAYcm
         e2LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp5O3c1tQsZ39IKRcvUfFpCVdOuEQEyC2MGZUnLcDyoWmygW9wRTMmH4s/UtmPISamo6PMksgq0233YqhO@vger.kernel.org, AJvYcCWoQaueCgB+FycSsh0h+OMX1DDU1VsXN2nrxwkUaG19kkOQBHCh3jjAeCQMnKapSHX1eYsJLcxn0i0Osg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWVaJJ0Y7I6HUAddK/xZQ4o+feCnAa89t4y31sHGUvjEWfG+VY
	o0xGip5C+Zk2ALN9LiUDBzA9NJ0A+sb4zWdp4+fPm7do38pWn9om
X-Gm-Gg: ASbGnctFi0y8E5ktXLytfVU8FwOoBwkspYBynsHuVDtUSI7mkwr1IG+b7lT/9k+Z/qL
	mpDwsq5H53/tzkbsm1QwTrUOD9hTIjMU1f6k3Pf2c93FhoQ0a+dZdIyynvEI3NFkzJ7vUqMCeFN
	AsPaLjZFlCS53bFH1wVjK4XkjhuM3DKEcYe+tlE1IE1pxhaiiLt68tSCtQGvVJe1qWsHuz6SLz6
	UcACqSTAexhozs+k0Qnz/WuXtm1jKQCVNvCRn4J3UFExbBOOn+Csbul6vobQfqzn0fewiZq7DMW
	liOruR/8i3jiGLBZHiK5APE9I5w=
X-Google-Smtp-Source: AGHT+IEVvLWR5puwGmIhIK0h2QSC6EpbRXEsJwHX8+Yi8eRbzozYZ7hLPVlfE/o/gbWcfoFK+dtQrA==
X-Received: by 2002:a7b:cb42:0:b0:43d:fa59:bcee with SMTP id 5b1f17b1804b1-43edf4581d1mr71419705e9.33.1744107672582;
        Tue, 08 Apr 2025 03:21:12 -0700 (PDT)
Received: from parrot ([105.113.112.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a8952sm156083585e9.10.2025.04.08.03.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 03:21:12 -0700 (PDT)
From: Richard Akintola <princerichard17a@gmail.com>
To: outreachy@lists.linux.dev
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Akintola <princerichard17a@gmail.com>
Subject: [PATCH v2 7/8] staging: sm750fb: change sii164CheckInterrupt to snake_case
Date: Tue,  8 Apr 2025 11:20:39 +0100
Message-Id: <c5c01f1840ca37c24fcca7bff4b09adba37c3a7f.1744105389.git.princerichard17a@gmail.com>
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

Change camelCase function name sii164CheckInterrupt to
sii164_check_interrupt in order to conform to kernel code styles
as reported by checkpatch.pl

CHECK: Avoid camelCase: <sii164CheckInterrupt>

Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index ac1aab77da28..1def02be4cce 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -23,7 +23,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.set_power = sii164_set_power,
 		.enable_hot_plug_detection = sii164_enable_hot_plug_detection,
 		.is_connected = sii164_is_connected,
-		.check_interrupt = sii164CheckInterrupt,
+		.check_interrupt = sii164_check_interrupt,
 		.clear_interrupt = sii164ClearInterrupt,
 #endif
 	},
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 6ce15b7816d9..aebde3d8b903 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -370,14 +370,14 @@ unsigned char sii164_is_connected(void)
 }
 
 /*
- *  sii164CheckInterrupt
+ *  sii164_check_interrupt
  *      Checks if interrupt has occurred.
  *
  *  Output:
  *      0   - No interrupt
  *      1   - Interrupt occurs
  */
-unsigned char sii164CheckInterrupt(void)
+unsigned char sii164_check_interrupt(void)
 {
 	unsigned char detectReg;
 
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 90b7ae823a10..aa3f34c13979 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -36,7 +36,7 @@ char *sii164_get_chip_string(void);
 void sii164_set_power(unsigned char powerUp);
 void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug);
 unsigned char sii164_is_connected(void);
-unsigned char sii164CheckInterrupt(void);
+unsigned char sii164_check_interrupt(void);
 void sii164ClearInterrupt(void);
 #endif
 /*
-- 
2.39.5

