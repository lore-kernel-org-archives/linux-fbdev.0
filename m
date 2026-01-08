Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D4C1DDC07
	for <linux-fbdev@vger.kernel.org>; Thu,  8 Jan 2026 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767902464; cv=none; b=rK/XPugByeqZS1AxRUQL/B+tfyBp3rs6Akodr5g0oXbSg7ClSeeZ1EVE77oxU9lte89+Ho1eByxZkyh7oqN5ErS64voeS/vlaRv7ok4B639yrISGW9HOthIXwrMkWTvCdsHuBKHMt/2/BUAibDFHByDpP1Ff+f5vW6fHryIszC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767902464; c=relaxed/simple;
	bh=DE6Sp1xOrVBNsH6sK2fuRAlXsqjZwLxh07gWzBcBmtg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CHV53s4YfNjqs/g0UF3jxglBQCe7h9aVOOvXT2sUYG6uENp3gIhOYkWJBRMuUOkzLrniw/fKlbqhSCqCv86fvQcUjgRWkq77E0AXwXL8tmtaGipS2tUR+4ZufHxBF8PGxZQfatiVEESQAwePxHNYsXNNbbzkotvQ2BAHDuDbDuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y1rGkU88; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y1rGkU88"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43260a5a096so2486801f8f.0
        for <linux-fbdev@vger.kernel.org>; Thu, 08 Jan 2026 12:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767902460; x=1768507260; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0R59JhP2h+GNKoVP+C9/jngayGQfqzbzM8akEAfrgYo=;
        b=Y1rGkU88DBRDx2fqYoyOlsxxs3rrpmhY1BfRnda5oPhYQRfxp4ctXH3jIXEVX43lN+
         MHpT7EsALTnyHg+IDnR1CITsEpi1FeXp2nxJ+tePwcWa3a8xtmli3JqFv/I7KCAMuO+w
         tSYKxXhTdYhtLRYOZSvHWpdGMQ8I8vYqGSI5deKdediM+/3BneYNf3Uv5UZZqZMTOH8j
         /hZXl3HHS91FZ/JhMSgKKqsYVCG+CLgpDYhoI0zqlmMPyjmZ+RwVqjCxKWV6/h9cSA3s
         f854u6tN7dBLjX2z6hCXdGF7hGijrxENL5XNa5WJa1mq0RQmFIuQqsKUGOO3zobvi/3y
         ZloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767902460; x=1768507260;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0R59JhP2h+GNKoVP+C9/jngayGQfqzbzM8akEAfrgYo=;
        b=uc0phw+oFm8dlu+khV/bvxIofFBNJb6soOCNJUNieox50/eN4VQLSxQ3K/dbA2eKXL
         C9ybPgMWdH/U15nlq49C7ZZMQmXE//UzjRFldMI/BUMHC9d4D17mBATADQVsIxUcSczw
         Bs/lEgtHHnv9C5q5Dg84T79B1YpT+Hb8ypLctS+qIC+lOf0nczu2q9fbjU9LRmmn76uF
         UBoz7th+hlQR0Cab1s7/GuJbNDMtm4pbLJVHvXNNvNHdzzY193smMXitEzqzYU1WL7+S
         Kd5daBkUQS9ZLh+t78P3RPY6vXPgYhl7wJyM/YMTa4MqyoMQtrunu1frT6TUXoU3dHIn
         qZfw==
X-Forwarded-Encrypted: i=1; AJvYcCV0XVdaXc4KuwM2K1NX9q9Kiw1XSOeBBk5Lr8wlF+1T2QtQfE5UBefQ/R00i/ml/eC9qLmBXuDWw3ZCTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx94lfELWC+lL/fzhGxyW4nMHK8qd86mCH3XnnaRN+vU3FH0iHY
	kFP9h+593sNBf+LzlbUV2V02uhT8SywGOg1F/0CbbH7CO6N02x7PMM6Y+GnWZFidLtU=
X-Gm-Gg: AY/fxX5SkOW03PfpzNjpwMH6VJHQkkQ/R+H3wsmZkf5BGNa2SS8cd6v/HNMg5xpCM4Q
	xExwR7mn+KExKQlVamVWw7hO3MhsSNKAVwYIWP0s9x6Ut8Qzzs7M/n7H96uUYEyI7Oo7H8BoxDY
	uedGqTjc2BNy0MGiVMLmDjlhybC8BrEpI0Z7hMgUZXtUzFZVvLn9KlbspHz+ODv2QzuB2KKnadU
	Dz/ZRaJkfgBfkU5aYU+X1dRIWqSYCuIxS+z+8gfWRTvM2twZBuDYXFREvK+pX2VlBlYGmh85SR9
	9RdXEKoghrpurYbYUYJ+95L5E75idhQNUhvLHxch1zt6DX4hFoig+VVVkHPSSHapAR46Vk6K4dy
	UROpWx/xF7ZFYX0f6hqidb7Byrj4gv7s2DtLMaogM1WOGIWYDv2zOQVUtKaQO/wcnDCcFRfasct
	OJKHPV39MjR5+xN7vO
X-Google-Smtp-Source: AGHT+IE0npwunWACAYL+5K87C4JawJUGa/VvYRBjPWPZGKZYwiEeVeAPHCRJ0OWPGNFKQWH85CyAbg==
X-Received: by 2002:a05:6000:4287:b0:430:f494:6aad with SMTP id ffacd0b85a97d-432c378a7dfmr8823298f8f.2.1767902460211;
        Thu, 08 Jan 2026 12:01:00 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5edb7esm17838263f8f.30.2026.01.08.12.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 12:00:59 -0800 (PST)
Date: Thu, 8 Jan 2026 23:00:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
	linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] fbdev: omapfb: remove duplicate check in omapfb_setup_mem()
Message-ID: <aWAM-SZArPSRNaNK@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We know "size" is non-zero because it is checked on the line before.
Delete the duplicate check and pull the code in a tab.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/video/fbdev/omap/omapfb_main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index 106d21e74738..a8740213e891 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -846,12 +846,10 @@ static int omapfb_setup_mem(struct fb_info *fbi, struct omapfb_mem_info *mi)
 		 * be reenabled unless its size is > 0.
 		 */
 		if (old_size != size && size) {
-			if (size) {
-				memcpy(new_var, &fbi->var, sizeof(*new_var));
-				r = set_fb_var(fbi, new_var);
-				if (r < 0)
-					goto out;
-			}
+			memcpy(new_var, &fbi->var, sizeof(*new_var));
+			r = set_fb_var(fbi, new_var);
+			if (r < 0)
+				goto out;
 		}
 
 		if (fbdev->ctrl->sync)
-- 
2.51.0

