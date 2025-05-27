Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9FB27E1CA
	for <linux-fbdev@vger.kernel.org>; Tue, 27 May 2025 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365895; cv=none; b=gsez2X0/AaEY3PUrXlKld9ef+6g6V7R5pdH4YVGqe7Ph5Nf1twbDe9u5a5V/KFJmhwbdZbk3JeHHA4QNHtGkamN00aZUZOhHH2FsJAPk3P26LWRSHUI9AzbqdOnR86xQVs8lcxAkvdHsSpzXzsGQ4kEiZEsiuRNqmZe6LHmhJZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365895; c=relaxed/simple;
	bh=xRMf5TFiD3IukzwA+3BGS+BrEX4qd2fgpFwrTPSzcOY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T0JYcrNQzSscHbrHzxalDXs0sUnwP3+4AWgGoZgaYjh8LwJ65/cU+pe0M2E/G7kJ9yTDENJdOgdIJqxagJuq9+Nl/3cNEVijYL/mol8Spjif6uHdVJy0jUYCvv1C2yEG+J9apZtv/SPnDcWsJ/foNy1Nm5i41YQCqmt3ALvE7r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fRH4nzOh; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRH4nzOh"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22e7e097ef7so26466625ad.2
        for <linux-fbdev@vger.kernel.org>; Tue, 27 May 2025 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748365893; x=1748970693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGpgHQv1Yjhu2NBPNLoBAvCrufXEESK7KYUZZgAiZNA=;
        b=fRH4nzOh55pr/Z2cuajsgScgvwEXUIlnOPTYNiVs5aOJ6OA9A7WWRfWfa9AlxbfxFz
         fejADglo52pU5xhA8iGUF3KShmAZVKM44UN0gHkrtY1LNO1FTRsQzDc4YpgrcARd78qD
         oMeCAAnVpUPTZKT4h0hRva3hcZluc6akFqtkZW1Ru+E+2w5VuPA7Gev/M6me6/Cqp3be
         q3fTLqdWk6csxFA2IGDwldrqFrkiP12pa0cXfE8hKB+4iBXcd5BLcAd2V9jMNDfOobS9
         rQOVf320Jcuk706iDDpuxb1ZAY9wuToYZHkeHL0L5SMLk26ZCSrmMydm04AOuoex9FG9
         J73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748365893; x=1748970693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGpgHQv1Yjhu2NBPNLoBAvCrufXEESK7KYUZZgAiZNA=;
        b=ir/p0Hff/etnVfokJOEPlQ5u1SGDIWpznMq21ZpXloc3GepeYjUVAPtWHlY+mZGhRX
         NmN5u8pZdCZmgVTv3PZdHaBUriRqm0pOdgxDWJGtZXUfsbq6m3us1GdEnnQF+8k+kWVk
         xu/QUlDjE7kXXQ39CgM98b2RGs92Jp3z1SthriT0oB7vbwn9Gzh+pqANjPmJguxTbMT+
         HSKRWAiwzgqFvdLRvevksKE8i4JEwTVAd0v4lmh683Qe8adWZojgzov2tvSid4zG09oA
         AtZmRnNGOGtVgbjqcg94O1v349T5WzhRKcqb+7hBvlAJJopM22OMhJGQoIuGwmTuW78R
         6AfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBWDql94cWHhTw/Z6sf/9Hdoy5btvnjMURYX0Hk92bvN45P6YloR6pCDMTBlND+V6bcQnwAC6kod7Rrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnsyRHUVrabG6MUhF2hevLmNlqdOOLF+0jNXafpmq5C+/o061u
	0JzRBxIph9Ym2zojMTYbRwOqDDvchvsHshEkNcLrVeHfDajda5AA7If2H2AqAB6eekG4jWyAxix
	AYzGUfhyqNzlI+W3oIJl/9w==
X-Google-Smtp-Source: AGHT+IE3WTlFx1duweMWUtRWUZ+stTGECKFWb4JdL2WHNP9bk0YeoZVjs0fdXgZHMKS+hrjElIbb6qMFX7sMB52f
X-Received: from plbld15.prod.google.com ([2002:a17:902:facf:b0:234:1b84:9778])
 (user=ericflorin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3d0e:b0:22e:59cc:a44e with SMTP id d9443c01a7336-23414fce054mr185474395ad.44.1748365892870;
 Tue, 27 May 2025 10:11:32 -0700 (PDT)
Date: Tue, 27 May 2025 10:11:23 -0700
In-Reply-To: <cover.1748365488.git.ericflorin@google.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1748365488.git.ericflorin@google.com>
X-Mailer: git-send-email 2.49.0.1164.gab81da1b16-goog
Message-ID: <61e6984331cc7ff88a9f8207e187cd5b9ffd9c63.1748365488.git.ericflorin@google.com>
Subject: [PATCH 1/6] staging: sm750fb: rename `sBase` parameter
From: Eric Florin <ericflorin@google.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Eric Florin <ericflorin@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename `sBase` to `s_base` in `sm750_hw_copyarea` to conform with style
guidelines as reported by checkpatch.pl

CHECK: Avoid CamelCase: <sBase>

Signed-off-by: Eric Florin <ericflorin@google.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 44b9e3fe3a41..74e4be8103ac 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -132,7 +132,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 /**
  * sm750_hw_copyarea
  * @accel: Acceleration device data
- * @sBase: Address of source: offset in frame buffer
+ * @s_base: Address of source: offset in frame buffer
  * @sPitch: Pitch value of source surface in BYTE
  * @sx: Starting x coordinate of source surface
  * @sy: Starting y coordinate of source surface
@@ -146,7 +146,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @rop2: ROP value
  */
 int sm750_hw_copyarea(struct lynx_accel *accel,
-		      unsigned int sBase, unsigned int sPitch,
+		      unsigned int s_base, unsigned int sPitch,
 		      unsigned int sx, unsigned int sy,
 		      unsigned int dBase, unsigned int dPitch,
 		      unsigned int Bpp, unsigned int dx, unsigned int dy,
@@ -160,7 +160,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	de_ctrl = 0;
 
 	/* If source and destination are the same surface, need to check for overlay cases */
-	if (sBase == dBase && sPitch == dPitch) {
+	if (s_base == dBase && sPitch == dPitch) {
 		/* Determine direction of operation */
 		if (sy < dy) {
 			/*  +----------+
@@ -234,7 +234,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * It is an address offset (128 bit aligned)
 	 * from the beginning of frame buffer.
 	 */
-	write_dpr(accel, DE_WINDOW_SOURCE_BASE, sBase); /* dpr40 */
+	write_dpr(accel, DE_WINDOW_SOURCE_BASE, s_base); /* dpr40 */
 
 	/*
 	 * 2D Destination Base.
-- 
2.49.0.1151.ga128411c76-goog

