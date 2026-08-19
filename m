Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CBE3E0094
	for <linux-fbdev@vger.kernel.org>; Wed, 19 Aug 2026 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787178539; cv=none; b=eeIWqQZcLweSgiu2kpd0aLuOPgKw2Vs6oBU2VH60lfVmpdQeNkzTJIlMDgHt1SkJxtIsWNuTy2UhihrTIndx3/DfP39ZqclGrx7uzbDxuShJUjF4H5gKYsEvUsUPmxZ+jOWs96tulsLT8Uuzk+XMfCBZPWqmyfOMza4Nhxacj4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787178539; c=relaxed/simple;
	bh=VqovMCFcIO0AgRizO3lLfzzCWFVFj4CMgUdjOYFesd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=K+hV0THB3RrbmlbdwFwywY3114Ai9oXRf8sDdow6MW7nvkF2esJjtTTfZPDkbprWvGUD7691SB+pVawbw+NVMHYNOpj4a+p4evy9K4Ll/8TuDd1UO50d9jyBTLBFbDXAfrw/n4FLiCMKgkyk5Bhva5x52YLop9P8hgaTwCilpv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ol3XbpN2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ol3XbpN2"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so19448385ad.1
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Aug 2026 15:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787178537; x=1787783337; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eJNgLzogKifzgb0L3CXlpNr21wbTpyoAKWAZKUrsE98=;
        b=Ol3XbpN25Im6vOUntR+7FgJ3yUHQPvfIsMkwzEBXdrIl8Sow9+jTwFTSy6ND+aZ2kI
         DIK4PsoAod5LFX/o6wpBQ42tdfpQagu0g2DCSWPlRgym9ekAuFANwuIdBRKpmjWxf6FU
         avPqv4Mp6+cahNl/mYIBwVA6OSPXHKCZ+XxlW8mqkH2vsMTBnZgekpAKVvGbTZ4JCEuW
         vSExWkoB74asTWGTpifSb6SB9juuWqPJ7Jqj9NvKJb/4QEUl8kvp90n52zueLWcBs+Xu
         eJb//mrfFLbj7Ryrbrgvm9541xhQCeHAnCGdf/hXbD0atej1FpSbDPxNxg71HBxk/beW
         BYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787178537; x=1787783337;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eJNgLzogKifzgb0L3CXlpNr21wbTpyoAKWAZKUrsE98=;
        b=He008ZIom/slK/Vffg7Pz7cNbmcHZw+Q8DDEbpONAS0ACZOr+8sAqZgmMV58YO9ukQ
         px4sXQ6VgisV6+7igW/In/pyMSYOqf69DxiC8VBR3m9U4Y6yYww1Pa98hTxvJykpm6wk
         CCGoqskyKBZUr2ntnZHvX1dk59HwsrMZzqCTUaEN2k50hWLJ+4UZC25lCinMV2Usfk5a
         m/C8aU9qwfAnKblXeTUtuVITJZEFIDGRN6bKAN9iADPuVnyaDMZTSocQq2ZDsa9fIGSN
         iZSf8LEc5hUuc99UcU5MpMNI2TlN1IJCrfJKmytDXWmcpxHZEjSIPUqn/1nygwWiC5Bj
         /qVQ==
X-Forwarded-Encrypted: i=1; AHgh+RpA1p7hqIuYmfw82JrgQ7eqSvhkHiZFVoOZVKfYNsE2vY23ZSBpTBLeyncbvlwqJhyWCiXEWt6UwufLxg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt7FwhC6iI85BcjHEY1EEGuaRmPzMiEAT4OGNehITT28PYdsvw
	hSjy7n8cN+DKp9LDuv2ri22pENN7VwRrfu4H5EhNSx6aZFradH6hOIgh
