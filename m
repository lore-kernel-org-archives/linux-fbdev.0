Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D888349CC1
	for <linux-fbdev@vger.kernel.org>; Wed, 22 Jul 2026 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743123; cv=none; b=DGkjjf/p+n6QLo2rvkPR9xytPbcIhHiy27hbaP7U3yJQc+gKKo7MYIBuHP3qPvj6lmUdrDVc9w/hKvX3eSQxz2Sx6mtDGyxzbH4NuaffFeD2DYgwr59irH6IgyDPev2wnclCG/2MelYiTq9kcSfSHGQvf4s1ZnHf8R69NMqtN4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743123; c=relaxed/simple;
	bh=ecT2gO/ZzAVIeRznVChrDRyBlm+Tx7VAthNScxo4f4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VeeJjl3E5p7M8tEsH3JivMP0oOhQV4qpVvI1TUTYssLqIW0LQSrHlmfoOiwtQ66P2RZVuTPG40bucg6dS1ymk/0m6K1MrrqgFCaI91wZnl2pFLOsz66ryeTCUNG1xKQS2ltObxeWry8wZFxpSHHyGUpUZ5NbP77wkypdNSdjFYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYZkUzCw; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYZkUzCw"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c96c92c0980so6284126a12.3
        for <linux-fbdev@vger.kernel.org>; Wed, 22 Jul 2026 10:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784743122; x=1785347922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FT23JezC0wXJyWPJrB8NdF3ihbQYF5YfS1BycISojdM=;
        b=gYZkUzCwAEJ+joVKrmVnlq196v/uaTZ9KXol2hoFVMrY4/hnZv3WnSGqvT0igQ8RnJ
         P4VYfgAY27yXJMAyFjJ3ORSTFr0dxwt60mHvN4sSnCLxleGfOfwLzH16NDFs0krPWEAs
         IZxZoUZEw55fvXDRPQQivOtGjJyoerPgbi/L4t/WSzACOR3IJhKO80WJXn4IRCqpNEZH
         B2BP829EcQEKxS8VchopWb7dlgYw1/VaVf2BKj2pAP2ftlLzBfdicwyuDJ92TRrNK2en
         Y+CvEHouIcg9insLEY7D0ei85toXlnyac+EuDmSlhLTx+yYGO7R9RW+A2U7EEOdQ5v6b
         8d0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784743122; x=1785347922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FT23JezC0wXJyWPJrB8NdF3ihbQYF5YfS1BycISojdM=;
        b=XVW2T9aykiDCrChXtiPDmojZOwLddxnKkpT1NoNxMSCDPKa+CMoZ5JewAeTOa63PbQ
         O0wb0FyepjgEhWZBcC3n5N56X61JdILUkPI4XAXYWI4bk0LSEoz8Anfm7GT0Q7xBf1on
         Z5f0ebWTG0UB1aNfHUH3RPO4GpbJvzTGyWcExNPhu/Rkow81z+GN5Umq7SFrPdunQjIa
         Ufi/OEKPAmNjog8mdvzSQmfCYl3aR+4An5Q8LnQYT+J4yGldwL+aWkaoGTrP15LjFxaX
         bOq1P555kIQ+R6YiPoZZsktMFeOY/zpyancaPcKof+35d9Plpu8J59LM2n0EDg/aMk5/
         OcjQ==
X-Gm-Message-State: AOJu0YxJ/S1EU0FBnbwMpH1ETFOnnor+TJc4YIKLMSdZZv3QiEEIeBib
	qv8CD95TTcwBAi2DC70Ntqn6lUfx+lFlYdKOHULDc2mNBG9433Tihxxe
