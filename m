Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88233D505
	for <linux-fbdev@vger.kernel.org>; Tue,  9 Jun 2026 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020836; cv=none; b=aeWPUEsvVvkYARn9UHmYi6FjnzUf8cC/qOc/Qsr8uSIwtCTGycugoRlWyQ9/vXvKhQRrxKZxcM/Ts+ZyddB8sIu/zmOCegQhbeBQjGrCRF8J86lsDiwN/obEQ9G8SQ5alM3f3JxnC6M6mo5f4knN7rW9AmhLehI91QXV+AfwXlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020836; c=relaxed/simple;
	bh=pytIFKARKAlOugb4ojkEBG+x9rQgE7IrEf8tFij0/Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lsDCfmJcSMcswDd31guBt6sjJ1lE28jG7Ip7trrM9aKO1shssEjSvHjqY26Eus1KHDQlD47K0Z6ZYk5ozfM2hZm6AG2cQK3gWNee+mq+8B7MdJSzNjIjKrgky/fGw9eTL0bxd33d9RsRiGCEqvE+Ktzt8424h6XpX8YxO7TMRVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJKKhCck; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJKKhCck"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf1cda2b17so42443525ad.1
        for <linux-fbdev@vger.kernel.org>; Tue, 09 Jun 2026 09:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781020834; x=1781625634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I13MawXg0cVVfgeTQBDKuPQbb4kgdF9QdrPA6/FJBmI=;
        b=dJKKhCckYgeiBSlnDC/P6FFAJ4mePpKfyNseMTomEf6LLiyIbGBy/4Vmk2zsQc1VWX
         8OjZ9WNzkGkDeEIG5ovJ1tbzp1vpQN+Xh2UPRE/2ScF32qeBICvu30+KU1clBnJIelKs
         82TlsHtofMtpXwbNFoTuRLKG2r+rfmczCsCqzU5ygmI3I9ODwcWIyRnJIeY7TCHTOEHM
         EoAKiVyncD1hhpWZROgMoC7NS1oMCZn8si2pKzNboXC8TX6jRzSliAfsbFd7nR8quyaS
         lSbuytY+xOUa6SshdM2pH82RmTOkTo5L8WHm3Rfj9NjkPuPaQRGoKG0p6q/2XmzN3yG8
         lQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781020834; x=1781625634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I13MawXg0cVVfgeTQBDKuPQbb4kgdF9QdrPA6/FJBmI=;
        b=e655b1C06obgwgGJ8fWyhESFclofH7RTFAKL8RAmteRM/cXzpmGT4N2oEs4f984ql0
         NwHOZ1UlLAlo90l6MGKiinmPTs1tcRw7BYQtoLlD1HF/pcvGT6NroA3CyZOMZkDAhk2F
         RaY4Kh9kV3LVkaTdgEirvogNZgeyrY9WvZdrw+xlo82R2bYxt+5DVNSzESsbRmCb1XRA
         asKkJZwMti9qmNs9/kkbXsrVJV7eLQHkkM0Ukeo8DEkewxnr3BpoPHWEdqQLBaYn8L1Z
         /HGjFEA372akAnjrBImZcOyWylTvPmySNkPnF9Jj5pj96j5B7Qk93z9KaUFY1Eg6mPWZ
         g1JQ==
X-Gm-Message-State: AOJu0YxbuyeUDzPhAEWdgtApAPpTTGaK6Htp3rBH6A/Rey0BOTJHoFDF
	ms6WHcnJ0rcs598riqhTKjOm4cLjrumtdnDKsFhA1hbTrdGg6M+2pFKj
X-Gm-Gg: Acq92OFUAJoZ/eOY5Pa8pU3rsVW1ssK/3iilXekqMeNfPRAx/7j9upUEHXL8cGwNiyp
	TF8yEjySTlg9ZuaMvD6s8CLm2NilLDnRYQAynQz9ZtItZ157WvwbHLkjNkCUZ/NBOSR1YTGZDg6
	FCEOffcg8oEY4IS3kjxuZ07JE+LhVxU96mBEGCbWE545hmkiSo/o875d9B6AQ6qz9tFap88iVMy
	9rR3wJc+NrzE4ewXuIYHNDvW7PnZ9hSSBdelnyKWJ4ZEVXwEjIwly/V83+M0QTIQCe6dOMMy2yY
	azducZ82Vo7fQRMUCevX/3SIkQ8Wru1fFecYYmNY4QVJcMT22OySV/wPoqoJW+CSbZBd0/nZ9go
	CewKSqbJl7uf0Qalur7dG+OgBqMblg/uT6f0TkIfidFFTarIATod+/q/O4DxIAlibDrnijketiu
	35Aao1drkugfiI7p60S7nJL4JtUsCCEC//r1SKLKWI+NxqvmcrpLc3GA==
