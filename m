Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424FD50097D
	for <linux-fbdev@vger.kernel.org>; Mon, 12 Jan 2026 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768226671; cv=none; b=aSy2QgBCmh56k4Kd+Zmu9fp6p+CWBIoFNQrDLgGcGsObaQVjJCD7NFfR1ygpZtDMzzfmx9Y9LuikN2OwZ1pfH2feu2jLxyYvd9ItLKyPihIijsLO5xhZkYZJxo87BE3O/MjqLRhNW/3xJr0w0bKmAjJzvjALx5KBfPhcQvr4wx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768226671; c=relaxed/simple;
	bh=DaGHYSZRKjN0qbFSeTmb7c7ON+ENG7XUIdBvvTtGqqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Svs+hjGpl05NHK6d8WOHeqEwUVvsu/66p4m8s7WBB8IwCX7r/wI+d7SlbSlcnRHXMUAfOjO8Dnpq1056SoXZGHmlFfZqQIL8xd4AB9z9XiVGUrUrB7Q/QzCjLS3X3594s0VkcFK2qbIgN6LGHhRAM5xaZ2WSg/Ue2Gx67D45150=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxO1SC+h; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxO1SC+h"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-432d29efb17so122387f8f.1
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Jan 2026 06:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768226668; x=1768831468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ckmRos2OAgMm2H7B68f5iy8S3ZBKtjS9ZYbxKUXmKoY=;
        b=XxO1SC+hhlRmJOQXgoSXdRTHqXvqemmqMiV4vSwC6SePEWwQg2D4jytIhlqOeeArdn
         5x+hLmRNlMxn7g7+/Uq3g+y9qlFBBFRv1cF9MjR5Kmk0JijFM+UQ90ATNZqXT6+sWR1C
         Kq4sBM9PCTU2hAYS7SI3PeSMqLfvY8cAcl3zdVDE3zgrImcvnSqJc21urjELVADS56df
         qrr0b+7ciWSkS9vQjDCv+JqDhD8kozBnia4H2QilO23/9r20Kk08FOB1CMIC58392+5k
         bae2A5KE1E8D+mvB2d9TKjcJYkahITkcPTCjvtu2yW4Wjoq1Ks1EicvhpUP6zYA8Lz9i
         7VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768226668; x=1768831468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckmRos2OAgMm2H7B68f5iy8S3ZBKtjS9ZYbxKUXmKoY=;
        b=sbXxMBi335/TEwDj1buOF8NOibaeveAzkkfc0KcZDy26ifnF7dkkPiRQMfqH4ITIdM
         U9WNsS9tkSkNi3hHDGlNKiqn5zIo4SsDYXMvp6aAkt6fAXyx6VrAQdpHq8d57nVYKNOL
         19vSyqiDuFnmXT0yi8/Md1a+1aWB2tYba5GC46d4L8muat/sVIeXmEHCT8l/D+INCbBk
         w5PiWiXSGi+JaimUy6JOwuhKBH8uv+pnFPn/3HsE9rnieREX5B8EIOYUYcvv1UN24D3a
         QD5r8EdoveQTCaZQpKxthN4ELj7yqsP8EqnE0nDYbrCxHDetDNzkxDcjbVh13IIrNlLM
         kT6A==
X-Forwarded-Encrypted: i=1; AJvYcCVuT2xp9FgJfoT8yT72eSsfh+SOx/akUrz0K2d48zRH1cUvH4QNDW9tHFIv5clFHe8qQQ54j9wLtIuoKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4LsywRTaO/2lPzUAnhLqXP9Yp90dbq1SQJWRUILT9tted4Hyo
	M9iHHzmjO0Trs3444z63uKhdRDXPLdouXfrjiwImkE+tIdTcEeH9e6EB
X-Gm-Gg: AY/fxX4XLdvXfSKEToqztmcpZjNR6LHmq46yBAy3cIWFQf0jm7rILhlgcTtLYZb3IJa
	cKiQzjiz4TYy5VUpybOdrOuJ3a/ePuVnOX2zIAXehzFytoxq4ghRyGxN3QLqZGTtn6zyWl5TtZk
	3B4W4zxHVVqsQHme7he3RPsW1FgYfnyFhTB9MqnSG98/beIMaxcADwexqE7wIS23WdluFKOwWsf
	CTLqlN02K9HLeCLzP1XX02KHiVryREaEoQbU36Fn1M5qePsa2aAd/eTOcEIE7T5DJgpGhtZGFW4
	LuXtXe8sviyFFJAYrsAp/N99TK1GtfG6DTZqlinq2a6n9joQIMJCyoyevocPGfIF6mnRHjm6+pl
	MI1AfZnVRaYlYrk5lz7406d4NbkguCKVwK85sD3LPNLIux/4wl+uK4Z6Yd8eJvE+TJpdA8juAFT
	sZRzNGwFUIzSQ6wL3KsdAp9HVNx/6wZv8e0rGoWeJR+gnBZaSDoTgzebz9Kms2EFw3Niig86cnG
	ESnGKI=
X-Google-Smtp-Source: AGHT+IH7GUSAAsNDPqrKUndihq0lAKqsPDKz3kaDifL2lP8tPCtWl0A1pugqhFaqlY9nRll5jZEn6w==
X-Received: by 2002:a05:6000:22c1:b0:430:f718:23a0 with SMTP id ffacd0b85a97d-432c39ded43mr12214129f8f.6.1768226667344;
        Mon, 12 Jan 2026 06:04:27 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-215.paris.inria.fr. [128.93.83.215])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-432bd5dfa07sm38643537f8f.25.2026.01.12.06.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:04:26 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Alexey Charkov <alchark@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Tony Prisk <linux@prisktech.co.nz>,
	linux-arm-kernel@lists.infradead.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: vt8500lcdfb: fix missing dma_free_coherent()
Date: Mon, 12 Jan 2026 15:00:27 +0100
Message-ID: <20260112140031.63594-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbi->fb.screen_buffer is alloced with dma_free_coherent() but is not
freed if the error path is reached.

Fixes: e7b995371fe1 ("video: vt8500: Add devicetree support for vt8500-fb and wm8505-fb")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/video/fbdev/vt8500lcdfb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vt8500lcdfb.c b/drivers/video/fbdev/vt8500lcdfb.c
index b08a6fdc53fd..85c7a99a7d64 100644
--- a/drivers/video/fbdev/vt8500lcdfb.c
+++ b/drivers/video/fbdev/vt8500lcdfb.c
@@ -369,7 +369,7 @@ static int vt8500lcd_probe(struct platform_device *pdev)
 	if (fbi->palette_cpu == NULL) {
 		dev_err(&pdev->dev, "Failed to allocate palette buffer\n");
 		ret = -ENOMEM;
-		goto failed_free_io;
+		goto failed_free_mem_virt;
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -432,6 +432,9 @@ static int vt8500lcd_probe(struct platform_device *pdev)
 failed_free_palette:
 	dma_free_coherent(&pdev->dev, fbi->palette_size,
 			  fbi->palette_cpu, fbi->palette_phys);
+failed_free_mem_virt:
+	dma_free_coherent(&pdev->dev, fbi->fb.fix.smem_len,
+			  fbi->fb.screen_buffer, fbi->fb.fix.smem_start);
 failed_free_io:
 	iounmap(fbi->regbase);
 failed_free_res:
-- 
2.43.0

