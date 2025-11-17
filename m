Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0990248896
	for <linux-fbdev@vger.kernel.org>; Mon, 17 Nov 2025 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763375554; cv=none; b=ZJ74vakPLSq8+Z02zlBIjIkF7iZ/LkouEMyP2iZyojUdcAkmN99cGuuA6P9wUbAV9ETrZ7vy79DpqKdutmmI5FvdgpVhxoWJcerJDsA69azC4HFGObmcPNDOILwnjS+0VWpe0wWRh0//F5D9fIdPPQNPUK9M2Rd5xk6/RUXwLbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763375554; c=relaxed/simple;
	bh=CW4MHO4QEPKhCpNs8V0QYQsQYAVY8q2G2vy81ShO5+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BihiEGgLeEp0DqAuqhV2RyLveYjHNhqHL/2ROAEX5sKENbJt2V0cGBvH4RdQgieinN4daVsBsl2zMZ7guvENS2yob7Q9unygagdFVzbNfBuodOTSOLEBwRwotudt4B3f7V1eK6MZmeD0kala0VCub6PHPXjkXFwD95L/2SD8HOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e84udcCc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J4dHaO2H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e84udcCc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4dHaO2H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763375551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P0XBD0RgaW2cGHx+QzNrWzybZSw9/JBmPBIYsTf/QGM=;
	b=e84udcCclP87sb/2AsY28oB0SSqYKAkuzWferew+g5/3wvSdOZ3ti6RWTKE57pj4l3UaFm
	AjJrMUpUCMS76B3DQlqshr5SpurTS5I1Tn6KI/4tNyy783H6gEN2Mqy+JRgv9m48ud/PjO
	KnRvRFsRqTxVwUI9wXF2iDgPgO8ASno=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-8U2l1zGIM2yEquvIfxGlHg-1; Mon, 17 Nov 2025 05:32:29 -0500
X-MC-Unique: 8U2l1zGIM2yEquvIfxGlHg-1
X-Mimecast-MFC-AGG-ID: 8U2l1zGIM2yEquvIfxGlHg_1763375548
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47775585257so33937575e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 17 Nov 2025 02:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763375548; x=1763980348; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=P0XBD0RgaW2cGHx+QzNrWzybZSw9/JBmPBIYsTf/QGM=;
        b=J4dHaO2HWCnzQC1oveNQiwSoP1+pdkvNiFJg8hORgkCKN+KOH0aL8MpPHlR2ysYBly
         D+ox+1fs0iftPTr+Aa5972TLt7kMRd1AlHP2cDUWxhWWRmWX0HIFopbWPSOEZu/y4U0L
         AsBki7vSPVXyO2/gOnrG423y4iwIt0fbwCbpFNku5nap01FfXV9/qrYkFyV5mcW4WI7A
         uQDgcmyQPG8yY3Zjf5/L6SKV5GgosG0oNkDmTcZHGgNkKRewUBnf1kX5BNaRIw9q7v3N
         aLNSzuLcPYGDxNSZ/1pgDMye+lMX+a6Mcuugnx/iphVFiab5KB973G2en9tF63/M60rr
         Tbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763375548; x=1763980348;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0XBD0RgaW2cGHx+QzNrWzybZSw9/JBmPBIYsTf/QGM=;
        b=FyjY+NSU4IbNpjyIgHn9jLeuvVv2FNjXNgBok6Wni1XRULgxLsXfevR0N+psgJHfHx
         htLeSVXSZtYvzp1v4950fjqnsiE2jxB7mYEAmY3m9qhd3qMhiv3VXNl6mOWg+K2UNQsw
         KzATQF3V4H5B6yWC+PvvHmuLLcRb1RTU1y/1tiSa8PQKr47Rd3T/cF8tJUZhHThhLB6E
         gkDDpHj9ia2qMVk34DD7UqnvNyw2bJomgqkNX8cXsXOjpJcyRpmzxGda0kw4vZBfueje
         nAyQN4QkXMZi9BIa5alBnPXB9PnVwz10BmGphv2XyGqdxbptfowUuYFQX0ArU2V1YZI/
         hnPw==
