Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DBB280333
	for <linux-fbdev@vger.kernel.org>; Tue, 27 May 2025 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365899; cv=none; b=o9/X3tJ9lfDSOwMMQdCjG6rhgelSUfPc4+hbei8Q63YNl+b1lVfopccONT8nAc/PFWtGbX/FyRBd8eFjNfTKnGWjlALwIHePc1H46moYbOuPvoy97RThJ1uwpIq4Bh2kj29eDDreAPLXgnMEIAqL/fjR17NIeY1mZlbstKHbsW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365899; c=relaxed/simple;
	bh=Bvf5XzmK1C7KFxHxm1e5k5vvsnilhL9xB57W1UxAvJw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PcynnNQIA7PJnVibjrGai0X+xY/NjYTdm1OH2FJyaFSVyB2YqFrMvYwkXxWzZ11LHi9o2OS3oYqkOKI6rLG7IoPZX5buP3FhIa73ZBi+IG8csTUwrtGrneavNfXS8psTY5US4ydKz0KIg/1G7YAs1e+Sag4CSKf83r87Oxyqv/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uF8W7Dfi; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uF8W7Dfi"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742c9c92bb1so2654547b3a.3
        for <linux-fbdev@vger.kernel.org>; Tue, 27 May 2025 10:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748365897; x=1748970697; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6I084BRg7r6NYSuT/XB9CcOlGWZUT2LEK0eREcn7WlY=;
        b=uF8W7DfijwAYNb8FmYA0sGajcm1OG6VLxS33JLFdKanmDXfGWTKDFIhIW+E6V75W3k
         aLwnHG2WSIsv3XnPPOTPkA/+Os2SkjwtrvZ2+o1zr1U6dSmtiV7LgeGhqw6hFo75iWR7
         4kF4M8ep+dNaV9gtsM0b/Kic9Pe1kwcBy4MojzGdMvdN20clh0QxOpJaB7DgE0aWiUt0
         rAlAS7KrvObfYM4LYX7WdwxzXNqiCNE7ukfGsxf3BdPP9gRJO/n6b8WJMoO3PL7GUx16
         YlbWslHA1rsrRDExSQlNMD2N+A1rHKmylKrqiWJp1AcFL2W039/lReDQRysr4RbvtoXE
         GLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748365897; x=1748970697;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6I084BRg7r6NYSuT/XB9CcOlGWZUT2LEK0eREcn7WlY=;
        b=r4BcZwapcoCya/6ibU0UZZJ2RrTiikZGPWFpOrRxd/yvGTpRVJRgOEtgVsOnnXhR/W
         pG6euCtJLvlU3pBxbO0ILNMtVIuvZzI5f+wn4RyThvY1R7Y8rcVgU8QvbaXVP0XKKpiL
         JIUanOf8UAoAdu24uObvORSra/wyufcJy8EFEEvPMmGAifmaA+sMFtZi+rtUzDgS36G2
         CXGjMAoUzOxLT+N3+NXC3DkUV9Y6fBFJONAlpBI5tWEp5DKGw/4evGQA/DG/eHhFHZ/9
         OaAhPURIzMHvu+7ohojVO2N/mMNjq7znoPTD9RnEsSXcsnbqZXx+vy8wBZKPI5Y+y29e
         Z5eg==
X-Forwarded-Encrypted: i=1; AJvYcCWkiFPZNKngHWfWGaBuYOqyeHBTEFJkOF8cblqHjvrXnipyfXaI7E86WvSaMosJ2A8IJKYwgqUEphcabw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx71sltSZUQYZcL5HMvcNIyM2m8JqnU8RarrEaS5v7O9jSAmITw
	ucJ5+0aFB7nGmyw9kErFLNXCcd9Blw6+Ox0aNO4rH1inLzehEb83OHvlp3Wbme0eWDxNlhHHb7o
	qkbs9sI5zRSLUmB2GQsAEcw==
X-Google-Smtp-Source: AGHT+IGZJsWT+MI+7toTUBwc8TwoPdXf5QX/ZfY+HuOurMgYLS6kCgj3PSDcttemfwybHe/5BIi9lzwqWp0FaNq9
X-Received: from pfbko5.prod.google.com ([2002:a05:6a00:4605:b0:740:555:f7af])
 (user=ericflorin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1822:b0:742:a5f2:9c51 with SMTP id d2e1a72fcca58-745fe084addmr20441201b3a.16.1748365897406;
 Tue, 27 May 2025 10:11:37 -0700 (PDT)
Date: Tue, 27 May 2025 10:11:26 -0700
In-Reply-To: <cover.1748365488.git.ericflorin@google.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1748365488.git.ericflorin@google.com>
X-Mailer: git-send-email 2.49.0.1164.gab81da1b16-goog
Message-ID: <5250c76b824f133c04135b0d82b18d85cd958852.1748365488.git.ericflorin@google.com>
Subject: [PATCH 4/6] staging: sm750fb: rename `dPitch` parameter
From: Eric Florin <ericflorin@google.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Eric Florin <ericflorin@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename `dPitch` to `d_pitch` in `sm750_hw_copyarea` to conform with
kernel style guidelines as reported by checkpatch.pl

CHECK: Avoid CamelCase: <dPitch>

Signed-off-by: Eric Florin <ericflorin@google.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index e5f1f021768b..ea64e10d4814 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -137,7 +137,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @sx: Starting x coordinate of source surface
  * @sy: Starting y coordinate of source surface
  * @d_base: Address of destination: offset in frame buffer
- * @dPitch: Pitch value of destination surface in BYTE
+ * @d_pitch: Pitch value of destination surface in BYTE
  * @Bpp: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
@@ -148,7 +148,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int s_base, unsigned int s_pitch,
 		      unsigned int sx, unsigned int sy,
-		      unsigned int d_base, unsigned int dPitch,
+		      unsigned int d_base, unsigned int d_pitch,
 		      unsigned int Bpp, unsigned int dx, unsigned int dy,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2)
@@ -160,7 +160,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	de_ctrl = 0;
 
 	/* If source and destination are the same surface, need to check for overlay cases */
-	if (s_base == d_base && s_pitch == dPitch) {
+	if (s_base == d_base && s_pitch == d_pitch) {
 		/* Determine direction of operation */
 		if (sy < dy) {
 			/*  +----------+
@@ -249,7 +249,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * pixel values. Need Byte to pixel conversion.
 	 */
 	write_dpr(accel, DE_PITCH,
-		  ((dPitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
+		  ((d_pitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
 		  (s_pitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
@@ -259,7 +259,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * for a given point.
 	 */
 	write_dpr(accel, DE_WINDOW_WIDTH,
-		  ((dPitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
+		  ((d_pitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
 		  (s_pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
 
-- 
2.49.0.1151.ga128411c76-goog

