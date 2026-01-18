Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED8050097E
	for <linux-fbdev@vger.kernel.org>; Sun, 18 Jan 2026 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768695566; cv=none; b=cUCSSzvr5+aibk1BHdeO0fy2FGo7VYK+x0VNO5X9dGt3wbdiEV9a0fznKlEzVYbYOA0NT5AsKw0XcwkEO8IlR+cyvV1yrM8AH8/5WGB07os6HzVhRYc21rzlcqLbt08rpmLz8VG+XyHixzOH3O5KvZyXFJjnXLUUYK7mz0Xcjcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768695566; c=relaxed/simple;
	bh=Dt0E/74VzliK78NzMtLSkuFaR98tIjDyPVEm1FW7i2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UXo7Yrgz0rWd6T+fw7XiIXEC0v+jkQ9fDj8HmVUzYWfQsSPOTc3NWCZZ2MYeEXTHI9kTYtaTW/yftRL8szF5UD+5MHCTjubg+i84Qr9N1lx689LUwBsyGtW1EQXuxlVD9sv9/UkRM6+4azjaKDBJUXMnsB4LkBKQzL+l4cCW/Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/15JDJc; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/15JDJc"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b5ed53d0aso4475513a12.3
        for <linux-fbdev@vger.kernel.org>; Sat, 17 Jan 2026 16:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768695563; x=1769300363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U8yPWNCbUsD1Zh7l62UZjxa3bF9d9nEOvTtSBxLfUzc=;
        b=B/15JDJcNr0gJ2Pb7leBaq3HkEXBgJzhbZRe1+RXTP/HA9AhLJxUlktvESECQD2dNE
         hS/uGNlxtMvXI54CzAULbv5dbYHi+mhRJlKTLRiYK4A3Sf2FLhVYBuv43dXB3su86qTm
         Z8jeRkcCIAvMd72TCbUy6T+HXKHtDSDAtueuN1RC7Am/JxS4T5jS7B3AePBcHTlNFtRo
         IPbKDoKZ/eZMNsbCWQRT7wtAswdCBXTXrXH2f9V925JPZlS/AledBvJ1Ph+Dt+PcoW5r
         BHSEt4XpnRaZNGMmbc4LjVnwi2lH+XYT2IvgZPkheM6eqlv2cf8eZcayqcydfCwf0/Z1
         mQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768695563; x=1769300363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8yPWNCbUsD1Zh7l62UZjxa3bF9d9nEOvTtSBxLfUzc=;
        b=c+BXrr1mzVnrp5LqkSOHdtKKMk7+jhdaZXG/kJcFMEmFjzRAySNgcigM2vDOlJesHO
         wrVcUMZdOirUPw3DcKJMw/dinTmddWnlh9I6EBWrPekAuNK6KjPOW4LnGToNPsl/AmKr
         5szaFFI+HHPNKjVJ49CtoCFihnCzY+GVXzCTLUuyUiiR2sq84hGld4S65GohLMRzUtQh
         CDOJzz2lPELfU2EJ4l170XXllFje2H4Sn9K4vrVjdt6PgjSPjZ4BZRHixZzFWONY1BYO
         kO5us1YaOHhkTFzyl4CMYaaxBMQX9vaoy0DENd28vwoLOO4A7sH7nf7qS5i1guCdSVIl
         itTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeMluDZRrg3+ofL2ZHB5zq3SpIvomBmu5p+gY8uDj0aj7HM8ZAsAfY8I8Cm0yto8tc+k8pSPUTdZpaDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YylFyu9e5mUkgIOE908V8GvpbcQDvcMtAOh/pzt8rVaTtidRakN
	SZjDj1vyanEjeEABr4P4EDwN3S6ig+Z2CBEnYrcx3yLJdoaV3dRtZ0yD
