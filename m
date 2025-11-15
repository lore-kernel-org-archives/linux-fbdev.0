Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4E41487E9
	for <linux-fbdev@vger.kernel.org>; Sat, 15 Nov 2025 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763211434; cv=none; b=g7CrzwkwnRGpypgqF/QyNu3X7qSamj5zgPKS+P56PbmxoT8OYmKh6uf+wSK9dp6G4fJChU+Rp0tnUcGHi6QfC6aFmH533ydB6VivDS6xtQ9e19nz8aOf+/kXEZQjyhko1kBA8RarRJ7vDgWE38uwWPqwPzm8SYnBkmhXyDdBziI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763211434; c=relaxed/simple;
	bh=G/Zw8pa3EXQuNHfFDuTGOE01zAqIIEFHAsKkDNV7O0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OilhkjeJow2bSHqoyZkyzA6hI0EVks8QXeuaRwvAMz4rsCrhgZ4cJvpRro8C3OZLHlpGeumqrhbsRPaXEIjkvfMnNL3F8KPdG8HSkIotxlwWRWro8Ybh/T0dVkp0FtcrPcu9tvyAoBfJMZHXfgpivNx78Zb3rfrbcLisxi5AJzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUeuau+m; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUeuau+m"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so1445869f8f.0
        for <linux-fbdev@vger.kernel.org>; Sat, 15 Nov 2025 04:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763211431; x=1763816231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+wKe+4acY/h67BQeNtw3SYgKv7BLen9vezukdhy+6+w=;
        b=RUeuau+mb+4bnYP6BMbKblD1DKcyp0LomFa9HKuKTQLA9+6hxB0H3Z2aExK6ZBDol1
         Ffs3YTMxopPBY1UHGNTrehNxqYgbBQwer9cEntb9EJA84/18EHVDwdzuu30YlQp3RU8p
         4KQ5vcO+Fz5gdAoPjtio/eplEzeOlxtiYfJGYYEIp8PiyfOEofSqMp3IiIn/iZv41ji7
         jt+lOGeBD6E1Rjc5pHPRHNR4LjqJlWLwpemRfYyIC4lRUp8lRwWAMA9Jmwt/UU8L60Ob
         W9tavQuQie3KZZ+oVqULXq4b6xSJEljbeX5eEIJvmZ6eJdbDwadifE9BFAx8SKUudpYR
         ngYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763211431; x=1763816231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wKe+4acY/h67BQeNtw3SYgKv7BLen9vezukdhy+6+w=;
        b=T6OtO61AcSVbadqOt+Nmox23jDf5QevvUXTxSKZQR2G0SWjWHyLRT3gxbEYulvHv5i
         OCzb6YLSfFHOI22qlcwDSKmMmAKRPfhpCSkwv29M4vkGE+ot7LHwJJXx2J+qNOM4P1b5
         djxlodFAFisDOb5e+Cdg8czo4wShcoPn7A94yZzlCZayETDlnM5N6LpJIQOCN8kd+g5U
         GcOL9DcyYpHAGIwl68N0abCXru8PL7m1uSZ358oi3I0miwVbrLZQnr8+7/xvi8tMyY4J
         tq392JVhF3Up+X4OW7Pge7fXP69p12XJhIZmuBPoer7Aa04T3J/cjdSXAsEwI96toUxa
         ahMA==
X-Gm-Message-State: AOJu0YymcGCEubUN4i74qVt+M6qsa6//ySqGf4cfwhjWWa2abo0/9EAB
	//NJ+BZ5Eo65+WjyZPLdVf66VcD9qKP8ecTw3y2bkHrMM9kJlQu97df8
X-Gm-Gg: ASbGnctG31Zj25ceu3gjjrkU6Slz+6GirwjDMCVTxZD9emRxP2gDFkiMVcpfQwyz8g1
	NHNU1NRlU3Qb+58kDj6HEjzpHdOD57Qsj4DWJrn1MS+o+GpNZDme7VChJsPuppHsmpqvItEJfhY
	UU73HLnKtSxDGF+7Yf+3EyP1xO376WVZuF68eCplqQGK/Uzg3jrLwLkhf/GTB5bD1lFW4TB8e5q
	bMlMLMJ+yeo9SW5G9D11czDS3dGYBCj1MjdzfvG6NjRFqEdqZBWzm67M1Mb9D/X5FYociecOOYe
	Kfm7msi+aWTrfEv7Fvwmz360OirffrmrwEuDt7b2+pVs2Ol7bSoodF7YEY1phNQKxvZdxBv2+U1
	GtZfbkDla+PWtjI5kv/vTeKz1EwO0yarNz6RewKLKH5KtOTajLb6WeIX2jmfJiVNH73g9Uf31UA
	hRA6ROznspZ1a84BbCrKkn0ALElg0GCg52LJpvyt+/f1pxIavkvDM7wTu5SNk=
X-Google-Smtp-Source: AGHT+IEwVoyFEpiN4NwAdMpmY/gp7f0+PyXQEZWI8peRnu5CniD4Jka1XX/hO/l3ei9QcID98HqBow==
X-Received: by 2002:a05:6000:3111:b0:42b:3661:304e with SMTP id ffacd0b85a97d-42b528147bbmr9775893f8f.16.1763211430692;
        Sat, 15 Nov 2025 04:57:10 -0800 (PST)
Received: from dell (229.red-88-1-12.dynamicip.rima-tde.net. [88.1.12.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bcfa2e9sm68119745e9.12.2025.11.15.04.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 04:57:10 -0800 (PST)
From: Javier Garcia <rampxxxx@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH] fbdev/tridentfb: replace printk() with dev_*() in probe
Date: Sat, 15 Nov 2025 13:57:01 +0100
Message-ID: <20251115125701.3228804-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Replace in `trident_pc_probe()` printk by dev_* fn's
- Delete the prefix `tridentfb:` from msg strings, not needed now.

Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---
 drivers/video/fbdev/tridentfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/tridentfb.c b/drivers/video/fbdev/tridentfb.c
index 516cf2a18757..17b7253b8fbe 100644
--- a/drivers/video/fbdev/tridentfb.c
+++ b/drivers/video/fbdev/tridentfb.c
@@ -1631,7 +1631,7 @@ static int trident_pci_probe(struct pci_dev *dev,
 	}
 
 	if (noaccel) {
-		printk(KERN_DEBUG "disabling acceleration\n");
+		dev_dbg(&dev->dev, "disabling acceleration\n");
 		info->flags |= FBINFO_HWACCEL_DISABLED;
 		info->pixmap.scan_align = 1;
 	}
@@ -1693,7 +1693,7 @@ static int trident_pci_probe(struct pci_dev *dev,
 	info->var.activate |= FB_ACTIVATE_NOW;
 	info->device = &dev->dev;
 	if (register_framebuffer(info) < 0) {
-		printk(KERN_ERR "tridentfb: could not register framebuffer\n");
+		dev_err(&dev->dev, "could not register framebuffer\n");
 		fb_dealloc_cmap(&info->cmap);
 		err = -EINVAL;
 		goto out_unmap2;
-- 
2.50.1

