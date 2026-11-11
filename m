Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409347;
	b=CXf3LWyMlqpPLSp7Z4p+ahxKcv7SqQ7PARZnNdg2yYoT6ivaseSVoKuAk7ooZK0hlK5J
	 Pc8pDKuN+z23kvw3yObKw5dg59psF6OODgPC4N0ohmJ7YHOnDAQD2xClsPUm/qRi/dE7o
	 zhSzJD2inV/mMbhOmqBajBv+XP135IOHzhxRKa6T9TypStrGUEE1DoFpSq24BKv75M+sd
	 9TOkYyhs6RQycjrxhOk67LPhI49ky1ctv2WLn1tE6frDXh9D0b8s4x2l/DrzvEYfRBXek
	 DL7xgFuZa6hsm8qKqGnW4JM3bh2xkT8/ZNO8yWMVElaszfMv0ZQx6uzEdEEhP+jLc1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=meWNXvMASPE39vwE27i8e5aNRxxg/xlneQl/BaplwNw=;
	b=tcEmO3H7x0xKgYQOFtPbPZACl6GHINCM1GFUyzAXaC8kSP9tgf4fDyiPNuAD0Gtotxpy
	 IiouvlUt+YQxsFsHQ1oKrGsh1jlbn1swrZ4PctE1NeaT4DE+nMdSB8oIZKr/H0AFeBKGE
	 Ym7zHZYlsFjCF66ic0STgy9+o84S62IxR/SW6Zt3XQLInxBucw/fZvLRwxQy5g2xQMtWQ
	 oAn+1fYu2JzhkvgpP+7DszCRSzq4YfLzpIaUbtwaoaLQMRYIZhItRfa5kHclFseXK5PnO
	 rx5MSpHfYYexFposcaNZmK5vc7D0ytIs6vZFuCy0QobpOCi5xVEDRU3n7sBJzLJ77rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UQ5VFpay;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35269606A336
	for <linux-fbdev@vger.kernel.org>; Wed, 11 Nov 2026 15:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35269606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UQ5VFpay
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so2194618f8f.3
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Nov 2026 07:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794409344; x=1795014144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=meWNXvMASPE39vwE27i8e5aNRxxg/xlneQl/BaplwNw=;
        b=UQ5VFpayE9CxUcVJjLg9m8k3212rMrE3w2g8bTETRaeTZGmJwXdK/iPr6idLYFo5lF
         fIVqcP5zR+wj6RG1R726OpDUDz2py52q1cKoTj2a0Sr7EbFzHZUs6xfArCzJjf6pn+Ip
         /mFujscxx4Nxo3a3LfKIGdEsEZ5rFc3l72gFAMxauhLiZoKPl+jILGzYojynnifJU2qa
         rELSdlHKFkyEh1sOk7MZo8oARRRaKEIdLQJ5yj5zWbmmwuYTQaT6jwq4/HVyfjBWaK+L
         Eb55SxwSHYC3x8LdvJ/FPQOxS3nV6QdwlXKxo5x7WFlAtNhYYrGRzAEwRkaCrn0tXU9w
         TwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794409344; x=1795014144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=meWNXvMASPE39vwE27i8e5aNRxxg/xlneQl/BaplwNw=;
        b=abSsvmLZQL7oHUxkBDyfBcrOZhOHObCTnW/n0AfFI0ozjceC9xgC7CXtPMzQt3WKza
         TQ2XSIQZGIIT0aUebVHKgyv0h5fvQvGOO3zPgBp/3KIi3UOCUpIWCkE63IaHPAc0husZ
         pF7ZKRGneOIxMLvrQF5xHA7HaT0kPPmzz3mvVUlLTHNbhm8J3/Bk4F5D1SqlJ095GD7V
         VTtFq5jVkjqV03ixn2myY6/IDFNDs2diVTKgieC+i902gFrOFFYetBAkTqv6bs/sIcub
         kD/BD970POZ1/nuUh+D/A6bbIrNoVDhYh9p6PrFavMIa7pesSGKWQnjzgqv8y+IFqARU
         dRnA==
X-Forwarded-Encrypted: i=1; AL+hErHDuKQuxvyxhnJqdjZnyS3BTzjcTnwHl7iscNldKdvK3lJEC3o7/OvOEtdPRFURP/3B4Xnh8nqBDN3Rfg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8lPJkxjhQfEzPABBVJnxAfyAKCF4reCSsjDqimIB55nwj9zHk2
	nhExgrfv0mw7RPPsF6m3SnSBQT2uteXfCBQXrIfCHtt13emn2VmNuOSJ
