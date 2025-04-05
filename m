Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ED01C8FD6;
	Sat,  5 Apr 2025 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743852862; cv=none; b=pBIQRnCpASTb/ljjE6rPFGyUgwgpYYajDCkiFU46OuKxCrOoeyByMx2SLnS3IEO6xfNrsEBxPrWBXZKXqYewkKguyONxB7fkGPrzCNIshMZ5KopYT1Pe8KNiT/kL5f6DBqT6aXGtenSQq7yfZ00wma+b8CCgDyWe/4oBAPnJUIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743852862; c=relaxed/simple;
	bh=JHgSmpHywThLvhaNGwqkN6rlBmIZHywWloaU6MKIwBE=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=QSuBjA5oLzVm1lztxwH87JxmXOxarUVhsQVbvZFCBllVoBwzMnniFrZCSWhkjUfDZ7OVL8iaR9LQhUEJehlD0C+zHJ/S03eEeQtNvG7hzTDE9B1ld8CvSbxH96en+9B9iyf+kVDokznSx0mlwviSPANBBnc50v/TlH2kjgvhRf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKXS9lZf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKXS9lZf"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43edb40f357so8264335e9.0;
        Sat, 05 Apr 2025 04:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743852859; x=1744457659; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qAIrh/4WE88oUvyzDDtUAXVVh7UEV5wee/SgtjWD0Rc=;
        b=WKXS9lZfXvwwMV1KvvOPnD1KxcLziu9YoQSIa0jitqCInDG1c8dMEjZbOi2E6PF7fF
         JaXyvaKMwoQ/u7TU8X21CIoLCa00Wg94R/vNwoTM7WcmJe4sZv69XAeG970Wj2NolzuM
         ipXRWGPg5DKBCKp82E9vZYl5XVs8VUv6tAXnL+k4/ozaVkIOrB6gm0DYFVE+jABVzctk
         n+5o0ISjJIsmA+90Ftba7NN+5QjUEowpjth5SqXOC6pjMZl8LdfUUP0CPBzU6yS343O5
         x4v51/txq7RSiJt8TFXnQgfvN9IbgxBmHsPYxo70c6GugDEioQHkSifsBfhCk0Q212xs
         XoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743852859; x=1744457659;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qAIrh/4WE88oUvyzDDtUAXVVh7UEV5wee/SgtjWD0Rc=;
        b=xTbxF9c6qm1Ibple0Agh9cwVo5kfTZjh4HTkbUqOpwgSeJULvl41PMv+4GUeKfI6xS
         29/v3/BIqFzu8vvA25pXZk5lSWu5oLZBhsGDZxhRcHMqFZyxSlChhH1njqX/BuivqY3P
         2O8GbtqBP75z+AzK0sZhlDTC3Pzu7QaO8PkP9BAzSRA+q/jDWG7jBKcC7Wdxo06/2d9s
         15YNd0k/SBgZi4bhwV50AdjAiJ3ThJtSWYjsdwv2uiEUxhRIyGttRy/kuzHNL0kNNocm
         KKdtQ2CxkLAHM0CPxFQr+1jWd4zpyrPNzjruMWGT6gPt+MPWaXEUZxlPPVXbksvGbDJk
         1RyA==
X-Forwarded-Encrypted: i=1; AJvYcCVbCWexPedCnq3iIkChAvkRE2QTPlxAoUnRGRKegPhsktfXRLuBWmC5yMXR2gTsLQOkvdwooRaTsEEkTg==@vger.kernel.org, AJvYcCW5NdZ/4kwZhtuNRpJZNcspAEwFOyFRWO6IO79T8nERP1XqObY/UXw4Zd6nBVs9oySUXpOUX5zJADN8e73W@vger.kernel.org
X-Gm-Message-State: AOJu0YwXrgFBAcf6eRHLjvxeqiTurVnBxuLaY20afIg48XjxXGM5tRGl
	PYkBpE9vcV7eDemlFdQsjgrsQTrqdycbD5Fprjs1EwrIyICzBgQhDiiDfa5o3sw=
X-Gm-Gg: ASbGnct1D7vRllxe2+ODWbYOnYk/6UIO59bs++XxfSH23qMAD8KTYm/0bqKw4100F7p
	9v5qnITu8g7LwUeThLQuTKECH3TQm6LvZo7tmdFluAebpOapkEfQkjik/uKeCYYoDk6NnnULTin
	cOoJROZfezcCfhyh1lMY2qcrjKSIYag1xnr9cO4uuqC7AnCR6DujdA1GgMK2xY8XHQa7pojWaKB
	wpU03yrPAn8IfEB8v+Xk7aSHzg1cvrBUZ8jfDzxz2swEaW/D3QvL4SXGXu7J9s9yLq0Gv/j+wy9
	6Mu9jnCg3yFtXs9H+kBWsJysgw==
X-Google-Smtp-Source: AGHT+IFemI35QNKyVOaqohFG+CqnKVeTP+GFL3QtSqb2csXBz3rnonb0On1EkabRo5049E0IfrLQDQ==
X-Received: by 2002:a05:600c:a4c:b0:43d:1840:a13f with SMTP id 5b1f17b1804b1-43ee076ca6bmr13194675e9.25.1743852858882;
        Sat, 05 Apr 2025 04:34:18 -0700 (PDT)
Received: from parrot ([105.112.71.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30096923sm6749640f8f.17.2025.04.05.04.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 04:34:18 -0700 (PDT)
Message-ID: <67f1153a.5d0a0220.4e813.17ad@mx.google.com>
X-Google-Original-Message-ID: <Z_EVOA9BY2i9bZiY@princerichard17a@gmail.com>
Date: Sat, 5 Apr 2025 12:34:16 +0100
From: Richard Akintola <princerichard17a@gmail.com>
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Cc: julia.lawall@inria.fr, princerichard17a@gmail.com
Subject: [PATCH 7/8] staging: sm750fb: change sii164CheckInterrupt to
 snake_case
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