X-Forwarded-Encrypted: i=1; AJvYcCWA32mpwMT9naPj0vgRN6CwdY8FIVa144jvz26vtbU+dsQFOuxmOZJu0DV+Ee0PlgJsRmGVLjnMFuZSkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/I3VXhJWis7u0yxTvoCw4JWrP/EWnlzQLe2LK4jMQrV5Y0ybR
	QxNnShmG/pQMp31FUTZS6DUtRPQEuSoT5uCQkZrVITEf5Jbbdj9O+x/rBlhUPdilyHJVOXlCWJF
	AhG96jVgeT4TUsHtOTobOYhPwvax10eusx2sEzxD8Sph3OlKQZvaDK1hxp3Qw98oE
X-Gm-Gg: ASbGnctUI5XrjPd813K/DKEkc/GuCffSVbIchM4tdufOv5ZHPRx5feY0WtlnyXsP/6s
	JlTMfrK6yVQ/ymp5v8kRMDlcHl6GybtSKrSZlyEeTr4kPXBkR41xi1Ex89UnFF6Mxbuk2o8eMHm
	i/YLIy4R1AUPMCkQKoiVVJLHw85Se+glc5ThovJNOUUw/QyWXpeOfzMXzsrYp25fULUu+PofUku
	FzHodsxR601euCPW3j8NTKNBDEyjEg44KRvUa6at55Ye4ykc2JMfA5UvTRb51aWggml3qm5Ce5w
	/wKaHWzIbJjDCMH7yLkbkwfq9n0NwGvsPHpEY7w60fVDWSoBR+rfstY61Pwxp8bY5fqLQk/x6KJ
	Iq2RKlHEMSdkNnUlA9Dv3Zm4RCWZo+LV1hOls3Fpz
X-Received: by 2002:a05:600c:8b38:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-4778fea2de7mr106847915e9.24.1763375548380;
        Mon, 17 Nov 2025 02:32:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnGB9P6XwFNFJpyxvyFcr1IsclfGk24GU77X7h/tXKSTtxct0mRYbVmgv2LusoMFuX2eiZ6A==
X-Received: by 2002:a05:600c:8b38:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-4778fea2de7mr106847495e9.24.1763375547978;
        Mon, 17 Nov 2025 02:32:27 -0800 (PST)
Received: from localhost ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bb34278sm107906635e9.4.2025.11.17.02.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 02:32:27 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, deller@gmx.de, lukas@wunner.de,
 ville.syrjala@linux.intel.com, sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] drm, fbcon, vga_switcheroo: Avoid race condition in
 fbcon setup
In-Reply-To: <20251105161549.98836-1-tzimmermann@suse.de>
References: <20251105161549.98836-1-tzimmermann@suse.de>
Date: Mon, 17 Nov 2025 11:32:26 +0100
Message-ID: <87fradkkzp.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Protect vga_switcheroo_client_fb_set() with console lock. Avoids OOB
> access in fbcon_remap_all(). Without holding the console lock the call
> races with switching outputs.
>
> VGA switcheroo calls fbcon_remap_all() when switching clients. The fbcon
> function uses struct fb_info.node, which is set by register_framebuffer().
> As the fb-helper code currently sets up VGA switcheroo before registering
> the framebuffer, the value of node is -1 and therefore not a legal value.
> For example, fbcon uses the value within set_con2fb_map() [1] as an index
> into an array.
>
> Moving vga_switcheroo_client_fb_set() after register_framebuffer() can
> result in VGA switching that does not switch fbcon correctly.
>
> Therefore move vga_switcheroo_client_fb_set() under fbcon_fb_registered(),
> which already holds the console lock. Fbdev calls fbcon_fb_registered()
> from within register_framebuffer(). Serializes the helper with VGA
> switcheroo's call to fbcon_remap_all().
>
> Although vga_switcheroo_client_fb_set() takes an instance of struct fb_info
> as parameter, it really only needs the contained fbcon state. Moving the
> call to fbcon initialization is therefore cleaner than before. Only amdgpu,
> i915, nouveau and radeon support vga_switcheroo. For all other drivers,
> this change does nothing.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Link: https://elixir.bootlin.com/linux/v6.17/source/drivers/video/fbdev/core/fbcon.c#L2942 # [1]
> ---

I'm not that familiar with fbcon and vga_switcheroo to properly review
your patch but after reading the explanation in the commit message and
reading the diff, the change does make sense to me.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

But I think that would be good if you get some testing for the drivers
that make use of vga_switcheroo. Also, do you need a Fixes tag ?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

