Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFEF192B78
	for <linux-fbdev@vger.kernel.org>; Fri, 14 Jun 2024 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358221; cv=none; b=W1HD3I/6I++Fyv2XFuPPsOfiLvpV/DsSMjCJSxGhlJ5ehyvOkg4VMUbZPnmhmO9GVyVnKlV9ZuRhGek2jixEyy8JFngQBIUb16mI0qlL8PYebJSaJWhzzMhSGX0EFLRje+JOr8FNSNjOOYmrVJel/vp9SPGWhxDvONZtEYHczX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358221; c=relaxed/simple;
	bh=keQq6LeSm+F0ZonXiMRrwgWDqAPJI/V5rs00sKADpT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MaFdE6i7Db5AFZIKoP4NFm1ko+75NWkFytl8guM13CTvsESq/em7xSkOZhTlCiA0r1y7F/wK+envp66KzsJ3F/hi56BN7ORMadO9gmeI+Comh+3CFOfc35b67kCN+zFovkIB+rUQ+b9YfVyPhpXVpxUZhC/XfAkGjfF5+go65PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGVvJgJw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGVvJgJw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718358218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=heLqAA0wM0fUQP0fORNtFU8D7JlMKELEoNr8KN8Qrew=;
	b=gGVvJgJwgwaROQ20GjOhMUOqn4zMJ1GRoDQxUL4poIrGC0FY5Bfm12ccgMz7YFua+aB7Cg
	AO2kmEByoH9Ck6rfQ1pYT9j7fYhn53YZxF+nAsOc94KNyrC6/xrh2Otbarc6E62U13RiHT
	Bo4e7BiZ22Pff+9/2xwA+UlgjVbovp0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-ORzDFqUSPS6wY52WT22Kvw-1; Fri, 14 Jun 2024 05:43:37 -0400
X-MC-Unique: ORzDFqUSPS6wY52WT22Kvw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-423034c6119so9290885e9.2
        for <linux-fbdev@vger.kernel.org>; Fri, 14 Jun 2024 02:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358216; x=1718963016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heLqAA0wM0fUQP0fORNtFU8D7JlMKELEoNr8KN8Qrew=;
        b=R3MlAgJLvqXASi2lOWUzScM2at8oQEophLQ9voUsD4BX3/p27aRRY0EH0huvplYNYz
         VYknMN/UrV7P71OH1bLHHFVqBn4U3PP95dpfOaaVeziYLno2zF2ynbgnqYkbxAcODQcd
         BkEtGIdnU4sHgxEFjU2WPbqQRxatHYcipPVmKT2cMki02e+8N0Pel4KGG/zTLmfE9qPu
         8ZrUVP8DttEzP+HkvS1y66LJ6F7IxjZbR0icny6nABtqGEwOXoUd+j9jrYT3P9fLcfsp
         1VWYRn1P8arxRRFmKCKYxmn/s7Whm3If3A6ZV7sYeMuLExsMgYeTJbDGWjajsqLQVOyp
         ZQow==
X-Forwarded-Encrypted: i=1; AJvYcCUzpeLQt9l74wb5ZzebgR2Q5WnrmXTb/yvN2xlCziZO7MrzyhZSvq7DvaFEvdUyJVxK/LmJUNs7IBCZssib0+vjQir86lyyuPi2UAk=
X-Gm-Message-State: AOJu0YzJuGhYFu/racgOtCswpm8Wjm6nYznTAkohymg5XbyU3jE46U9t
	zTEVkKo7dxKMfrBHMJ9Wl7doo4JYLMedGRmABKYNLnrb6I4jsmzW9SGS4R4YhjYowjssUhhgNUg
	oCtZ3+LmPNlmfAxYMwhWzn4Fjjt3k1Ql1xV7rt8YfNxwXGqvZjncfk5s/S3O3
X-Received: by 2002:a05:600c:2d8c:b0:422:140:f440 with SMTP id 5b1f17b1804b1-4230484adc9mr20830935e9.36.1718358216375;
        Fri, 14 Jun 2024 02:43:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwO+zXvhvhQvCW6i8bz09aVGJhUN0WDNG7f/kXUgSm5uCrWT8iKWcNV6XAPWyK1hW7VzDmzA==
X-Received: by 2002:a05:600c:2d8c:b0:422:140:f440 with SMTP id 5b1f17b1804b1-4230484adc9mr20830745e9.36.1718358216023;
        Fri, 14 Jun 2024 02:43:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e? ([2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e9145sm90904925e9.22.2024.06.14.02.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 02:43:35 -0700 (PDT)
Message-ID: <a45f0b8d-1220-4dc5-9d23-7ec5a1349087@redhat.com>
Date: Fri, 14 Jun 2024 11:43:34 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] drm/panic: Spelling s/formater/formatter/
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <cover.1718305355.git.geert+renesas@glider.be>
 <5a11f8caf8759aaa22d421034d3047368e9d5f33.1718305355.git.geert+renesas@glider.be>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <5a11f8caf8759aaa22d421034d3047368e9d5f33.1718305355.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/06/2024 21:18, Geert Uytterhoeven wrote:
> Fix a misspelling of "formatter".

It's probably because the same word has only one t in my native language.
Thanks for the fix.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Fixes: 54034bebb22fd4be ("drm/panic: Add a kmsg panic screen")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>    - New.
> ---
>   drivers/gpu/drm/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index a9972ce05d7e6fe4..e3c51009d9b476b3 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -138,7 +138,7 @@ config DRM_PANIC_DEBUG
>   	  If in doubt, say "N".
>   
>   config DRM_PANIC_SCREEN
> -	string "Panic screen formater"
> +	string "Panic screen formatter"
>   	default "user"
>   	depends on DRM_PANIC
>   	help

