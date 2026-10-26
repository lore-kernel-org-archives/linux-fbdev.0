Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029742;
	b=Ihs9QoJ+gJ36i/aX3UAYqdY+R+AahSovRMOx3lqjbtTl8SHDPh7toHYZDmRG81VIH3la
	 VzahJ32i2TbJZIReOHrytPqZ5inMMVwnflzqsTHyRlWfzj65tW4eOqJW7mx//mR0n/nCp
	 uDPDBp2YA5RzOeM4uGZ2y8vPQcNOkrJPz0OOgL9ERqyrxNP+WkjsFlJeW8ktXQAhwxdAl
	 9r/H6jMX5UR+ykTEIyN9814DTneX21c3HblAFrGNUfAEYE0NoTTwNPVCwr04KnV1H+eJD
	 OKSZ57+rYR0QPljht5tHBiHcrZzDg1wwOj6j1K1yVGrur746ewuxtWKPudPlfwJaSWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HsJcoE+tcg++lXHusmJ7l3VcG6mAANy+njpMsw2MDrY=;
	b=tAFD5u3nOc8PFNeSOar/kpY94b35r4cHmANkA/pxULLV4Bh2KtnMCZUkb8ldSOa/q/Gq
	 WHyD6EjGE8niDtNGw2UFGNseoYOZE+BVCqgSvE7lqizYwwxp6z/Ntym+MyYJg7jlJwZUD
	 KxFXAbE23U42xozgZPQsmL+vBGgQIDwoqG6Kb7OlcSnL5VbDNPjrkX9tev3mueO2oGPOP
	 oyFbgD/Mqm/PY8kvOkraZVV5WyWqmdNTZD1ydR8JlaR9fcFlJIBJdnlM0h9OPldG2ud/G
	 1yUHCgLaugZJiXP6kvfoqCFpu/HChCfQSyppSooobS+uRi3fXOQwI57GYDkLSqXL4xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="R/7VtgIM";
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB9C606A31A
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 15:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DB9C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R/7VtgIM
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35c76e9614aso5074808eec.0
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 08:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793029741; x=1793634541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HsJcoE+tcg++lXHusmJ7l3VcG6mAANy+njpMsw2MDrY=;
        b=R/7VtgIMVUPjS3JNQbeOlGQ1HwUljc1QN/3FRshRpSijhV4BIopmB7prNof/3ppYEM
         J93Eiq75HlvCBMK1nH7ibCTOoXhq42H3kjKrt/ogOanLUSp2ug9qdj6amvozq54QT2Nd
         UX7OlbfPTz7npVbIW8wzVhmDEkIywkba6ZPxFb+aNY5gq4gtq9TgZ7eSmKHSNek9sKkW
         ZeMoLFf3F5+zKz9YJuSjd7RAH76U+cYx5rKK7zVg+zINSmK7oUzkrzd2uSlXHMhs2bAk
         VgwzpXP+uhkZoVqA6Y9SVVMwSHWd4r+9GstoXSEQL/eh2zgin76BnAV4YUL4GsgQDF82
         b12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793029741; x=1793634541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HsJcoE+tcg++lXHusmJ7l3VcG6mAANy+njpMsw2MDrY=;
        b=B9a7xWw3vWvYrC+THTKz4DA5ww5j6U7MbfM4hIVgYwOoXkRGLibUw6q4vGTtUV0uEf
         v76ZCWgdTiH4nudk9NhykDZ8boC9KPc2SeGnWCDMzBkhlMl4XZsI/eD15Pfs8rmEUr3j
         oBZHBnsgKXl8aJ/kCRymAhxkx1+PI2M/SjquPxRQvIM6udTmhvkJr+n/QmYAwhruGgG9
         ESuOQyf8q4qRG32AE9+2ulMs7BNnjWt/onrJP5XfVlECcbU38g3RkK7YgxdAEhr6z+2g
         ExHJYFPEF0atV2S9G0WonCtpPwPj80fzSUM8FqrmA6H6pTW8o32kDDn0B4vPfKQ6zV8W
         3xMA==
X-Gm-Message-State: AFq9FYKHXK7qIyevqUjbp4Gxe56q2nqeP7ZNWGFrLv3yN11dT1WUNJsw
	NzpdbhEqvBVXBeQef0fB8/Dv1JZGetp4nXVKH4Lmrytf9u6yvcO31V/5
