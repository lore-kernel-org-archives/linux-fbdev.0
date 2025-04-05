Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540A21CD1F;
	Sat,  5 Apr 2025 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743850137; cv=none; b=kLJbTnHaS8ow2UYP/BXWByxwqQvFSnMqAMpGy6iWRen53ypfcmnOEpr4Up8B32xVoDkLmv5r75wQDptyN7rfKeecWc1Wp1Rtz7EjpzARYepv/1NvUi9t8ohrswLOJtrafRe+3U0cBIregU0orVp9L81vcuWIJRH3DCM/ZcuM8Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743850137; c=relaxed/simple;
	bh=+7dT3tL82Twj4medpCe66/0q0Wl1ZErhjrtaxQu867M=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=PuMwUBUtaPL6lNyE4SDB0mNhqhu7QSmua+N7moy9+pZXDyAIBssu6E3AVOvK5894NlFdYGDaXoW4CZMvbstjYpyOiSmVQNw4n7saeEZp0z60CqEAL1Ou/1tmcnUmmSkkabeoPaYuhMvkGo//W8zezwBVhq9MqQYWZzI8qOjsVfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK3+IQYu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK3+IQYu"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf848528aso22831855e9.2;
        Sat, 05 Apr 2025 03:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743850133; x=1744454933; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4QDk5t1ncy92IlUqUOHalwkPhSsIRI8ajRfXHeyssg=;
        b=dK3+IQYuyNBvz8C1yiYqSJvFG7cGfW590qzkat8/4T9eoAQyHzRGkxcaLcvkgBwVZD
         rDy35aYhjYq27zL/QzPYPvAyFp7dM5puJKBsWFB6byI8axJtJ4s9PwQBVN2OcOumnd/U
         neoHoF+k9wpHmPp/SJGrRTJCzalce6GabfkG7ayvaltKfm4YpOxRC58mAPFDytkjeZrm
         FbRZFF47pcDOLSJ4ECRlgGDhYdtDvlUpP5Zb6fY156WJpVik92jIt1xRMzhyyLDnrzJR
         xaN2kt4g8t7VwtWaYo9YHTXMaalLI4CDJmb+WyDXFriuyC7MXak4FaYV4xujQeumbEEx
         EBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743850133; x=1744454933;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4QDk5t1ncy92IlUqUOHalwkPhSsIRI8ajRfXHeyssg=;
        b=sVYBCj0E+vyMMvUVjoh9ikV4KkA9hXuwFXmmuxCQj9RyistYJKOYHhsUynGlH5OJrW
         1KGllvTWxpTZwdLohxSglSbWyxKwpizEfaJdfBCJ2I0Da1TzG6vvDCyzTu5YMSHCTxRl
         tebqIUcmAOr7cBzVWLRgVGCnOk8AjdKSm+3r1BDqc8KKdNid8KNU398hX91Q1MTTnYcI
         H6bHcv/UE5fsw3TCNIk8VA7iXyS+ZIjt+rSWMWzcJYcV97yx6CMRUzzEv6LUDwp+TwyK
         uQRvGL/BqCt8JbD6Bn/q3HCaDWOV+XqOKcnHTwnSRhwJP/LChyMAguMCkogZWcUNi5wF
         FPWw==
X-Forwarded-Encrypted: i=1; AJvYcCVepb1fjM0CGgcYhAQj8xsLH35OwU+CHJfCm+wGX5JqcPw1FY5oezqYo1GkfH9bdnY1fcF/kY27ofE3Uw==@vger.kernel.org, AJvYcCWlPrUi0g59JYa1dvmBeJA00eFUiHSBSTMilQ7Mcd4UjPlENGlIvhXvYvPz/SUpWFTRID5w2/zssJPnGrYU@vger.kernel.org
X-Gm-Message-State: AOJu0YwWP57usCvxYsMWkmdAkJn8UdPhXGq3e5nD8Rx2lFNMphxT+MSc
	0+E6bdEjOJllKUoj0bbBWuUT6N0V7Xn9dEQGl1TzdOor3DYPNGj1
X-Gm-Gg: ASbGncv+oIcjoiZQh/0QMJfJdk0edHeGezLeRkwevHWmFLU1WQ+nm0XxDdsCMz7RedA
	sbgXc7F28rw5hJZ6/htMgtHN6XJDu7GJ2jq3YjffQed+lsR9zunwGSErao6KxcUJn1bzCl/zEW5
	ULfocvKvY5GYmMefz1POaX3q1YEPr1XVp3BbP7GO1PFv2ChpJcCZs3KULiSZv9aXcbV4XaiYSZn
	VlzgXVC/iGK7kUOIjb5M5IPfcz46d3jVUNsmZAFWp9oM7fSPtL+vOvyLVdnA9XEwEeFSgwOSB6x
	hb9iJB4Dirglte1EBXmfTbsuSQ==
X-Google-Smtp-Source: AGHT+IHwf8Js/My2J8UMQBuLVCW//I/axSLebBS84eyKeVWEDa9vUAPCE1NZ4QHWUnhmQDRLWBVyJA==
X-Received: by 2002:a05:600c:34ca:b0:43d:49eb:9675 with SMTP id 5b1f17b1804b1-43ee0768b1cmr22034185e9.22.1743850133238;
        Sat, 05 Apr 2025 03:48:53 -0700 (PDT)
Received: from parrot ([105.112.71.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1662feesm72260565e9.12.2025.04.05.03.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 03:48:52 -0700 (PDT)
Message-ID: <67f10a94.050a0220.146fef.20e1@mx.google.com>
X-Google-Original-Message-ID: <Z_EKkvJFg8LV-JQA@princerichard17a@gmail.com>
Date: Sat, 5 Apr 2025 11:48:50 +0100
From: Richard Akintola <princerichard17a@gmail.com>
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Cc: julia.lawall@inria.fr, princerichard17a@gmail.com
Subject: [PATCH 4/8] staging: sm750fb: change sii164GetChipString to
 snake_case
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

