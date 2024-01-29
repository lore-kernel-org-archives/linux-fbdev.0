Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F415BAF0
	for <linux-fbdev@vger.kernel.org>; Mon, 29 Jan 2024 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529802; cv=none; b=uNbWma9SGNCcfmrfo/vfqeOEBCrk8LIBd6J7egYXmZJWd9drXgoAQGqM0NaXFW//vvPMg4TJZ7HD2t2LVRnRISDdarxiXSd5QFIobLICKVdD9wMxgoQJIqCOIA4BXzVdhsQdpYHrEVBsxzIfYpvNpoE3csi+3cFaTgbjcPeZHf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529802; c=relaxed/simple;
	bh=Ht6gyK1WKZGKzBv2HHbK9sLlsRFYbULgg0MnKqJ79Mc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IKh2oPolUoEHkJcJhdgc0r5kR0ozhc4CIUAoqFlBY4o8LjPj26txASi39SNzKcrxqGuf3p0qiu8vpKO+FGBSe54HXtGIB6nvyed8CC3dRydl4X7R9UWzgA+/8PNSQYNWUp2JCM75orwknorPJbSismiJIwKon4i7ZTie7HoHBNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B1DTLtLj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1DTLtLj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706529799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bYShEolk94igkROb5mUh7N+Ee2KYt4Kx5nTD8/LiOIw=;
	b=B1DTLtLjC202ppEIaj49NsPvumS8Zx3jWdewMrFSEn8OWcQ/rcUEI/GLfOa6+mBUXpXHfm
	hSBiHZp5Z/g3EtKv4X1sZpXfe04w2XHKAasLEW8ZNThPLcXZKMetIq7OLpgjxlPIb1qmSk
	tBEjyObu4BtV8JAJroerF8/dKmBrOOc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-oMJF42MGNQKX2A4MIkaJaQ-1; Mon, 29 Jan 2024 07:03:18 -0500
X-MC-Unique: oMJF42MGNQKX2A4MIkaJaQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40ef989f0f1so3153185e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Jan 2024 04:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706529797; x=1707134597;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bYShEolk94igkROb5mUh7N+Ee2KYt4Kx5nTD8/LiOIw=;
        b=v9NCzP1gIqA0a4EBZqB3z2RzAdTWfpNDeiMS3WqOdpqNcocxANJMiDf1TzW6Ke6aGS
         lCeZBoXSmQigoOsx+nB68/PBLe1KVq5en8SsZHG4NSnbDVUIa06/S3ZmfjAapzwP9A6u
         +09ni9yT7RAt7+5rIvXaXJH3r+AXR0FgS4/fmBmdcQJb3/bF5LZ0Mrhx2vZRmWmWx8kE
         dmzWIlZGqqDNGi2V+CNgD+pA0eGYqiH+tkXzdxVaN8y88ibGKfO7DqkCGIU5XGJoCg9C
         GN4ANuZ5CP5z/Eetk6/GQ31K3RysDA9KiKtwLhF7JKrpjOltWmNhL06Dp+c4SbGgUryI
         /RUw==
X-Gm-Message-State: AOJu0YzvcVHvsnePyjjxJSMtsjgpJYbekQsA51Gmx60+qCW0oLFW8iuG
	STQNIj+KnWgbeOh8yC9phIZc1Rl1DTgf4B8oBN6uS7SHZWpGM571LKMYLCT5E2MwDQ3a/V+JAwQ
	wsa3qu0pHz5rtL+nDo57bvgv496dgxFzbNivU81KlX5c0AojCUr13aUCW6KHR
X-Received: by 2002:a05:600c:a082:b0:40e:e4a0:540d with SMTP id jh2-20020a05600ca08200b0040ee4a0540dmr5017807wmb.36.1706529797330;
        Mon, 29 Jan 2024 04:03:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8RY/iib+itekAvsHvhfv+zPnjQBL0cSACylF/MdWpnV56rS9jUyme+8q8/EQp236KgXVzCw==
X-Received: by 2002:a05:600c:a082:b0:40e:e4a0:540d with SMTP id jh2-20020a05600ca08200b0040ee4a0540dmr5017782wmb.36.1706529796973;
        Mon, 29 Jan 2024 04:03:16 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id gw6-20020a05600c850600b0040e813f1f31sm9971683wmb.25.2024.01.29.04.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:03:16 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, pjones@redhat.com,
 deller@gmx.de, ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 7/8] firmware/sysfb: Update screen_info for relocated
 EFI framebuffers
In-Reply-To: <87fryguzjy.fsf@minerva.mail-host-address-is-not-set>
References: <20240117125527.23324-1-tzimmermann@suse.de>
 <20240117125527.23324-8-tzimmermann@suse.de>
 <87fryguzjy.fsf@minerva.mail-host-address-is-not-set>
Date: Mon, 29 Jan 2024 13:03:15 +0100
Message-ID: <875xzc73ek.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Javier Martinez Canillas <javierm@redhat.com> writes:

> Thomas Zimmermann <tzimmermann@suse.de> writes:
>
>> On ARM PCI systems, the PCI hierarchy might be reconfigured during
>> boot and the firmware framebuffer might move as a result of that.
>> The values in screen_info will then be invalid.
>>
>> Work around this problem by tracking the framebuffer's initial
>> location before it get relocated; then fix the screen_info state
>> between reloaction and creating the firmware framebuffer's device.
>>
>> This functionality has been lifted from efifb. See the commit message
>> of commit 55d728a40d36 ("efi/fb: Avoid reconfiguration of BAR that
>> covers the framebuffer") for more information.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>
> [...]
>
>>  #if defined(CONFIG_PCI)
>
> Shouldn't this be && !defined(CONFIG_X86) ? Or maybe &&
> defined(CONFIG_ARM64), although I don't know if the same
> also applies to other EFI platforms (e.g: CONFIG_RISCV).
>

Answering my own question, the !defined(CONFIG_X86) was dropped in the commit
dcf8f5ce3165 ("drivers/fbdev/efifb: Allow BAR to be moved instead of claiming
it"). The rationale is explained in that commit message:

    While this is less likely to occur on x86, given that the firmware's
    PCI resource allocation is more likely to be preserved, this is a
    worthwhile sanity check to have in place, and so let's remove the
    preprocessor conditional that makes it !X86 only.

So it is OK to just guard with #if defined(CONFIG_PCI).

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

