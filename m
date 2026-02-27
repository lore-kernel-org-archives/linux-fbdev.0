Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF1D330334
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Feb 2026 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195115; cv=none; b=GyfZ5vLNQjkef7WOlMvzCkBvCYEIsy0lTULBJYQnJCTshdrX1qIMsLsNXrmVAfNQfmI1EUfX58BKLkDXJMXaoK7S/cKFyAm/qCebr3u9cM1f2X4LTvmJD7NFeSFuy+tn5huD2/WM9+Olf6WdHPSyE+26jGW/jCuQHbmKYjkm8Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195115; c=relaxed/simple;
	bh=P+qkb+46r1pOhfXqbnnaPkQ6Y0J/SoJAGu2MyiHuEv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hRVcPf5hQJt32DKw/RQGLZ0VQNPsotW32qlfk2sEjDAU1h9cSUfXpFtCe8ZHsxInoiarQnWnTL/CFF0udSak+p9MvY/XK0ZIWX62Y+xgOaMsPct1Q1n5FtVwz8lgiHhBnsa0ha0DOh4u5fxXLirBBAg/KpMeA6ooWu8bzGk2iF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=fAXeXlni; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="fAXeXlni"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3594d7b36bdso646529a91.1
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Feb 2026 04:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1772195112; x=1772799912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4DTCycSkXD9AMNo6HpXSEpzM+j7SRgkLeP93XH/2s3c=;
        b=fAXeXlni5g8rv+SeT8kVGc6LC9C3tGPG9A5kSHq6bQBmwQKIJJ2UwpRkaijV/rtHpq
         3KBvC4in5BzjGeQJLa93lm6R8f/kQAiR71kwzTCxBnNtdpTdjaZR0DCE8/6mELSdvEru
         wLRBY64VtVlNzXIEi1m+p+IE6P06kZI2apWJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772195112; x=1772799912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DTCycSkXD9AMNo6HpXSEpzM+j7SRgkLeP93XH/2s3c=;
        b=RXxf0iZadnXhp5LVEKKLEt2pkBkYWFV4N+HHsZf8vphi4nqzIjXajuGgMjQIkJHgv4
         v/QO32uPXdqSgF0eSJtR0LhRcvhXQonxsz0zmwQKUjiZCnFWsTnCKcw80y11JEFfzBdY
         O+8CikPObV38+rtOgjGvsAztaRTpxU9D+AL3w56ZOK6LFwYe7z6yAthSSDpGoi3/byhe
         6v7cWb8Y/W4rnoAmJX4QccalKxk1HwE9mwgMSqyPpNbticUssMeLzLe02qmpZtN8OoA2
         wSHw7MWvCICTz0YvNmI7mTQ8E6vkHbEz+l4Zy7DZVGpiwjMI/V2DQGPiPbq7Jy60HTKV
         FNlg==
X-Forwarded-Encrypted: i=1; AJvYcCUhXA7Tw7w+l6eLnfaQ1dvpNntzfO8Wgj1stsp+WgSVO7bJAuxr2KPFUrr3LWMYE+1NW1mAXOFMwjpQRw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3taDpGEQz+t5mDjYdc7Z8V9muYrGji2voPq+ntkgNSR/Oe9vT
	VmfcYO6FBUgBvGSqKPVwqAfJuu+9McZ2zRzJ3mA4PldveIfRT8Z0PWNjT0otE+vcP/sE2CsOaS7
	YTY8T
X-Gm-Gg: ATEYQzxU30IoPlyywnTtncIYnLILLrGzGJAdDk6pzM88OC4DhHMK4nJGga9ah3E1QT0
	5R/x/Ce3r2XvliFBOyZQkcJUNfP2OsHwKI5qn+CXdJu2DQmp6s+qt9zuTOzIgGaz/y++bHO0Fg/
	7GlBBFIOeSNe8MTml8opggL9JCmuWmAGy0fFsk9PVPN0X806t2hWRPurO/9CuJv+5OcL49JOQjj
	AHafUQyrG8tayI9swUuYPEIYRhX0sDkYAD6RMcjZozSBLKZHDfElP0mTgjFH3U4vtGfdlFLoxVU
	kDYJKK1Bn2lkkRkSLLEIvnAlI3Ifo34yNmJ9oHoCBTUcUIUpWvHltP58jSU/FfGQM+qBzFFmmjk
	5//qcMdXK7F13NCXDCh83to4mvJWRb9tgg0KPJqNsQkJxxGjJ+tz21IrMZH198GK3Pv0xuBQqs/
	p323mmMMjGdFGkpdQ3wwwrqz3LZ7aV6sSGLGlC35HcOuW4BIKcFJF3WV6CjuPu7R4DDn0uk3E7e
	vw1WqKPOl3guoA=
