Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D8E1DFEF
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270188; cv=none; b=DAkkG3S6mXMZ1R8v/+WKtuPYmipwri1xQHOXyGp8YLPRVJo8GYn/S6QHJgvo7gB8ekhniisNHz7c1DARAvDc1bmxacFABxQAlGzIQ7HKzf9c0+jH0LNScS11UjSRou7f3wqoaLFTR3oW8ep3PRVPX6ZQ6XCeEgjTnsmpRbjqUsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270188; c=relaxed/simple;
	bh=C1jUeqwDwmjObgO1egTxhOoGgeyaGrt608rckVXXR60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ev+V8u6A/xIx1a/vs6wlPzL9dkRUXfjtOm5Tfv1heXawIhB2wiNA9XR8oqNhPs0QQ4zrOs5kpcXmELBC61fbLZEBeerpNOU0cDqaJZXI8otLo24Kb0/AiUOdbHRaTYLMDSAHCYzT3bFjheHqvEKcj3Eg/Xj6nKorNd+/3Oy+eZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVlJIpo9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVlJIpo9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713270185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEDYzTJZLPP5KChkZiTTbiufy8jdzN3WLrTioTKBrxM=;
	b=cVlJIpo978XRs0VmraPq8ZYDvpQ+ICQ5VL17SfGoRfYO2Wm3HtKWfov8FxNeuupko5GPrX
	JavoxiAiTLGLmplUiO7kS18HQ8XDFHztfW6HyLKYxvLMG9olVcoiAzjH7EAtvCg/nkEsIN
	bqbzaAzpAU9Up56A9Lj+OmtdhowmtcE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-38Gx8actMzm357dPsMsJkQ-1; Tue, 16 Apr 2024 08:23:04 -0400
X-MC-Unique: 38Gx8actMzm357dPsMsJkQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343f8b51910so2470966f8f.3
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 05:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713270183; x=1713874983;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEDYzTJZLPP5KChkZiTTbiufy8jdzN3WLrTioTKBrxM=;
        b=DS24D2m/E/840cOMgsIfGrMkMFoXWGcKAPp28DGT1cVkRnzttB7V8nca+edTz6An9X
         py9iIMtdbHE0d7kpa8zHy5Lwv5PYDlzfv3NIeAnfdFdILzxtJKb6blbCI6HPpkPSMVcK
         T2sDLpuU3jzZBUCNkm0TEMGCh8TQTKo86v0hOJBAtG10t51f3EcNxJKFF1BzSZVNHnS6
         tcpCjmlf5UJr6aSoZ2V7DGgtYedRc9sHY3ZXFwjargGywKO37dbUtTiz0ujqayGLQNG/
         06DXDfIhG/u5ZkQRO79AZ+SbcL9SgbRHl1BYn7vtBs0AUNpEjwa9pBf9pWjVonTGyPvO
         HLCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmhk8s42rwqem0zdEkb4EZyybpD5+SbsE6SN++pihru/dW3lGgYD269JxSwFk+Q4NiDD4OumZgdBKWG8x9HQoAlH4UTZq9E8/FobE=
X-Gm-Message-State: AOJu0YzSI5B7AbgR5UB6jZib8iH6wCGyATK8qnq5CAo/ZgyXKms/J7QV
	ESSdU1xnJoRzaTsaHDCuizpWkBDoiaZfZ7Eu+NisKnaYM2xEkmn9G7is4+CnWediPNb0YnyYlec
	Utim9PdCPG7C/UxchpDRiL0/QLSf88JGmyy8zJk0X9QmUEYEEgNwHESpRvrk4
X-Received: by 2002:a5d:4842:0:b0:346:407a:a2d7 with SMTP id n2-20020a5d4842000000b00346407aa2d7mr8119510wrs.71.1713270183321;
        Tue, 16 Apr 2024 05:23:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQETyZGkr3zNvPiiskHfwVE8JtadFYNoQLFHO5x2CPEx0WHJkHTgGo6tl9Ypq1n5XapvvE+g==
X-Received: by 2002:a5d:4842:0:b0:346:407a:a2d7 with SMTP id n2-20020a5d4842000000b00346407aa2d7mr8119495wrs.71.1713270182944;
        Tue, 16 Apr 2024 05:23:02 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i4-20020a5d6304000000b003437ad152f9sm14755120wru.105.2024.04.16.05.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:23:02 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 08/43] drm/fbdev: Add fbdev-shmem
In-Reply-To: <6cdccec9-e1a1-477b-a41a-4fb9d94d3238@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-9-tzimmermann@suse.de>
 <87r0f54kir.fsf@minerva.mail-host-address-is-not-set>
 <6cdccec9-e1a1-477b-a41a-4fb9d94d3238@suse.de>
Date: Tue, 16 Apr 2024 14:23:00 +0200
Message-ID: <87y19d5wez.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

[...]

>>
>> I guess is OK because is_vmalloc_addr() is always true for this case ?
>
> It's not a vmalloc'ed address, but see patch 7. Fbdev-shmem uses a new 
> get_page callback in fb_defio. It provides the necessary page directly 
> to fb_defio.
>

Thanks! That was the missing piece of the puzzle.  I didn't look at that
patch because I noticed that already had a r-b. It makes more sense now :)

>
>>
>> This also made me think why info->fix.smem_len is really needed. Can't we
>> make the fbdev core to only look at that if info->screen_size is not set ?
>
> The fbdev core doesn't use smem_len AFAICT. But smem_len is part of the 
> fbdev UAPI, so I set it. I assume that programs use it to go to the end 
> of the framebuffer memory.
>

I see. Makes sense.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

