Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BFE3491D0
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772644289; cv=none; b=mVQD1RUXDHruYVUZnogqjAiYNWQtZ/ktK7r5qWFXK76JZ1x7PVOHpS8xGweq1nr/0s+YyLRfwsVNCHrASZys0jfiXiS5RgbXImUgE6dLYkbSsBZdVNuF/A2V3wg4UGHgnmvbbyAqGvn9bRgwbjikzOCg5FCuvWov/J28uhOoOYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772644289; c=relaxed/simple;
	bh=fvm+1TuVEfBZgWEioDiGHAQkV9PHuQ2+SLQAWe7HMDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fbCg1poye9ZasrxNtsPO8ZGbN9DkOClm+wGB3S03eeWWLSLsuYmio/Uu2CswLdW9GLVwdiOXFw+LTZAoAvCBvf1sRS7CRQo1jXBOSomtd+62za6o9Dgmup+yAUys6TDbvd34NiZ1qrTgM+Jw7lNkyeqorW79JxJL4s0Zf9TZM+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPbFYV0x; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPbFYV0x"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso861523f8f.3
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 09:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772644287; x=1773249087; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6+ERZG98Y+SteZfiVlR3jzzX4R2QxjyojMlsxgWSx7U=;
        b=NPbFYV0xuXaLVnZaAjju/tlZYlnL8EfwzG8VBapgOfRfwCu9kXp6YMedsSq5YG2iby
         cH7GD4DIA/Y8HuWRMHxodAdUK2ilRL8q72arChT8+Lfc0WqZoa0D7wmyVHMwNXyDNn2p
         wWTZxLL3WJ1MLYUfoecVtlAAHHFPjoLGrBWIpk6+f6wtDDW0S/V/AsqH8LGVomrxqaon
         ekd+XCLuyO/ep6P1ay4YlIfS/9YWOjnbYttAwNtXzDdbxMtCdE60LTKPaZMbRUbdWwMj
         OCwzqi/2q9U8sunfA7yrDMO2uWnQASpZ//ggWcVBmmJcvrvbaa76vzYEhBrIrKTpIrwk
         Yhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772644287; x=1773249087;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+ERZG98Y+SteZfiVlR3jzzX4R2QxjyojMlsxgWSx7U=;
        b=TA83G6Yzy/oGvUs9Cerv0wK9qqpnXzCP0Cc1hBlmJpDx59U+vwHZ1JqcYcWU+881/C
         Oc0saNwTwn+EiduY8Xu8v3c87ZIvovQCqP8CPOMp31HaF2vfsW57pvPZaJqkx8mpuKlI
         Ypm6RX6fxzOAsjVgWfUO1dLQ+XtW8yljmp5TcAZOxEJQFTVF9CqxXpmoVUVs8whhpYqn
         Gh4rbKBkoe/fLvAGTU5AVPO475PCVWajgjYmiJGt3HygxHnnjiai+nmyffKUSsR6Ac2c
         pQS/5Swb2lu4EkBH6W5HyhOUSfWSZBqhAWzYNe9njPWdOiT1uR7peHNXgKKpArkV9A5W
         dVLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIOG02I0yLzFmdyvR/BTv4yXL62Gcp8JwM/MSod78D7w8Vo9PbG02mFWIxPtSHVRhqQ+0MIww/SYzlng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtzS5NsNcwyxrAEe2bjGz/ZXFQX1IK6dz+XXAZNpsINIZAnuE6
	PB+PTnCbOQnXjwip22ggLHLAFBcOnB5IR2hHZtid6jMStUnK8wSKs2zp
X-Gm-Gg: ATEYQzxhZh+gIVNggJwg5nt59iT7fakobjzmSfFVct1v4gjTliN0WSCcg1QVvlwl+je
	SLrioMgiLd4dwWpGh6fUQxTZxgWaUmwHi0Qrufz9al83CVQEBPKkVvh18G6HxMrpPDsOrHO5+v2
	2Fxx0pwL73juG0UIiH8SpJY42BEkWQb2mI9Bh+Of01Oar4uyVWBOMr83mjnZgYYlzSlM9/bTiHG
	cQq+zUFBkGEwjnrv2c0VqAVK8LMYCZ/9AhJC2wh8DSPxl71/4iS7ftd5ecD1ZhY529gjKG7QxdE
	/9rVy1U0spC6iQVOQOKVJwx+nh+CEL1MV4od3MiFpwSeB8AII48oyQ3GRM3wJ/cGuD0R//eBDwo
	QeCedSuRuyhAOev1oXurNZQ4dyyiNHP3sZ4oH/UIDJR0CFDj45qY23SxmNfgyd/KdWc1v93UdXc
	RtSrkoXrqwkUj1YlPFVp1UeDiU8cUa1w==