X-Gm-Gg: AR+sD12FybFOj+abVf6KZSJK4cGxcjpSohwOdgavSXdKw6rHBWtBnVqgtPNRPCJeyCs
	BXnmQK2wpz4pWR0c5RzX3WudMgCyWRSTkEo5qJI4tlyn6wIiedV7ds3zQAfBBrfbE+PBukEPdyk
	lV78QD3BLIqr3DFnsC303EuMTcbq+pQ+kLCZrNQUynBNxjeGPEALrGEehTZbQ1oMBHy09JEp59L
	WXgyvUtEuHklO1sNGtnG8yY9Z4c+93asGcB8uNpjgrUz1TdEFVfBO+s3ERyrimmkq5tVysUaG9k
	3UYCrDbY5cNiP1t57sVXwHWkR5uyIb7T3uIhEj62hVSui/bauizEH7flMMFhc9ihldgSwa68hvo
	yKZGEFNxOzaKx0npl7ATi9KrLasQtq1BjJ4I+86N7BmB2tG6G0NbwKsuBYvzOyevaARAzlcni52
	G6oQgj0Fx2SiNvgcBplG98/4mH71s5lVBYgD0I/28qEZqsmzqGihIYZ6zNff+DycKcZ80+q1yLR
	Pkt2E5vXdMUUO1xT8gEySGV9HhgxPSAY19aqKca4O7lpVr2Og==
X-Received: by 2002:a17:902:ebc7:b0:2ca:e565:7b15 with SMTP id d9443c01a7336-2d5fd73d03dmr142054395ad.10.1787178536890;
        Wed, 19 Aug 2026 15:28:56 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-59-250-182-adsl.sparkbb.co.nz. [122.59.250.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3cde4sm11490849eec.4.2026.08.19.15.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 15:28:56 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id 34A993604AD; Thu, 20 Aug 2026 10:28:51 +1200 (NZST)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org,
	geert@linux-m68k.org
Cc: schmitzmic@gmail.com,
	Miro Kropacek <miro.kropacek@gmail.com>,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v3 2/5] fbdev: Give atafb proper parent
Date: Thu, 20 Aug 2026 10:28:35 +1200
Message-Id: <20260819222838.21256-3-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260819222838.21256-1-schmitzmic@gmail.com>
References: <20260819222838.21256-1-schmitzmic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

From: Miro Kropacek <miro.kropacek@gmail.com>

The atafb fb device registers no parent, causing a missing symlink
(/sys/class/graphics/fb0/device). Xorg fbdevhw driver looks for that
symlink when scanning for devices, so add a parent node for atafb.

The proper way to do that is use of framebuffer_alloc(), which
requries refactoring atafb to move from static fb_info to allocation
of fb_info by framebuffer_alloc().
About the only location where a fb_info pointer cannot be passed
is monspec setup in atafb_setup(). Store static monspecs there
and copy into place after framebuffer_alloc().

Pass fb_info everywhere it's needed (detect, decode_var and
do_fb_set_var functions), and remove the static fb_info struct.

Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Cc: <linux-fbdev@vger.kernel.org>
Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html

---

Changes in v3:

- fbdev: refactor atafb fb_info use to allow use of framebuffer_alloc()
  (Thomas Zimmermann)
---
 drivers/video/fbdev/atafb.c | 174 +++++++++++++++++++-----------------
 1 file changed, 92 insertions(+), 82 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index b8ed1c537293..a9be06ded5c9 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -158,14 +158,6 @@ static int DontCalcRes = 0;
 #define VMO_PREMASK		0x0c
 #endif
 
-static struct fb_info fb_info = {
-	.fix = {
-		.id	= "Atari ",
-		.visual	= FB_VISUAL_PSEUDOCOLOR,
-		.accel	= FB_ACCEL_NONE,
-	}
-};
-
 static void *screen_base;	/* base address of screen */
 static unsigned long phys_screen_base;	/* (only for Overscan) */
 
@@ -175,6 +167,12 @@ static int current_par_valid;
 
 static int mono_moni;
 
+/* monspecs passed by user */
+
+static __u32 mcap_hmin;		/* hfreq lower limit (Hz) */
+static __u32 mcap_hmax;		/* hfreq upper limit (Hz) */
+static __u16 mcap_vmin;		/* vfreq lower limit (Hz) */
+static __u16 mcap_vmax;		/* vfreq upper limit (Hz) */
 
 #ifdef ATAFB_EXT
 
