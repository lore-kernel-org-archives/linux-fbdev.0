Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBF376047
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443347; cv=none; b=fs0yqbu8OMh8P59JYxEMg5GjBHWe6r68lfarxnKX8aNxcHSK7uy40Dy1vb1jMgttckIJ9jcXIDUzq1dQHq2crT7kpy+/fWCNmYPcSlSEiARfGlSwuPeXw/TEIQzlkYNtD1mXJT91sP8nt92EREi6jSw6QSe7dd5N2YxNalpDcq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443347; c=relaxed/simple;
	bh=O1s6f0aVlfXsIZe84Tbyl+6qx99iwWHj2GqrxpYofNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqGrnZjHS6Z0OsyqSDYyExn5fZOjz3BnxbMWXaeBSaTg4sElLxTSY06uFR7FMUwtSf98dCWbxzyVZYRwY2lTVo287FWB8lhFnzDzDNZiBtj7/5jSgjHVwsJBn+2RjNGT0SFEWqwdowuubHxzI5mrpK9Oon9LA8eSK+Tiaxe2YQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A49fnGSF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A49fnGSF"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4126f486429so5581265e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 07:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708443343; x=1709048143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dg9eYBATJE28KVVYL5JHYrMeYFjWDGTymWB+eHLR51Y=;
        b=A49fnGSFiIMUaweEaPKUd6QHs1z8WahFQvp8dNyIcW9wpWfWFd2pKWwpCxYEyVejeN
         ejOSqBBZKU8ynUhhYl076di+o4ntEEdz1UI7m689xVlDjaMPRWrPnKDGyE7D80yrZIn2
         fi5fkQFN9QI/zI90ZulWgsKtp2T+W9OnKjK3lto9WHpRf8MXD2hTMxXDM3KBth7eYhrK
         uiViPRzm1rhe67dBpceWcm7iRkXbctJFzzXIe6LqJAzlwDX/DYzdPaPqyLDsSMI6JnMV
         /dFpgDoBkGGeXpKYCUWZvH+Eneu0XtgoU1RjOS4oKyE9RCgUgfybCcdjbit9k8pyIdp4
         czUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443343; x=1709048143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dg9eYBATJE28KVVYL5JHYrMeYFjWDGTymWB+eHLR51Y=;
        b=BOowFsqg4mlwrC7KfpVLORXA83AYJgQexZx9w23vs2mXggJNHzXtjHvgd2hhMlPSMr
         R2Yo5J0ecA3uv0FzyYrkURKv2M8Fk/RAtaLFsW7n4v/ln46RqhDCBnomMqOxiQca2Cg9
         r5tO68R92jVWGgDZZ7DtLo0nDcLmV4FdgXBuSvWIgFojjiFFOlj8LU4XTrVTuJnUgJN2
         qKkhN8sMYV706poM0YAGRS+gGz/BS8wPSpaavA6tpVRXILP2JcIISY4HPjOv4VkSlz9R
         qWq/FZcjtLa2VelLg934i8I9ikf2wim+NpEJB1HehGWb9uUrSfGIaTPVJeT8sxgcLqzN
         4M4w==
X-Forwarded-Encrypted: i=1; AJvYcCXkATtzQwBNo3KLrAt0nvEIBtRcMc9zU2uJq9fm3fI+FdIoKZqAUQ2q1tT090cb3/5L6pTs8ZFup/Zoe7wKEL5+MlUNGJJjQJMOEdE=
X-Gm-Message-State: AOJu0Yy/BNO5q8sMbvsBgyCp5FXqfOrdbefIdDRSzoeP/RW1UD5WYfIe
	3r3MSuYGqgwgvFtyTgUnASd45pWaN2yM1ymwxtFG3keioBzShO7wuioNuYMuPBw=
X-Google-Smtp-Source: AGHT+IG8vq/wsIWwmwQlvm7aXyY0pdUfrR1TIk4qOIdiIiJ3ne1J8Iih0b1AG9jJ3O8+DPyJtcyN8A==
X-Received: by 2002:a05:600c:1d24:b0:412:6574:c9a6 with SMTP id l36-20020a05600c1d2400b004126574c9a6mr5189419wms.2.1708443343754;
        Tue, 20 Feb 2024 07:35:43 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b004126ec2f541sm2444905wmo.0.2024.02.20.07.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:35:43 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/4] backlight: lm3639: Fully initialize backlight_properties during probe
Date: Tue, 20 Feb 2024 15:35:25 +0000
Message-ID: <20240220153532.76613-3-daniel.thompson@linaro.org>
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

props is stack allocated and the fields that are not explcitly set
by the probe function need to be zeroed or we'll get undefined behaviour
(especially so power/blank states)!

Fixes: 0f59858d5119 ("backlight: add new lm3639 backlight driver")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/lm3639_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
index 5246c171497d6..564f62acd7211 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -338,6 +338,7 @@ static int lm3639_probe(struct i2c_client *client)
 	}
 
 	/* backlight */
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.brightness = pdata->init_brt_led;
 	props.max_brightness = pdata->max_brt_led;
-- 
2.43.0

