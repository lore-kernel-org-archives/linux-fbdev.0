Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1550514039A
	for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272676; cv=none; b=ot/5kf0K+BF4kMPOTGW/glh2fGUNOtujByDE5Of2VTpmYzljwv1n/qEOrRRg+RqgSsAUv4DwnFqjterCS+o1Q3AmsRePsW7H6gU+UwWBdsi3RDnv5zLPKxrCSfAQii0h3GSud5vDJveRnFFbm4P51X9tBNVcssncgDWsk27ccpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272676; c=relaxed/simple;
	bh=KqwMyBd1dqBsHTMrepbMUs5rTSpEgf/1qKcFMkboj1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jNp7Cx7ZnKX6ESpY7uWOoFseRbnCNjxKZXOVLbdkArTWWfBdTbEGrFo27jh896fwmqANgabno7yqjvZfbaW8v0lnBlxHNMeXtfeeSam2kYWAKo+0KQMPY5P0xe+6eCWXZzCr8QON4YB8bDvSmnoXkPr531nB0Xxdw0+Slp9ZvkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FxgJGF0U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxgJGF0U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718272673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFPOJ2hSIaSgoYB7lOp5T4CRdabG9WpRLVhiydu9eE4=;
	b=FxgJGF0UHN+B4bduS6v1amRlaCMVBsJGOABo+bF6ktb3JgwpKBFqTWPBbDCz4ccBik8X5f
	UYIFipKfFhLXpS3KGTI3D/9kI0zpXNjZZIOMdKB0kONCUWvbSaolM3rlEarg6u8CxKBv5u
	Cr+ewweuI+VLiK39nRpmRV8ENrfNqsk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-O-LEQBPlO-2YCWMOjH24lw-1; Thu, 13 Jun 2024 05:57:52 -0400
X-MC-Unique: O-LEQBPlO-2YCWMOjH24lw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4229a964745so5084975e9.2
        for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 02:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718272671; x=1718877471;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFPOJ2hSIaSgoYB7lOp5T4CRdabG9WpRLVhiydu9eE4=;
        b=L5M867G0O+eyzYBxn1h19PZzlvPFGWtWrAC1YzeI9OvXZHAdTwPYhIQYr0ISG1e6h6
         N/1O2V34Hfkjuhp6ML8QjbNuXB4YaKyhIFo2JiJAAzbaQOtdYt75xEGiaot0ogeKcetN
         VEprWxv+b8tYV8ml74GLG6l6WlP7P7+/jKZcf/zWuTZlbain8vSaixUnqZXtEGHrK61Y
         S6POldUZwn1jcbrZqKIVZMNs0K8yIWuw+O46rhjjSTXV8Rs/dQYDydzcOmMOKIdHszNq
         q5z3lWzESHtJ0grZmKsH0t7X9RiNRS9SerJa799MqioC0gcHWBKCy64gqoxmm4UmzhKv
         tBkg==
X-Gm-Message-State: AOJu0YxkY0Ll3OMBSmR0s19rcmtSYtu8/Pv0tT4b7N1TRvRSC82gL/RT
	/b5vHbo9wWdvApGo1c/DAfNC9OqGrZEWuevGV2AmVK9DEpBB/ysElWDGFTSdRn3of6h0jnvjD/F
	aVOta9mSLN214PC21YmpdO/8PlttHQ203KGQUMidMQqdjnlXPsWDnF5Vi066c
X-Received: by 2002:a05:600c:310f:b0:41e:db33:9a4e with SMTP id 5b1f17b1804b1-422866bc34amr32585675e9.39.1718272671167;
        Thu, 13 Jun 2024 02:57:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKxVqO3gRC4n1Hu5nh47Iqq6X484SlcFsPRKwYBuNanSOIuIw53eNqx/vh1p3V4X7kDpg3Sw==
X-Received: by 2002:a05:600c:310f:b0:41e:db33:9a4e with SMTP id 5b1f17b1804b1-422866bc34amr32585495e9.39.1718272670623;
        Thu, 13 Jun 2024 02:57:50 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750935ecsm1229362f8f.3.2024.06.13.02.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 02:57:50 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 sam@ravnborg.org, hpa@zytor.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] fbdev: vesafb: Detect VGA compatibility from screen
 info's VESA attributes
In-Reply-To: <eea40059-2692-4b1e-a92e-006908220f34@suse.de>
References: <20240613090240.7107-1-tzimmermann@suse.de>
 <87zfrpqj5y.fsf@minerva.mail-host-address-is-not-set>
 <eea40059-2692-4b1e-a92e-006908220f34@suse.de>
Date: Thu, 13 Jun 2024 11:57:49 +0200
Message-ID: <87wmmtqi5e.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi Javier
>
> Am 13.06.24 um 11:35 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>>
>> Hello Thomas,
>>
>>> Test the vesa_attributes field in struct screen_info for compatibility
>>> with VGA hardware. Vesafb currently tests bit 1 in screen_info's
>>> capabilities field, It sets the framebuffer address size and is
>>> unrelated to VGA.
>>>
>>> Section 4.4 of the Vesa VBE 2.0 specifications defines that bit 5 in
>>> the mode's attributes field signals VGA compatibility. The mode is
>>> compatible with VGA hardware if the bit is clear. In that case, the
>>> driver can access VGA state of the VBE's underlying hardware. The
>>> vesafb driver uses this feature to program the color LUT in palette
>>> modes. Without, colors might be incorrect.
>>>
>>> The problem got introduced in commit 89ec4c238e7a ("[PATCH] vesafb: Fix
>>> incorrect logo colors in x86_64"). It incorrectly stores the mode
>>> attributes in the screen_info's capabilities field and updates vesafb
>>> accordingly. Later, commit 5e8ddcbe8692 ("Video mode probing support for
>>> the new x86 setup code") fixed the screen_info, but did not update vesafb.
>>> Color output still tends to work, because bit 1 in capabilities is
>>> usually 0.
>>>
>> How did you find this ?
>
> I was reading through vesafb and found that [1] and [2] look 
> surprisingly similar, which makes no sense. So I started looking where 
> bit 1 came from. The flag signals a 64-bit framebuffer address for EFI 
> (see VIDEO_CAPABILITY_64BIT_BASE 
> <https://elixir.bootlin.com/linux/latest/C/ident/VIDEO_CAPABILITY_64BIT_BASE>). 
> But old VESA framebuffers are usually located within the first 32-bit 
> range. So the bit is mostly 0 and vesafb works as expected.
>
> [1] 
> https://elixir.bootlin.com/linux/latest/source/drivers/video/fbdev/vesafb.c#L274
> [2] 
> https://elixir.bootlin.com/linux/latest/source/include/linux/screen_info.h#L26
>

I see. Thanks a lot for the explanation and references.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

