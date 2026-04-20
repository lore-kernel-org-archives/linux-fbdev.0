Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A3D3164A9
	for <linux-fbdev@vger.kernel.org>; Mon, 20 Apr 2026 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692703; cv=none; b=vDS5AcuImH5jFKXdEcLKDcgKrFdHSE5CXDTXAAYKNd9Gd3Ox7K04DmSwumG3i4MzYwpFvL+vnfJq7FqYc0BeqqjXq2FKzICxVYxHQeoYufEz3vy4p1Ih0Fo0BLZWxPb+0N4kexgEPEWxwY9XGzDS/M467Y8+HJ0iNPek5TpVBeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692703; c=relaxed/simple;
	bh=ozZS2HGz0xaWK1p7832qQ3NAXyuyvRCWYhiFLjBNBpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvsRtGzXMfluqz/xKE94Ml8QUYKuqqdMwny0r+adnObXAQHQjVrqcLfXqDsGWh/vt5/9NtpO7mutFDYVEhjEuYgApWRmlKS5CoHjAusY3La1TeMfmuL+dVLLAIG2E/Jq/a/UwLEhU25rxSBzt8Z8qp9rI5slz6BayyNkif1GaGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFxZF1oS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFxZF1oS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso42267025e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Apr 2026 06:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776692701; x=1777297501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lA60hJOVBSJE2U3bgFqAWxtT9r0e0fushLu59yGaJZQ=;
        b=DFxZF1oSeWmhvurQ3Lj77Jc8dkfYSogQP4TlBKZyvMFFdZy2ZCpbZ0JWAIob0VbEYV
         AOO63T/GiK7wZ5X/5r7mTey0x5078prjs4Y7so2XBd1n/AKhW1JtiLPaISgWLpUORwUp
         2OedYm7UVKw1wKZsSCgIXQEvFIQzLQ/JJX310L0Nbe+mFnKCPEGIvTXb06KdNSZ49l7t
         YyYqXHo/aU2ZHgwV7Kt8hpwu1bukDEsO7jUs9itlfD3aDu9m5a4kb7gwSb0delUwEh57
         +lzlIdJKjNAxbV8rFoACIaw7fNM9u5jk+fg65qfgHiT4KZsNxq5lGHCCYpTFImSh9is/
         H+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776692701; x=1777297501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lA60hJOVBSJE2U3bgFqAWxtT9r0e0fushLu59yGaJZQ=;
        b=I3bIv+ylgrhcOuoYXGnWOrjmgyCM6o1f4cFqODUc9cXj+NhLBj+EJh/o3TQivfkaUe
         ecQWyew887lTQjrm+1R+sDRApnBAkKgb5PNbVwdZnUzIk2tiNVjfoxQHuNmqD1fTf5Jw
         VoFfUNIa5Vq8iU1mF9PaApFk9tnQeodER1odb495m/C0xSXbDdecW0buXQPlfvxrQVqg
         75fzs6Et913YGv21957q3jFxvPQXTvfZqCtv4R6cfmaVGsMQ8SC0MnWmiBfduzmF5aTc
         4tqKbbMYtD+RCSnc/t34DV8BqTDTNkUUsgjxTCnLq7BPj9E+JSMmcl2QoDWb7bpuAGMl
         BAPA==
X-Forwarded-Encrypted: i=1; AFNElJ/oIrkNgzzbAsX0YjLaBoGTw8ap2rO3krFXXd3t70W0u+N9ZPPKEaplA4d2p7/ftWgZyqcETB756LWlHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRMb2L1fAhlPYlELfQLqeBH6qj7KlmHf78jHQcjTp20u545/yz
	SDE4Oy9AZFPy4wmUatLbtvjhlqlX+lAX2zHhuw8hbIbC9n5ujPOb84c0k4NSVnY4
X-Gm-Gg: AeBDiev9k7SmplV/wNJp1pr/kMvCX3ZId34kQlzGJOtFzsHnj1NJ41FJ9ajOtESRiLb
	VxUB/7f3KGjogYEEB3bUmKLjig2lxf48aR+VnUcbxnTuaWtSZAZYSioDukj/FzjhMKMDiu3Fjq8
	iwE9GsCNmv8wD8E2hPm81VaYQ6B5ZWIx6zJaTyssMfqbEFmkNmIIC21QpqBhwNn2j1zACE1CeZI
	Pz3O44ActcQyDfuZnnndXL0tt4qd/iOSZ3criVb2q2nJ+8cCoNqgODclOSeZJy2GDZDqMPgFFlO
	FpDCZkdEFCyBr4u5gSgQoWj88grPi7aR1DQBHzxHF4BugNOQOF7WBTGGM/dyjS/WXDU1mrC5Zmi
	vxbGxTCET1OGz5ntCEVrp2KRO9IQfVmQ5bYU529ZczISzSMGsCp8vhiAzQrX954mYOqOXNIXXE7
	9EgfgkSSEcIxn5gyyRVSRvxMzNSvRx3xhrjpnlAKhd
X-Received: by 2002:a05:6000:1ac9:b0:441:1c06:17e4 with SMTP id ffacd0b85a97d-4411c061807mr2455722f8f.39.1776692700590;
        Mon, 20 Apr 2026 06:45:00 -0700 (PDT)
Received: from anthony ([2a06:c701:499d:3e00:12ff:e0ff:fea5:3d2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc2cacsm29302178f8f.13.2026.04.20.06.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:45:00 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: deller@gmx.de
Cc: thomas.zimmermann@suse.de,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH 1/3] fbdev: cobalt_lcdfb: Request memory region
Date: Mon, 20 Apr 2026 16:44:22 +0300
Message-ID: <20260420134424.77494-2-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420134424.77494-1-amit.barzilai22@gmail.com>
References: <20260420134424.77494-1-amit.barzilai22@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_platform_get_and_ioremap_resource() instead of open-coding
platform_get_resource() and devm_ioremap() separately. The helper
requests the memory region before mapping it, which registers the range
in /proc/iomem and prevents another driver from mapping the same
registers.

Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/video/fbdev/cobalt_lcdfb.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/cobalt_lcdfb.c b/drivers/video/fbdev/cobalt_lcdfb.c
index 308967b5096a..f7faa95fefd3 100644
--- a/drivers/video/fbdev/cobalt_lcdfb.c
+++ b/drivers/video/fbdev/cobalt_lcdfb.c
@@ -295,19 +295,13 @@ static int cobalt_lcdfb_probe(struct platform_device *dev)
 	if (!info)
 		return -ENOMEM;
 
-	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (!res) {
+	info->screen_base = devm_platform_get_and_ioremap_resource(dev, 0, &res);
+	if (IS_ERR(info->screen_base)) {
 		framebuffer_release(info);
-		return -EBUSY;
+		return PTR_ERR(info->screen_base);
 	}
 
 	info->screen_size = resource_size(res);
-	info->screen_base = devm_ioremap(&dev->dev, res->start,
-					 info->screen_size);
-	if (!info->screen_base) {
-		framebuffer_release(info);
-		return -ENOMEM;
-	}
 
 	info->fbops = &cobalt_lcd_fbops;
 	info->fix = cobalt_lcdfb_fix;
-- 
2.53.0

