Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763914B8270
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 09:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403358; cv=none; b=G6/hZVhBi0G91/s5I8/bZ5t6n4VBx0r9t0pLuP5QSC3RcmjT30SKopAPIFVjcTg83lknJzPHO3BfiUjUtak2vVtxh6WfgdErDpm8wKoCs8AWO8JSfSJplNnzRTIMPjDiofLUtME+4kBywTeWURk2aXE84NoP3MASv2e+zIC9qWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403358; c=relaxed/simple;
	bh=Djw+CAa4TdmdhY24d0q7OhDkmwT0mOBOFc45rC3up0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V1m5HIPA7rwUqHjnPeL6eLHQjIKU0xzqJ2BWK4xslH0hWW/eWN30NATYorruH3cCkCZAgCSfh3U7vdM1ePFo18AAQFX4XvR54FXUm3DLC+DfjCQkQRjSrHPy/D+il9hUBovk/2M1kySA7Hkiji/IvrYlwBySb0/paA8//K7X/n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjIaNhDh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjIaNhDh"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so6510875e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 02:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792403355; x=1793008155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wVwmmSqI00v46zZ18N04BUiAXDw2jjv5hFhr+um5J7s=;
        b=kjIaNhDhKAIOEtLwjZApMa1KxaqWxsgFHyKiGuvTmrsiOayEUH47oxJXkpWXq4U7nr
         mkwLFWvbmHpMN9mGJuDyp3vcqjo80rhBfH2lqfsoKlluphO2akFAId6CUolBTALwpvkX
         PWmFp61zh1YHqzISmMJcqTv6agpsogDuICgNy7bBP3JHQ0LwODI+JuzRe61dKeOa4im3
         Oxo/kin9jIcbIuJR1D0/G5XoyAxbtE+TMsWPx7CjeJIWo7o4dRMrHptuyfsXTg9zxxHN
         KCtY/7tQMQYao9x8VIbzepBD2KsEeWchsriUgGCC/PNdvqcuKEt147zNP8DR253BmYir
         wS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792403355; x=1793008155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wVwmmSqI00v46zZ18N04BUiAXDw2jjv5hFhr+um5J7s=;
        b=mKc6rhNC/3W69hHE8BvVAy6sRcSqmjy2iVXgdwMqitLoVMGjnX0uFuVSByj4UPHJYZ
         Vc6rPdDJJK3hOZ7bG8Bk5x4xkZZBaze3iPAzbkzlMYdO+fFFky2X7S0c6QggJtVYnSya
         Frql+QX2zk9ER+7rGCDi6r8nkuOahmhzOpy/dXcwQFCVF3884dF/J5THQ3fxM5e3LZ89
         8/tvjKjy7AXZwdw/9zspEXl6ZFEnx6fpfYVmrMZZnDwVAmaMOZtSmf2btCyufhh2QoSM
         0e5j+lwX3Mq5xsaWam5hXM31xM6G8N4DUY42GBCJzsc3JzoHiuKZNbX+Uw8pu33Y2WVf
         RvFQ==
X-Gm-Message-State: AFq9FYIRmU8P+NXKRNi96WYvJWiYbeuGpfEAzhrwAXmgCzucQy0Uj0Rc
	S1CId5pnAKScIf1ipcKrACY2GCF+xsV2xRYv/hTiEGwLd9k4Fczg+XMS
X-Gm-Gg: AYBFou0oORM0qWI0Xb2q24JVwjsO+umH2uB9Wzdu6e2ezErgyvVAAOSmgSJWYz5HNun
	V6eSVWS9OPfuQFob29xR/rJca2K3E8Z2gdM1fLFS7KW7EL3u6+RfNNwt21QkHzrexX/3nxyIcil
	wz+CbiDpjAPLq7GQEnLUanwcvKJ9admeGLBXA9XPwBb7uvBIwvpIUxehMEBpwX7jqd6rPt/dllq
	LyI1IPVBcA4ZSEQvkcYFSDfxC7B9gTlGw9LYeQz0KKPm1GFStWqTv5D3c6wkCy9gt8SQo+7YcoT
	gI0Xgv28vCjDZxN83NDb+f7vBtl2sB7/oq8xzXoXBQON1xeV2PPgzlkj/mlGbOvFTHX7M5AeE8p
	ApG8bthjgih1jA324uD2YOdeY2OyCQui0T+W9nbJz0Iw5igtIvJd8uyX2pbmUP3YCZdpg7mHu8h
	IYTES86+LISxPJ4t8GdW7l8qoZ/J52jjQb3o2pidxS+9u/aXdhl6kpMy0wHGCWSvHQffZPJVkT8
	GD2/34ua4Y+uwHZambFz1lyxh8=
X-Received: by 2002:a05:600c:3b1c:b0:4a1:c646:3edc with SMTP id 5b1f17b1804b1-4a1d75f2aedmr149554645e9.11.1792403354550;
        Mon, 19 Oct 2026 02:49:14 -0700 (PDT)
Received: from DESKTOP-0KSTGNI.localdomain ([156.213.131.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce02d619sm177669655e9.3.2026.10.19.02.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:49:14 -0700 (PDT)
From: Temitope obabi <obabitemitope765@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev,
	julia.lawall@inria.fr,
	Temitope obabi <obabitemitope765@gmail.com>
Subject: [PATCH] staging: sm750fb: Remove redundant NULL and zero assignments in probe
Date: Mon, 19 Oct 2026 12:48:35 +0300
Message-ID: <20261019094835.1343-1-obabitemitope765@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sm750_dev structure is allocated with devm_kzalloc() just above,
so its memory is already zeroed. Remove the explicit NULL assignments
to fbinfo[0] and fbinfo[1] and the zero assignment to mtrr.vram, which
only set fields that are already zero.

Signed-off-by: Temitope obabi <obabitemitope765@gmail.com>
---
Note: Greg replied to my earlier sm750fb patch that keeping the
explicit zero assignments is good because it is clear what is
happening. In that patch the allocation was in a different function.
Here the assignments are in lynxfb_pci_probe(), just after the
devm_kzalloc() call and its NULL check, so I think removing them may
still be useful.

 drivers/staging/sm750fb/sm750.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 8b93bfeb217b..8702f6313f78 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -969,13 +969,10 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 	if (!sm750_dev)
 		return err;
 
-	sm750_dev->fbinfo[0] = NULL;
-	sm750_dev->fbinfo[1] = NULL;
 	sm750_dev->devid = pdev->device;
 	sm750_dev->revid = pdev->revision;
 	sm750_dev->pdev = pdev;
 	sm750_dev->mtrr_off = g_nomtrr;
-	sm750_dev->mtrr.vram = 0;
 	sm750_dev->accel_off = g_noaccel;
 	spin_lock_init(&sm750_dev->slock);
 
-- 
2.53.0
Note: Greg replied to my earlier sm750fb patch that keeping the
explicit zero assignments is good because it is clear what is
happening. In that patch the allocation was in a different function.
Here the assignments are in lynxfb_pci_probe(), just after the
devm_kzalloc() call and its NULL check, so I think removing them may
still be useful