@@ -299,7 +297,7 @@ static int *MV300_reg = MV300_reg_8bit;
 /* ++roman: This structure abstracts from the underlying hardware (ST(e),
  * TT, or Falcon.
  *
- * int (*detect)(void)
+ * int (*detect)(*fb_info)
  *   This function should detect the current video mode settings and
  *   store them in atafb_predefined[0] for later reference by the
  *   user. Return the index+1 of an equivalent predefined mode or 0
@@ -311,7 +309,7 @@ static int *MV300_reg = MV300_reg_8bit;
  *   values in the 'par' structure.
  * !!! Obsolete, perhaps !!!
  *
- * int (*decode_var)(struct fb_var_screeninfo *var,
+ * int (*decode_var)(struct fb_info *info, struct fb_var_screeninfo *var,
  *                   struct atafb_par *par)
  *   Get the video params out of 'var'. If a value doesn't fit, round
  *   it up, if it's too big, return EINVAL.
@@ -345,10 +343,10 @@ static int *MV300_reg = MV300_reg_8bit;
  */
 
 static struct fb_hwswitch {
-	int (*detect)(void);
+	int (*detect)(struct fb_info *info);
 	int (*encode_fix)(struct fb_fix_screeninfo *fix,
 			  struct atafb_par *par);
-	int (*decode_var)(struct fb_var_screeninfo *var,
+	int (*decode_var)(struct fb_info *info, struct fb_var_screeninfo *var,
 			  struct atafb_par *par);
 	int (*encode_var)(struct fb_var_screeninfo *var,
 			  struct atafb_par *par);
@@ -576,7 +574,7 @@ static int tt_encode_fix(struct fb_fix_screeninfo *fix, struct atafb_par *par)
 	return 0;
 }
 
-static int tt_decode_var(struct fb_var_screeninfo *var, struct atafb_par *par)
+static int tt_decode_var(struct fb_info *info, struct fb_var_screeninfo *var, struct atafb_par *par)
 {
 	int xres = var->xres;
 	int yres = var->yres;
@@ -782,7 +780,7 @@ static int tt_setcolreg(unsigned int regno, unsigned int red,
 	return 0;
 }
 
-static int tt_detect(void)
+static int tt_detect(struct fb_info *info)
 {
 	struct atafb_par par;
 
@@ -877,7 +875,7 @@ static int falcon_encode_fix(struct fb_fix_screeninfo *fix,
 	return 0;
 }
 
-static int falcon_decode_var(struct fb_var_screeninfo *var,
+static int falcon_decode_var(struct fb_info *info, struct fb_var_screeninfo *var,
 			     struct atafb_par *par)
 {
 	int bpp = var->bits_per_pixel;
@@ -1069,13 +1067,13 @@ static int falcon_decode_var(struct fb_var_screeninfo *var,
 			/* Choose master pixelclock depending on hor. timing */
 			plen = 1 * xstretch;
 			if ((plen * xres + f25.right + f25.hsync + f25.left) *
-			    fb_info.monspecs.hfmin < f25.f)
+			    info->monspecs.hfmin < f25.f)
 				pclock = &f25;
 			else if ((plen * xres + f32.right + f32.hsync +
-				  f32.left) * fb_info.monspecs.hfmin < f32.f)
+				  f32.left) * info->monspecs.hfmin < f32.f)
 				pclock = &f32;
 			else if ((plen * xres + fext.right + fext.hsync +
-				  fext.left) * fb_info.monspecs.hfmin < fext.f &&
+				  fext.left) * info->monspecs.hfmin < fext.f &&
 			         fext.f)
 				pclock = &fext;
 			else
@@ -1245,14 +1243,14 @@ static int falcon_decode_var(struct fb_var_screeninfo *var,
 
 	/*  check hor. frequency */
 	hfreq = pclock->f / ((par->HHT + 2) * prescale * 2);
-	if (hfreq > fb_info.monspecs.hfmax && mon_type != F_MON_VGA) {
+	if (hfreq > info->monspecs.hfmax && mon_type != F_MON_VGA) {
 		/* ++guenther:   ^^^^^^^^^^^^^^^^^^^ can't remember why I did this */
 		/* Too high -> enlarge margin */
 		left_margin += 1;
 		right_margin += 1;
 		goto again;
 	}
-	if (hfreq > fb_info.monspecs.hfmax || hfreq < fb_info.monspecs.hfmin)
+	if (hfreq > info->monspecs.hfmax || hfreq < info->monspecs.hfmin)
 		return -EINVAL;
 
 	/* Vxx-registers */
@@ -1283,50 +1281,50 @@ static int falcon_decode_var(struct fb_var_screeninfo *var,
 	/* V-frequency check, hope I didn't create any loop here. */
 	/* Interlace and doubleline are mutually exclusive. */
 	vfreq = (hfreq * 2) / (par->VFT + 1);
-	if (vfreq > fb_info.monspecs.vfmax && !doubleline && !interlace) {
+	if (vfreq > info->monspecs.vfmax && !doubleline && !interlace) {
 		/* Too high -> try again with doubleline */
 		doubleline = 1;
 		goto again;
-	} else if (vfreq < fb_info.monspecs.vfmin && !interlace && !doubleline) {
+	} else if (vfreq < info->monspecs.vfmin && !interlace && !doubleline) {
 		/* Too low -> try again with interlace */
 		interlace = 1;
 		goto again;
-	} else if (vfreq < fb_info.monspecs.vfmin && doubleline) {
+	} else if (vfreq < info->monspecs.vfmin && doubleline) {
 		/* Doubleline too low -> clear doubleline and enlarge margins */
 		int lines;
 		doubleline = 0;
 		for (lines = 0;
 		     (hfreq * 2) / (par->VFT + 1 + 4 * lines - 2 * yres) >
-		     fb_info.monspecs.vfmax;
+		     info->monspecs.vfmax;
 		     lines++)
 			;
 		upper_margin += lines;
 		lower_margin += lines;
 		goto again;
-	} else if (vfreq > fb_info.monspecs.vfmax && doubleline) {
+	} else if (vfreq > info->monspecs.vfmax && doubleline) {
 		/* Doubleline too high -> enlarge margins */
 		int lines;
 		for (lines = 0;
 		     (hfreq * 2) / (par->VFT + 1 + 4 * lines) >
-		     fb_info.monspecs.vfmax;
+		     info->monspecs.vfmax;
 		     lines += 2)
 			;
 		upper_margin += lines;
 		lower_margin += lines;
 		goto again;
-	} else if (vfreq > fb_info.monspecs.vfmax && interlace) {
+	} else if (vfreq > info->monspecs.vfmax && interlace) {
 		/* Interlace, too high -> enlarge margins */
 		int lines;
 		for (lines = 0;
 		     (hfreq * 2) / (par->VFT + 1 + 4 * lines) >
-		     fb_info.monspecs.vfmax;
+		     info->monspecs.vfmax;
 		     lines++)
 			;
 		upper_margin += lines;
 		lower_margin += lines;
 		goto again;
-	} else if (vfreq < fb_info.monspecs.vfmin ||
-		   vfreq > fb_info.monspecs.vfmax)
+	} else if (vfreq < info->monspecs.vfmin ||
+		   vfreq > info->monspecs.vfmax)
 		return -EINVAL;
 
 set_screen_base:
@@ -1720,7 +1718,7 @@ static int falcon_blank(int blank_mode)
 	return 0;
 }
 
-static int falcon_detect(void)
+static int falcon_detect(struct fb_info *info)
 {
 	struct atafb_par par;
 	unsigned char fhw;
@@ -1732,18 +1730,18 @@ static int falcon_detect(void)
 	f030_bus_width = fhw << 6 & 0x80;
 	switch (mon_type) {
 	case F_MON_SM:
-		fb_info.monspecs.vfmin = 70;
-		fb_info.monspecs.vfmax = 72;
-		fb_info.monspecs.hfmin = 35713;
-		fb_info.monspecs.hfmax = 35715;
+		info->monspecs.vfmin = 70;
+		info->monspecs.vfmax = 72;
+		info->monspecs.hfmin = 35713;
+		info->monspecs.hfmax = 35715;
 		break;
 	case F_MON_SC:
 	case F_MON_TV:
 		/* PAL...NTSC */
-		fb_info.monspecs.vfmin = 49;	/* not 50, since TOS defaults to 49.9x Hz */
-		fb_info.monspecs.vfmax = 60;
-		fb_info.monspecs.hfmin = 15620;
-		fb_info.monspecs.hfmax = 15755;
+		info->monspecs.vfmin = 49;	/* not 50, since TOS defaults to 49.9x Hz */
+		info->monspecs.vfmax = 60;
+		info->monspecs.hfmin = 15620;
+		info->monspecs.hfmax = 15755;
 		break;
 	}
 	/* initialize hsync-len */
@@ -1795,7 +1793,7 @@ static int stste_encode_fix(struct fb_fix_screeninfo *fix,
 	return 0;
 }
 
-static int stste_decode_var(struct fb_var_screeninfo *var,
+static int stste_decode_var(struct fb_info *info, struct fb_var_screeninfo *var,
 			    struct atafb_par *par)
 {
 	int xres = var->xres;
@@ -1971,7 +1969,7 @@ static int stste_setcolreg(unsigned int regno, unsigned int red,
 	return 0;
 }
 
-static int stste_detect(void)
+static int stste_detect(struct fb_info *info)
 {
 	struct atafb_par par;
 
@@ -2112,7 +2110,8 @@ static int ext_encode_fix(struct fb_fix_screeninfo *fix, struct atafb_par *par)
 	return 0;
 }
 
-static int ext_decode_var(struct fb_var_screeninfo *var, struct atafb_par *par)
+static int ext_decode_var(struct fb_info *info, struct fb_var_screeninfo *var,
+			struct atafb_par *par)
 {
 	struct fb_var_screeninfo *myvar = &atafb_predefined[0];
 
@@ -2226,7 +2225,7 @@ static int ext_setcolreg(unsigned int regno, unsigned int red,
 	}
 }
 
-static int ext_detect(void)
+static int ext_detect(struct fb_info *info)
 {
 	struct fb_var_screeninfo *myvar = &atafb_predefined[0];
 	struct atafb_par dummy_par;
@@ -2344,12 +2343,12 @@ static void ata_set_par(struct atafb_par *par)
 
 /* used for hardware scrolling */
 
-static int do_fb_set_var(struct fb_var_screeninfo *var, int isactive)
+static int do_fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var, int isactive)
 {
 	int err, activate;
 	struct atafb_par par;
 
-	err = fbhw->decode_var(var, &par);
+	err = fbhw->decode_var(info, var, &par);
 	if (err)
 		return err;
 	activate = var->activate;
@@ -2368,7 +2367,7 @@ static int atafb_get_fix(struct fb_fix_screeninfo *fix, struct fb_info *info)
 	struct atafb_par par;
 	int err;
 	// Get fix directly (case con == -1 before)??
-	err = fbhw->decode_var(&info->var, &par);
+	err = fbhw->decode_var(info, &info->var, &par);
 	if (err)
 		return err;
 	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
@@ -2635,7 +2634,7 @@ static int atafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	/* Validate wanted screen parameters */
 	// if ((err = ata_decode_var(var, &par)))
-	err = fbhw->decode_var(var, &par);
+	err = fbhw->decode_var(info, var, &par);
 	if (err)
 		return err;
 
@@ -2651,7 +2650,7 @@ static int atafb_set_par(struct fb_info *info)
 	struct atafb_par *par = info->par;
 
 	/* Decode wanted screen parameters */
-	fbhw->decode_var(&info->var, par);
+	fbhw->decode_var(info, &info->var, par);
 	mutex_lock(&info->mm_lock);
 	fbhw->encode_fix(&info->fix, par);
 	mutex_unlock(&info->mm_lock);
@@ -2677,7 +2676,7 @@ static struct fb_ops atafb_ops = {
 	__FB_DEFAULT_IOMEM_OPS_MMAP,
 };
 
-static void check_default_par(int detected_mode)
+static void check_default_par(struct fb_info *info, int detected_mode)
 {
 	char default_name[10];
 	int i;
@@ -2688,14 +2687,14 @@ static void check_default_par(int detected_mode)
 	if (default_par) {
 		var = atafb_predefined[default_par - 1];
 		var.activate = FB_ACTIVATE_TEST;
-		if (do_fb_set_var(&var, 1))
+		if (do_fb_set_var(info, &var, 1))
 			default_par = 0;	/* failed */
 	}
 	/* Next is the autodetected one */
 	if (!default_par) {
 		var = atafb_predefined[detected_mode - 1]; /* autodetect */
 		var.activate = FB_ACTIVATE_TEST;
-		if (!do_fb_set_var(&var, 1))
+		if (!do_fb_set_var(info, &var, 1))
 			default_par = detected_mode;
 	}
 	/* If that also failed, try some default modes... */
@@ -2708,7 +2707,7 @@ static void check_default_par(int detected_mode)
 				panic("can't set default video mode");
 			var = atafb_predefined[default_par - 1];
 			var.activate = FB_ACTIVATE_TEST;
-			if (!do_fb_set_var(&var,1))
+			if (!do_fb_set_var(info, &var, 1))
 				break;	/* ok */
 		}
 	}
@@ -2901,10 +2900,10 @@ static void __init atafb_setup_mcap(char *spec)
 	if (hmax <= 0 || hmax <= hmin)
 		return;
 
-	fb_info.monspecs.vfmin = vmin;
-	fb_info.monspecs.vfmax = vmax;
-	fb_info.monspecs.hfmin = hmin;
-	fb_info.monspecs.hfmax = hmax;
+	mcap_vmin = vmin;
+	mcap_vmax = vmax;
+	mcap_hmin = hmin;
+	mcap_hmax = hmax;
 }
 #endif /* ATAFB_FALCON */
 
@@ -2991,12 +2990,19 @@ static int __init atafb_probe(struct platform_device *pdev)
 	unsigned int defmode = 0;
 	unsigned long mem_req;
 	char *option = NULL;
+	struct fb_info *fb_info;
 
 	if (fb_get_options("atafb", &option))
 		return -ENODEV;
 	atafb_setup(option);
 	dev_dbg(&pdev->dev, "%s: start\n", __func__);
 
+	fb_info =  framebuffer_alloc(sizeof(struct atafb_par), &pdev->dev);
+
+	strscpy(fb_info->fix.id, "Atari ");
+	fb_info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+	fb_info->fix.accel = FB_ACCEL_NONE;
+
 	do {
 #ifdef ATAFB_EXT
 		if (external_addr) {
@@ -3052,15 +3058,20 @@ static int __init atafb_probe(struct platform_device *pdev)
 
 	/* Multisync monitor capabilities */
 	/* Atari-TOS defaults if no boot option present */
-	if (fb_info.monspecs.hfmin == 0) {
-		fb_info.monspecs.hfmin = 31000;
-		fb_info.monspecs.hfmax = 32000;
-		fb_info.monspecs.vfmin = 58;
-		fb_info.monspecs.vfmax = 62;
+	if (mcap_hmin == 0) {
+		fb_info->monspecs.hfmin = 31000;
+		fb_info->monspecs.hfmax = 32000;
+		fb_info->monspecs.vfmin = 58;
+		fb_info->monspecs.vfmax = 62;
+	} else {
+		fb_info->monspecs.vfmin = mcap_vmin;
+		fb_info->monspecs.vfmax = mcap_vmax;
+		fb_info->monspecs.hfmin = mcap_hmin;
+		fb_info->monspecs.hfmax = mcap_hmax;
 	}
 
-	detected_mode = fbhw->detect();
-	check_default_par(detected_mode);
+	detected_mode = fbhw->detect(fb_info);
+	check_default_par(fb_info, detected_mode);
 #ifdef ATAFB_EXT
 	if (!external_addr) {
 #endif /* ATAFB_EXT */
@@ -3100,43 +3111,42 @@ static int __init atafb_probe(struct platform_device *pdev)
 	}
 #endif /* ATAFB_EXT */
 
-//	strcpy(fb_info.mode->name, "Atari Builtin ");
-	fb_info.fbops = &atafb_ops;
+//	strcpy(fb_info->mode->name, "Atari Builtin ");
+	fb_info->fbops = &atafb_ops;
 	// try to set default (detected; requested) var
-	do_fb_set_var(&atafb_predefined[default_par - 1], 1);
+	do_fb_set_var(fb_info, &atafb_predefined[default_par - 1], 1);
 	// reads hw state into current par, which may not be sane yet
 	ata_get_par(&current_par);
-	fb_info.par = &current_par;
+	fb_info->par = &current_par;
 	// tries to read from HW which may not be initialized yet
 	// so set sane var first, then call atafb_set_par
-	atafb_get_var(&fb_info.var, &fb_info);
+	atafb_get_var(&(fb_info->var), fb_info);
 
 #ifdef ATAFB_FALCON
-	fb_info.pseudo_palette = current_par.hw.falcon.pseudo_palette;
+	fb_info->pseudo_palette = current_par.hw.falcon.pseudo_palette;
 #endif
 
-	if (!fb_find_mode(&fb_info.var, &fb_info, mode_option, atafb_modedb,
+	if (!fb_find_mode(&(fb_info->var), fb_info, mode_option, atafb_modedb,
 			  NUM_TOTAL_MODES, &atafb_modedb[defmode],
-			  fb_info.var.bits_per_pixel)) {
+			  fb_info->var.bits_per_pixel)) {
 		return -EINVAL;
 	}
 
 	fb_videomode_to_modelist(atafb_modedb, NUM_TOTAL_MODES,
-				 &fb_info.modelist);
-
-	atafb_set_disp(&fb_info);
+				 &(fb_info->modelist));
 
-	fb_alloc_cmap(&(fb_info.cmap), 1 << fb_info.var.bits_per_pixel, 0);
+	atafb_set_disp(fb_info);
 
+	fb_alloc_cmap(&(fb_info->cmap), 1 << fb_info->var.bits_per_pixel, 0);
 
-	dev_info(&pdev->dev, "Determined %dx%d, depth %d\n", fb_info.var.xres,
-		 fb_info.var.yres, fb_info.var.bits_per_pixel);
-	if ((fb_info.var.xres != fb_info.var.xres_virtual) ||
-	    (fb_info.var.yres != fb_info.var.yres_virtual))
+	dev_info(&pdev->dev, "Determined %dx%d, depth %d\n", fb_info->var.xres,
+		 fb_info->var.yres, fb_info->var.bits_per_pixel);
+	if ((fb_info->var.xres != fb_info->var.xres_virtual) ||
+	    (fb_info->var.yres != fb_info->var.yres_virtual))
 		dev_info(&pdev->dev, "   virtual %dx%d\n",
-			 fb_info.var.xres_virtual, fb_info.var.yres_virtual);
+			 fb_info->var.xres_virtual, fb_info->var.yres_virtual);
 
-	if (register_framebuffer(&fb_info) < 0) {
+	if (register_framebuffer(fb_info) < 0) {
 #ifdef ATAFB_EXT
 		if (external_addr) {
 			iounmap(external_screen_base);
@@ -3150,7 +3160,7 @@ static int __init atafb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	fb_info(&fb_info, "frame buffer device, using %dK of video memory\n",
+	fb_info(fb_info, "frame buffer device, using %dK of video memory\n",
 		screen_len >> 10);
 
 	/* TODO: This driver cannot be unloaded yet */
-- 
2.17.1