X-Gm-Gg: AR+sD12OU+Lz7J1ajhBPTgoSJSpNF+I817Mk2JcX1WwwNf8Ol1CG5spHOAJVugudzpz
	cmBMHuxX49LYyFeRLjFyueAhwpdi0itgigsndPDV1OOS8NWq0pcS6+hRKP+yCKFJo8bhlLOw69Z
	Fdes3JsjVrvwqQovC8dsGX6G7ULg6r/JJnE4o3QQLt0zCYhIMrTmJHm6BG57vUvpzoXO051h5yN
	JEOtmbWp6aGqCwP2FLFfuyVkIU7rm3HyhWquuqe2UBPCHsYrDWHYXn5qT7jydJ5PQWHBR3jQrLt
	paYyMryfUn9hPEzS1XMiGOZOPj1h72GnB2SAPOAiESn5mJSFH/YX9MK4VProumkNMrhL7vnMXvr
	IlW/lye02QdTL7yXwQfoODkcncF/ig0ZbrfZ1yJn2HfhJycmH3kTK9Ft8z7FG190nWXsIUwQwI1
	XqoA==
X-Received: by 2002:a05:6a20:e292:b0:39f:59c8:f302 with SMTP id adf61e73a8af0-3c3ada195ebmr26645657637.37.1784743121546;
        Wed, 22 Jul 2026 10:58:41 -0700 (PDT)
Received: from PC.. ([103.172.209.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc1a67esm12057690eec.2.2026.07.22.10.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 10:58:40 -0700 (PDT)
From: Mohit Mishra <mishraloopmohit@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mohit Mishra <mishraloopmohit@gmail.com>
Subject: [PATCH 1/2] staging: sm750fb: Remove legacy kernel-doc comments from header
Date: Wed, 22 Jul 2026 23:28:16 +0530
Message-ID: <20260722175817.213235-1-mishraloopmohit@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header file sm750_accel.h contains duplicate kernel-doc comments for
sm750_hw_copyarea and sm750_hw_imageblit. These comments are outdated,
still reference legacy CamelCase parameters, and generate kernel-doc
warnings because they do not document the 'accel' parameter.

Since the correct and updated kernel-doc comments are already present
in the actual implementation file (sm750_accel.c), remove the duplicate
and outdated comments from the header.

Signed-off-by: Mohit Mishra <mishraloopmohit@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.h | 33 ---------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index 25e5703b6774..e98cf8f9fb2e 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -194,21 +194,6 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 		      u32 x, u32 y, u32 width, u32 height,
 		      u32 color, u32 rop);
 
-/**
- * sm750_hm_copyarea
- * @sBase: Address of source: offset in frame buffer
- * @sPitch: Pitch value of source surface in BYTE
- * @sx: Starting x coordinate of source surface
- * @sy: Starting y coordinate of source surface
- * @dBase: Address of destination: offset in frame buffer
- * @dPitch: Pitch value of destination surface in BYTE
- * @bpp: Color depth of destination surface
- * @dx: Starting x coordinate of destination surface
- * @dy: Starting y coordinate of destination surface
- * @width: width of rectangle in pixel value
- * @height: height of rectangle in pixel value
- * @rop2: ROP value
- */
 int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int source_base, unsigned int source_pitch,
 		      unsigned int sx, unsigned int sy,
@@ -217,24 +202,6 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2);
 
-/**
- * sm750_hw_imageblit
- * @pSrcbuf: pointer to start of source buffer in system memory
- * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
- *>-----      and -ive mean button up
- * @startBit: Mono data can start at any bit in a byte, this value should be
- *>-----      0 to 7
- * @dBase: Address of destination: offset in frame buffer
- * @dPitch: Pitch value of destination surface in BYTE
- * @bytePerPixel: Color depth of destination surface
- * @dx: Starting x coordinate of destination surface
- * @dy: Starting y coordinate of destination surface
- * @width: width of rectangle in pixel value
- * @height: height of rectangle in pixel value
- * @fColor: Foreground color (corresponding to a 1 in the monochrome data
- * @bColor: Background color (corresponding to a 0 in the monochrome data
- * @rop2: ROP value
- */
 int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
 		       u32 src_delta, u32 start_bit, u32 dest_base, u32 dest_pitch,
 		       u32 byte_per_pixel, u32 dx, u32 dy, u32 width,
-- 
2.43.0

