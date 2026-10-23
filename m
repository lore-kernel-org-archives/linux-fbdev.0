Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777912;
	b=N4mci7Ewb12cIi77mJLGdQsPk4ylQgWDa8zvL1euWDglBABKq4+orBdj7POAXy4R85fW
	 xJp7mNpxnc8qpmnaLwypVD5iplMdbwDq7vFM3lHIvkxO5tCmiDTBIn3I5+Z/6uX4hkLYI
	 WXpNC7KUeIGZJE/sbJJjyFtxctHrLX10g+ypxB4JCYr+fCRemqwS5zuBP5e2fUCm2g8Jp
	 cSvf6ccnGennFUOlU/XC9TVXsIFXxKdpUEk1n62pRot2gIwLUXR9IfQAM3dAXg2GmXdZ0
	 UMPr0C+IJwHRQ1h+1olPNhs4hO4o7WSM7Wm+P5PyM3owoIAsN8Zg53aaJN9SSvkHuvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7wwANjuDtZeTrIYJO8YoDGwetOTDKqWw0CaiXm+A6RE=;
	b=NBcVW6wCeAlbqRWqZyU3CwnGQd712/tXNzai46J0pIM9hBpazKpz/8P+x+4TOd2cFXQj
	 e2QpBmEaA9Rs8fXC5mVGXi1gIqDHA2oCh8bQf7NYxCQRGt5TBZOJT3dLeP8hvzcGhCvV8
	 hrTfPkSmzz13bDZcvSKW0qc/fOET4REbGaZqrNsMtF4iGUfRdSXfWMoFbUkAIgBJNE6ec
	 O/Fj4/4x7N20iWvpEh+FfZoxkjesNT2aRS8BH8XAxVD5BUoGz300CzgP4JBqLT0tnxyzF
	 rQjN71uXGz6WP7HxugGT9nHEzjeD6i5N2nGmHfIEcnqRGf6Log1rmsH/wL2BXOL4p5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KeN1mHlU;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FC9606A320
	for <linux-fbdev@vger.kernel.org>; Fri, 23 Oct 2026 17:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37FC9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KeN1mHlU
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-18cdcfc05ffso1310874c88.1
        for <linux-fbdev@vger.kernel.org>; Fri, 23 Oct 2026 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792777910; x=1793382710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7wwANjuDtZeTrIYJO8YoDGwetOTDKqWw0CaiXm+A6RE=;
        b=KeN1mHlUE8H65mhqBFxPDjAG6SEA3nwST8Mc8fzc+ILmzrxXNLUzhLHAeC85poJFLa
         quV0YF5rE55k4WkIsNGxOT1aHSkPGtL7zMVPeGsh0zwDayyAHWAyFTuA+ZzJ1qr7CaJ8
         bLsmdSsXV1D0RZY8B7iZiajKfokJcj9zkcexZk2DPVANmTwQ44bePkUtlAvEsUbLktJ9
         omgOjWUQ5BKQMXONQtpD3K1BeatmQSTPtWeu5eIwfk+mUYyYOuEUzEId8oqciiXKRUXb
         U0uQL0eX667yZjF9NsuSsqRGjfCgMSHYrGdRznQRK2SiMMDXKi59nWjLV0BntKQP+79w
         NhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792777910; x=1793382710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7wwANjuDtZeTrIYJO8YoDGwetOTDKqWw0CaiXm+A6RE=;
        b=l8mSAodz41fObbQY8U04fhrglg4IiUMSh7Ba5wLlcZCgS8pdlYSKwAHjfrbYZNml3M
         2AaUBo4F2//iOIGwoN+oawJIIcAHqNMxXV7TB4aRuLqYvjqO6uCB1n/1hNfxLpM21vOl
         Rox9EZiIMd2ueI0/uWE5wKwRGZNXH0iemKh331YssMRi/1OPZ3EeykXx/0E3jdPiE6lh
         SCtATSw4J0a6YcO17QSB9jXeaK91s7HWV2LHBKeeh8JZApB3c/smH9CH49cBfTCUQn0B
         zD6739n71CCwvn70NghRWoDYbRbBWVAf8tGABz7d10tSJEuE0Ix38l5uDAN5M6kQWUTY
         hogg==
X-Gm-Message-State: AFq9FYJIXRB+XHuPmY8gEqj5rfkIOOg0sU8LFdMezw455+Mq6uV8IETq
	8PP4s1W2l5Ir9ImyHVWTPCFdbB7G2ZQzFKqeSd5SzjV+uaDKVVu/9UXl
X-Gm-Gg: AYBFou2eZtzSfI5hkeDd/JdWy9S4ns2I0YHX8FqKnNIGRss3A2zT5lXKnaPUHV8o7jK
	hjwtex8eTdfTfXNSfirHQga6iwpmTBhmG44xq5ujpbzEj4XumcgpdiRdGLOnbmhztEgMaR53/1X
	aaKiBEY8F6pMCPq+hcO8d6IqBb1v8jVutDOK4g69eVUE1WXcpw5c+etsPYeIWRsLcWswUJz/dFR
	xwSeAaQ0T1nI+RGmIVn8c1NHpb6tbB0+b7Xko0IWENtHRMjS01HMMHZam+RfyLfYhD5oJG4e1Ry
	bPA7Cjf4VTGDJVwPqJR/Ffmz+Zfl5ZEZ/mf/7zj6sUxKohJK21rt29kff3hKe9Fjl7sIzdvm16n
	3AU+1cg/lOljzTiGJ9gk20qMeZwRhEYKKk/NbFmcDOaP7Yg4DKuOTDFXfq+r4dBbqoenm5z0uTj
	Z5Fv6WbhX+bhGk3qD2ahvg0RklRLq7WNPrAKlCgCtZQNDSepom88Ae1n8drX0FZAU38sSfs72Fb
	QpjDeT82IsyycFDjo7PHJzoaH2V4XUNK7pZzAMXbF2D0SXhq5WIXLhsD8CU7O2CqaXu77A7QvO9
	Z45CN1V08YQY+tH38ULayxEWjYnQ
