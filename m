Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482E4BFE82
	for <linux-fbdev@vger.kernel.org>; Mon, 12 Oct 2026 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827642; cv=none; b=WFOOurYTeDCyFTWw2TZ8z/lXkZ9n0jxW03vTP6GUO4YyS91IPOBLI3f+c+8UtMMYKDVihOcjkSyuoLMqa0ibixsV+lwZ8fbjVczvDK/3nk8jdiCyHzaatE7TAgQ11vciEKt/OZw//cFJcWCPVjr3IJp6Lts6J6UEVYLZBBUrdRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827642; c=relaxed/simple;
	bh=DBFvf6LMpAJ03sozSIk/CRTorRD2UyaqRnlG5DyjTlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=msG6m2Qow+zsUphbNPacSnLrYzz+Zyak1IqHVJir1fmOBagKQKmCQm9uqZWdJwHPa9+i+hrfeHFckYJK5fZ+0UlzdhbF9dYmJ+s9RNV7ouLZqWJEH6KaL+jh1q2Z5tnDXp3nDf2fNPF/+fuJOj9Y4uSl01LTaS5+Xniy2pIzY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ath056ul; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ath056ul"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48c4207ac26so2078104f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Oct 2026 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791827639; x=1792432439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QntbKw3gaGgw4tIzgsEy78HK5tHJosqnu2qH2MEsZDc=;
        b=Ath056ulQElu2pL7OPP4nO3E+Lec3aFLH+N2vLFqthFyYDaue5OTKAsRtTUuvEXYaa
         RLJ/JHNvKW5NvnOPzfChosjm9l3w4p3eK0oV4ndDBlwExmNUJYBFc98E+lZoFFeWJ7Qh
         nDNxVJmEllOxQexk1oC1gLL5U9pAaeWlAOJVAwKEWEykERT4Ji48XIxQet6V4jOXGKj7
         FiinpkDHUXt/d5ItO4PVcJ9C+4JWlI8/QivVYOMXzo45R7x9grOtxqiF8+fRuYLFr6Ux
         4qQkiRNiu75/A2QmHt8XBFB1Kq10qXMVxKGumfKgdLtyFUIROsESnzRriAUih+QjDGRG
         w4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791827639; x=1792432439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QntbKw3gaGgw4tIzgsEy78HK5tHJosqnu2qH2MEsZDc=;
        b=GrAP7+n9eYqlU/J+qScWR+de20PjL0rHRDxfm3V/pPqQpCWZ5g9/GZTqZob4B//NH6
         GWXqk5JC8JgSvpMSyx1J8+cLBdraEdoRywZpc/1Z+iqngufqcS0r40Y7rqFS61PwRw8H
         NdqAt+KZal6PsyIVmb8rm+HO6CLWm0jx53aOuRU0PELr/SsFsKa5nGx/TWZZ0nDvv1b5
         wdb9Rg1WXTdgqusCgEdRuAJOcwkkGVF8si+x644Er1/w8BWBsB/BhqiRKCQU4FU6bzhB
         9nrp/ko+jeErdfJmGT58VM6kSPhv7gFJtCwrdi8ei4EUWeufLHdF4vOTaT/y5iwMsi9s
         AUVA==
X-Gm-Message-State: AFq9FYJEqtnJ2yUXChquidkr1N6hlEiaAoelR7BgwwTUr5wZdV0LFpmw
	icSGMII7Q/Keje/pripYqfkECjEpxaDwWvZrC7BvXuvl0fmUVlGAeksA
X-Gm-Gg: AYBFou1Xwq1QLWx9O9C2QKZyuYN5iwR/pwUK3EJg9joIIw+UJXcuAHpZiyXdtNgYzt+
	2DnaSY4llOW6V80LzrwujZy40/OzpK8nxAbMZUYuHN659a3ROoC821G+jWhoexZTvrsiobW1SHj
	UryyQA4tzyw1yziijo+MSsJBL/cNGvLsuKKaIRZKZ2rloH8C5vGFMfcVdWXCvtKz/z9hQqBcvJk
	AZ25QV5cng8tSIDuU0DDMLWXiVMFIPdabp7gIg+UFRjzUrbEpMwQxZvTpdatA00ukbbEcnqBNsI
	zA7HZIfKW7tz0BMxF94esnnEdF8j7E5O9vlbwJyYPgYIbUOjUPHfl/wzOC0APzQlIZKwCftlr2e
	+eGnNkjJCBrvA7Ab8+sSmvkK1izGOom9nUX4tHZEjrqqbC1fQMsc9hMv8gPp9Qv7mPLthIyuzpT
	bURk1lyGynY4FgagvshuHfItrtiQJm+u1PqctEe5NicKNBz2vErglS3fUwAkQo613zdOc=
