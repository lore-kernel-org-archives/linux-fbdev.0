Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B417C478E36
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jun 2026 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781714736; cv=none; b=NBW9kt+XyV5ESbKASmmenNkVX6eHh3BGErnuQULZskrLwtMh1ZU5SE+38v51d8muSgfACVOnwWTVp8LH+ias9XRSV4A3hPEY9gud3x874o/lQEJK37AvPtBHrXKTO0KSi0s4aP4ORIZ2el3zWWQByy8mWDEN/MAqyADQlijJz/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781714736; c=relaxed/simple;
	bh=bavFeLFEpqC4Yg1c8I7L8oQhFIGVzqkuA2wOFOlRsQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLBNxXtyG0rXYFHvp68kWpERBAXscgDE9XBYtyxqGXwmuuyhZki9O2fqyiRmCtuORFPJ6DaGfSHt6Qb1DqD0jKF2qdvMzMaiDS6+YGynzFn1zLjmRsd65kuapNl7hKW9ecTSDEPaYYm57DrfV7r4jO9jWwprlkOz18+XDdsp9HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zl7yPVeC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl7yPVeC"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso76239745e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 17 Jun 2026 09:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781714733; x=1782319533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=A1zq+Wkffhwt6DPuMr/sNaZlD6xfxWLIc+V5gFViAHY=;
        b=Zl7yPVeC9VUFdzLfGDh7Lh2+FP6cxeXmH7RIW32q8hKJaAXHH9WAxgHD0gr/lCHy6N
         OQE0HyYvKecbh2ZSu/lqalbxdbe4Atc3jW+Cgu/UdLKXXMQ6dWowASXyf5mBhyH+qERw
         onY7twZfrQ4KWEXnT7ZXVg+RMFb8qTX1CN7ZQNqeqCNdP+1Jc1Dmkd1ytz4AJppxcQe4
         Aht8WpspE2TGkevINRtxPMoA9PnOho1NJ3+anLKl5wq4gsxY7PlZBqWiZjgsa8hLy9LW
         NhpZcfx3OnrXFF7ltRuKlmyUvrckAKV27RsUWeQQwU4mjJEMjhrndSHtnYMEEk5CaUsM
         oHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781714733; x=1782319533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1zq+Wkffhwt6DPuMr/sNaZlD6xfxWLIc+V5gFViAHY=;
        b=sB3BpA8ysWOfiwwBecS6HohlUHfmoSTSiT5YNGcZwDqplcle3UmaiX1dqFC1QAaJYq
         3e+wcJpN+UZ+yyK6l7ft4AgxNsUSudCGeRUxEQediBizZPVGH/mU0kyBhuRXlGyURgn2
         0e2qEbBHTiqBFk47KGnzoYld+S5lX8cdKUrHgFdPTSo+8UOeHOsjckTgfBcK7wico1Mh
         2V/BjSrzViZBiUUc+XvGa5b7+hMKGdlAxCTLZDbpcST0hVzOgbFC3+0J8SryFyOD6GXw
         OuOJJUI4Czo/4hmYupM2D19gpFgAAUJeSOUnO3pE8aXDHPAaLnlvh16uXzyefm8TzjMY
         Mdtw==
X-Forwarded-Encrypted: i=1; AFNElJ8cnmNOeHPYUQ0gRex/I0wA/wU6hdOCQtTvdtAId3BeBuyAmuS0QbExTYOkyMJVG+lUMyG6g3ifEbFzNw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yya33nOPI2KZG7Xbuf7xUdbaOrHafS8iX3z4l7xI6g4wZMcqOOi
	yQLGkqve3dybpzb0g1rfqmIMNKQu6HLJiy2PV2Ec6lrvADuwRpVUSZCa
X-Gm-Gg: Acq92OHXnszZq8JqjdNA9z9Eoh69JOD5E7N1DhMb1CjVnAjH3y7gyYHGwIN1WI6VKkI
	Zy7ceqCL43W6UvOlzClQZeHsOij5OiwslyLXBiKWb3NPoeeFDy5O0a7WSLeav2VZNyy3+VV2z5B
	jiozlOp/pFreXy4Dav++iXXDWAIOpLod5Bt1kyh2f4M5FHZWz0G9LVIDiQX3CGAhdHx08ZmKHgG
	IC4FBQBrurLr4+rh6eNKiLo8DyKofVCfaoNKWp6yR7uj0UbVrhS8t424tJUioz8HfyITdrMkoz8
	f8Dg7VESKhGNkypOS7KR96e41l7vSGxzUIgQKfu1Lc+LY0hYDcUQGEty4ruW5ujL+zLsczg4/y+
	iwBpWAE9bTh80Ff4OvCq17xKdpgCjzKGqfqPH6lIk1hs8fd6SWbzxNsyf0Uj3Xh7zgI2Zb9bkn9
	4tJ2nn9L1BCOazzoZKu0LwIU+eaTnnLWlQ3/ygW9EIUKo4F+xRopSstHmVJZaVtEtQWftU0/4or
	LoPb0Y=
X-Received: by 2002:a05:600c:c16a:b0:490:58ef:cea7 with SMTP id 5b1f17b1804b1-49238226b0amr3695935e9.22.1781714732879;
        Wed, 17 Jun 2026 09:45:32 -0700 (PDT)
Received: from [10.128.11.42] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0c10sm54827640f8f.21.2026.06.17.09.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 09:45:31 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <7da7d892-3b3c-4f83-b3b0-93eafe14e15e@gmail.com>
Date: Wed, 17 Jun 2026 17:45:30 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: sysfb: Mark CONFIG_SYSFB_SIMPLEFB as deprecated
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 sima@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260617081810.218168-1-tzimmermann@suse.de>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260617081810.218168-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thomas,

On 6/17/26 09:17, Thomas Zimmermann wrote:
> Mark CONFIG_SYSFB_SIMPLEFB as deprecated. Enabling it allows to

>  config SYSFB_SIMPLEFB
> -	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
> +	bool "Mark VGA/VBE/EFI FB as generic system framebuffer (deprecated)"

In v2, I think it also makes sense to add the 'transitional' attribute
to the Kconfig entry to help phase it out.

Also see this patch message for an explanation of 'transitional':
https://lore.kernel.org/all/20250923213422.1105654-2-kees@kernel.org/

- Julian Braha