X-Received: by 2002:a17:90b:5111:b0:343:eb40:8dca with SMTP id 98e67ed59e1d1-35965cad678mr2014537a91.19.1772195112207;
        Fri, 27 Feb 2026 04:25:12 -0800 (PST)
Received: from kinako.work.home.arpa (p1590226-ipxg00c01sizuokaden.shizuoka.ocn.ne.jp. [153.227.10.226])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3591342f19fsm3612094a91.10.2026.02.27.04.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 04:25:11 -0800 (PST)
From: Daniel Palmer <daniel@thingy.jp>
To: deller@gmx.de,
	linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH] fbdev/tdfxfb: Make the VGA register initialisation a bit more obvious
Date: Fri, 27 Feb 2026 21:25:00 +0900
Message-ID: <20260227122500.3885069-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a while I was trying to get this working on m68k, for some reason
the card doesn't display anything if it's own video BIOS didn't run..

Anyhow, I spent a long time looking up what each of these offsets
were to work out what the code is configuring and eventually
replaced them with the human readable defines in video/vga.h.

Functionally there is no change but maybe it makes it a bit easier to
look at for the next person that finds themselves in here.

Tested on a real voodoo 3 on x86_64.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 drivers/video/fbdev/tdfxfb.c | 109 ++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 54 deletions(-)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index 51ebe78359ec..7606e024fa3f 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -77,6 +77,7 @@
 #include <asm/io.h>
 
 #include <video/tdfx.h>
+#include <video/vga.h>
 
 #define DPRINTK(a, b...) pr_debug("fb: %s: " a, __func__ , ## b)
 
@@ -591,7 +592,7 @@ static int tdfxfb_set_par(struct fb_info *info)
 		vt = ve + (info->var.upper_margin << 1) - 1;
 		reg.screensize = info->var.xres | (info->var.yres << 13);
 		reg.vidcfg |= VIDCFG_HALF_MODE;
-		reg.crt[0x09] = 0x80;
+		reg.crt[VGA_CRTC_MAX_SCAN] = 0x80;
 	} else {
 		vd = info->var.yres - 1;
 		vs  = vd + info->var.lower_margin;
@@ -609,59 +610,59 @@ static int tdfxfb_set_par(struct fb_info *info)
 			 info->var.xres < 480 ? 0x60 :
 			 info->var.xres < 768 ? 0xe0 : 0x20);
 
