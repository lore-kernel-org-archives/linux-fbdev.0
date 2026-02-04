Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B7F352937
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219578; cv=none; b=uSL1OAOpOtNa5cgNFwOP6MBYZNN5591yu4k2DHFlpnLHgDHFjb7SoGYKE70a5psf5RgLcfIDkIJo4udHTF4u+wDMO+Y61u5h7VxHrw1ZtnCwafLtt0oIE3+bUXUv6xy/xJwKAKReqg2lFMKUbjH+rMJSRr2uS8zTn2R2UZq0dOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219578; c=relaxed/simple;
	bh=yNyoJ5AhNfMEoR0z+MIXzwexmhFP/LF1Uj0/9f8QB7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d+/OscEBPuwcJMSXbvjyIb1JqL1nCFBYTI5QleKLQXpg+d3KCMu6DOwvQyNYFd77pGlZgUK7Ibhsxev8QnnedICwtoj3JnBIeplUn9HMNehw7u0K8jyL4k53ztQKTUKlZenIlgAdKkVlWIHj9HMfxCHO192uysGD/U7r129My9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaxFY85X; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaxFY85X"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4805ef35864so61918045e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 07:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770219576; x=1770824376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jk10eGunB1uJKb8jAOCmTCvnvS5rA0nvykd8EFnZG7Y=;
        b=OaxFY85XOjy4JZd1pDjjCJuomtqk0f2yNpMPFaLpavjALQ00CDTpC6F2HHC6uZrD3K
         NYE7psDMdvNE0+56EoS3CxMvGSXQvO5Rg9i8pn63ch+gfqKDTFV3eg7BiYPB+iguyyIz
         p/IoJxE8cmXgk2OKh/Ts+PZKYMp7NLMV8EqHNgHXmeEHmORgGAFPon1RPOB3zEB0UJ0S
         6Rem6kZOCZJfDz344XJrdAVQjTjEgjm0DbvfEJ53FqWrgIFuYh9lFygyYcbxxafxJeoH
         vrpgoRvDifmGa13A40ID0rpVwuJeW+O1ek5bBNXAcOn2WD3QoHdrMubbKZXHfYJliwPD
         jiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770219576; x=1770824376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jk10eGunB1uJKb8jAOCmTCvnvS5rA0nvykd8EFnZG7Y=;
        b=iUTCLQJFNJRtwGotHqr20pVHCVke4kdNEtZKaF+k2apgbA3rNAees6mp++HGsxJW7m
         fVmoFddZtPtbmfm54NVNAkV6JYvu16CgAm6qdD0EjIFbG8xfvfzHKKmg125kbb9LtBe0
         QaU9HazybqUaYFueqrixbKCsm7+aAahJpyPmjY79LfO6I8yJd2W5IeB1C/yyC77000mg
         RMyGMhYI3xyszcJpKu3lBCO6CZoYCWrZIyxAL7Ew9OM8WZrMsp9fGt5GT2CtCl15M4yQ
         KWKXO0AqRGtesZyOKkgA6iiX0o6EdCcCmnQIUyNE3xy6JKe56Y30BYt3MiCPFFQ3Iihf
         IaHg==
X-Gm-Message-State: AOJu0Yyt6kBw2r1dg8Z7otcZNap7UImk4WGaccIQ0GCZpX7303t3RRmi
	/zEAYdqFBQnavgCK6od2NkxHexXFSVVtd6nKKrGOEgzuY6kGxq7DXxoG
