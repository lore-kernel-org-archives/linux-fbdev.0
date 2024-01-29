Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097D0537E2
	for <linux-fbdev@vger.kernel.org>; Mon, 29 Jan 2024 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524882; cv=none; b=eu9Hk8J6vXPAmHGMd4H7/W5Y3beowSiEG2EIqhmVuCDKUibfO4c5zTJ7q+Fdx240Sl6h0QfoTS4/LOvqfsSCdEzjPoENbOcT6G9VY/zhStkVhAN6PxtFUDYm7P0YKrrFdXppe4JyDLzRy+OsPrqlc18UpdqanE7fJJGUiFhtydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524882; c=relaxed/simple;
	bh=JZieUS7RXQH4sJhXPiB/EknJAepT/XFdan03H5xFE94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tsUIDcVdrJhx7DzJnZyHh7zU+pAStCbBvxWSBbeO4jmu8ivYc6nnd2myg89lHvD7rxhBmGne94pImjTONUiBzr+xVC5/oOsFkrw+xSi7/eHPT0idfi3ny2qN6u33r8eQh0lI44sEUXrY9jMPWRGEjRWv7wla68/YCF+ihHzP798=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6CT3C81; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6CT3C81"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706524879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iuw+sd9oKGlN++0B7Qqn1bE1N0OC+tp2A8+Ru07eNUc=;
	b=F6CT3C81fkefWw7bCOuYJKVXqSvptFyHkbaqTP8NIRiWwG7vzwoGjvO9L2cR07rlXPvYuW
	ultZpR37Ri42CsrcWqftRPCA1pvenedUTGVjpYadzN1PlZvjfLs3NusphFaoKWG7QhaL+f
	GXJl0LSsF+hiv4B2kwfVfcO8AaPxqI0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-WOPPfYAhPna7k7NgsfyffQ-1; Mon, 29 Jan 2024 05:41:18 -0500
X-MC-Unique: WOPPfYAhPna7k7NgsfyffQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-337d6024098so1333854f8f.1
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Jan 2024 02:41:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706524877; x=1707129677;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuw+sd9oKGlN++0B7Qqn1bE1N0OC+tp2A8+Ru07eNUc=;
        b=acUc40+PRfoKbqCRn6gO3zoO+sAJ95a/JCcUPLnpmw+/nNbVOBsFd9YaZnkxGpflH2
         hmSP4Ncfwvs3yinnN5PGhLIwYBYYRMj3uDtte12oWFSCaMhxZKpSBU0LDLPdEJ2xtOzK
         4ri7XUL59LdjOoUi/p8x9TtC1uFI1eagGZFGUwD/qwzPRUxHWPRHtfJ98DPdi9wH1NcK
         VfBoAPdWKTNAQrXCz8uqJSwI0hfwQWWp438sXVHJdoj/FHcencCQ4+ypJCjRlaY2UAJK
         S8XLsgx9KYUODZVLKtJQaj0JcXGeroToJfmTyI3va1CPO7iDfnj+g/xWNGNKfNtnyWts
         kmWw==
X-Gm-Message-State: AOJu0YxoSoPkmXG7Kyg1uol/tCD+ndrI0sJmnEXNXlTbJKEE3QpvR8FF
	QzUUg1xzz7wzpOl+atp3mKjJB1CjPyQ0aU4DMQICUiizeg6VUiVWYoI0UOq9ugEa7sT0vNQ8tC6
	5SrmT8rJzHSCZ08y0e0Uxgv7h9s6tAM01yZrF0Wx2vlMAdxAKuMWtlN7/lMzj
X-Received: by 2002:a5d:4043:0:b0:33a:f51a:f7ba with SMTP id w3-20020a5d4043000000b0033af51af7bamr164609wrp.49.1706524877150;
        Mon, 29 Jan 2024 02:41:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExzbLj3XPsh+SexBvN/jdpZc68WXbSDGdGg/7k0PlqDJOHKiXCIIn37mrTX2pYX3WvTiYVww==
X-Received: by 2002:a5d:4043:0:b0:33a:f51a:f7ba with SMTP id w3-20020a5d4043000000b0033af51af7bamr164595wrp.49.1706524876814;
        Mon, 29 Jan 2024 02:41:16 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m13-20020adff38d000000b003392cdeb3a2sm7737125wro.103.2024.01.29.02.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 02:41:16 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, pjones@redhat.com,
 deller@gmx.de, ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 1/8] video: Add helpers for decoding screen_info
In-Reply-To: <20240117125527.23324-2-tzimmermann@suse.de>
References: <20240117125527.23324-1-tzimmermann@suse.de>
 <20240117125527.23324-2-tzimmermann@suse.de>
Date: Mon, 29 Jan 2024 11:41:15 +0100
Message-ID: <87wmrsv2us.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> The plain values as stored in struct screen_info need to be decoded
> before being used. Add helpers that decode the type of video output
> and the framebuffer I/O aperture.
>
> Old or non-x86 systems may not set the type of video directly, but
> only indicate the presence by storing 0x01 in orig_video_isVGA. The
> decoding logic in screen_info_video_type() takes this into account.

I always disliked how the orig_video_isVGA variable lost its meaning.

> It then follows similar code in vgacon's vgacon_startup() to detect
> the video type from the given values.
>
> A call to screen_info_resources() returns all known resources of the
> given screen_info. The resources' values have been taken from existing
> code in vgacon and vga16fb. These drivers can later be converted to
> use the new interfaces.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Thanks for doing this! It's quite useful to have these helpers, since as
you mention the screen_info data decoding is complex and the variables
used to store the video type and modes are confusing / misleading.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

I just have a few comments below:

> +static inline bool __screen_info_has_ega_gfx(unsigned int mode)
> +{
> +	switch (mode) {
> +	case 0x0d:	/* 320x200-4 */
> +	case 0x0e:	/* 640x200-4 */
> +	case 0x0f:	/* 640x350-1 */
> +	case 0x10:	/* 640x350-4 */

I wonder if makes sense to define some constant macros for these modes? I
know that check_mode_supported() in drivers/video/fbdev/vga16fb.c also use
magic numbers but I believe that it could ease readability.

> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static inline bool __screen_info_has_vga_gfx(unsigned int mode)
> +{
> +	switch (mode) {
> +	case 0x10:	/* 640x480-1 */
> +	case 0x12:	/* 640x480-4 */
> +	case 0x13:	/* 320-200-8 */
> +	case 0x6a:	/* 800x600-4 (VESA) */
> +		return true;

And same for these.

It can be a follow-up patch though.

[...]

> +int screen_info_resources(const struct screen_info *si, struct resource *r, size_t num)
> +{
> +	struct resource *pos = r;
> +	unsigned int type = screen_info_video_type(si);
> +	u64 base, size;
> +
> +	switch (type) {
> +	case VIDEO_TYPE_MDA:
> +		if (num > 0)
> +			resource_init_io_named(pos++, 0x3b0, 12, "mda");

I see that drivers/video/fbdev/i740_reg.h has a #define MDA_BASE
0x3B0. Maybe move to a header in include/video along with the other
constants mentioned above ?

> +		if (num > 1)
> +			resource_init_io_named(pos++, 0x3bf, 0x01, "mda");
> +		if (num > 2)
> +			resource_init_mem_named(pos++, 0xb0000, 0x2000, "mda");

Same for these start addresses. I see that are also used by mdacon_startup()
in drivers/video/console/mdacon.c, so some constants defined somewhere might
be useful for that console driver too.

The comment also applies to all the other start addresses, since I see
that those are used by other drivers (i810, vgacon, etc).

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