X-Gm-Gg: AYBFou3O1jfJ/XNnsM47ez9nTRg5+xWxo+I75XFdtm7FMw/MQt4a6YQKGNlSrMKiN/t
	qHpxz98qUBxMahk/pca0D9bXTEHe2WzIbpInepEBwNVt+dGWk9GVXnhC4IpcV1wsUT6+5PJpzC3
	kIoqoVMmzSmokesbnPFZTFJMZZm79xXHhYDMN3HqTU48g37ja/GFtKS/O5gY3+l47HUZFb2xhqG
	UzIFVZPkzU6F4ZoGxjxadZClg46tVZaRyGvrSBF92mS5uD5UhbRpiGX2FgptAL3MFNv3l9PsWtc
	8b6PJ51anZwr4cXNP02gzrh1mXob/ZiKhKYsFU9KdX285bGX7dPf+q67VZAzIg79lzH1Ykyj307
	4NTHFviBeBJuvCM67alZc5d5ckmmEe65BJjnAqbnQgGZz8QItXAxcwm7vnZMNMZ6IoV5Pp3Cs58
	X0gIkWR1miYH1w9+4WxCBUlD8Dnut7CNyEos654ff71vPZu/HmdrPY+VTWlu0ksG7dQ75mMmYED
	7SGcqNLxAu70XOo9XOZZOGGiFP1Xi+tw+6Sd9d/xpz+1e1KdaKcwGnPuPaAwo2sGTxrFRg8q8gE
	d4Up5GL+weXVTF1+p9H7c7vROT9R28pVpTXlTH7QFeuaZF25Eucqklw=
X-Received: by 2002:a05:6000:40c8:b0:488:8ab9:f74c with SMTP id ffacd0b85a97d-499c425746dmr5287776f8f.3.1794409344157;
        Wed, 11 Nov 2026 07:02:24 -0800 (PST)
Received: from localhost ([82.77.126.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835e20327sm12054259f8f.26.2026.11.11.07.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:02:23 -0800 (PST)
From: Daniel Matyas <matyasdaniel006@gmail.com>
To: Jaya Kumar <jayalk@intworks.biz>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Matyas <matyasdaniel006@gmail.com>
Subject: [PATCH] video: fbdev: Request IO ports
Date: Wed, 11 Nov 2026 17:02:17 +0200
Message-ID: <20261111150219.239706-1-matyasdaniel006@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Some fbdev drivers do not request their memory correctly. Request the IO
ports' memory so no other driver may access them. Only request 1 byte,
because the inb() and out() are used for reading and writing.

Did not test on hardware.

Signed-off-by: Daniel Matyas <matyasdaniel006@gmail.com>
---
 drivers/video/fbdev/arcfb.c | 8 ++++++++
 drivers/video/fbdev/n411.c  | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
index b807cf07522d..6771a7409cde 100644
--- a/drivers/video/fbdev/arcfb.c
+++ b/drivers/video/fbdev/arcfb.c
@@ -481,6 +481,14 @@ static int arcfb_probe(struct platform_device *dev)
 		printk(KERN_WARNING "no IO addresses supplied\n");
 		goto err_addr;
 	}
+
+	if (!devm_request_region(&dev->dev, dio_addr, 1, "arcfb") ||
+		!devm_request_region(&dev->dev, cio_addr, 1, "arcfb") ||
+		!devm_request_region(&dev->dev, c2io_addr, 1, "arcfb")) {
+		retval = -EBUSY;
+		goto err_addr;
+	}
+
 	par->dio_addr = dio_addr;
 	par->cio_addr = cio_addr;
 	par->c2io_addr = c2io_addr;
diff --git a/drivers/video/fbdev/n411.c b/drivers/video/fbdev/n411.c
index a3677313396e..ed0281939d37 100644
--- a/drivers/video/fbdev/n411.c
+++ b/drivers/video/fbdev/n411.c
@@ -165,6 +165,11 @@ static int __init n411_init(void)
 	if (!n411_device)
 		return -ENOMEM;
 
+	if (!devm_request_region(&n411_device->dev, dio_addr, 1, "n411") ||
+		!devm_request_region(&n411_device->dev, cio_addr, 1, "n411") ||
+		!devm_request_region(&n411_device->dev, c2io_addr, 1, "n411"))
+		return -EBUSY;
+
 	ret = platform_device_add_data(n411_device, &n411_board,
 				       sizeof(n411_board));
 	if (ret)
-- 
2.55.0

