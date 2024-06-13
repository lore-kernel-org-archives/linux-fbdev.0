Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99075A4FD
	for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 21:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718315436; cv=none; b=h84wUYKrff0qWWc3+YZOoSBI5iXYN3Qz2TC8zUp2s/rcb9x02nevH3C5GKqJ4odeAVC5CCOt9ZuWAqWjXLzM5irkQ48NDO48HNriuymuBnQFlbMIGO2itukLkjxcjVJfN+X0yU0surFhoV6Jh18JmuflCHEHuLgy4DX6AfoEbzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718315436; c=relaxed/simple;
	bh=aS8F1TD84oFfeKTWRotM4K6veEgqnukIk7l5xUx882M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g3wxvnIR27xwxpVBtx2KcUGAEaWt/MlS3gLY8Iqk81j/bG4wdJsu5X1gXM8YXZofi3TyrLxB5cevDWshm1UbkfRAWZRWvYrZrj8i6zzb3neIIgDoVO6J4cW8MVo7t9Dr99fvSyCwI12ZBspdUZVafdTNiFT0aPACcznFTG6KFMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRS+e6E3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRS+e6E3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718315433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WYhVBB92WRba06kdvoVhXYWDr7tfly6ynhI5KCT2iy4=;
	b=eRS+e6E3B+zvmLaYF7oHLieZWO0dfaBhRUbrlZID4jjgKiA4N/rtiQuHSglFnkac+8KpBx
	seg0DtU5EJf/aQ3Skw8Ml+gam+q70kaTHoCn2h3MhjC2QPw8305bxQuWFIYQNTiW8Wof6U
	AvMuPzKD52jH6dnTTl9XkropP3tZPJw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-f-t_iQ9tMYGnHOjrEJ_rdw-1; Thu, 13 Jun 2024 17:50:32 -0400
X-MC-Unique: f-t_iQ9tMYGnHOjrEJ_rdw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-421e17ae038so12924425e9.0
        for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 14:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718315431; x=1718920231;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYhVBB92WRba06kdvoVhXYWDr7tfly6ynhI5KCT2iy4=;
        b=U8WCorTyVxPV681TqSvGVncD+lrxsaD51+1KPaRHDvjAxcmf3nbxq8F2+wJDbbcY32
         7Gp1f14iGfQTUq0rhZ3FO8qUdwVD0aeLmuzR8ij1RVbbuRzA1eax4srLd38Y6nHHuxMG
         yurUtTwjAdHWFZ+fUozrn3qM+QLUzm6cbdfrsguxQL6NsPBcfylIpudat3Nvn+yVhkfF
         WB9oLbRC/rv7HNeCPgku2i4zBkd9WLOJEoyG6W8bjEPoo+Byzu3ycUzm/qXSZYy6qOsm
         iOUACShyPGh6jyctyg9H0lhA8dYIVUoPiKVFur8C5W4M7DaMpyuK9RDZKPXYjAGQDk7e
         bjRQ==
X-Gm-Message-State: AOJu0Yyt1D6LxmLshqGPykIBFMLMvwQoeu1VzFwfBputdlGSqgx9cyom
	qtTBLT25ujzpAR3duCy0sSiEdBMgca6PBLVS0OgYGNO3ib2c/m35LPOXAKDatmMHS6oL5IQLTB5
	1hWnWqJQOq7DEnY+IdCdXAXNku1C/J22CsTMOT16+4i/FoTVuCTP+IIgyqIdZ
X-Received: by 2002:a05:600c:314f:b0:421:7f30:7ce3 with SMTP id 5b1f17b1804b1-4230482158amr7552195e9.1.1718315431174;
        Thu, 13 Jun 2024 14:50:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFclJBD4+gENweiNq3Sn4ls37mHaaCLzO4VspJZacVbRM1WmTh+gqlxMlVWnpECmhgW+xecNA==
X-Received: by 2002:a05:600c:314f:b0:421:7f30:7ce3 with SMTP id 5b1f17b1804b1-4230482158amr7551995e9.1.1718315430593;
        Thu, 13 Jun 2024 14:50:30 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4229c60f758sm60963905e9.20.2024.06.13.14.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 14:50:30 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 sam@ravnborg.org, hpa@zytor.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] fbdev: vesafb: Detect VGA compatibility from screen
 info's VESA attributes
In-Reply-To: <5d8d2efe-45dd-4033-aaae-e7f923ef9e76@gmx.de>
References: <20240613090240.7107-1-tzimmermann@suse.de>
 <5d8d2efe-45dd-4033-aaae-e7f923ef9e76@gmx.de>
Date: Thu, 13 Jun 2024 23:50:29 +0200
Message-ID: <87tthwqzq2.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Helge Deller <deller@gmx.de> writes:

> On 6/13/24 11:02, Thomas Zimmermann wrote:
>> Test the vesa_attributes field in struct screen_info for compatibility
>> with VGA hardware. Vesafb currently tests bit 1 in screen_info's
>> capabilities field, It sets the framebuffer address size and is
>> unrelated to VGA.
>>
>> Section 4.4 of the Vesa VBE 2.0 specifications defines that bit 5 in
>> the mode's attributes field signals VGA compatibility. The mode is
>> compatible with VGA hardware if the bit is clear. In that case, the
>> driver can access VGA state of the VBE's underlying hardware. The
>> vesafb driver uses this feature to program the color LUT in palette
>> modes. Without, colors might be incorrect.
>>
>> The problem got introduced in commit 89ec4c238e7a ("[PATCH] vesafb: Fix
>> incorrect logo colors in x86_64"). It incorrectly stores the mode
>> attributes in the screen_info's capabilities field and updates vesafb
>> accordingly. Later, commit 5e8ddcbe8692 ("Video mode probing support for
>> the new x86 setup code") fixed the screen_info, but did not update vesafb.
>> Color output still tends to work, because bit 1 in capabilities is
>> usually 0.
>>
>> Besides fixing the bug in vesafb, this commit introduces a helper that
>> reads the correct bit from screen_info.
>
> Nice catch, Thomas!
>
> But do we really need this additional helper?
>
>
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Fixes: 5e8ddcbe8692 ("Video mode probing support for the new x86 setup code")
>> Cc: <stable@vger.kernel.org> # v2.6.23+
>
>> ---
>>   drivers/video/fbdev/vesafb.c | 2 +-
>>   include/linux/screen_info.h  | 5 +++++
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
>> index 8ab64ae4cad3e..5a161750a3aee 100644
>> --- a/drivers/video/fbdev/vesafb.c
>> +++ b/drivers/video/fbdev/vesafb.c
>> @@ -271,7 +271,7 @@ static int vesafb_probe(struct platform_device *dev)
>>   	if (si->orig_video_isVGA != VIDEO_TYPE_VLFB)
>>   		return -ENODEV;
>>
>> -	vga_compat = (si->capabilities & 2) ? 0 : 1;
>> +	vga_compat = !__screen_info_vbe_mode_nonvga(si);
>
> Instead maybe just this: ?
>   +	/* mode is VGA-compatible if BIT 5 is _NOT_ set */
>   +	vga_compat = (si->vesa_attributes & BIT(5)) == 0;
>
> I suggest to make patch small, esp. if you ask for backport to v2.6.23+.
>

I prefer the helper. It's a static inline anyways and having it as a
function makes it much easier to read / understand.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