X-Received: by 2002:a05:6000:2dc3:b0:439:bf38:16f7 with SMTP id ffacd0b85a97d-439c7f7e3aamr5793716f8f.14.1772644286733;
        Wed, 04 Mar 2026 09:11:26 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:3007:da20:bc65:66ea:698d:4a44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b130abfasm27138542f8f.34.2026.03.04.09.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:11:25 -0800 (PST)
From: Amin GATTOUT <amin.gattout@gmail.com>
Date: Wed, 04 Mar 2026 18:10:42 +0100
Subject: [PATCH] fbdev: wmt_ge_rops: use devm_platform_ioremap_resource()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-master-v1-1-2bfeb1b9559f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJFnqGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwNj3dzE4pLUIl2TlKQkYxOTZMtEY0sloOKCotS0zAqwQdGxtbUAA9j
 Lt1gAAAA=
To: Alexey Charkov <alchark@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Helge Deller <deller@gmx.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Amin GATTOUT <amin.gattout@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772644285; l=1961;
 i=amin.gattout@gmail.com; h=from:subject:message-id;
 bh=fvm+1TuVEfBZgWEioDiGHAQkV9PHuQ2+SLQAWe7HMDg=;
 b=iKDzURGU6c9p1RaVBuYzo76POHmO10cJlkMXVJt7qWoZi/pfdEawYK9LwvspVtgF3iSrXLohY
 M5lAcaB+zeECKSvVIgxHTKrJ37eI8XvJ0JFwlCpZmwOaJkDiLWf7nBg
X-Developer-Key: i=amin.gattout@gmail.com; a=ed25519;
 pk=C9HM6Jf5d9dPl9fnP9pM/nhMwm+c280ldqYZ0ESu3a8=

Replace the open-coded platform_get_resource() + ioremap() pair with
devm_platform_ioremap_resource(), which requests the memory region and
maps it in a single call, with automatic cleanup on device removal.

Also reset regbase to NULL in remove() so that the single-instance
guard in probe() works correctly if the device is re-probed.

Signed-off-by: Amin GATTOUT <amin.gattout@gmail.com>
---
 drivers/video/fbdev/wmt_ge_rops.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/wmt_ge_rops.c b/drivers/video/fbdev/wmt_ge_rops.c
index 2bd26bfb2b46..0cf78bcadfa6 100644
--- a/drivers/video/fbdev/wmt_ge_rops.c
+++ b/drivers/video/fbdev/wmt_ge_rops.c
@@ -148,25 +148,15 @@ EXPORT_SYMBOL_GPL(wmt_ge_sync);
 
 static int wmt_ge_rops_probe(struct platform_device *pdev)
 {
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no I/O memory resource defined\n");
-		return -ENODEV;
-	}
-
 	/* Only one ROP engine is presently supported. */
 	if (unlikely(regbase)) {
 		WARN_ON(1);
 		return -EBUSY;
 	}
 
-	regbase = ioremap(res->start, resource_size(res));
-	if (regbase == NULL) {
-		dev_err(&pdev->dev, "failed to map I/O memory\n");
-		return -EBUSY;
-	}
+	regbase = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regbase))
+		return PTR_ERR(regbase);
 
 	writel(1, regbase + GE_ENABLE_OFF);
 	printk(KERN_INFO "Enabled support for WMT GE raster acceleration\n");
@@ -176,7 +166,7 @@ static int wmt_ge_rops_probe(struct platform_device *pdev)
 
 static void wmt_ge_rops_remove(struct platform_device *pdev)
 {
-	iounmap(regbase);
+	regbase = NULL;
 }
 
 static const struct of_device_id wmt_dt_ids[] = {

---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260303-master-4dbb344c9a39

Best regards,
-- 
Amin GATTOUT <amin.gattout@gmail.com>