X-Gm-Gg: AYBFou1IRbUTfbXj9JUPh9NqA7eN6QkarsGj1F9IESQbzsBefMjVOEomOiC1BwXphF6
	WOv/zl41A/veoTkM2L8IZwYNysUmgS7sJOCFt6x5FiDsvkgzws2yOUv1Rc+A3XdXavGBjdEvzYd
	wou8rlspK+7/72e1OEN85HuIdEEd4nCgaT3cuvPTlITZQBdEbmzWB7l1Yb9vCRWJn1oYWvu//rW
	wWUzOXcrMTUTlomIKJU7p+wdSClVA0fs9z2Alq6puVNTSziNj/K7tvuqQpFnZUFWX5Poni0yA6w
	zRICILaOvMLnsFcRtl9REtzYQyvRYlxg6QBKaaI6aqPP7KgPMZLZQnY/zZqtY6wM6TZSF5xu5KY
	2PaeMm260495szxPo3m1tH0bfxCgrVxPfBH8mAqyG+APNnrFBynFLUJMyLfGTNPEYj9MkpHPdk7
	fdH9k6XYqxHrUqrokBwYmpHwrJwhEHo/porZIZOJ+BasRYdksdroPUiSPjY+Z/d+CtZazi2p0e3
	kz8wBUhwzw8QmPE4weAB5Lbk/65s6QnxlDYRa6ZSVKMmRb5GqK0niBPbulVLX0/hfwmt8I6s14m
	YVU0ny5BZtpVHI6HuFHasS1EBVMO
X-Received: by 2002:a05:7301:514a:b0:359:3460:bc1c with SMTP id 5a478bee46e88-369e8492c25mr10432744eec.12.1793029740452;
        Mon, 26 Oct 2026 08:49:00 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f44bd644sm18151012eec.15.2026.10.26.08.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:48:59 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	co+b0df61d49532b2ee@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] fbdev: vfb: Validate framebuffer geometry and memory size
Date: Mon, 26 Oct 2026 08:46:05 -0700
Message-ID: <20261026154604.579823-2-bestswngs@gmail.com>
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

FBIOPUT_VSCREENINFO can supply a virtual width large enough to
overflow get_line_length()'s int multiplication and bypass the
video-memory limit, allowing fbcon to write past the framebuffer. The
offset additions can also wrap, while an excessive videomemorysize
module parameter can be truncated when PAGE_ALIGN() is assigned to
unsigned int.

Limit virtual geometry and offsets to 8192 x 8192 and cap video
memory at 512 MiB, keeping the stride, framebuffer-size, and generic
fbdev drawing calculations within their destination types.

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

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: <co+b0df61d49532b2ee@bugs.sh>
Suggested-by: Helge Deller <deller@gmx.de>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes in v2:
- Limit virtual geometry and offsets to 8192 x 8192. This retains 8K mode
  support while bounding all generic fbdev drawing calculations.
- Cap videomemorysize at 512 MiB.
- Keep the existing arithmetic types now that all inputs are bounded.

 drivers/video/fbdev/vfb.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index de137b2bd..de40ba8c3 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -31,6 +31,9 @@
      */
 
 #define VIDEOMEMSIZE	(1*1024*1024)	/* 1 MB */
+#define MAX_VIDEOMEMSIZE	(512 * 1024 * 1024)
+#define MAX_XRES		8192
+#define MAX_YRES		8192
 
 static void *videomemory;
 static u_long videomemorysize = VIDEOMEMSIZE;
@@ -159,6 +162,14 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
 	else
 		return -EINVAL;
 
+	if (var->xres_virtual > MAX_XRES ||
+	    var->yres_virtual > MAX_YRES)
+		return -EINVAL;
+
+	if (var->xoffset > MAX_XRES - var->xres ||
+	    var->yoffset > MAX_YRES - var->yres)
+		return -EINVAL;
+
 	if (var->xres_virtual < var->xoffset + var->xres)
 		var->xres_virtual = var->xoffset + var->xres;
 	if (var->yres_virtual < var->yoffset + var->yres)
@@ -434,9 +445,13 @@ static int __init vfb_setup(char *options)
 static int vfb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
-	unsigned int size = PAGE_ALIGN(videomemorysize);
+	unsigned int size;
 	int retval = -ENOMEM;
 
+	if (videomemorysize > MAX_VIDEOMEMSIZE)
+		return -EINVAL;
+	size = PAGE_ALIGN(videomemorysize);
+
 	/*
 	 * For real video cards we use ioremap.
 	 */
-- 
2.56.0
