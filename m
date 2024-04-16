Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1260129A7B
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271946; cv=none; b=hI9CfG5taQbnqrmQYVcDIsEzYlpDNyOUl5yMoI6Hd9W+wwkUTQg9LvvVnh3CQzdgl3jVwkCvSL8+6VFHmLd/r+D8KxQUTZKkzbR9jROV7Ug/GNnOS2xQtRszu8A6qAV5CgSfSC9C98A1zn7EqkRN70wRgqhoW8q7LbY/xBGY33s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271946; c=relaxed/simple;
	bh=bHfGOFEGRHP3cUTy7CN8AginmZyAOrLmUV0i0kCs/yw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jkwMS5C18NoNODgUgZ9wqf5Gxzszq2ZLk4j993BkoNK8oMLXdC3bZKwc3+ClbwGMOoMyrI03qTDjlbZ1U0vfzFXAAS1B68KqdrcDmRhsZm47RNWSMI43LEVZujau0ieP4hU/YTNV8ecw9jd4d/L2AL4ckex6pmHbFQ7N7JMFF6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTaqsBgH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTaqsBgH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713271943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zxlFUfTeSgKCsCdKtJ0S6d32bgkTGD79E4bwSfj5zbI=;
	b=ZTaqsBgH7QS/hcD+JXi9Q48qC10fLorExSc9RUooKTrqliKV5eYIEL/eJTQm5Hg7+gRDtc
	6iqk1FkgRzAol6o36v3bn6LH/vb/XP21a/x8/JU4uucMfPrZkg34uqML8fvKOMpYhTUitv
	aawBRRTdTffwcfA/trgbR3D0Lg0sOqQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-Ktjpl-lpMz2nLpM-XLE33A-1; Tue, 16 Apr 2024 08:52:22 -0400
X-MC-Unique: Ktjpl-lpMz2nLpM-XLE33A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-417fb8195d7so15525005e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 05:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713271941; x=1713876741;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxlFUfTeSgKCsCdKtJ0S6d32bgkTGD79E4bwSfj5zbI=;
        b=FnWaJIZbxaIK0762oZgt1tdfQJt2rd+2hmZUvHv/Po3br9NPWKxA/vqURvCtJ8i2XU
         BL+yndAi2yZ7hKVGxeLmutG4kSupE7Lag9oPtiauY0/ZH3jkWdG2MHrNldQ+rzwgBeJx
         NEJR3iokcsHQL4kP8K23iH1GOI6Ny0cisp+j77o+QClguj0AtF5bxGZpmgPAufuXKmVG
         DR4g3HTF3tUMiVE88O0L9y/jizV7eRLvxM15WfpR/tS0Oicy20H0pdV1UDjGkaxpC1++
         DoAjnv/rwEUCHVoqnsprL71AJ3R4cmpTMXcNZKrW0t3Mi5gvdcijx8rn/3Ga1iaCWvnn
         R/aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEG1MnIt+NazlSR3P4WXVk6OJK3/5talmDMHbhQco5cTlIj1sJF0TfoCsfxN1vIf85oFKvnV+zjgU55w3s29W/+wwaJIR2usnO1gc=
X-Gm-Message-State: AOJu0Yw+XpgA3XOEzUs54zcygmENu7/A0WCNBqm0G5WL5inb+r71+cd8
	pHZUJtKTbvPtx3YL8vntXsS/7PnK9tMoPKYcTkosoBHXCbSxBNZShY7d4pvfx/92iIqDNeGeJMs
	mDOD5aAj2qqyDmL4EcKBS8anlT7RgJj6/Jaz+0ZA3EiYEY0ryZpGnIBroFgRk
X-Received: by 2002:a05:600c:4f49:b0:417:f526:6cc3 with SMTP id m9-20020a05600c4f4900b00417f5266cc3mr8922263wmq.20.1713271941000;
        Tue, 16 Apr 2024 05:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH25PNtyLwQbkK6cR9rp8WCEMDH38TwHqAQN8DUaQuPcNKQqbZiGlv1wsD/OJ9PLvJxgvGQsA==
X-Received: by 2002:a05:600c:4f49:b0:417:f526:6cc3 with SMTP id m9-20020a05600c4f4900b00417f5266cc3mr8922247wmq.20.1713271940487;
        Tue, 16 Apr 2024 05:52:20 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f18-20020adfe912000000b00343d6c7240fsm14804520wrm.35.2024.04.16.05.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:52:20 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 21/43] drm/fbdev-dma: Implement damage handling and
 deferred I/O
In-Reply-To: <18d461b6-8086-42f5-b629-b673daa04bd7@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-22-tzimmermann@suse.de>
 <871q757b73.fsf@minerva.mail-host-address-is-not-set>
 <18d461b6-8086-42f5-b629-b673daa04bd7@suse.de>
Date: Tue, 16 Apr 2024 14:52:19 +0200
Message-ID: <87zftt4gho.fsf@minerva.mail-host-address-is-not-set>
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
> Am 16.04.24 um 14:18 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>>

[...]

>>> +static int drm_fbdev_dma_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
>>> +{
>>> +	struct drm_fb_helper *fb_helper = info->par;
>>> +	struct drm_framebuffer *fb = fb_helper->fb;
>>> +	struct drm_gem_dma_object *dma = drm_fb_dma_get_gem_obj(fb, 0);
>>> +
>>> +	if (!dma->map_noncoherent)
>>> +		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
>> I noticed that some drivers do:
>>
>>                   vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
>>
>> I see that vm_get_page_prot() is a per-architecture function, but I don't
>> know about the implications of getting the pgprot_t from the vma->vm_flags
>> set or just using the current vma->vm_page_prot value...
>
> That's in interesting observation. The code in the patch adds a WC flag 
> to the existing vm_page_prot. The code in your example first creates a 
> new vm_page_prot from the vm_flags field. Fbdev drivers generally use 
> the former approach. So where does the original vm_page_prot value come 
> from? (I think that's also the question behind your comment.)
>

Yes, also if the vm_flags were set (and where) for this VMA.

> I've looked through the kernel's mmap code from the syscall [1] to the 
> place where it invokes the mmap callback. [2] Shortly before doing so, 
> mmap_region() set's vm_page_prot from vm_flags like in your example. [3] 
> I would assume there's no reason for drivers to call vm_get_page_prot() 
> by themselves. DRM drivers specially seem to have the habit of doing so.
>

Got it, makes sense. Thanks for taking a look.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

