Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C173F5695
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Nov 2025 23:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762124511; cv=none; b=TKFfJb1HSvwuUqsl4r5qDaVKpPotk+GbwQpZ8ogOqYXrqqQfUClYR/bm9WDT49+h1wxHyIFjDDhoUtY9q7+nfFc6hbP4ftlxVMd+EueAmkVo2pp21KWHBQ6IEKLJ+d/PmekrfB8l7O/of1Ec4kiQksk/Vg/7WEaa6HtzurppjTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762124511; c=relaxed/simple;
	bh=TLZKZNnITQFcd97o8fyws0ES3nNzbLGkdPJtuqGz5sQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f1bsKuPJ6Fa59UnDBG+PKsE2JjNinAuqPFRHYmU00rfEwxeX0isPT12kq6IpGfKGv6+pveXwqGzRJXI0faXIRa0pSkrvEq2WIm3Z2cA8405bOnjhLOFtlxISW36/pKGfJjlLxpEsXBle3bLjLt1mhPLGlTznZMySl9HO2FxQou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcMexx5L; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcMexx5L"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3d70c5bb455so1399214fac.1
        for <linux-fbdev@vger.kernel.org>; Sun, 02 Nov 2025 15:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762124508; x=1762729308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=suckYxpxhS8tpm2524qw9Mw5oQrBRRr9u/yRv9LVIaI=;
        b=QcMexx5LR1PZSxEkWDknLztbCBkMo0IGDANf0xGvP945SFPldvjINnJ52WbH/E3OUl
         /sYxi3n7Hez96A+9jhU7AKqAnMKj5t1VlQ8sBXwx2fYCM7eMEeNPV3YpVcnSmLN/Ikl/
         jrqkIrVHzC2dYLeULsMau9OMt9lmQXt6eTbu9jU7CPkJOjLGEelbmRUBF3SUbsq/DNsq
         k+LClaQTEqbGj4ySenUmqH8GoyahZn4VFs11eoupW2KGhlvysUIksjtCiXDAGekq42ck
         ROjaa8cAScVaaIsj7nc+GmUsa4ZEJJxvxOEm5qFiNHUV4eEFBRmH9AxRn//iE27UXG9Z
         gp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762124508; x=1762729308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suckYxpxhS8tpm2524qw9Mw5oQrBRRr9u/yRv9LVIaI=;
        b=VZS0Zl8XxZSzqYbOVMDnZiPHq9kdg19DEjUtBe9X++6K7K6SiX7c+ZFVNJfIYzYmTf
         XyCca+8v/juOKzwRf6KjGf0V4jOxR/z47Y6gQVJupTfVFl122ti85/0UP4SMGvgYWD56
         RD2RKi5r05Gu04PTPX30xe+dBmg2CQNo/Q/1nwtmwv69OEQKkxsZ6VdOfMxwm/FxCRTd
         TFGtbvoL9sLJnAL8BBS5W+OSeD2rUbU6Mtyx6GYg4+fOL9DkosjaE/mGJNiQtHVZY+g7
         eY6MJS5veja1+59sDTOfV3HHe1JltfW8yOCpLx+jhwgvBeEc3cMFL/kHQiLmzO5aMSTt
         l+XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU9oTubJE65co42ULcjIT9mK3O6mzAsDxYBujnsIsk+J+6+cla6JN7Fe4aCTw5S7of5qNg0V5GN1QZMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL0VVJxggLnSHZPY92tUyZgGK6oSDR4VrRvJeyCufDJsohsAr/
	wCblDvIHuCv2SWIbyS9fVAPCw3fcbNtmzxJAyjIFshLti49S4YxL3Y3a
X-Gm-Gg: ASbGnctfFJtb8mrW4Ud92lbN0OF/pP+ILjpsk0+3S89egJBHIkehkhyIIejd1Zp8O5s
	Re6oHjdSAkFt8FZ8coKFQQMK+r+l4WNFtTbgpk3cGJd4AwIL4dOzP+sHm2VqcWgFQjKKYzgdpmd
	NZZgAzN22L2UhLP5eC2U4ulsfcExIGYf5b79qgpJ8eB0XCSCsjfalesez3EcH87PMMhuNvliew7
	ulvxOpUpoKi4sXhaVUKETs/c7lUX/Vjx8PKGSs4AvW0WBKHH73fMJCH7oZxI2gFiliJpGfVUQEA
	rodDstEAkh3FvvEDr3BZkgJCKE32Yfc85Cg1/7LSs1uRABorVI3Y2bDzQmzwPsN8kkElj3EOq6g
	8dQ74Hx/qZ5juXY8ugvSv2iR4tGoU7HgNmgWxnpNRNpGcfsBkHAK5e+qY6cNEbNBRnFrRteciaq
	HcHXjdVoisU8xN4sQ446O/F+KOr+W+TKQ=
X-Google-Smtp-Source: AGHT+IHwr7jt3DaVtnfLsqGmmW7FFdKpHCSeTikP3CPRe2wVho/p0Ad6nhxEqMqv/Lasjs4QOtMNdQ==
X-Received: by 2002:a05:6808:3c4c:b0:441:8f74:f2f with SMTP id 5614622812f47-44f96029336mr4760053b6e.57.1762124507728;
        Sun, 02 Nov 2025 15:01:47 -0800 (PST)
Received: from localhost.localdomain ([104.247.98.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3dd9a924727sm1210628fac.15.2025.11.02.15.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 15:01:47 -0800 (PST)
From: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
To: sudip.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
Subject: [PATCH 1/2] staging: sm750fb: align sm750_hw_cursor_set_size() arguments
Date: Mon,  3 Nov 2025 00:01:38 +0100
Message-Id: <20251102230139.1720-1-cristiandelgobbo87@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Align the continued arguments with the opening parenthesis to satisfy
CodingStyle and checkpatch.

No functional change intended.

Signed-off-by: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 3659af7e519d..9740f2705679 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -121,8 +121,8 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 	sm750_hw_cursor_disable(cursor);
 	if (fbcursor->set & FB_CUR_SETSIZE)
 		sm750_hw_cursor_set_size(cursor,
-					fbcursor->image.width,
-					fbcursor->image.height);
+					 fbcursor->image.width,
+					 fbcursor->image.height);
 
 	if (fbcursor->set & FB_CUR_SETPOS)
 		sm750_hw_cursor_set_pos(cursor,
-- 
2.34.1