X-Received: by 2002:a05:6000:26c6:b0:48b:10af:f85e with SMTP id ffacd0b85a97d-48dbaaee1admr18683631f8f.33.1791827638653;
        Mon, 12 Oct 2026 10:53:58 -0700 (PDT)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab5af7sm667374f8f.31.2026.10.12.10.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:53:56 -0700 (PDT)
From: Andrey Misiurov <andrey.misyrov@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	Andrey Misiurov <andrey.misyrov@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: core: Initialize modelist in framebuffer_alloc()
Date: Mon, 12 Oct 2026 19:53:38 +0200
Message-ID: <20261012175338.2283897-1-andrey.misyrov@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

framebuffer_alloc() returns zeroed memory, so info->modelist starts out
with NULL next and prev pointers. The list head is initialized only
later, by fb_videomode_to_modelist() or by do_register_framebuffer().

The "fix potential memory leak" commits listed below added
fb_destroy_modelist(&info->modelist) to the probe error paths of s3fb,
tdfxfb, tridentfb, i740fb and carminefb. These paths can run before
the list head is initialized:

 - s3fb, tdfxfb, tridentfb and i740fb call fb_videomode_to_modelist()
   only after a successful EDID read, and tridentfb can also hit the
   error path on an ioremap() or kmalloc() failure before that;
 - carminefb jumps to the error path when fb_find_mode() fails, before
   its fb_videomode_to_modelist() call.

fb_destroy_modelist() then dereferences the NULL head. Reproduced on
Debian 12 (6.1.180) by binding s3fb to a VGA device without EDID and
forcing fb_alloc_cmap() to fail:

  s3fb 0000:00:03.0: cannot allocate colormap
  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:fb_destroy_modelist+0x10/0x80
  Call Trace:
   s3_pci_probe.cold+0x12b/0x2bf [s3fb]
   local_pci_probe+0x41/0x80
   pci_device_probe+0xc3/0x240
   really_probe+0xde/0x380
   __driver_probe_device+0x84/0x150
   driver_probe_device+0x1f/0x90
   __driver_attach+0xce/0x1c0
   bus_for_each_dev+0x87/0xd0
   bus_add_driver+0x1ae/0x200
   driver_register+0x89/0xe0
   do_one_initcall+0x59/0x220
   do_init_module+0x4a/0x1f0

Initialize the list head in framebuffer_alloc(), so info->modelist is
always a valid, possibly empty, list and fb_destroy_modelist() is safe
on every error path. Keep the lazy initialization in
do_register_framebuffer(), as drivers that embed struct fb_info rather
than calling framebuffer_alloc() still depend on it.

Fixes: 3b0ed04bc852 ("fbdev: s3fb: fix potential memory leak in s3_pci_probe()")
Fixes: bb019d755366 ("fbdev: tdfxfb: fix potential memory leak in tdfxfb_probe()")
Fixes: 7a35ec619d9a ("fbdev: tridentfb: fix potential memory leak in trident_pci_probe()")
Fixes: 5936063409af ("fbdev: i740fb: fix potential memory leak in i740fb_probe()")
Fixes: 6fcca16a2b19 ("fbdev: carminefb: fix potential memory leak in alloc_carmine_fb()")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Misiurov <andrey.misyrov@gmail.com>
---
 drivers/video/fbdev/core/fb_info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/core/fb_info.c b/drivers/video/fbdev/core/fb_info.c
index 52f9bd2..05988a9 100644
--- a/drivers/video/fbdev/core/fb_info.c
+++ b/drivers/video/fbdev/core/fb_info.c
@@ -43,6 +43,7 @@ struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
 	info->device = dev;
 	info->fbcon_rotate_hint = -1;
 	info->blank = FB_BLANK_UNBLANK;
+	INIT_LIST_HEAD(&info->modelist);
 
 #if IS_ENABLED(CONFIG_FB_BACKLIGHT)
 	mutex_init(&info->bl_curve_mutex);
-- 
2.43.7

