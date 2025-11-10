Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5C82FC875
	for <linux-fbdev@vger.kernel.org>; Mon, 10 Nov 2025 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793542; cv=none; b=scmHGgF+EUxwdDtQCrquedTwUJBvZXihsCzr3xd4BSUsUb9I3+s+6pw1ZH8Appgdp5ZskgRFNEiqKtp3VGJJgWwRNEpkE8AIJtYK3bxN3cWGvOBi6uWyL6Holk+UGauCIXw9+iKYiGBMlPHColE6Vl0aq5+1kWmPvlzZW8LVXBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793542; c=relaxed/simple;
	bh=kiNB2fO3oTEs981aAt0JS5iQlZG4IF0eLK7b3NPeWl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GAE8cpDZebReH7CPbANBfUEVqVz5SOIz3qY2cK8EcN5HgHOaQVSrwXE2ufQePpQqCiRA8uR3jDXXjlFBhtNNUDs0WsrUc5fIC0eLJIa1sds3S+SgnSs4SDWsN9x4CfyOpRIhPg3K1sgksNfxOR54UmJtV7Ks+6LT2rAaCLZL/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqA0YfS9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqA0YfS9"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so25417675e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 10 Nov 2025 08:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762793539; x=1763398339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+yoMHzq4OWCUa/io8A/Ge/syIs6RyyUhmU2sJkLMP4=;
        b=gqA0YfS9r8Rk6j+lU8275WDDCTZfb2zisLn0HfJ00moHyK2TAJ5dEqjfAfsIozYHjE
         hB+6f1DqNw0jwEM7jdwAn0UXE/vjNBJDUpN2btkGlRWy5wDFE4OR7juJ6+wcfyeQQ2Q2
         PMHbBS/Qu+9fkHfxKXqZu9lC/uX0eR8OvPF1keE3Py3lKUbEKGjpVo8jAZziuOoZiaTx
         XhpZ7c5xbGj9FFoYLkUD0G5/DO3fBz5N+M49j5bTQgsJUdahaehY4Rp1AvBFWXP3CQgr
         AIbXFS/SQm52WwdvwPjPNy82v36h5+pUIZVTAVJBSgpui7f+D62jPS793Nwd+LjVBh0z
         4LzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762793539; x=1763398339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+yoMHzq4OWCUa/io8A/Ge/syIs6RyyUhmU2sJkLMP4=;
        b=Zvs0mhA7g47kjg1isxp6byubXM0emyKVIRngQyvN/lU/f8m053FILAABICmp45JJYa
         lmFcs5klkrrVubtsFldTT9PDfQm8/dTw7j5+yzKXS9ArU+TMpjn8fen6payNLOojLPYf
         maFcsrjm3yWpZt0RVXUqZJbHKkaCMn40orC0mSXOMXx/jvBxu8mPhrjTrlQ1Viyn76sE
         6wLEjRzY910yu8768DIzEviKuEZcWfRQq3aHl3M1qJO48HDKR9nAG4SdL4gq4Nh2ozVe
         TQZhYqW5D4/8mxIukA16EmRkbRe5BFuWbEwHQXE1UtZKg44v3eZ+jih2a4UEk2Ja3cn/
         45eA==
X-Gm-Message-State: AOJu0YwQEDmoE/uo2BxGm7+aFjF7/jMIFOhsLyrZeKdUh+H790suTTND
	E6PBMCq524Gb8NOkZbQsX4Q8gUWq6u7u5klvSylnZrH3FCdyOn8NaiV7
X-Gm-Gg: ASbGncttecYCZLH3mhROwZHvKq3+DjYQcbsKSFBwrborGwAu5O+IjhweCubSZMaxYy6
	1JEs7aORv+J1MDAiTj5H9TG/Ec7zdvacUDJfMZBQkKHo8A4UzTQIwV0NYl1Pm6EOw5+DRWHMIra
	bvoxMfYwAgT5erHiIxmG3xpA9q4oTL7DkdvlEfC41Wcu/e10E7LRpp2ckFhA95XlCE7q/xKXrIS
	lTH7PFaRdaCroGBhC8Bj4BqBqLoFLI9NONauuM2wv911gtRBL6uSgtbuMYGsvOTdjovImKdA8T+
	65CKAsGAJF+bZ68pA+RphWOqiXs1l4VegeDCpFwVsF5sjHtIHDQuGWBQlyIQxVxcer3Knrd7ZhF
	VJPXP6W8U8RnOcq8hruwYXBwsPw7shz8OJmSI6UDcvdiP3sf3kfpF5qKCxPPfiCDvZheKfZayCH
	Vybus+9aDf6oLmVxNFx59KF0nDZEOzPy3uqbIv1REJkAK4IZcv+8fJC9goPrg=
X-Google-Smtp-Source: AGHT+IFEBkHfG5WjmgHWOwlDV9Phr4+xIjNcsuxFIG53bO4xWInLPdps27JCx6DYqmMEKGbWLuk6Dw==
X-Received: by 2002:a05:600c:6384:b0:477:5aaa:57a6 with SMTP id 5b1f17b1804b1-477732372aemr64753305e9.10.1762793538848;
        Mon, 10 Nov 2025 08:52:18 -0800 (PST)
Received: from dell (229.red-88-1-12.dynamicip.rima-tde.net. [88.1.12.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777f1b61acsm32926005e9.3.2025.11.10.08.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:52:17 -0800 (PST)
From: Javier Garcia <rampxxxx@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH] fbdev/gxt4500: Use dev_err instead printk leftover.
Date: Mon, 10 Nov 2025 17:52:14 +0100
Message-ID: <20251110165214.3076586-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I coundn't test as not have that hw but cross compiled to check the code
change.

Fixes: a3d899839064 ("[PATCH] Fbdev driver for IBM GXT4500P videocards")
Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---
 drivers/video/fbdev/gxt4500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/gxt4500.c b/drivers/video/fbdev/gxt4500.c
index 15a82c6b609e..27a46e364419 100644
--- a/drivers/video/fbdev/gxt4500.c
+++ b/drivers/video/fbdev/gxt4500.c
@@ -704,7 +704,7 @@ static int gxt4500_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	info->var = var;
 	if (gxt4500_set_par(info)) {
-		printk(KERN_ERR "gxt4500: cannot set video mode\n");
+		dev_err(&pdev->dev, "gxt4500: cannot set video mode\n");
 		goto err_free_cmap;
 	}
 
-- 
2.50.1

