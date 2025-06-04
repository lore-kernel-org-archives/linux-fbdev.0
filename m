Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5430F28E61C
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Jun 2025 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749035709; cv=none; b=XNIzX/f/twDNlZWZsMH2aOyKPfxJRrQYSyXkI4lMplckUTmInaMCdXpR7TVQSfSdyjFni1owWsBVpXAnkjhMufv6yqupqYYZxaQ9eQQAVdb1HmtfekvQp+dqadJHpTSR8ACgP50l5NXb88XVzj/MAC+kzkXjTIKnKbReNA7cVNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749035709; c=relaxed/simple;
	bh=DDIrx6qniSjWoPqZ1+FQ6cvCHnIr1IHnMhtHEPpu3Uk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ux1EODa5d2K19egPzyMZRK+WfJ87lzU3ukJHPfunK4mCnd0bhIpyHE5DjIfe06gFNsZOromkmUsEMawCkCdrJUkNRbIpUs+TXw7vGkE0oR+zomql9MKi5WNuoeoi3no2o0NoAHTY35jNNz79VxD9JTYNDxSB81oiec11ur6t058=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhQtsuSX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhQtsuSX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749035705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H5bmvoV528ZDMkA8vQ3GG9k3siMYViBoGzRoypMVKOg=;
	b=DhQtsuSXVgzmSCn0wnyUdW+YVlr9NUQyYvR5IRxjHF9idM8PTO2hvSqlgxuDjuDpEj8d2X
	5D7R5lMhfyonIVigVscUQbBVXUxGTSTlrE7WDAy2n8qO5xaarBmrRZthsveEvD+rkLrxTJ
	i2e5IsCNIyZX8dc4r+4gb56u1ESbQ3o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-203xfnXuN5aegCM7_KBehw-1; Wed, 04 Jun 2025 07:15:04 -0400
X-MC-Unique: 203xfnXuN5aegCM7_KBehw-1
X-Mimecast-MFC-AGG-ID: 203xfnXuN5aegCM7_KBehw_1749035703
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso22504865e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Jun 2025 04:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749035703; x=1749640503;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5bmvoV528ZDMkA8vQ3GG9k3siMYViBoGzRoypMVKOg=;
        b=BLveLyBQV8E4r8ULVYmJ/0OKfBFdZyTLCUezPcvRFxXzK7HCLDRzMGZXHACVWSqKGN
         7lMrYvJ9hPtIr+SuKdaopg9Mo/jjRPQRSJrmD7/u2NSnz1zP5J+g4PNHtmZYXgpqAVAG
         zG7d8aCqfbhLjaA0/hTagzC0sOqxmg0xP9U5OE9ReWB8P39iO1XbyNt9K7m4mhIo5204
         IMUDn8x9hYj/pVXYH5kVpleovit2nEnMH8TucqT+g6s0yiHoMk/+b5o2O1RdT1eW02v/
         TP9UVPQU148fYSyN6vaiRhQiGPDg8VaOOMi/cZr/QGkb1TuPQ6mB69bZv5t105Y9IOI9
         q5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCV95+Hc8fa3NxsFGplcxonVeOkBVLN1dF4WxydtXF1JNvlAd0pIH5wTNMV/oU/+7at6AY7ZN3gaYcPwsg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0fKFrew4/a/7CrUDbaurDTvne2Gt/YSk0RSz7AY3eFlVOqQ37
	egiFNKEPKwhbswTEg2/G3zwuBZ9p0bI0fn+B102M092QDK9vd+DwG4Oo/CRkUhZMWw1f4eXqUT4
	9ihtnvWo1obMvpxXlvx9TDi8kOErlSSNGU2CcNOfm6ASoEzxIxx9LCgMuo+7QgGoy
X-Gm-Gg: ASbGncsfKDNzg6Uq9I8LPAvWB1hV/ynWN0L1VYPeIONkfmBfno5QQpdmoq0ttFatKFQ
	UJbeGnnv9JWtUDwoAFVyuoSsEjxd955LSuU3j+bd9EnN4YTn2EwG/uw0zKchzPCQ5mpmzvyz/Ir
	SMlozDJUSuj4S1xWfMmbPNYQ45fEUd0jYNfR1dzAQk6vJqZGbfV0iYQjEKZSc8ZvK+bLV6xjuf0
	+4zAx27iCHEvYZDeVIXsFFGpjBeOkrXLrZi7xsjDYbGaeVI6Hrw/5Sk4l/QVvAX0Xwxl3Uvz/uz
	Dj9Ws+meIwbRQmcaE+xtIN2ZGL6Qn7mRseC82kSIjHziPhs+hJzbNLLInPKT6UgpFvdAjw==
X-Received: by 2002:a05:600c:3542:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-451f0b3938cmr24124175e9.30.1749035702779;
        Wed, 04 Jun 2025 04:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEkyu2yxy9u1E10EDNHkq0GJQg9fveXJ4AfXqJRU2A9xpka6O8heUM24yU/Pjyhp3aJF3xAA==
X-Received: by 2002:a05:600c:3542:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-451f0b3938cmr24123775e9.30.1749035702404;
        Wed, 04 Jun 2025 04:15:02 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a522ab67dbsm916950f8f.62.2025.06.04.04.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 04:15:01 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Alex Deucher
 <alexander.deucher@amd.com>, Tzung-Bi Shih <tzungbi@kernel.org>, Helge
 Deller <deller@gmx.de>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,
 Zsolt Kajtar <soci@c64.rulez.org>, stable@vger.kernel.org
Subject: Re: [PATCH] sysfb: Fix screen_info type check for VGA
In-Reply-To: <20250603154838.401882-1-tzimmermann@suse.de>
References: <20250603154838.401882-1-tzimmermann@suse.de>
Date: Wed, 04 Jun 2025 13:15:00 +0200
Message-ID: <87ecvzahcb.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Use the helper screen_info_video_type() to get the framebuffer
> type from struct screen_info. Handle supported values in sorted
> switch statement.
>
> Reading orig_video_isVGA is unreliable. On most systems it is a
> VIDEO_TYPE_ constant. On some systems with VGA it is simply set
> to 1 to signal the presence of a VGA output. See vga_probe() for
> an example. Retrieving the screen_info type with the helper
> screen_info_video_type() detects these cases and returns the
> appropriate VIDEO_TYPE_ constant. For VGA, sysfb creates a device
> named "vga-framebuffer".
>
> The sysfb code has been taken from vga16fb, where it likely didn't
> work correctly either. With this bugfix applied, vga16fb loads for
> compatible vga-framebuffer devices.
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

