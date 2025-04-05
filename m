Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261421917D0;
	Sat,  5 Apr 2025 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743852144; cv=none; b=ZrG/+RmiF78mv6l3+lsg11MHrHNZq3rzHHKij97TKXGJ72jn7qOd3O9v0+F6fKq2WHXtqwdGzAXfptA5rsqGt0yTGh/0WTY+jogkp/IK7Rk0QF5Tj2ZKUiMZbrZNItSlqTfW4EonzN4NqgFMwgs5SEh5f9EKwqsh0duWcpEX0+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743852144; c=relaxed/simple;
	bh=z46nsSq1v/0fvClzA4Zas3TDcqFixPfx6NddUMaqlWc=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=eKVruMhAD+qF0dGiAkgiMXhXUZUjzD1PxDalW2IvHPFy+hxWE09G8eZgoFioh5wZhsFqGeEQJm16b3DSd7AbbMOidP2fvR/00QQXiRH1K+uw1YZyghoYuFzz4soA93+Qa8Kw1Y1IOlj8eDhfIjClNN6H2vVNVtjcn+qfdKZml3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYuQT1j2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYuQT1j2"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so18278865e9.1;
        Sat, 05 Apr 2025 04:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743852141; x=1744456941; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pxfh28JgrgsZ43718+Rog7hGuSrWMc3dc3Cy5VLEAE8=;
        b=FYuQT1j2+GuubKz2pmHiORpFL9e/K9/j5VRQ2MDK/FbgMv57wqXGNYFUpAp3rP3g4Y
         oiKOWJFxF1hGDKCjziegZxzRTEIRaywO8gOdAt0X0lSprMX+ksIkD2jRqor6pJ1sCvhc
         WI0/v48duvDpCpfaJpCAStJ84AexzzKNiAYeMELoOxVYj0Tha3Fp9nN4t7dLYbDgVpby
         qncCbk1xg45JrpP6H7XDDfrhY/lu/iKllbv0LXWboJ/8amxpVYXycLJACAF6+tNS+dXb
         QJCfKP5CFXkiK2u4HFSrkpYkpdDxOy4qNUSCfadYDzXSjmEuYH4wxAqz9/hjPgNKYWr/
         O9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743852141; x=1744456941;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pxfh28JgrgsZ43718+Rog7hGuSrWMc3dc3Cy5VLEAE8=;
        b=MJ+LPuEU5z4tCjt8c1x2KoviTqScr7wcef7cXko7fsTlss8xYcHpl3oiUIanFaaTEi
         EU4ALvQaX1rov3fXW94lcAStFUMAiIKY2+ga6o/E9i62C+S8ETnbsmvRoXKq/qcLDxxM
         8JzqOts6fXayX1Qtn1TEoEJZG4gsrRTJ19oda63ymSuspwVx1qOhqiop10pPQG4EgzU/
         Cy6Id/4HZWCauo1FuRC0D7w14kjnvYvTrNFN4vPUb6daxFhDaDKvA7r79AYwqBDk3nke
         dIXNNFLUpthS+U1vlkho0AmBk14upO4vH/BQ+lI5mtS7tNnScLmMaZVc/LZ3CRa9WiLz
         TaKw==
X-Forwarded-Encrypted: i=1; AJvYcCUWKYxgKwh1Gj7mgkd+24GaOcR3fqSdsnIhA1RyUxaKj8ViM2pwrK31X8+mOxVxzCAdnhrQbF+qyuXXCg==@vger.kernel.org, AJvYcCXRyBJcgRZeIEMjB0CYScuqkaXU1yxBfCKZBcg16XzBa+k37eIsPZdbYlfKLaOBZ5GRK9AWLRJxDbyWriE/@vger.kernel.org
X-Gm-Message-State: AOJu0YwKRWQaf0Q9O6lqpPtUO0QRkrcte8/2z+6qbBl/cA+S2acVqkkm
	RtIoioTDFCRWroLaY1cTf/puYPTPp/JyXLRc9uKwz7b1fh+so0d9
X-Gm-Gg: ASbGncuUXP57UXrVxqczuHa1VGLl+xJB/wsAMTXk2ejfPQZvSDf1bjljVOukYQXkkk7
	hb0qnxyaJvBJnR2eUEFzPdylp2v4CmMcwYlXhUO9j8AiMiYh2c1rwCKxrH1QiDBZN8/+q3bPb0F
	jJtVcSqfn0i5pBZp4jwNZ5LVWSsojGfwEtC6rEDff6TCtAtMy7R3JMbOLnL5N5kNRJi6WsiUKDV
	sPGGkKglQtNQFgKCnYLBa/2MIFzRBxDx56ytSm0f/JSXYwy+aD/IEv1pi4FnWf7ih6K3ImoMz6j
	++zuYQVn6UjW+irZztxYnMf6VQ==
X-Google-Smtp-Source: AGHT+IGKKIELTuQ1Fb17LlCqV3DbKkczWXrIUwTeorlfMOhrGCSQC/Kz+zOqIxH5LrBtL8WM/IStRA==
X-Received: by 2002:a05:600c:310b:b0:43d:36c:f24 with SMTP id 5b1f17b1804b1-43ed0bde9bcmr59177915e9.13.1743852141261;
        Sat, 05 Apr 2025 04:22:21 -0700 (PDT)
Received: from parrot ([105.112.71.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1795db7sm75201415e9.25.2025.04.05.04.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 04:22:20 -0700 (PDT)
Message-ID: <67f1126c.050a0220.410e1.52e7@mx.google.com>
X-Google-Original-Message-ID: <Z_ESagGQ_89ThTdb@princerichard17a@gmail.com>
Date: Sat, 5 Apr 2025 12:22:18 +0100
From: Richard Akintola <princerichard17a@gmail.com>
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Cc: julia.lawall@inria.fr, princerichard17a@gmail.com
Subject: [PATCH 6/8] staging: sm750fb: change sii164IsConnected to snake_case
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

