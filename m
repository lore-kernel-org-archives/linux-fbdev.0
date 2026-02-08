Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04822D6E4B
	for <linux-fbdev@vger.kernel.org>; Sun,  8 Feb 2026 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770573513; cv=none; b=EhH3tSrOGU/82edBrcmPIwOwmQwO0lHgM5Kx8cXrmTrt+JDrXKK0Nu+V8/bT6/o05QbS7WQFg3zn0Tp1Se32RmGmB+o5NjSvDS57aSc4GklONcokKp7JhtS6+7QU5hmhuejNZC3+j409nlRJlgk5JebGx9Mg5dO/6wjeBFbF6ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770573513; c=relaxed/simple;
	bh=DuNlhjJhQWs4f1TsLwXQa8mEYD76mV9xWj6rGZydkYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pz7K2EPsxinahvj2uNVEqomaDoPW4Zxed5Du5LH2xp1nsa7Sbr1zukp4v1gA+q3Y4q7XLL4JTE760HCFvtTQNGAvJwBcs8ZIO4MTA8A9BzgeJi2MorjebowJTDCfg+y36LNGoc2gfAWsW7YXu7Yu+2xqPN3ZSow2IHKfdoalsGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=h+9nE3ke; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="h+9nE3ke"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so26415765e9.2
        for <linux-fbdev@vger.kernel.org>; Sun, 08 Feb 2026 09:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770573511; x=1771178311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yE2ylBa4QK89SCH07FfbDONHRts+1FKqT8EvuwSyOdo=;
        b=h+9nE3kehlpZBnbpncZqVh+l9t3tPOrKGdpXWW2froHvhH5UOi8/FOg3eY1JFbmzsE
         rYrEOkj8AccDCH3oxwcTLAhbluxixi1AZUV20R63b+3RZrZijIyjz1e713kaYDSE32w5
         3r4LSrYx9Ewgmtj26t/JMKi5e/vr6NskrFobxMQDY60AskHHqLfZGZZAjE0e1bctGi9d
         CPB+yoVwhZcjDncl/vKnjbWY5rndAd/MKVJofF3Lj8F+HsElph+7lPXhsG46u6tzAk9y
         bBSPB6MczaWR3m32ZzSwEFy/odcFNUi75UIbN2m1NNNUrG/20QqY+op9QjdUGQk1Wo+A
         gXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770573511; x=1771178311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yE2ylBa4QK89SCH07FfbDONHRts+1FKqT8EvuwSyOdo=;
        b=ufFE0JvxCKxVKp4MnhHd2Nv//MKjjuTIXJ1qbcZ/3zcAyvOJeeU3h31WeuiZk7JYjw
         u+wbkeekdn1xPlr+xdP0ppZ2hXFdRMC+CXFnL8ncFre09S8K16VkrPlWSRETfPHzLFMi
         gZlU0oKpk1raXbWf72puVDb5ldSOS1NfsHVoRwqHMw6yjLpcpXUwHT+C7wE6jUdnKIvv
         Gw+t7eAGP85yX0kkmFceblJUgxm9oF+xRryuRyjypXTJllFgAVsu0Ejz1gnDHRaaVQcc
         ZdGyOsCaHFbzEtp3opDj4xlg2MRSzv4IGAhfVjOpI3i/hCMHUbQsA5vqvAPM/I7tjc24
         Giew==
X-Forwarded-Encrypted: i=1; AJvYcCU8yUnGjepe6Kbh10qyuL3xSdYfLe1+Qb3urq3BInu3tgQaYvS4jRsddOXb9Ds1fNPuUwOigzj1d4b94A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6cxOVDxuE8PMpa+mrNQ3j88uRWyY5mAijAFkmKexoapsOncfy
	TRNfiKeoNnxpW+W0SiQYR3aWM00NVVuPe65Mo1CAnOaz+km2DpNRBsx37IFQK7/vcxk=
X-Gm-Gg: AZuq6aIv2e8St0W2tmtQHTEo02B6FaPR/YS6U+wi4h70huba0f3NfglQNWPNZ8DHvkU
	ez1PZcRPScZBMm3ouQgDm/y5M19PllhF6S6LbbdUhPFmLLTBFrEm1XQL4ghWxj3MulvlwV/0ewt
	OaEEM6/Ws+XwJ9rC6l56kj67cpwH7crWUNGSa9X7OiDox1iaylMK00CZ4sQ70seNzlNq6eLp6XK
	X4m6RxJ/lk9keyOjei+hQS/3PDngDH/N+yQJ14Fl3vxQIqoqB3veuABDWs/oc51WtWygctGCOFW
	NASUp5GtwqbwuUPG2uRTmGpQzMEVTRxPoeMJ+g2rey5H80KkSyTTPsdc1MXb17noQ/+uDB1uXwc
	pZeygPAMjEceDXcrwa0Hx4dqEeJ5XmmVrmw20grRq5QXnJ3Dedxk9XkpqjuK1hT5KX3OuWVu9qO
	73w0FOuntXyyF44D1I
X-Received: by 2002:a05:600c:c16a:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-483202160a2mr143378295e9.17.1770573511092;
        Sun, 08 Feb 2026 09:58:31 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483206b8bbbsm318522835e9.3.2026.02.08.09.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 09:58:30 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 4/6] fbdev: au1100fb: Use %pad to printk a value of type dma_addr_t
Date: Sun,  8 Feb 2026 18:58:01 +0100
Message-ID:  <740dda7be9c7640ef3890c96d65bc7cd29d89d1d.1770572936.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770572936.git.u.kleine-koenig@baylibre.com>
References: <cover.1770572936.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=DuNlhjJhQWs4f1TsLwXQa8mEYD76mV9xWj6rGZydkYo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpiM6yNYRVKTLT22DmhhcqMiI3mcT/emNiM6vJN ZQOlnu4ADyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaYjOsgAKCRCPgPtYfRL+ TnKnCACKUl1hAdxiOCZSKA9M9EB41AwPKe/Sq0XLuGb9TU5AV1n7adfUgDqb0xI76tvJTqK8laS BqpDTH+L7rF0itXVtlIW9h0m5EV1zcYNBYNwttfLtPbvEwoklo2Sp2Sy9h7zE5DtYBjMnwKbgJQ yXXo1cECGb/9MjUDs9A4x9vlkSGeE8UHGQYbSpkbyT9CMEuIDH86kUQprkweJWsVmCZsuqaaF+B VZqAOrhO6qGaupSIr7YYOsOKWlIVqHWDrisWv3pTAHevm6e7LUXQfzSY/PY/SQoVBGn/j7+wCGq 4k9iTBmW7wkri43O1Ax/xCwNDls9plleQ6d2CuQab4xQJz0t
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The size of a dma_addr_t variable varies among different architectures.
The save way to emit such a value is using the %pad format. This
prepares allowing this driver to be compiled on non-mips platforms.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/au1100fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 914f371a614c..e43687ac74a1 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -465,7 +465,7 @@ static int au1100fb_drv_probe(struct platform_device *dev)
 	fbdev->info.fix.smem_len = fbdev->fb_len;
 
 	print_dbg("Framebuffer memory map at %p", fbdev->fb_mem);
-	print_dbg("phys=0x%08x, size=%zuK", &fbdev->fb_phys, fbdev->fb_len / 1024);
+	print_dbg("phys=0x%pad, size=%zuK", &fbdev->fb_phys, fbdev->fb_len / 1024);
 
 	/* load the panel info into the var struct */
 	fbdev->info.var = (struct fb_var_screeninfo) {
-- 
2.47.3

