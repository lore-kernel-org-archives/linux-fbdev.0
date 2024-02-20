Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D24567A08
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422390; cv=none; b=Ap1nLukm/DqQvCfxr6yMy+Ovlpifo2FIlBU2M+82/yFJiwPkXDI/6NblTokGUHCE/rbYpWLA/iWYYvnlk7jU1ilYPmPnRxB05aDuyqupRFIfn0Y23DJyeDt2ExNs8bSDObbCM5NqJ2gXWzJsUTN8hmAasx5DMFv7fnbkoRaVqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422390; c=relaxed/simple;
	bh=VU6lUw9k90PuFwFfUzpvE+ClWSw7Z6+NspthVyDjW7w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aLW+bTbuR+h7K5RYgRc2KcUnyWllEjMo+IYyBU2KpPQ1xnxbkkmo55FIjr8JvUv8WLwVZq9HR6gt55oaWXUYlUOlnQuqmeL6cbthQIC0/pt6/jMOq+uQ5ZffrMsaAE4oCZOTilC4cyZGbm+Z/dCc+8Ph36lxLDScdy5tgfZ3wrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWx4QgFe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWx4QgFe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708422387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua+iueUGl77okzhaoQdUc6zme30b1qrWNRG/YazNKLc=;
	b=XWx4QgFecLD0ewKxJAMpIeKA8PgjsXqxBI3XqCdIlpszR6UbT1PHlRT+IsMPpFfY6SJMZe
	l+tEgIPEUJbwaWKs3/bNCf2T8vDarCffDmYSkKq9IZ+toz+FpgNV31GpUw3TdMNxU/WLYn
	RNqyYeM3xm7N23QHxQdCODZp3Q00/mg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-Z_6AkrgfPVWZN-rvTY-R_g-1; Tue, 20 Feb 2024 04:46:23 -0500
X-MC-Unique: Z_6AkrgfPVWZN-rvTY-R_g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-412565214c3so20340985e9.2
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 01:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708422383; x=1709027183;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua+iueUGl77okzhaoQdUc6zme30b1qrWNRG/YazNKLc=;
        b=T5bBmMOsvDDvNS97Qt/SzgH5sBONNGR3c6qqLAWh4Z/RkOrKFrlMZa4mS4X4U6FF0k
         oCm6Vfn9/IGVCJ55MUlPY6U+aqnqeYVsERRaMMYZh74EfgcPBvGQdk2Ze2YU1HcIBWiZ
         BAEdo7fAwCQXj/2d80y9nt+0qGXsXvmxZd+2ZQesVPiz06ylzfY+LMKheUm1TV2XQIhu
         ju6VHMUTsyj/nsuH96Au5jA+d1RCFFKO4BebaFayXQSdjQQsiODtRWb7Qxg6XWgl79Bh
         1WiI6dO+bJcwy29FGoOTjRNTRrxl6jrWKMrfEHG9swiRU3gj626a5ggB6PaJo/37BSaH
         hLDw==
X-Forwarded-Encrypted: i=1; AJvYcCVKVpKKM3O5D9b4hQJmyB9N6qPl4k8YCSFRNBN5vpWFQ/5tsWDSbBnRQBAPw6aA2QHI88leBS6Wr3ov7YpQ5Nl2K/HkFEbKZ8/OZiE=
X-Gm-Message-State: AOJu0YxjC2y/t0FzgHsjPAz25qOLbqEXqUgsM4uNUMX6JRbZu/4N9+Cu
	aAouSs+oMIZnsNtdO7E72fMicwsTf9i5vtv+/JrgrSfo37nPC6HkUwYOcie3fVTv3EicVLl/4Eb
	X2TSbUiBxFUkcgVOayw3rcb+ZjcaO1CthhEm6a3IeYCGqvatnMwVqnkiRs40j
X-Received: by 2002:a05:600c:4813:b0:411:fae0:b158 with SMTP id i19-20020a05600c481300b00411fae0b158mr10243414wmo.35.1708422382798;
        Tue, 20 Feb 2024 01:46:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVewDRy1qipC9k0gZj2P7ww2xioxl7Ke3sBkdfIzbrcFreEU44DweZYKlUDvIymqIYAVgmSA==
X-Received: by 2002:a05:600c:4813:b0:411:fae0:b158 with SMTP id i19-20020a05600c481300b00411fae0b158mr10243398wmo.35.1708422382457;
        Tue, 20 Feb 2024 01:46:22 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k10-20020a7bc40a000000b004101f27737asm13892556wmi.29.2024.02.20.01.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:46:22 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 01/10] backlight: Match backlight device against struct
 fb_info.bl_dev
In-Reply-To: <a5b9a2d8-f305-4b68-9086-76d5f1b985c7@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-2-tzimmermann@suse.de>
 <87bk8bjxzo.fsf@minerva.mail-host-address-is-not-set>
 <a5b9a2d8-f305-4b68-9086-76d5f1b985c7@suse.de>
Date: Tue, 20 Feb 2024 10:46:21 +0100
Message-ID: <87edd7ii36.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi
>
> Am 20.02.24 um 10:17 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>>
>> Hello Thomas,
>>
>>> Framebuffer drivers for devices with dedicated backlight are supposed
>>> to set struct fb_info.bl_dev to the backlight's respective device. Use
>>> the value to match backlight and framebuffer in the backlight core code.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> ---
>>>   drivers/video/backlight/backlight.c | 9 +++++++--
>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
>>> index 86e1cdc8e3697..48844a4f28ad3 100644
>>> --- a/drivers/video/backlight/backlight.c
>>> +++ b/drivers/video/backlight/backlight.c
>>> @@ -98,7 +98,8 @@ static int fb_notifier_callback(struct notifier_block *self,
>>>   {
>>>   	struct backlight_device *bd;
>>>   	struct fb_event *evdata = data;
>>> -	int node = evdata->info->node;
>>> +	struct fb_info *info = evdata->info;
>>> +	int node = info->node;
>>>   	int fb_blank = 0;
>>>   
>>>   	/* If we aren't interested in this event, skip it immediately ... */
>>> @@ -110,8 +111,12 @@ static int fb_notifier_callback(struct notifier_block *self,
>>>   
>>>   	if (!bd->ops)
>>>   		goto out;
>>> -	if (bd->ops->check_fb && !bd->ops->check_fb(bd, evdata->info))
>>> +	else if (bd->ops->check_fb && !bd->ops->check_fb(bd, info))
>>>   		goto out;
>>> +#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
>>> +	else if (info->bl_dev && info->bl_dev != bd)
>> If the driver doesn't provide a struct backlight_ops .check_fb callback, I
>> think that having an info->bl_dev should be mandatory ? Or at least maybe
>> there should be a warning if info->bl_dev isn't set ?
>
> bl_dev can only be used for display drivers that set an explicit 
> backlight device; otherwise it's NULL. There seem to be systems where 
> backlight and display are distinct. And the docs for check_fb say that 
> by default the backlight matches against any display. I tried to keep 
> this semantics by silently succeeding if neither check_fb nor bl_dev 
> have bene set.
>
>>
>> The would be a driver bug, right ?
>
> I assume that some systems create the backlight instance from platform 
> data or DT and the display driver has no means of knowing about it.
>

Ok. I thought that in that case a (platform specific) .check_fb callback
would have to be provided then. But if the semantic is that none could be
missing, then I guess is OK to silently succeeding.

I wonder if at least a debug printout is worth it. But maybe a follow-up.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

