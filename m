Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3793612CF
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421760; cv=none; b=KV+r4oP3KvWjAT39oLsrJMS7vusLFDonCUg6f5IPkmJg17Z+Qk6jw+vHszXkZd2zTZxb4Q7q05Ys1ITMYKFo1zw7VzhLID2Q87Ct3QLaMPF8Lo6bPkC1sBE+B79l+4hTU8OhArGnpPS8CjMiVkWazsyeACSPVBOUlF/Y9LO7/5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421760; c=relaxed/simple;
	bh=VnAn8uZAJT5vkIYnj03sUb9gmxZzfSWHD4320ZoQ8KQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JVyaPADfOkM2VXPvKGaHSMbDR6HNCUScX+QmM6q+1bcKmF21fFcpGbtaag9LwZDNiXL6tJ438pLuuO6aFdjBXM1j7aBEaNx0xylrg3Mi2jD0cWmg9vWt6KRaHK5WFWrsNzwghqa3KKPgTU8gjVWLEb2FXZV7mGlr8L3/zEjV0iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/yxXXE5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/yxXXE5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708421758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Hgn9WqXu1AhhX6E5+lsbEBu8N0fTK8tYmqmiPGcClA=;
	b=d/yxXXE5mVcQzs9IBDf/o3hGuISJjRK1hOLTyruyDWQ1IiwFmGbxYFck+0rc3jTfQb2Ax6
	YWpckt9B11TmRCUmHs84J1NH80vxi+5aScuCrgPVoaEnfsXycYG2PpuNQb2LW8Z7qa0Uv/
	qH5Cj3oQ3wy55VS8JWdoxXCwazwlc7g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-J-wk36DLO3SMKnkEfT2x6w-1; Tue, 20 Feb 2024 04:35:56 -0500
X-MC-Unique: J-wk36DLO3SMKnkEfT2x6w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4121ac8634aso20886945e9.2
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 01:35:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421755; x=1709026555;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Hgn9WqXu1AhhX6E5+lsbEBu8N0fTK8tYmqmiPGcClA=;
        b=J8XoACaiS/xzkgn3n+ofESXPqbh21QhLhOcmjt0az8hB0Dsk80c7hmNfwOi3jHUp2K
         E8AA2d7XRcNDv2mKOjLUvb6NmGzaF59lYCMhGACD5aRJcLI1PuFdODYYuf+kxQaXq5rW
         B55jhGETGoiRcwFeVe0R223Slki3RJX8dIAKqjNpTSXnxGu/5S0+VgaqgmGTIM+u+vg5
         kEpeOXk48IlnW7Uxi9Qzt+SCtKXEJ8nOqKf6XmFhtxVrZvalGSMdfifwLn/3cgdzjPmM
         VIxGSILMagUzo6A7xlgy/baJ+WUgvBpi/mZdJufG8pwTu8GBMkNSocABKjkoXwcsaszl
         MtBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg8mqvwkaWKfiOry6azma3TFCC+6QZZddqemjDZZjf1TqsWopazV2bgF6Z9vmn3TDddfnFe3rCSskcKecw8mPWFXfxOyox3aCywoY=
X-Gm-Message-State: AOJu0Yzh2mBdqw61oeC8uAdzRzShtMUJ3ySg7mGTm99NCXgKfAZZ/HNy
	oOqCHDWox9uYsrnl+d+eP48PI++3hoFaz3TuHBSI8abJJJU+4IWDJckdnym2zFjik6WxJM1FjGS
	HUYm53BKJ4JTh2wmzznTH4UhYi0SzTR3No9O0wJ9dq79+GAUNvC1FV/ttQjmY
X-Received: by 2002:a05:600c:310f:b0:412:68a1:1020 with SMTP id g15-20020a05600c310f00b0041268a11020mr3013466wmo.17.1708421755411;
        Tue, 20 Feb 2024 01:35:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+JttJJiDku7kTZxlbPK/PYMKWsh61tt639P+Ab793uMc5bDoYOmRxrg62ZITenPVeeiMypg==
X-Received: by 2002:a05:600c:310f:b0:412:68a1:1020 with SMTP id g15-20020a05600c310f00b0041268a11020mr3013458wmo.17.1708421755137;
        Tue, 20 Feb 2024 01:35:55 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c229500b0041228b2e179sm13843333wmf.39.2024.02.20.01.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:35:54 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, Thomas Zimmermann
 <tzimmermann@suse.de>
Subject: Re: [PATCH 10/10] backlight: Add controls_device callback to struct
 backlight_ops
In-Reply-To: <20240212162645.5661-11-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-11-tzimmermann@suse.de>
Date: Tue, 20 Feb 2024 10:35:54 +0100
Message-ID: <87le7fiikl.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Replace check_fb with controls_device in struct backlight_ops. The
> new callback interface takes a Linux device instead of a framebuffer.
> Resolves one of the dependencies of backlight.h on fb.h.
>
> The few drivers that had custom implementations of check_fb can easily
> use the framebuffer's Linux device instead. Update them accordingly.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Personally, I don't like the "control_device" callback name that much. I
think that check_device or probe_device would be a better one and easier
to understand what it does.

But not strong opinion on that,

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

