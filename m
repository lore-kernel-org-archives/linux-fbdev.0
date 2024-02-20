Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DA2763F2
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443025; cv=none; b=c3d/oUyqA6Q0rTeBcb3UZFDhlXhmOHqNWfWP/pGLZNtkQyfvP5tKZMAirrASmHIDwj1TjXPrTW7Jsw2+WScZCVDF8p+rjU7nSVECQ9PXN1ErGx/xVFU40zFXr8RaVtPtZhfepczVGImzBGId2Y49OKEPiIafuu0DLYZ2Ie0cwdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443025; c=relaxed/simple;
	bh=qYHC0DIL9EkTejQxo0dNu3EOioYY1QzCa+VXZLu5HiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYRFfO69y4PQs1MYXO2aokC904LHboW1AuXJXQlbWd3Wiw/kQnJfdS427riesJJ+6GnYbkVeVPN3LJJWhDoCjTcDAfJIM850kOZRLGXbo2aMTlakjVE+l1dbDt/zYJRaH7nAFJTRssnxS9Xcb6OajtxKL1Wqy0u7OVjm5AILTrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c7FNHgwr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c7FNHgwr"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4126dd40a54so7057195e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 07:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708443022; x=1709047822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwLWP4/vhF0uIJPtwS5+bkpQQd9v2zac6pd8EH25YT0=;
        b=c7FNHgwrqAoCvO0G0cQ7kwC8S+uOlPtFbjY113GjE7pbjgX7wAoF4kzSvpbDSB7F89
         x97ZRe3cKmlGLaXTTMbz8Gk9iLHlMTfmOGj9uWHl7fWfv/+hg1d/ZmQlx7AKMX7cmpLs
         AdP66eAp0Y9V7nvFzc/zlubtrSbLz0r2ai6bh/5uEMHgOK1TrH41w9RFtqd6RFBtDjNN
         KCSmcg5yHp8ayC6BB3v23UCWYog4H1D4vjRB13vh2v8Z0AUZD95vGzXDmm4k42Wq+Z3/
         dYaqJ8YQqDIE/9DRdmyCcKl3Wt+4CP9cIUAaek+jzv2k8xx2XFZcs65iV9Sx/1HnFN8a
         CwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443022; x=1709047822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwLWP4/vhF0uIJPtwS5+bkpQQd9v2zac6pd8EH25YT0=;
        b=wd7WUk8hLsj6/clEFBcw+TeDT3hb16XkaoW2bUcbB/cruHKiwuX2k5/eG4WZk7/dg7
         YKaOAagz11+kXHEpInquEglRvAgiOs/rLcxH3yyULE5X0npRLoqQfISYztpk59Z/Vpiy
         gLGEHHkUEl2VAu36ERj5dtabjmXSsqM/RHeITvauiaSmqhqni75UR4TAYsghUedgyxRj
         Pjg9jwJZfeIwo0CWdqP8tUApt13ztbf7/9PHHQi43RKyyr0SyMqkEJB/U9X0Lc+MSCE3
         5GEPyx9WiIvDUpb5rDESojGn774QOoLGlMqQ+ixpQ3jn794cZh20KFNDivu7w2Ectiv+
         0Sww==
X-Forwarded-Encrypted: i=1; AJvYcCUU3du59dAYFJuI6OO9bQ7sd3lKLN43VTZSJkUw00ejWyfqyQAmAqFW+EIbt7CzRlM4rYzGr/DQ85SlwsLDcqY1xH03kiB3Ie30i7E=
X-Gm-Message-State: AOJu0Yyt6vIXzWJnZZyZrypgkOXtElojpW0UJNwqyzG1lMi7nS58D4o1
	qTV24tkOEIJfCwOtsOa7sObuJDt9i7Bahkudpn3x3HLDMSF2TjLM+8HSSmqySlU=
X-Google-Smtp-Source: AGHT+IEGWcSQbhDlP9tq4t7O/sVQt2zHCnqWm9u68HuVcuEt7FNSTdwzCSXTgIgXE/i7RnLhBW0X2w==
X-Received: by 2002:a05:600c:2805:b0:411:a5f9:26f5 with SMTP id m5-20020a05600c280500b00411a5f926f5mr13067635wmb.38.1708443022356;
        Tue, 20 Feb 2024 07:30:22 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c280400b0040fe308ff25sm14691564wmb.24.2024.02.20.07.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:30:21 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Lee Jones <lee.jones@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] backlight: mp3309c: Fully initialize backlight_properties during probe
Date: Tue, 20 Feb 2024 15:30:08 +0000
Message-ID: <20240220153010.76238-5-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220153010.76238-1-daniel.thompson@linaro.org>
References: <20240220153010.76238-1-daniel.thompson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

props is stack allocated and, although this driver initializes all the
fields that are not "owned" by the framework, we'd still like to ensure
it is zeroed to avoid problems from this driver if the fields change.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/mp3309c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
index 34d71259fac1d..cdf302d6f1cb5 100644
--- a/drivers/video/backlight/mp3309c.c
+++ b/drivers/video/backlight/mp3309c.c
@@ -373,6 +373,7 @@ static int mp3309c_probe(struct i2c_client *client)
 	chip->pdata = pdata;
 
 	/* Backlight properties */
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.brightness = pdata->default_brightness;
 	props.max_brightness = pdata->max_brightness;
 	props.scale = BACKLIGHT_SCALE_LINEAR;
-- 
2.43.0

