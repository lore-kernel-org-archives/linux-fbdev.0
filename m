Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4503D7D65
	for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747151; cv=none; b=BYwpuW/D4JguhnqZcfeg5VwBUebfhkzbux1yOXSpgK89WupBXs9pJiB085oGQHrmeG4z4APZMMUwpk7lHVf0kt8OHbQlKT5D1MgKdXiWW/9YKAVrLF40rwQV4kLHlzN8sINBgblGiUmOYmQ688BDSIv59+qoCJR3xJDwBWkJJFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747151; c=relaxed/simple;
	bh=Dkx3pVUGwjaUQXWa+bptzHOFLaaIn6XK7Bp6IDRBSVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MFr1iZd3K455GoXWRhoYVdfm2HStl96Yh5VdlO6MFAdgLufdVXrAL6nd4hH1hqYHk9QhCGmGBoPcoYFEWu+ev/12au+lEctAnvXU2JfrzZHYy0UakklC2tFZ9mIOr0gP731+S5v3CIKUCkshxWOSpgro2R1IO9wDfHDFwFZdVAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=z1Lt5KaP; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="z1Lt5KaP"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-365e20fe3b8so4566875a91.3
        for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 01:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747148; x=1779351948; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8JuFCRwwrvf2GMkTB19c8/MiJ4FqDOCW/ASwDDZNHk=;
        b=z1Lt5KaP747LvCfDiP91KFSqqQKP4kQ1y3sXy0FLgUW340f22HXKEamlJ/Syk/avuE
         kouavYUB0Z/kzfBCo+LJnpLRV5VzB3cRu5mmN13MWRd4HvtvusFo9tQbGt6Gh8wOUXF0
         q810a0rZk6c1wjiwsVznxQRlLBvp0UnWtLkmIQjb/3VGS5pCPf+zQB9OSxGvwsCbI/Kz
         o8vyZIF9RdiaLQmKMdVHlx4aqlldtx7F64Bi3FbS12VFLb9O6VkVNlvrNg0A0SdLinOF
         kGnLVhpTs+WOdPCOOvLEGaxeKdHcbcz6keUL33ol4kn+nz6hC0IDgHl0YbRk7qoo5WQl
         009w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747148; x=1779351948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U8JuFCRwwrvf2GMkTB19c8/MiJ4FqDOCW/ASwDDZNHk=;
        b=Flm61LjO+R0c6yGD8j0aZaPouNJ/cHiWcVszCln2rYEBPPbp4coEDhIctGWcnlaRap
         IIxROizR0Xo0n4NTGdu6GHjHTpKTjZXzcNxpKZYjzwzVnnXDj867wIrUVXK40HCwraav
         akRBvybJ8EG/yDy0K3wK7p95n0DbxzAuhF4pCEv4y8WVNc0axhNWODdVdkHbLJQ0EsXl
         J7lhNJ/aVJuzZlAV/T1AAIPcz1uzuvQivJnYIIaOMYGAFRA1Xw43Ws7FiBmWNF/5u9vx
         vPdSI4qkcZDk8jqPrhXMcK1XZnOf9YlTKRiUSa7Vzi+qbRGIGQ92fjSU15KWaZzs1hea
         R2gg==
X-Gm-Message-State: AOJu0YxtCZgrGiQ4Clc42fKNlYXpOLjjF7C0oHgS8mu4LZlWQ8JRvb6R
	IVIRrKmmwcySDm5RJ3H/RbrXccxKh1UNq4JJyyxITg5B6QrD6rMMFZIf7/6t0iGpWxXLB/xyT2K
	pJ5HsC0k=
X-Gm-Gg: Acq92OFdWwgCypw52cyMm2JZuDusjNgQurtrmLPWf5wyGOUNmzPdwy1UwINn8uY3QQs
	+2QDiL3g84NKODRqctngBw04hVfM5NXQmvVw7yPe+IIilpejInxWE+FN7GEp9Ru2dtdcXYNSs3S
	b0HhcMLayv1zdLW6F1IGHQLLdHA409V64qNV0ibl+n9rNexTF/jDlRsutFlNH9uXu8hBO+HUuJn
	Xz78mFeMbj3e3AKFPXoWX8CnEvqtTZpFy5OvQ7uRuQ+8lUtS+bffoZH6xiClAdfrV/VRS8ox6uX
	SdJ0R6tUUlG+fKxqxiBVyk5OqtO9oMq+BlsZF8WnjPfZQdKHRcTag9+FXMVk4bDxHmd9mv07o9j
	xHgZwtVHmu+L5s1Wbu+VlRRj7mHcDEJJcZh0FGACvOI+d8YLXf0793ewDAAJd6m8KbSD7eK+eDb
	QJEuNf2zQ9mjUlUUuD9dCF7DWzIcIHaWFt2BmZgfdf63Ej+cNZGOnnfghJfv7AR7DFwYijbT+jB
	TYlF/dWUR2Qpzr7QA9fez9LzxCsyOHAbi1Y3QSKiKnG7vcx7LDGLcM=
X-Received: by 2002:a17:90a:fc44:b0:368:4cb2:17b8 with SMTP id 98e67ed59e1d1-368f40835b7mr7602543a91.21.1778747148094;
        Thu, 14 May 2026 01:25:48 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:25:47 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:37 +0530
Subject: [PATCH 08/14] fbdev: s3fb: fix potential memory leak in
 s3_pci_probe()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-8-b3a2474fa720@cse.iitm.ac.in>
References: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
In-Reply-To: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Siewior <bigeasy@linutronix.de>, 
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, 
 Ondrej Zary <linux@rainbow-software.org>, 
 Antonino Daplas <adaplas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, 
 Krzysztof Helt <krzysztof.h1@wp.pl>, Tomi Valkeinen <tomi.valkeinen@ti.com>, 
 Michal Januszewski <spock@gentoo.org>, Heiko Schocher <hs@denx.de>, 
 Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Abdun Nihaal <nihaal@cse.iitm.ac.in>
X-Mailer: b4 0.13.0

In s3_pci_probe(), the memory allocated for modelist using
fb_videomode_to_modelist() is not freed in subsequent error paths.
Fix that by calling fb_destroy_modelist()

Fixes: 86c0f043a737 ("s3fb: add DDC support")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/s3fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
index 831e9e6861b1..dc1f9b627185 100644
--- a/drivers/video/fbdev/s3fb.c
+++ b/drivers/video/fbdev/s3fb.c
@@ -1446,6 +1446,7 @@ static int s3_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 err_alloc_cmap:
 err_find_mode:
 #ifdef CONFIG_FB_S3_DDC
+	fb_destroy_modelist(&info->modelist);
 	if (par->ddc_registered)
 		i2c_del_adapter(&par->ddc_adapter);
 	if (par->mmio)

-- 
2.43.0

