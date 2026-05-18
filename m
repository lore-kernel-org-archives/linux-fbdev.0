Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF55A396D36
	for <linux-fbdev@vger.kernel.org>; Mon, 18 May 2026 21:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779138803; cv=none; b=kniRL75W0AxPHkTmUjIRGLgLBnXGc62H9uH82eAGBoNRP3gX7oRhCA801mBUrfVlV83OXOZ+cImVK/WixvjX2jWbJGr6wg7wOC9EHc94ZBWS3IGGeXB3K+2wJSnlQRkgLs8lmyhlQU3wKmRMk0xJYw69ZBJlEsK1LA0bSUF2BZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779138803; c=relaxed/simple;
	bh=f14EBHDq2i549qJGTfXyZXOwE38/F7SK5VJW+mFje14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fqEoQrSqoZasLJVix9kizcyUdvSJbfr5wJ5a4B8kaoNEXu6BRCDfBWtRZhO0Kb6YJMHY4OC/0HBR8YbCEo1XusBgVUDB5tYGH0dk8ZWHQ1s+aHEO9WfRb0ukVLdWhX6UAKme8CDOccpc1w3iSpz/WnciIcDsn4xs5LxnAazB+Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pHKqMjd5; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHKqMjd5"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8383fb7143aso1214616b3a.3
        for <linux-fbdev@vger.kernel.org>; Mon, 18 May 2026 14:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779138802; x=1779743602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5kHLteZtDYYZ0uPDSlKWBJ8+KtD0htFyv3V8YBKOEqE=;
        b=pHKqMjd5L+gh168dJ6FQpmQL4qGksFKJ3LOSk16jx4l4DZjeWZDviBJA+RGAwU2Mi3
         Onn4QtmZo2xeEsk8MQ/6W5nFWfiflmbVqKOPPiPim8F//3aJs/F29fDrcDtpNS0cMTgF
         5kNq9miZWcP3J+sUCmgo6KaOArmn2vRlR4x7YobL1rMk4C47yvw3JtIpePN9qhHJfv3z
         aK8qEjYKIGb6/3uPx7lHxP74WdUqXBB+qy+0pwXmaG6WYB/FrdcnCIL2D4u6NiXL+z4x
         rkccMJ0uLogWuxrJhs8XDQJ8bsz3ekcSNKEUBtZqsU8t+mnAf2VOkeqGAAKRU43DnhRU
         FM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779138802; x=1779743602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kHLteZtDYYZ0uPDSlKWBJ8+KtD0htFyv3V8YBKOEqE=;
        b=mJJkF15Xh4DapdXabQBYkIFOUI7IM2TxgzaK8lRl1rPdzHQuntY0U26j1vWOEKRzaQ
         xkXz7v3ovGgJv0uRwSqWfjP4WK0WBeO9vXtdQXDPRtWoP/Ekf9N3M9ypB/t1DLELFfcW
         6iQv8uHA0assy56x/wxUxxA1q1wLNoNrTL8curBwyx3m80BLVB0OBGjbV3xMEtaLWbPc
         /RC5w9BNTvc1TRDQYVFIud2sYxYgWUPAomEEWQidRAro1mWFTCGpD6lLfRwxM9OscigD
         OJIJeyC0XO2XzrfSF4syf0bb5spVPS/gpXm6KcboWs1/zE7/FYIdtgRB01ECHtptEub7
         wWoQ==
X-Gm-Message-State: AOJu0YzxE7O7SeNCetWRztOd/I5kG+LjiRpNUt4EPGespqzodUoPUtSK
	ZL6FNsoOb8cluhDuP94aBdvkzCpNpi+9F2XbfjLZ6OY4ix5Duqi4TrhWILj21y8k
X-Gm-Gg: Acq92OH84nDFR95XFNm6eQbYVbYIsn7QrRSA7taV5GK6ER1g85P1wqQ3kF36o+HkVaf
	zghIey/LqBaEpbivPBQyT9bBJRMa2BsCqUPmwVzrOmD72MTeMGSff9JiSjjGyz4yG6x35+f4bR9
	Pw6hL/t2G44iDZ1XKuruM6obrE9MzbWmTZGMy/S2Gm/F1M+lqVIzfbJe/rPpVAQGP9fdpFPa+oZ
	AHg9DFotsmY3B7DbumJdxVwC69k4Q+ex5IGY2mVphB7l9Rxdif1SQj3JsnvSZazbd+HruEgk+aC
	BqZHYHACv/9h6QvnySq10uSsXE6tBtvM5WPAQeDIg8M/HH+81pKlA7CG4HRi1+2d6CTEkyug1b3
	kRukTeR6aC/MGBm7wjMf7PkZBpZPo2+WJ985QrxPG6o/cExJItkL4ULUzUtP1lpQLCfy5pyTxEh
	rAF5No7YQyWS7rNVNOpfLooBmQJhnqzlGRA4unYNBA6Vs+p0PMuJaHJmZxj7K9RsbPaQpDjf2Gr
	DTz75J4xjNXH8+RY6lWcmO/65Xci/6qV6A2zymLklCPzw==
X-Received: by 2002:a05:6a00:88e:b0:829:7e6d:cf22 with SMTP id d2e1a72fcca58-83f33dbe4famr15918075b3a.43.1779138801540;
        Mon, 18 May 2026 14:13:21 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f196638d0sm18775306b3a.7.2026.05.18.14.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 14:13:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Helge Deller <deller@gmx.de>,
	Frank Li <Frank.Li@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:FREESCALE IMX / MXC FRAMEBUFFER DRIVER),
	dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] fbdev: imxfb: Use of_device_get_match_data()
Date: Mon, 18 May 2026 14:13:03 -0700
Message-ID: <20260518211303.10777-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_device_get_match_data() to fetch the platform ID entry directly
instead of open-coding an of_match_device() lookup. No NULL check is
needed as every compatible string has a corresponding data section.

This also lets the driver drop the of_device.h include.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/video/fbdev/imxfb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index a077bf346bdf..7a021da0a32a 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -30,7 +30,6 @@
 #include <linux/lcd.h>
 #include <linux/math64.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/bitfield.h>

 #include <linux/regulator/consumer.h>
@@ -880,7 +879,6 @@ static int imxfb_probe(struct platform_device *pdev)
 	struct lcd_device *lcd;
 	struct fb_info *info;
 	struct imx_fb_videomode *m;
-	const struct of_device_id *of_id;
 	struct device_node *display_np;
 	int ret, i;
 	int bytes_per_pixel;
@@ -891,9 +889,7 @@ static int imxfb_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;

-	of_id = of_match_device(imxfb_of_dev_id, &pdev->dev);
-	if (of_id)
-		pdev->id_entry = of_id->data;
+	pdev->id_entry = of_device_get_match_data(&pdev->dev);

 	info = framebuffer_alloc(sizeof(struct imxfb_info), &pdev->dev);
 	if (!info)
--
2.54.0

