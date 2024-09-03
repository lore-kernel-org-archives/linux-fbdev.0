Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD3613DBBE
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Sep 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375363; cv=none; b=NJMxO06zkYJj9cI7AxKiIDx7U4sVeE6soaWW6Vq+xbzL9rX2H7A9lozbkQscww2QE8QibOXwHQC9AIWe0aAsDWL5kzg9OxHnPF+g86FBcXW5VC2nsreFpfFxxfCQHjCMbEx6PDsDTkbbMq3rwY1o/u3hMnnngWWIqV8A8LvhTA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375363; c=relaxed/simple;
	bh=mq4PoI0gorkAyyaCZit32i3NT28bgDnJGv+7A3joxoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYVD+asPA6LcR/vt1ZYj07xcLgr4xHpOawhPB+PlgEjaNCbBC0LGFfNKCpbDjUEw+CYoujLkQRmYuca4ra715sXs/MXoOYDf73CL+GSU3VbaRqkPszfOAqzvaGE4w4a+VwCHa6Xu88nOZ7Pade2UFMExexklontqFV88MaeStEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RqJYcmUT; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqJYcmUT"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c251ba0d1cso2332202a12.3
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Sep 2024 07:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725375360; x=1725980160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mq4PoI0gorkAyyaCZit32i3NT28bgDnJGv+7A3joxoc=;
        b=RqJYcmUTKFBDuLBbgyXS/8YoQdi74ETHl9WQbNjmA/L3F9SBGB7F7FUZqz1kygbjD1
         tkrCHh/Jn3qvlFcxbdN5VeXc4D3hSUZF8pp7giDFmbnXTShODQ9YL9wuVt7uBMMh1hAH
         tGKNgqtFTmBpLXVG7ILAWVQxJFyqc+zmx/D2ABnGnO/FKg19oA6Ace8u/pSrZV0M+P9A
         GW9+12o8oruwNuiaz042wvBMKzWBx063N2G1JwPE7+MaasGYOsyjl2OR3anTC2drHuNI
         Ybtd92QzWIV/rdIaJXO8KBBwexNUIm57ayrXFMmCbaECQquuy5Ps39T/suM2kBFUuf5L
         FNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725375360; x=1725980160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mq4PoI0gorkAyyaCZit32i3NT28bgDnJGv+7A3joxoc=;
        b=s8FqxpHuqTLOMg1/zgViYz2H4fhHUMMd4aox76DBwl99WWwFF/YM4Jq+NMEqMdiZIK
         17K6DaMn90TnUrn6hjIV4HT7rmN1W46yjOCZz7JpdqhfqEgay12p7p1D/urH2nVEbhRc
         Jc1jn9pRFJkGiRsFKd8NBfl7ZDeJJwC1Ox42mZuqHhq/evqQISSeMOrIij1Ku+iiiSlv
         tRpVyGIL9Agk9gLVz8ByiiVXARhUgFPpn10Grj9c/JBbHkQ4r+NX+tepYiBt/i7ImsCe
         V1RsrivwKufb1U/OCYwO8pMDGDeo5GcgKAH+ghkXdysNPdUbJnUUlDJRZpROVan93Iuy
         vM9g==
X-Forwarded-Encrypted: i=1; AJvYcCU7VW/OJmYrp1jlZuKPcHI5W/mAobZZNNCQSRrbQjPUDLmFaYJvDe/8AOBxR0owkiG5s2ZZkbSaocCn1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFtMAPpjIz71yizmkbNfv4ZG8xiCHAfOXlhG3rBLXPGPx3IOj7
	C1F3bCJ2GaO4HUbLqhRcokhkbJoXMlhLzMFSkn+maC9QicxD2xh2eQmtcb6D6gg=
X-Google-Smtp-Source: AGHT+IFmCIy4WjsM9TxpFUwCZ5NOUizVwi6W7Jj6qImaS1/dW13DdSWn/EnFrWRnxL1i31++KvAcsw==
X-Received: by 2002:a17:907:e91:b0:a86:8ac7:2b5e with SMTP id a640c23a62f3a-a8a1d58a5d5mr322181966b.65.1725375359706;
        Tue, 03 Sep 2024 07:55:59 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891b9e7dsm693567466b.104.2024.09.03.07.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:55:59 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:55:57 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	bonbons@linux-vserver.org, jikos@kernel.org, bentiss@kernel.org,
	shc_work@mail.ru, s.hauer@pengutronix.de, kernel@pengutronix.de,
	shawnguo@kernel.org, festevam@gmail.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH 26/28] backlight: lcd: Replace check_fb with
 controls_device
Message-ID: <20240903145557.GD12939@aspen.lan>
References: <20240820093452.68270-1-tzimmermann@suse.de>
 <20240820093452.68270-27-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820093452.68270-27-tzimmermann@suse.de>

On Tue, Aug 20, 2024 at 11:23:04AM +0200, Thomas Zimmermann wrote:
> Rename check_fb in struct lcd_ops with controls_device. The callback
> is not independent from fbdev's struct fb_info and tests is an lcd
> device controls a hardware display device. The new naming and semantics
> follow similar funcionality for backlight devices.

Nitpicking but...

s/funcionality/functionality/


Daniel.
