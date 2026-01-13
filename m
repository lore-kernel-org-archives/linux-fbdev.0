Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA3F2F6594
	for <linux-fbdev@vger.kernel.org>; Tue, 13 Jan 2026 04:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768280383; cv=none; b=mM7L0N69vzOffG0VvcejvmTsWYujEny49LKpDMmkphgV0esTftbrCnOFrh31jGX8RCCamWedlmfc/X0un0hMOUfzho36L7tZEYBVEOvj1WaxJzmtsS2ZIRtBIx3ZtL7ZpUpgYve9DhNeAgKAQoERSykFrvy7nWljuSyTSpS1OcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768280383; c=relaxed/simple;
	bh=bCEMHZ6kz6Fm1BrBwVu56MAE7W4gVEikAeeavZ/Di9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=db8Zeo90Mds104SvyCO1G9rfmP6KZrWOoj3QpDDKIP5OqHr7WgJRcC3UTnVw4nHBIQrTIiAfLqPYZWxWZfLyTRubj+9jafo56RFM4Q3yBl8gquyZuaQjVGpQynCyxGwxmsM568yJGRIEJe8zSRsxyoHLXBJkXRiBFRJC69p+hyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROu4u9rg; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROu4u9rg"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b553412a19bso3211724a12.1
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Jan 2026 20:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768280381; x=1768885181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTvxo6KbWMtGy6RGpj72F7tdPe/SFWx8IlZmuHDEiGo=;
        b=ROu4u9rgjOCaXGJEOSbb5pNZ9vmHO3Tev3hoSEt5orAw5hu84/0oqAgsEGjFT5M8Vp
         XrBD9LBYWzOMjJzJvxP3TyVutZ3dKPFHSM+t8A2f8h2MXYN71EbCbNL7kiecA++jpbJs
         5pGwQ/ixsl9ZHiJkjrpMK/FpmSEefHBnFB2qjoJZuwU8B1L4G+R1Ic3Gvs2Tudl8IX7m
         K68viRaUe0lj2cgrbnlOCeKpUsvZsIn0A6Eef66rFl90Ns8rqxUZWHderY4SK76ODJXr
         8d4MgwLD3UtFP/1chuXyKl9egz/n6qgrNo6ybwNSD75CZN+GTXCbWC0fkSJbdpNflreA
         T4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768280381; x=1768885181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTvxo6KbWMtGy6RGpj72F7tdPe/SFWx8IlZmuHDEiGo=;
        b=fK3nZEzBgvoHwrEPZAL7G65vKPl+SwrMrj9jgTwjnm8WmGQ3vClP70GguwH+nS+EkW
         T48YLip+qYMZcbpx0tjXCpAI4CmKrbaDXVNrbXaiPDZsfcUIri7fBQPbjXYjWHnnxXsf
         SKajKhqCPCstWaxY+11nVkTWnDLvJRYr2YF9gGQMv5dPfZpSwDZzBeRjJROX4KpZCoDD
         xwuR/NEgW7awWER0iiIYPLAaCJe0pDCeWdja8wFxT0k6f+YlGH//pS75qrcbV4Y4aIBo
         etlQo9stFgqHZS74HkTQCPkrex3JF9XsChkbknV91YEj/zmoou3uCCGQLVD2I4HQBZ0/
         WHHA==
X-Gm-Message-State: AOJu0YxN4QKhjwwqooBfL1JT88CFPiXEhET/RcgsOfo+bp2tlAQvQE2j
	KmhvwKXVf+D3ZwzwpXchNFd0exp7E/ikAvgkIT8zsZe/E/YqobLxiK7+o8ZNNA==
X-Gm-Gg: AY/fxX7gnjVTcXZZGYXidn9Vyk+MnkiArQSVJ9EaOIXbp57oDF58+kjlcZfpk4zjk4i
	mcwKNxwJSQNDVJKY2KXL5WnD0xzRmFEJjsINwG5/8CAaBQYqowwwIIic66RnhgFCGVGleACcHYb
	E8WNxzI5+fonCJrR2VcAucFXsHAvDbRT8nyQeDYHhaVbdOG3jrYDhTxtkJ711KwMlRnosRg2u6y
	YzNrPW5TkrYcRIXdO07YKbXcqFaFyTF9E9Mu4LQh6f5LHNUQXnRyYWLKmY/GdeF6wOvZen7+bUZ
	Hk6IfVHKy3TlOUdMUlriELUlTcOyCLTLZqmvDDRXz4Lqj5AiQMQ6sWiDiDU7fQBA06F0PAPqEC2
	JsLdfKvjhnlyf0wSDsQPKQUpeT1hCqJ9PbgIuTWZbd3h6ARec5vohOmtI+uUsJXJg15shiMzo0i
	5Q/r0yxrDTGp7Jeo/BiFVzJFzbtODlD7wB7p4MDEi2G6c=
