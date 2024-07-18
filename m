Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258946F30B
	for <linux-fbdev@vger.kernel.org>; Thu, 18 Jul 2024 07:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721286368; cv=none; b=N/fjg3ZXrrl73+5LThwbz2Cy1QP7l/eK49Y1624QRNShJowoMPvWbiTE2QEsIFl8zZZ9zwXICayQy6YWkIwBjKz1TAitiDr8tTJRYPRfWodyzLrtGI0iGLhmgoe3UtcsmBo7nfFWFIVMOdc8MOXqtiF4vW3D05G4rjjUJhHpk5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721286368; c=relaxed/simple;
	bh=uA0JGGjakiMbR9WsA7dhks+DdnDu6St2X1YRdoaTlws=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=elUKAiC7ihS3HBpKrY4e56D8Dn7XswZT2F8mAJlBPRtt7TUwq5clHPLZ0L0DFM4Qbdu1661Phf4M/VBOXYGlBACzxQQF43+GgC3v5IqxplynEdArFafTeIfJfJ/rx4tLKb7vymIIhoG3P4gSU+XSQ6YeuUvM/w1otZXJFYEQNJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JW9XMahH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JW9XMahH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721286366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZ1lU4s3MEl0eqBrDrKpVc0POkcvbrGUvI/MYSaxt9I=;
	b=JW9XMahHpN9JlXItgjKirIQ2J7fVIUqpwRNQJqJ33LLNJo1XiyAYv4U+PB76JJrMFG4ZlI
	cIW3tBTFdsdN7pf4I9ovUcSWoDwtiwkrH5/asx0b7ooH3hDMlBD9NkS6uEl8HuOG4qis2M
	9fVbe3VNeTgIznaRJURJMyfuWPR28RQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-wJHjrgcuP0eGtiLVpf4oOg-1; Thu, 18 Jul 2024 03:06:04 -0400
X-MC-Unique: wJHjrgcuP0eGtiLVpf4oOg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4265464ddc9so2012135e9.1
        for <linux-fbdev@vger.kernel.org>; Thu, 18 Jul 2024 00:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721286363; x=1721891163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZ1lU4s3MEl0eqBrDrKpVc0POkcvbrGUvI/MYSaxt9I=;
        b=UMFSaIZ3xE2qrUfDGlxnQS1EO2JpZNvQCKy8SLFEDeXvuXUsoC5tKk+udEafyrB1Cq
         hPAkiaFutdc3D5t4X6vjIWhbzzKRa6XcR/rZQt6I6uRRmksMnvEhmAmR2jiNircWXlqE
         iN1cc0MoYhc7vKDjA00y7a+ATvQpJ4VbKwu/TMhnX3TG1oYMFhJdDjYtCo0wNs/DhRNT
         Kw36OYfDh23meLygkCmvCCVmRPy6hxeg95FSTjQuOoFoSpPf8bPp3ih/6x1fT+v0Q4KW
         v2xhXPi0YbCLnYnRMIm/KRExuUGmaBSwHrrBc72q3W1oYXl4maV9nsBLCVU9WRssQSwO
         PLRw==
X-Forwarded-Encrypted: i=1; AJvYcCXDn2ewiACzdLiSErw+Oyz+Kt/+C7Un9g/GCF3CDsWxSPSp7+/D8zT1O8c/aBM6KrVY599aMshHyxSgHaI/+puUMgMFXSYjoekJqEc=
X-Gm-Message-State: AOJu0Yyve8izqLLNhKcpG1Mwm3a1EfcndXMw1YYEAt/nrBYhiXgc8DfK
	urgvhqvdUClPdfK9z2E8TgdxT7F5ZScmNyf+h+6edtMnMvnS902a6cnIaSb/gjQ+B4/MQ5tE66G
	2gdjUrfKDvTbdyRrw1DEL/TTS+RowCw8LPsoWSgwxUFSJQBTkoRxgu//waAxA
X-Received: by 2002:a05:600c:a41:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-427c83abaacmr11056335e9.17.1721286363342;
        Thu, 18 Jul 2024 00:06:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa7qUlOIVPtRLS94vJ5+kzoefqLguJcUGf7zXA8087LONGESX8WhOSNJuoCKzvG05hbn781w==
X-Received: by 2002:a05:600c:a41:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-427c83abaacmr11056155e9.17.1721286362999;
        Thu, 18 Jul 2024 00:06:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77f21bdsm23840755e9.29.2024.07.18.00.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 00:06:02 -0700 (PDT)
Message-ID: <93589af2-dcfc-437b-85ca-b0029f4d6401@redhat.com>
Date: Thu, 18 Jul 2024 09:06:01 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] fbcon: Add an option to disable fbcon in panic.
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
References: <20240717090102.968152-1-jfalempe@redhat.com>
 <20240717090102.968152-3-jfalempe@redhat.com>
 <ZpfdcC2Es9rweHW_@phenom.ffwll.local>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <ZpfdcC2Es9rweHW_@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/07/2024 17:04, Daniel Vetter wrote:
> On Wed, Jul 17, 2024 at 10:48:40AM +0200, Jocelyn Falempe wrote:
>> This is required to avoid conflict between DRM_PANIC, and fbcon. If
>> a drm device already handle panic with drm_panic, it should set
>> the skip_panic field in fb_info, so that fbcon will stay quiet, and
>> not overwrite the panic_screen.
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>   drivers/gpu/drm/drm_fb_helper.c  | 2 ++
>>   drivers/video/fbdev/core/fbcon.c | 7 ++++++-
>>   include/linux/fb.h               | 1 +
>>   3 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
>> index e2e19f49342e..3662d664d8f9 100644
>> --- a/drivers/gpu/drm/drm_fb_helper.c
>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>> @@ -40,6 +40,7 @@
>>   #include <drm/drm_fourcc.h>
>>   #include <drm/drm_framebuffer.h>
>>   #include <drm/drm_modeset_helper_vtables.h>
>> +#include <drm/drm_panic.h>
>>   #include <drm/drm_print.h>
>>   #include <drm/drm_vblank.h>
>>   
>> @@ -524,6 +525,7 @@ struct fb_info *drm_fb_helper_alloc_info(struct drm_fb_helper *fb_helper)
>>   	fb_helper->info = info;
>>   	info->skip_vt_switch = true;
>>   
>> +	info->skip_panic = drm_panic_is_enabled(fb_helper->dev);
>>   	return info;
>>   
>>   err_release:
> 
> Bit a bikeshed, but I'd split this patch out since it's for drm's fbdev
> emulation, not the fbcon core code. With that:
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Agreed, I considered doing that when writing the patch, but as it was 1 
line, I kept it with the fbcon change.

Thanks,

-- 

Jocelyn

> 