X-Gm-Gg: AY/fxX6h964yo8+jh7LzAOmIDdEhLiCbVJHLqZRUw/8fkksfPftd9OOdVuRccao9arE
	snFJc312MFsLtiWRBuoGZAyGnT1MWAoVfpme93QdQM0neKEicVmbmV2r1jIr8RpsgLP1VgORuyI
	XMwyZqQ0FmMFDrcGo9sQ2MnCBwfS4p7/J/dmaJR76r/Lrs0W0ELPWUCHYktQbk7w4BVlzAn8dyL
	rCP1DMbrqXkjmz7xRH1aCUHwvRTg9l6eZd4h4uwPj+SN7vS/RagV+0JQSEYcLSE7RZvsgkJpkVe
	hSxjMsjw580dBvxa9i40ALMIr6p8eveeCxzAifqFW4oUbMHWgPicOkHHV+/acm3+a6lv0MM8Rmt
	7Vnm9woVTfAFvImV/JLfwHOpSM85ZJatliwNGFIp0zFAfIpPPmNQhGgDCZn+97CnyDa2bYEgn0E
	hNxSxyK+7ujBH2Nw==
X-Received: by 2002:a05:6402:5243:b0:640:ef6e:e069 with SMTP id 4fb4d7f45d1cf-654524cf263mr4839330a12.1.1768695562948;
        Sat, 17 Jan 2026 16:19:22 -0800 (PST)
Received: from osama.. ([2a02:908:1b4:dac0:5102:ac1a:4cf6:b9b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65452bce4f7sm6543849a12.6.2026.01.17.16.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 16:19:22 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Zsolt Kajtar <soci@c64.rulez.org>,
	Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: syzbot+7a63ce155648954e749b@syzkaller.appspotmail.com
Subject: [PATCH] fbdev: sys_fillrect: Add bounds checking to prevent vmalloc-out-of-bounds
Date: Sun, 18 Jan 2026 01:18:48 +0100
Message-ID: <20260118001852.70173-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sys_fillrect function was missing bounds validation, which could lead
to vmalloc-out-of-bounds writes when the rectangle coordinates extend
beyond the framebuffer's virtual resolution. This was detected by KASAN
and reported by syzkaller.

Add validation to:
1. Check that width and height are non-zero
2. Verify that dx and dy are within virtual resolution bounds
3. Clip the rectangle dimensions to fit within virtual resolution if needed

This follows the same pattern used in other framebuffer drivers like
pm2fb_fillrect.

Reported-by: syzbot+7a63ce155648954e749b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7a63ce155648954e749b
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/video/fbdev/core/sysfillrect.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/sysfillrect.c b/drivers/video/fbdev/core/sysfillrect.c
index 12eea3e424bb..73fc322ff8fd 100644
--- a/drivers/video/fbdev/core/sysfillrect.c
+++ b/drivers/video/fbdev/core/sysfillrect.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/fb.h>
 #include <linux/bitrev.h>
+#include <linux/string.h>
 #include <asm/types.h>
 
 #ifdef CONFIG_FB_SYS_REV_PIXELS_IN_BYTE
@@ -18,10 +19,28 @@
 
 void sys_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
 {
+	struct fb_fillrect modded;
+	int vxres, vyres;
+
 	if (!(p->flags & FBINFO_VIRTFB))
 		fb_warn_once(p, "%s: framebuffer is not in virtual address space.\n", __func__);
 
-	fb_fillrect(p, rect);
+	vxres = p->var.xres_virtual;
+	vyres = p->var.yres_virtual;
+
+	/* Validate and clip rectangle to virtual resolution */
+	if (!rect->width || !rect->height ||
+	    rect->dx >= vxres || rect->dy >= vyres)
+		return;
+
+	memcpy(&modded, rect, sizeof(struct fb_fillrect));
+
+	if (modded.dx + modded.width > vxres)
+		modded.width = vxres - modded.dx;
+	if (modded.dy + modded.height > vyres)
+		modded.height = vyres - modded.dy;
+
+	fb_fillrect(p, &modded);
 }
 EXPORT_SYMBOL(sys_fillrect);
 
-- 
2.43.0