X-Gm-Gg: AZuq6aL21y9AToddPer1E3U3xEOK3VOosusJby2kVjTO1Qi3IT2sAZN7mwxt7EWtilr
	V1QR+3yygWK+6UsZqif/fV5yKPWABqmv56PbloPnjVuJDF0HOpbI/8MoK+C4qAm2DoVFst1f1j0
	kQ0lXsr/u6vRJbUbThEt4CjB6ADk5FRXpPyKqYns5u7j2xmOca0s30qTPgjHNGf5UQVRw0caD3l
	GKQxLyqlDnURSvp6ugMFJzIe3t9fHV2+PHwBR+BoZk2r8qE6c/PIKH/Af28KT9PecWv8fseeP1M
	LEhiNBxYwnowhnWwdWkLrmUNF7tSrq8sO0/9i+xpaBUJK1URFQZG+zZaUFcw5LJTHol0sfITXDP
	zORiKPaW/ID2FAPmobiHCu5cp81UvYHbKzGQQ5X8XzB0kjqspGaa4oG6+r5WvL6Yr3IYJXxYiB1
	N+TjraeUPKfBi3
X-Received: by 2002:a05:600c:c163:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-4830e988f3amr50683105e9.24.1770219576301;
        Wed, 04 Feb 2026 07:39:36 -0800 (PST)
Received: from ubuntu.. ([46.31.101.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4361805813asm6930407f8f.27.2026.02.04.07.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 07:39:35 -0800 (PST)
From: Sarah Schwartz <sarah.schwartz025@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sarah Schwartz <sarah.schwartz025@gmail.com>
Subject: [PATCH] staging: sm750fb: fix CamelCase warning for dBase
Date: Wed,  4 Feb 2026 15:38:56 +0000
Message-ID: <20260204153856.23277-1-sarah.schwartz025@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable dBase to d_base to fix a CamelCase warning reported by checkpath.pl
This aligns the code with the Linux kernel coding style.

Signed-off-by: Sarah Schwartz <sarah.schwartz025@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 046b9282b..c77b0fe3b 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -136,7 +136,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @sPitch: Pitch value of source surface in BYTE
  * @sx: Starting x coordinate of source surface
  * @sy: Starting y coordinate of source surface
- * @dBase: Address of destination: offset in frame buffer
+ * @d_base: Address of destination: offset in frame buffer
  * @dPitch: Pitch value of destination surface in BYTE
  * @Bpp: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
@@ -148,7 +148,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int sBase, unsigned int sPitch,
 		      unsigned int sx, unsigned int sy,
-		      unsigned int dBase, unsigned int dPitch,
+		      unsigned int d_base, unsigned int dPitch,
 		      unsigned int Bpp, unsigned int dx, unsigned int dy,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2)
@@ -160,7 +160,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	de_ctrl = 0;
 
 	/* If source and destination are the same surface, need to check for overlay cases */
-	if (sBase == dBase && sPitch == dPitch) {
+	if (sBase == d_base && sPitch == dPitch) {
 		/* Determine direction of operation */
 		if (sy < dy) {
 			/*  +----------+
@@ -241,7 +241,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 * It is an address offset (128 bit aligned)
 	 * from the beginning of frame buffer.
 	 */
-	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dBase); /* dpr44 */
+	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, d_base); /* dpr44 */
 
 	/*
 	 * Program pitch (distance between the 1st points of two adjacent lines).
@@ -304,7 +304,7 @@ static unsigned int de_get_transparency(struct lynx_accel *accel)
  *	      and -ive mean button up
  * @startBit: Mono data can start at any bit in a byte, this value should be
  *	      0 to 7
- * @dBase: Address of destination: offset in frame buffer
+ * @d_base: Address of destination: offset in frame buffer
  * @dPitch: Pitch value of destination surface in BYTE
  * @bytePerPixel: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
@@ -316,7 +316,7 @@ static unsigned int de_get_transparency(struct lynx_accel *accel)
  * @rop2: ROP value
  */
 int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
-		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
+		       u32 srcDelta, u32 startBit, u32 d_base, u32 dPitch,
 		       u32 bytePerPixel, u32 dx, u32 dy, u32 width,
 		       u32 height, u32 fColor, u32 bColor, u32 rop2)
 {
@@ -345,7 +345,7 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
 	 * It is an address offset (128 bit aligned)
 	 * from the beginning of frame buffer.
 	 */
-	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dBase);
+	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, d_base);
 
 	/*
 	 * Program pitch (distance between the 1st points of two adjacent
-- 
2.43.0

