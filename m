Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F42548E1
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Jul 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721382494; cv=none; b=GWMZDp+3q1veONRJdJfVaO139lsGT/ceIb9I18ZE7sri/e/Siomw3uzdeIcrAf+/Am9/0nYjNQoPMMR/QtrTf8J+Y0FChAC3k2Nn/nQ67OShdZPLHJmmATZG6+q1ZRQSAyMmCCgGq+YSHw2xl4hH1FMSm7A0YCNmwdI0cFne/g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721382494; c=relaxed/simple;
	bh=h3l2T5sEp2By360+/5+5liuYMkniFkS4ZoyWnatVDmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=awzt6pE0pbvRAA4I+NfwGdF4iOIkr4Q0ILC+Rjg+rNgl4RUyUFBcxI3T7SlOQ3K4Z0JZ7Aj9XE2A1VPSOD9nWvjArMudP7YiLoDPUJYTd9frMshbWv07wnsy7mH2nyfNgMsZ30r8lbJ9Nbwz9d39aWqltcYX+gwvsczryenX8y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A504NrIF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A504NrIF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721382491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wrXqc6+BI9y9N/9R3c5HOJPDPGVypzLRzTKRBdzUEf4=;
	b=A504NrIF0NL2DaPgQS7g3/hrfSWjvTOJ33eUUAIJCv6AINc7k/7jcfG942N2YXGpYuiXOr
	c616RjOgfc7UFuSXgiQ5diLm8eKgBGfKTqy4a120NlOEwIy1Sg/a2ZecDh1jBJv7Gs34s4
	Ns9mIUEdK71URkODCvPM3+KbkxWdb1M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-bXAhseydMmCpMeH-dRDHRQ-1; Fri, 19 Jul 2024 05:48:10 -0400
X-MC-Unique: bXAhseydMmCpMeH-dRDHRQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-367a058fa21so388648f8f.1
        for <linux-fbdev@vger.kernel.org>; Fri, 19 Jul 2024 02:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721382489; x=1721987289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrXqc6+BI9y9N/9R3c5HOJPDPGVypzLRzTKRBdzUEf4=;
        b=kEzmXAv1/fVj6981yWMypY/04d1WV8br7K0iB6kvJo7r8KNVXEYgP39La1dTXsO0eq
         gvP52BgtAh3v10qtq+R2fd1xLoLp43vT6ph5XBweBzt4XsYHsh+afhctz2I+/9U0x5L9
         ZiMoHPDnednqaGzHvfFcz9dsal4w0/nqhqkKKqFxrMge4P6Xg34YVXVgLxypnuYxQGc+
         hRlz/qVJgVv9TUfiJfYWRZOk4fCTsSudltfLumisw6DpxvEidgYV30T1+dXU5gL4UziP
         DXhgUes/LQir66OQfjZ1GCarR0XKlFG2AQ7Ozt8p9NqZzh8aNPLZZZfaJC0LXD1TSZRC
         3EIw==
X-Forwarded-Encrypted: i=1; AJvYcCX5KKSl9TVzjM4EFOPlDQGAuitBlQrRNXrkg267skSwnZRa6Kl+mfn6sMtWlIkTKLDLxjEbbchMlhXWPQz/z/kv2n3rCXfp27DBYhs=
X-Gm-Message-State: AOJu0YzgufHJCfc8siitEsKmeuyGZfvUtzLMr3UnCTIpR+e74HzDoBQ0
	jrNBe43BeEA8kGgcGppk+/tCKfvNvQcn1D618pZIU1LERaQXX7JD2HDgWqPHQ5WD9Y003Nj/veC
	wNNzA2fAsVFjmjw0A4U8LtiGk7001XbdPTLP4pE7v3uMzbA9h8anNyJAP9REd
X-Received: by 2002:adf:e650:0:b0:368:3562:7c76 with SMTP id ffacd0b85a97d-368742a29e8mr1315319f8f.3.1721382489200;
        Fri, 19 Jul 2024 02:48:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK22G63JIRPE2xIFnYosHW2rA1aTs4UvzPTnx79Ujjp4yRSq10kKEZSH+bF2E+A1zNhnULEQ==
X-Received: by 2002:adf:e650:0:b0:368:3562:7c76 with SMTP id ffacd0b85a97d-368742a29e8mr1315291f8f.3.1721382488767;
        Fri, 19 Jul 2024 02:48:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787cee03sm1119215f8f.76.2024.07.19.02.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 02:48:08 -0700 (PDT)
Message-ID: <031ac173-412c-4d14-ad07-52e438f86790@redhat.com>
Date: Fri, 19 Jul 2024 11:48:06 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] drm/panic: Remove build time dependency with
 FRAMEBUFFER_CONSOLE
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Helge Deller <deller@gmx.de>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
References: <20240717090102.968152-1-jfalempe@redhat.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240717090102.968152-1-jfalempe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/07/2024 10:48, Jocelyn Falempe wrote:
> When proposing to enable DRM_PANIC on Fedora, some users raised concern about the need to disable VT_CONSOLE.
> So this is my new attempt to avoid fbcon/vt_console to overwrite the panic screen.
> This time it doesn't involve any locking, so it should be safe.
> I added a skip_panic option in struct fb_info, and check if this option and the panic_cpu are set in fb_is_inactive(), to prevent any framebuffer operation.
> Also skip_panic is only true if the drm driver supports drm_panic, so you will still get the VT panic info on drivers that don't have drm_panic support yet.
> 

Thanks all,

I've just pushed them to drm-misc-next, with the required changes.
(splitting patch 2 in 2, and moving function prototype to 
drm_crtc_internal.h).

Best regards,

-- 

Jocelyn


> Jocelyn Falempe (3):
>    drm/panic: Add drm_panic_is_enabled()
>    fbcon: Add an option to disable fbcon in panic.
>    drm/panic: Remove build time dependency with FRAMEBUFFER_CONSOLE
> 
>   drivers/gpu/drm/Kconfig          |  2 +-
>   drivers/gpu/drm/drm_fb_helper.c  |  2 ++
>   drivers/gpu/drm/drm_panic.c      | 20 ++++++++++++++++++++
>   drivers/video/fbdev/core/fbcon.c |  7 ++++++-
>   include/drm/drm_panic.h          |  2 ++
>   include/linux/fb.h               |  1 +
>   6 files changed, 32 insertions(+), 2 deletions(-)
> 
> 
> base-commit: a237f217bad50c381773da5b00442710d1449098