-	reg.gra[0x05] = 0x40;
-	reg.gra[0x06] = 0x05;
-	reg.gra[0x07] = 0x0f;
-	reg.gra[0x08] = 0xff;
-
-	reg.att[0x00] = 0x00;
-	reg.att[0x01] = 0x01;
-	reg.att[0x02] = 0x02;
-	reg.att[0x03] = 0x03;
-	reg.att[0x04] = 0x04;
-	reg.att[0x05] = 0x05;
-	reg.att[0x06] = 0x06;
-	reg.att[0x07] = 0x07;
-	reg.att[0x08] = 0x08;
-	reg.att[0x09] = 0x09;
-	reg.att[0x0a] = 0x0a;
-	reg.att[0x0b] = 0x0b;
-	reg.att[0x0c] = 0x0c;
-	reg.att[0x0d] = 0x0d;
-	reg.att[0x0e] = 0x0e;
-	reg.att[0x0f] = 0x0f;
-	reg.att[0x10] = 0x41;
-	reg.att[0x12] = 0x0f;
-
-	reg.seq[0x00] = 0x03;
-	reg.seq[0x01] = 0x01; /* fixme: clkdiv2? */
-	reg.seq[0x02] = 0x0f;
-	reg.seq[0x03] = 0x00;
-	reg.seq[0x04] = 0x0e;
-
-	reg.crt[0x00] = ht - 4;
-	reg.crt[0x01] = hd;
-	reg.crt[0x02] = hbs;
-	reg.crt[0x03] = 0x80 | (hbe & 0x1f);
-	reg.crt[0x04] = hs;
-	reg.crt[0x05] = ((hbe & 0x20) << 2) | (he & 0x1f);
-	reg.crt[0x06] = vt;
-	reg.crt[0x07] = ((vs & 0x200) >> 2) |
-			((vd & 0x200) >> 3) |
-			((vt & 0x200) >> 4) | 0x10 |
-			((vbs & 0x100) >> 5) |
-			((vs & 0x100) >> 6) |
-			((vd & 0x100) >> 7) |
-			((vt & 0x100) >> 8);
-	reg.crt[0x09] |= 0x40 | ((vbs & 0x200) >> 4);
-	reg.crt[0x10] = vs;
-	reg.crt[0x11] = (ve & 0x0f) | 0x20;
-	reg.crt[0x12] = vd;
-	reg.crt[0x13] = wd;
-	reg.crt[0x15] = vbs;
-	reg.crt[0x16] = vbe + 1;
-	reg.crt[0x17] = 0xc3;
-	reg.crt[0x18] = 0xff;
+	reg.gra[VGA_GFX_MODE]         = 0x40;
+	reg.gra[VGA_GFX_MISC]         = 0x05;
+	reg.gra[VGA_GFX_COMPARE_MASK] = 0x0f;
+	reg.gra[VGA_GFX_BIT_MASK]     = 0xff;
+
+	reg.att[VGA_ATC_PALETTE0]     = 0x00;
+	reg.att[VGA_ATC_PALETTE1]     = 0x01;
+	reg.att[VGA_ATC_PALETTE2]     = 0x02;
+	reg.att[VGA_ATC_PALETTE3]     = 0x03;
+	reg.att[VGA_ATC_PALETTE4]     = 0x04;
+	reg.att[VGA_ATC_PALETTE5]     = 0x05;
+	reg.att[VGA_ATC_PALETTE6]     = 0x06;
+	reg.att[VGA_ATC_PALETTE7]     = 0x07;
+	reg.att[VGA_ATC_PALETTE8]     = 0x08;
+	reg.att[VGA_ATC_PALETTE9]     = 0x09;
+	reg.att[VGA_ATC_PALETTEA]     = 0x0a;
+	reg.att[VGA_ATC_PALETTEB]     = 0x0b;
+	reg.att[VGA_ATC_PALETTEC]     = 0x0c;
+	reg.att[VGA_ATC_PALETTED]     = 0x0d;
+	reg.att[VGA_ATC_PALETTEE]     = 0x0e;
+	reg.att[VGA_ATC_PALETTEF]     = 0x0f;
+	reg.att[VGA_ATC_MODE]         = 0x41;
+	reg.att[VGA_ATC_PLANE_ENABLE] = 0x0f;
+
+	reg.seq[VGA_SEQ_RESET]         = 0x03;
+	reg.seq[VGA_SEQ_CLOCK_MODE]    = 0x01; /* fixme: clkdiv2? */
+	reg.seq[VGA_SEQ_PLANE_WRITE]   = 0x0f;
+	reg.seq[VGA_SEQ_CHARACTER_MAP] = 0x00;
+	reg.seq[VGA_SEQ_MEMORY_MODE]   = 0x0e;
+
+	reg.crt[VGA_CRTC_H_TOTAL]       = ht - 4;
+	reg.crt[VGA_CRTC_H_DISP]        = hd;
+	reg.crt[VGA_CRTC_H_BLANK_START] = hbs;
+	reg.crt[VGA_CRTC_H_BLANK_END]   = 0x80 | (hbe & 0x1f);
+	reg.crt[VGA_CRTC_H_SYNC_START]  = hs;
+	reg.crt[VGA_CRTC_H_SYNC_END]    = ((hbe & 0x20) << 2) | (he & 0x1f);
+	reg.crt[VGA_CRTC_V_TOTAL]       = vt;
+	reg.crt[VGA_CRTC_OVERFLOW]      = ((vs & 0x200) >> 2) |
+					  ((vd & 0x200) >> 3) |
+					  ((vt & 0x200) >> 4) | 0x10 |
+					  ((vbs & 0x100) >> 5) |
+					  ((vs & 0x100) >> 6) |
+					  ((vd & 0x100) >> 7) |
+					  ((vt & 0x100) >> 8);
+	reg.crt[VGA_CRTC_MAX_SCAN]     |= 0x40 | ((vbs & 0x200) >> 4);
+	reg.crt[VGA_CRTC_V_SYNC_START]  = vs;
+	reg.crt[VGA_CRTC_V_SYNC_END]    = (ve & 0x0f) | 0x20;
+	reg.crt[VGA_CRTC_V_DISP_END]    = vd;
+	reg.crt[VGA_CRTC_OFFSET]        = wd;
+	reg.crt[VGA_CRTC_V_BLANK_START] = vbs;
+	reg.crt[VGA_CRTC_V_BLANK_END]   = vbe + 1;
+	reg.crt[VGA_CRTC_MODE]          = 0xc3;
+	reg.crt[VGA_CRTC_LINE_COMPARE]  = 0xff;
 
 	/* Banshee's nonvga stuff */
 	reg.ext[0x00] = (((ht & 0x100) >> 8) |
-- 
2.51.0

