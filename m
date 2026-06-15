Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901C51EDA0F
	for <linux-fbdev@vger.kernel.org>; Mon, 15 Jun 2026 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781486952; cv=none; b=AbJFusTLUyWPnWt0H0mXJzdqSh1wLluDuxsXfihS9ihlD6wBkzC/x59cGfUVLgyNXIdx0bj+U6atTQrDsWtSwjW/zG7DYJTM/5MKXvKR7KQqnl0p55SrlS47b8eqso7/9cBGCKV3FfIW2FCL8mIchKC769KF7MtNRoRQn7KsqCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781486952; c=relaxed/simple;
	bh=VoiN+qLBR9B3HeLbsY+CTDz4NWYDpxjoXZy0bpB7eNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TMwNCQpQ0zT68VJlVCeQK7vSZTa7jxNQ4b7+mB6DcO4Z21mqlcSofY/hQoehbu+OPhge0Cc5FnE4Q82UuTDAV1YYXM8wUYYV9t+QmB7E7VeTnAX6mVUn5uucZvrMMzmxy5UiQWoasIjpR1AY7gLA0bYt2pM4NYyTUkEBqOnniIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ri70X0+t; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri70X0+t"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6611689dc10so2778478d50.1
        for <linux-fbdev@vger.kernel.org>; Sun, 14 Jun 2026 18:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781486950; x=1782091750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xTjeij5sLwgES0f9hCPJ9GbQnA+7+YUnwk7xWCwfQo0=;
        b=Ri70X0+tglaEZIfYhbj4KsluS0yJyfJUd7nBGY+tN89ucfiJoU65LFt4I/RQsTb07o
         6Dg2MdUFCSLljT5fD/5EVhpaObjhqu/6UUW8SqIbQDdxLTUyWfQuuAF3/oTtXiV8Isvc
         wbTg0dIegauxT+7OAq+Tv+by4ZfELypnJkLGJaNSnmQvmgbXpkzo3lq1+pjwcGH40ekS
         KeUP+SbQgM7JSJKD1fQt6DiqNxHuFidN1hWStCipKQiKQWUssXPVP/4karzJingV3WJo
         YRuE3FCY0FrCl/8/UtqZQN/8yQHa0TgA2dVEzuEF+mhLkYwJikjrF7LrLFan++TqqWnd
         U8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781486950; x=1782091750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTjeij5sLwgES0f9hCPJ9GbQnA+7+YUnwk7xWCwfQo0=;
        b=X+AI3xWBoXX1hQAwcjXUjhSnPq9gpaTt3FXcNigiMcxhs7kavNOwvhMj6N7VkJINnk
         uey9eah1cprcgtAD0UYZFSBkLx69MG8A/NHsBeGsGCidobYp6O4rz105psXaaBIryn1d
         a/pvAs3llvpz3D7UjZZyHUAmFybo3IqkvBNgVLChK8/QkEvrHy7pnAo6qOCYZBf29bM2
         GiZXi20TOBgiPxgvrcaKjvpULVzTNZtq1G1z/BS0gVfGHc29VqsjMY56J2JjE1s4YEV1
         Z/w98C9DE+y3Nyr/vxtinuEvmG0QftjyHAbJCNgzyonAhUEBn47xcrruSZDbfpjAyS5t
         kq3A==
X-Forwarded-Encrypted: i=1; AFNElJ9QEkJ5DFX7357FjvV91qzRvWrTLyGjSxFp3IRKW2XBz2AAC3XKvQnWSbBDB8H9+QnS5GQb6GFQDyY8Tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAVtNJLDgoR7LyN2raxNlpE50VUpLHWnya1heycF+EbMLQAd/a
	bB+bGYJa5x+fyo0rcSd/PSF3AGS8EAgPUzunoL1+eEXg9YWON7ZOX1k/
X-Gm-Gg: Acq92OG/tt3MOfrRmvJJoHlR5vRMxukytng0lpCEJDXfacm1UD9649pCOkme4aw0Hb+
	qMVRbJXuY1WsM7TJZ4Uivs8A+QvxqyoBimesWLmMozC8gh6MSb3nyBrXeYE2u5CBSR5thSo24rx
	RCx6VCJzwXrboWWqmL5EO2xqsC+z8nO9o8/gLRN44tEtyOYYL0H56kOqomY0cMHnNApiTHRH0Er
	W6vxaMyA8pDTlZoWrirsklzhMlC9649kJxNabjZMqsqoWF2WYEKkf5LdaEIjz5och4v8rMyQIDv
	R5mSLUBYhfTWeuZpCBlATu7ka4YQr8GGTF1afHDNtdETDIeoGvoW38oZn2aKLJd5E7y7GwP30Pl
	azMjJO7ceke9t+Zn+xrkLm8iSZvaWXjjf+O6vp6cQhfjZb4mUVa/6+8i4znBDVqDCApJh59CLPp
	Sqfsu1rDN1SUGQ0KOVSkUYZg==