X-Received: by 2002:a05:7022:3b85:b0:187:efba:9ba2 with SMTP id a92af1059eb24-195c6f00fa6mr4412390c88.44.1792777910049;
        Fri, 23 Oct 2026 10:51:50 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ea25sm132988c88.5.2026.10.23.10.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:51:48 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	co+b0df61d49532b2ee@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: vfb: Validate framebuffer geometry and memory size
Date: Fri, 23 Oct 2026 10:51:29 -0700
Message-ID: <20261023175128.4127122-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_line_length() multiplies two int operands before assigning the
result to u_long. Setting xres_virtual to 0x8000000 at 32 bpp therefore
wraps the product to zero and bypasses vfb_check_var()'s video-memory
limit. fbcon can then clear margins with a zero line stride and write
past the vmalloc'ed framebuffer.

The xoffset + xres and yoffset + yres calculations can likewise wrap,
leaving an invalid offset in info->var after fb_pan_display() rejects
it. Subsequent fbcon drawing can then access far beyond the framebuffer.

Finally, PAGE_ALIGN(videomemorysize) was narrowed from unsigned long to
unsigned int. Values near or above 4 GiB could therefore allocate a much
smaller buffer than the size used for mode validation.

KASAN reports:

  BUG: KASAN: vmalloc-out-of-bounds in sys_fillrect
    drivers/video/fbdev/core/sysfillrect.c:24
  Write of size 8 at addr ffa0000001671000 by task poc/198
  sys_fillrect
    drivers/video/fbdev/core/sysfillrect.c:24
  bit_clear_margins
    drivers/video/fbdev/core/bitblit.c:247
  fbcon_clear_margins.constprop.0
    drivers/video/fbdev/core/fbcon.c:1410
  fbcon_switch
    drivers/video/fbdev/core/fbcon.c:2261
  redraw_screen
    drivers/tty/vt/vt.c:994
  fbcon_modechanged
    drivers/video/fbdev/core/fbcon.c:2693
  fbcon_update_vcs
    drivers/video/fbdev/core/fbcon.c:2732

Reject video-memory sizes whose aligned value is not representable by
the fbdev metadata. Check the offset additions for overflow. Compute the
line length and framebuffer size in u64, reject unrepresentable line
lengths, and check the total-size multiplication before comparing it
with the allocated video-memory size.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: <co+b0df61d49532b2ee@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/video/fbdev/vfb.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index de137b2bd..84b0a937c 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -101,11 +101,11 @@ static const struct fb_ops vfb_ops = {
      *  Internal routines
      */
 
-static u_long get_line_length(int xres_virtual, int bpp)
+static u64 get_line_length(u32 xres_virtual, u32 bpp)
 {
-	u_long length;
+	u64 length;
 
-	length = xres_virtual * bpp;
+	length = (u64)xres_virtual * bpp;
 	length = (length + 31) & ~31;
 	length >>= 3;
 	return (length);
@@ -122,7 +122,8 @@ static u_long get_line_length(int xres_virtual, int bpp)
 static int vfb_check_var(struct fb_var_screeninfo *var,
 			 struct fb_info *info)
 {
-	u_long line_length;
+	u64 line_length, size;
+	u32 xres, yres;
 
 	/*
 	 *  FB_VMODE_CONUPDATE and FB_VMODE_SMOOTH_XPAN are equal!
@@ -159,17 +160,23 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
 	else
 		return -EINVAL;
 
-	if (var->xres_virtual < var->xoffset + var->xres)
-		var->xres_virtual = var->xoffset + var->xres;
-	if (var->yres_virtual < var->yoffset + var->yres)
-		var->yres_virtual = var->yoffset + var->yres;
+	if (check_add_overflow(var->xoffset, var->xres, &xres) ||
+	    check_add_overflow(var->yoffset, var->yres, &yres))
+		return -EINVAL;
+
+	if (var->xres_virtual < xres)
+		var->xres_virtual = xres;
+	if (var->yres_virtual < yres)
+		var->yres_virtual = yres;
 
 	/*
 	 *  Memory limit
 	 */
 	line_length =
 	    get_line_length(var->xres_virtual, var->bits_per_pixel);
-	if (line_length * var->yres_virtual > videomemorysize)
+	if (line_length > U32_MAX ||
+	    check_mul_overflow(line_length, (u64)var->yres_virtual, &size) ||
+	    size > videomemorysize)
 		return -ENOMEM;
 
 	/*
@@ -434,9 +441,13 @@ static int __init vfb_setup(char *options)
 static int vfb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
-	unsigned int size = PAGE_ALIGN(videomemorysize);
+	unsigned int size;
 	int retval = -ENOMEM;
 
+	if (videomemorysize > U32_MAX - (PAGE_SIZE - 1))
+		return -EINVAL;
+	size = PAGE_ALIGN(videomemorysize);
+
 	/*
 	 * For real video cards we use ioremap.
 	 */
-- 
2.56.0

