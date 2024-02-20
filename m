Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFC3762E8
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443349; cv=none; b=u8aXoaA8yMmHuzwpeLeqyoB/jhVOFK0sn3O9/MWIbF6uCQALORhBfqW/j5lGCnPfXoLA8RKkK07PoU5RrjF+3Wg9uRNcxLD+kEN+urqaD5I3H0bI5MEjYkJQbLTZMZbCW2gFZzqXdRZbktJPcGbdbVwySUGV1cW5rj/xLI9Nvmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443349; c=relaxed/simple;
	bh=qYHC0DIL9EkTejQxo0dNu3EOioYY1QzCa+VXZLu5HiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9NrlGfbbi+l4GObohAlgQ3HjQmPN5s+3MpjbHRnTCsjng+wMKiwOyZNMLigu/MvKx0QiGmsboujFUQC+bTMDt/05ogXi+tyHOsX8rhEH5NiG0NmHAlb558ARRmHMqf9uqwcDW9hsVtlsXtEt0EOqgadiK2iFZeKtbM0SYQYidQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UC6QvBg+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UC6QvBg+"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d146737e6so3483885f8f.0
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 07:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708443345; x=1709048145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwLWP4/vhF0uIJPtwS5+bkpQQd9v2zac6pd8EH25YT0=;
        b=UC6QvBg+3Mdb1lYH1E5enNvjiZPxjrCQyYs3NLvC0W1tVnAJ6SXsCZo3xouUod+3KH
         kP306Ihacy5zZvwIliTSIPMUAIEZzMRj5njuTeuRvHFYCed9aPC3aYrohNlXSSrbcwft
         3Nl47kCynpL68MPaqc9A6PAVLj/KIE30nxo++oBguSs4o6uKPGmffGYW547FXdJiYwyR
         mplMzkYsAB2oIYEHBxGMzNWw7zhMC1udcVF+GiLPtc0oQLYknIWPz5tKrwrUJdMNIzWq
         Cq7SYGQEMRHFUn57Lw91iXsEr1kMdtvCwTb1Qd3h4v/eQXbKdgQN2Rt6QPAqyFOj/vSu
         2jhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443345; x=1709048145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwLWP4/vhF0uIJPtwS5+bkpQQd9v2zac6pd8EH25YT0=;
        b=d5Szj+u2Ehh65hVpWV6VpwbHgnaSWsnQJMYhGURyxaL/3Iz7hbPfmC75TfamUqZcE3
         U6c5gQTbp93ArDy8uiCH+uOKKVvjBZWiqUXeGxSCpER1fAtVLLGzks56mK8e9zgJHLut
         Br91nQ8c/XiPazrrFOAH59MIW4A6VCt0h2T3hx3WmC/p2kvoi0raH0cQ+QUjz3A53sv/
         VteKOQNs6M2U6A+SXkTXN+FsYviGULrjHKm9U4pg4zxNAnRcypMZtaNNhn2aWD59p8Vz
         5yhbSBZtHBMQdXuQwmNz7TrL3g57lS9F/Jnhfh+PqOhQkd/610G3yFlyhaTOghI7ZkcO
         WpIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc22Rq8VW+j8U0VdjP6hrYpgPFr0LCojHy4uSkZkiC4ZNGfvyTzs/tZuny1DBinc95CqUV1qQJ+GmUcxEx8WgqU0C0irTLZCIwD3E=
X-Gm-Message-State: AOJu0YybfISk21ntCETnPLPr301ZoI7ytHpo429rFYiZkKCb/O/F4PeQ
	zTkGKHt3Lr7rLqEi81qE6wis6Oe9uC5xmrYIW2cRuklOelVVVgYacaxd/y7NTTo=
X-Google-Smtp-Source: AGHT+IEMn5UIvIGN8ynNgBG1UECcP3133jvG/f9Bq3NQkmhEynvf2+SdDbQmpD5zbEoioW5xKTd9vA==
X-Received: by 2002:a5d:414e:0:b0:33d:1427:5274 with SMTP id c14-20020a5d414e000000b0033d14275274mr10295254wrq.52.1708443345703;
        Tue, 20 Feb 2024 07:35:45 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b004126ec2f541sm2444905wmo.0.2024.02.20.07.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:35:44 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 4/4] backlight: mp3309c: Fully initialize backlight_properties during probe
Date: Tue, 20 Feb 2024 15:35:27 +0000
Message-ID: <20240220153532.76613-5-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220153532.76613-1-daniel.thompson@linaro.org>
References: <20240220153532.76613-1-daniel.thompson@linaro.org>
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