X-Received: by 2002:a05:690e:4805:b0:660:7b4d:1ac9 with SMTP id 956f58d0204a3-662782e2880mr7271458d50.38.1781486950556;
        Sun, 14 Jun 2026 18:29:10 -0700 (PDT)
Received: from localhost ([69.237.12.115])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66274ae1ce4sm4227521d50.0.2026.06.14.18.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 18:29:08 -0700 (PDT)
From: Noah Adkins <noahcadkins@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org (open list:STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER),
	linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Noah Adkins <noahcadkins@gmail.com>
Subject: [PATCH] staging: sm750fb: convert camelCase parameters to snake_case
Date: Sun, 14 Jun 2026 21:28:38 -0400
Message-ID: <20260615012837.90113-2-noahcadkins@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the camelCase parameters in the 2D acceleration helper
prototypes to snake_case to conform to the kernel coding style
and to make them consistent with the parameter names in the
corresponding implementations.

Issue found by checkpatch.

No functional change.

Signed-off-by: Noah Adkins <noahcadkins@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.h | 37 ++++++++++++++-------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index d15a40cacb84..0efb7cc00050 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -196,12 +196,12 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 
 /**
  * sm750_hm_copyarea
- * @sBase: Address of source: offset in frame buffer
- * @sPitch: Pitch value of source surface in BYTE
+ * @source_base: Address of source: offset in frame buffer
+ * @source_pitch: Pitch value of source surface in BYTE
  * @sx: Starting x coordinate of source surface
  * @sy: Starting y coordinate of source surface
- * @dBase: Address of destination: offset in frame buffer
- * @dPitch: Pitch value of destination surface in BYTE
+ * @dest_base: Address of destination: offset in frame buffer
+ * @dest_pitch: Pitch value of destination surface in BYTE
  * @bpp: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
@@ -210,34 +210,35 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
  * @rop2: ROP value
  */
 int sm750_hw_copyarea(struct lynx_accel *accel,
-		      unsigned int sBase, unsigned int sPitch,
+		      unsigned int source_base, unsigned int source_pitch,
 		      unsigned int sx, unsigned int sy,
-		      unsigned int dBase, unsigned int dPitch,
+		      unsigned int d_base, unsigned int d_pitch,
 		      unsigned int bpp, unsigned int dx, unsigned int dy,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2);
 
 /**
  * sm750_hw_imageblit
- * @pSrcbuf: pointer to start of source buffer in system memory
- * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
+ * @src_buf: pointer to start of source buffer in system memory
+ * @src_delta: Pitch value (in bytes) of the source buffer, +ive means top down
  *>-----      and -ive mean button up
- * @startBit: Mono data can start at any bit in a byte, this value should be
+ * @start_bit: Mono data can start at any bit in a byte, this value should be
  *>-----      0 to 7
- * @dBase: Address of destination: offset in frame buffer
- * @dPitch: Pitch value of destination surface in BYTE
- * @bytePerPixel: Color depth of destination surface
+ * @dest_base: Address of destination: offset in frame buffer
+ * @dest_pitch: Pitch value of destination surface in BYTE
+ * @byte_per_pixel: Color depth of destination surface
  * @dx: Starting x coordinate of destination surface
  * @dy: Starting y coordinate of destination surface
  * @width: width of rectangle in pixel value
  * @height: height of rectangle in pixel value
- * @fColor: Foreground color (corresponding to a 1 in the monochrome data
- * @bColor: Background color (corresponding to a 0 in the monochrome data
+ * @fg_color: Foreground color (corresponding to a 1 in the monochrome data
+ * @bg_color: Background color (corresponding to a 0 in the monochrome data
  * @rop2: ROP value
  */
-int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
-		       u32 srcDelta, u32 startBit, u32 dBase, u32 dPitch,
-		       u32 bytePerPixel, u32 dx, u32 dy, u32 width,
-		       u32 height, u32 fColor, u32 bColor, u32 rop2);
+int sm750_hw_imageblit(struct lynx_accel *accel,
+		       const char *src_buf, u32 src_delta, u32 start_bit,
+		       u32 dest_base, u32 dest_pitch, u32 byte_per_pixel,
+		       u32 dx, u32 dy, u32 width, u32 height,
+		       u32 fg_color, u32 bg_color, u32 rop2);
 
 #endif
-- 
2.54.0