X-Google-Smtp-Source: AGHT+IF5y3wMzzLD9O647B9Fwv+OhX6pLmVT/zSElB3m1p3Mv2vCh9yICG/2VmelPoTP3BFPVF2CNg==
X-Received: by 2002:a17:90a:d40c:b0:34a:b8e0:dd64 with SMTP id 98e67ed59e1d1-34f68c023eamr17396933a91.1.1768280381428;
        Mon, 12 Jan 2026 20:59:41 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:6652:1d71:eee0:e3bb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb74436sm1341597a91.14.2026.01.12.20.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 20:59:40 -0800 (PST)
From: Chintan Patel <chintanlike@gmail.com>
To: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	tzimmermann@suse.de,
	andy@kernel.org,
	deller@gmx.de,
	gregkh@linuxfoundation.org,
	Chintan Patel <chintanlike@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v6] staging: fbtft: Use fbdev logging helpers when FB_DEVICE is disabled
Date: Mon, 12 Jan 2026 20:59:09 -0800
Message-ID: <20260113045909.336931-1-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace direct accesses to info->dev with fb_dbg() and fb_info()
helpers to avoid build failures when CONFIG_FB_DEVICE=n.

Fixes: a06d03f9f238 ("staging: fbtft: Make FB_DEVICE dependency optional")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601110740.Y9XK5HtN-lkp@intel.com
Signed-off-by: Chintan Patel <chintanlike@gmail.com>

Changes in v6:
- Switch debug/info logging to fb_dbg() and fb_info()(suggested by Thomas Zimmermann)
- Drop dev_of_fbinfo() usage in favor of framebuffer helpers that implicitly
  handle the debug/info context.
- Drop __func__ usage per review feedback(suggested by greg k-h)
- Add Fixes tag for a06d03f9f238 ("staging: fbtft: Make FB_DEVICE dependency optional")
  (suggested by Andy Shevchenko)

Changes in v5:
- Initial attempt to replace info->dev accesses using
  dev_of_fbinfo() helper
---
 drivers/staging/fbtft/fbtft-core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 8a5ccc8ae0a1..1b3b62950205 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -365,9 +365,9 @@ static int fbtft_fb_setcolreg(unsigned int regno, unsigned int red,
 	unsigned int val;
 	int ret = 1;
 
-	dev_dbg(info->dev,
-		"%s(regno=%u, red=0x%X, green=0x%X, blue=0x%X, trans=0x%X)\n",
-		__func__, regno, red, green, blue, transp);
+	fb_dbg(info,
+	       "regno=%u, red=0x%X, green=0x%X, blue=0x%X, trans=0x%X\n",
+	       regno, red, green, blue, transp);
 
 	switch (info->fix.visual) {
 	case FB_VISUAL_TRUECOLOR:
@@ -391,8 +391,7 @@ static int fbtft_fb_blank(int blank, struct fb_info *info)
 	struct fbtft_par *par = info->par;
 	int ret = -EINVAL;
 
-	dev_dbg(info->dev, "%s(blank=%d)\n",
-		__func__, blank);
+	fb_dbg(info, "blank=%d\n", blank);
 
 	if (!par->fbtftops.blank)
 		return ret;
@@ -793,11 +792,11 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
 	if (spi)
 		sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->bus_num,
 			spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
-	dev_info(fb_info->dev,
-		 "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
-		 fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
-		 fb_info->fix.smem_len >> 10, text1,
-		 HZ / fb_info->fbdefio->delay, text2);
+	fb_info(fb_info,
+		"%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
+		fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
+		fb_info->fix.smem_len >> 10, text1,
+		HZ / fb_info->fbdefio->delay, text2);
 
 	/* Turn on backlight if available */
 	if (fb_info->bl_dev) {
-- 
2.43.0