X-Received: by 2002:a17:902:e5cc:b0:2c0:ccdf:5e61 with SMTP id d9443c01a7336-2c1ec66c7e6mr175806875ad.6.1781020833563;
        Tue, 09 Jun 2026 09:00:33 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:37c9:44fa:729b:6aaa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c249aeb62csm96424255ad.68.2026.06.09.09.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:00:33 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] fbdev: modedb: keep mode option buffer until parsing completes
Date: Wed, 10 Jun 2026 00:00:28 +0800
Message-ID: <20260609160028.5-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fb_find_mode() obtains the mode option from fb_get_options(),
mode_option_buf owns the returned string and name points into that
buffer. The done label frees mode_option_buf before the database
fallback has finished using name in name_matches(), so the fallback can
read freed memory.

Move the free to a common exit path and convert the successful returns
that can use mode_option_buf into jumps to that exit path.

Fixes: 089d924d03d5 ("fbdev: Read video= option with fb_get_option() in modedb")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/video/fbdev/core/modedb.c | 41 ++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index 703d0b7aec322..82f6ea38e1fb8 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -627,7 +627,7 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 		 unsigned int default_bpp)
 {
 	char *mode_option_buf = NULL;
-	int i;
+	int i, ret;
 
 	/* Set up defaults */
 	if (!db) {
@@ -724,10 +724,9 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 			res_specified = 1;
 		}
 done:
-		kfree(mode_option_buf);
 		if (cvt) {
 			struct fb_videomode cvt_mode;
-			int ret;
+			int cvt_ret;
 
 			DPRINTK("CVT mode %dx%d@%dHz%s%s%s\n", xres, yres,
 				(refresh) ? refresh : 60,
@@ -745,11 +744,12 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 			else
 				cvt_mode.vmode &= ~FB_VMODE_INTERLACED;
 
-			ret = fb_find_mode_cvt(&cvt_mode, margins, rb);
+			cvt_ret = fb_find_mode_cvt(&cvt_mode, margins, rb);
 
-			if (!ret && !fb_try_mode(var, info, &cvt_mode, bpp)) {
+			if (!cvt_ret && !fb_try_mode(var, info, &cvt_mode, bpp)) {
 				DPRINTK("modedb CVT: CVT mode ok\n");
-				return 1;
+				ret = 1;
+				goto out;
 			}
 
 			DPRINTK("CVT mode invalid, getting mode from database\n");
@@ -793,8 +793,10 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 				if (!interlace_specified ||
 				    db_interlace == interlace)
 					if (refresh_specified &&
-					    db[i].refresh == refresh)
-						return 1;
+					    db[i].refresh == refresh) {
+						ret = 1;
+						goto out;
+					}
 
 				if (score < diff) {
 					diff = score;
@@ -804,7 +806,8 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 		}
 		if (best != -1) {
 			fb_try_mode(var, info, &db[best], bpp);
-			return (refresh_specified) ? 2 : 1;
+			ret = (refresh_specified) ? 2 : 1;
+			goto out;
 		}
 
 		diff = 2 * (xres + yres);
@@ -831,21 +834,29 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 		}
 		if (best != -1) {
 			fb_try_mode(var, info, &db[best], bpp);
-			return 5;
+			ret = 5;
+			goto out;
 		}
 	}
 
 	DPRINTK("Trying default video mode\n");
-	if (!fb_try_mode(var, info, default_mode, default_bpp))
-		return 3;
+	if (!fb_try_mode(var, info, default_mode, default_bpp)) {
+		ret = 3;
+		goto out;
+	}
 
 	DPRINTK("Trying all modes\n");
 	for (i = 0; i < dbsize; i++)
-		if (!fb_try_mode(var, info, &db[i], default_bpp))
-			return 4;
+		if (!fb_try_mode(var, info, &db[i], default_bpp)) {
+			ret = 4;
+			goto out;
+		}
 
 	DPRINTK("No valid mode found\n");
-	return 0;
+	ret = 0;
+out:
+	kfree(mode_option_buf);
+	return ret;
 }
 
 /**
-- 
2.51.0
