Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7666B5F486
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421096; cv=none; b=X6uhT/j+LYsgazUQ3ucDs8wPtV4DTR8L6rtBsto00j/s2Xhsv5t0uVXp7mtPDlk0T9FWAcT6rxaBuqbdRptJFxxVnYENP7d7KKgzwMLyn7mJGIbHk5UF/ac7LulnffM2sCvPhPCtNPGuEBX0ms2+T8zPmZpt5f0IsdWugiH3hoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421096; c=relaxed/simple;
	bh=udKLWycwu+hf+6x5oFlyNQr/LkDvsWZpDbgX4ydJdKQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y3z0l0CUd9wSntXc/bM/6HRA9GqL4aEZhKSHQ6C6U+rxkEKla8woCWLbKfla8mkX/IacQ8OXUzg3BZlTIwfk4/pw0nrtqPLIXTvzNo0eXLl1txdZbkib7Fr7jrhJYLVRW8GjuXjzBxIKjR+MFbv+2WvyPxZJog9BxKMdKAMZm60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LfOgC1db; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfOgC1db"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708421093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xshxlpsQluS7qRAd7fMDdSOWA/KW0tH/DDlQJBA+rDs=;
	b=LfOgC1db1K56AHho9mtA2Iu4ukPRa2JNkgGVuSdurkqFtR/6vUhlGWe+Fe/OlhmbFsW7GR
	btNFIlf9QOrOsRW9vePM1V0EhhFbgydoq9mafvKa5z0DN1l0VimewPLI1wwZrsLZCS78JL
	7eNIamfMEWQy06CfTeYv7tJMjFaOZ2c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-f3Ma76-KNZ-U3gpozRXUYw-1; Tue, 20 Feb 2024 04:24:51 -0500
X-MC-Unique: f3Ma76-KNZ-U3gpozRXUYw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-411ce6e7708so28741845e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 01:24:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421090; x=1709025890;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xshxlpsQluS7qRAd7fMDdSOWA/KW0tH/DDlQJBA+rDs=;
        b=F+w1V2PCPd9o8N1DO7jqHsSA7uo0Hyjv8p3rRA0vKkM/iZ4MUVxIEdfgbAoj70lxXb
         XmFtOVzywdwb1q3CA7wBd+jec4e71WqB6vfftHX7VyQ7hCIlfNceSESCDtxlYQM/Pfsd
         DaQF/57eY3r00x6/3oNFsnDbFYhrU5mr+APBG1Ju5nCMwpVg4M47MwMmcwiiX+R1ikgs
         8zb8CP1wB+GmRc4wvQZ4TA+ZlSyVnpr8Shr54KjtkRQ5gcMnbqySj/oMjn3G9AZplyf5
         RoBmMwv+WM2WDARGI5q3/geCJp6WZxdZN4wPJ1epEtM1fqmEGqDmZ+VVAIO8waG5KQcV
         HmxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe+qihlxdeYy4WZPqHrn6Qb7Gel9v+me7g8xkkbRcAdqxu5U2T48cUHGqaPIYE0IyGXu/Kx7jVvRQZp/bQ8fa8S5k2xkLYtAY/Rys=
X-Gm-Message-State: AOJu0Ywiw0PDMn/TqSjnyuEeRCfIZsBgTPG7PbM1GMql1HW9Fv7zXc1W
	IRXPtIYUZsXUU0qtDxuOw0+GLvoS9DLa6tozYugF0BgVQ/vzwS2xQy7E4mKAzk9p8XWmc+HKBW7
	qyhei2CHxV0Chb5jWvYdB/5+UnOXrjfQRgWzXWWGJBem7Gt+tKJMskC+ZZqSH
X-Received: by 2002:a05:600c:1d26:b0:40f:de6a:2a27 with SMTP id l38-20020a05600c1d2600b0040fde6a2a27mr7454594wms.40.1708421090415;
        Tue, 20 Feb 2024 01:24:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkPjh10xOQRjnJMuYej9HPk/BhMMWKcIszDd75k/eW3ji67ZhUwGUtMHTKJ5oYHxYrfH7Zng==
X-Received: by 2002:a05:600c:1d26:b0:40f:de6a:2a27 with SMTP id l38-20020a05600c1d2600b0040fde6a2a27mr7454582wms.40.1708421090135;
        Tue, 20 Feb 2024 01:24:50 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b00412704a0e4asm779017wma.2.2024.02.20.01.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:24:49 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, Thomas Zimmermann
 <tzimmermann@suse.de>, Bruno =?utf-8?Q?Pr=C3=A9mont?=
 <bonbons@linux-vserver.org>
Subject: Re: [PATCH 04/10] hid/hid-picolcd: Remove struct
 backlight_ops.check_fb
In-Reply-To: <20240212162645.5661-5-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-5-tzimmermann@suse.de>
Date: Tue, 20 Feb 2024 10:24:49 +0100
Message-ID: <8734tnjxni.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The driver sets struct fb_info.bl_dev to the correct backlight
> device. Thus rely on the backlight core code to match backlight
> and framebuffer devices, and remove the extra check_fb function
> from struct backlight_ops.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "Bruno Pr=C3=A9mont" <bonbons@linux-vserver.org>
> ---

[...]

> +#ifdef CONFIG_HID_PICOLCD_BACKLIGHT
> +	info->bl_dev =3D data->backlight;
> +#endif
> +

The robot complains about this, I think that you also need to guard
against CONFIG_FB_BACKLIGHT being defined. Alternatively, you could
include a preparatory patch to fix the HID_PICOLCD_BACKLIGHT config
symbol dependencies.

Other than that,

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

