Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A27C5FDCC
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421275; cv=none; b=qYUulLKa3n18EeAcG16C1w0tXDpF5F19/KlR8KlZQeRx6r8vWcW6RaHcgIEs4N2iFag9bxZuuNdrKoGQNgd7K9NfQUXBqFFVGJSb65OxW09OVTVMRUhDwKu0eW8zT/XHslJ5pxWA/Jbhx4AIDHRalMyRCfCKW37FXlPufdyT4PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421275; c=relaxed/simple;
	bh=WrnpVBUoYjGoDOOrj0S02mflbU9UnxAKN3MjYxaIOA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fjOfHDBU2C5nxb6UCp7nb250b1HYu8LMDpM71awMHG4IKt2f1i0Gtrdyu+ZfkHaEhlM+dzc2BfpSW/G24gWpGrAkUmou4ZnGUk1MakB7T3u4I9trU0MCdsCy9OO0AE5XvZYmpMvy/FbUkvsKWuo5PG4TDguMCSLj6psClnzsTu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MnEpWMj0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnEpWMj0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708421272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obRxtLx6rLeO3YU/rqnXda0xS0dHIkiSbzya77n1Jfs=;
	b=MnEpWMj00gOQkqOmQczMdrFW+Iod0nGhLRNuoe0lIEh71XN9uVdjYBO1iwSFWLHcWakX5X
	q4ZskszBNiv2XkV5MLRlg9/UpEkPislMjCGkWDyURxmUfLjPlZW+r35BagzSJ41dMdmdfK
	q230nFN5lzX8grIVKKLe2foRKLWWulY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-JwYnx9kyPXq1iRcCiPlMaA-1; Tue, 20 Feb 2024 04:27:50 -0500
X-MC-Unique: JwYnx9kyPXq1iRcCiPlMaA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d2328bbce4so20635211fa.3
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 01:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421269; x=1709026069;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obRxtLx6rLeO3YU/rqnXda0xS0dHIkiSbzya77n1Jfs=;
        b=txmk5gPZ1h8m1cQvyqBA74Y3dQJQHZA+j1adgXvk+ZobkXPy3ZYI+IfBsrC83fgm4P
         k9HIfaYDMgLvfoCem1ICsNqxLP4+5kSyCr5DGoc9R1ImFvXE7/ahHInbiqyyThDSMs63
         XrPPtzqLHtmPLKYQaTzSnIGkO112hhrbRaZvLhm6ItLdIZ7RNFctA8oUbhGTxscu0Shi
         tOPNcafoA6z4piMpvcIbAv3OTAZRE1Ibq3xvESUtB66Dq7yVmgLRC12FzftKlqeRQHGK
         tSiasrfSJF75F4frnJx79iBKm7a51DBL/v/uWzQ5agVcCffm+Iu7/txJKLP/b4n64bak
         qe7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8ZRuq0+wkTMoQ/lpKGqMIKZi/+8HOiL3PZ1LqNhRQUe78okr+1ccnmnyQJd+pJNfr+NaibM6KgGi08XmEgU7XGorRk/uBGvvZkW4=
X-Gm-Message-State: AOJu0Yzap+dwvfz5tbqo+lpRwdeRsJqjMhcZ6eXCK0O15QyLqERh80fa
	Cw0ibXckv+IKCTEqblihbXgJt0THRJ5Fy9LbUeSyIeIoJoUB8EL2+4pXtRicfgobA/kmqpogsVt
	X1JbNnW/BhzEH3JNlTh/bEQbUsdMHWiTo6S/YwydXmvkO/Q9DoA1iGwxCPZuj
X-Received: by 2002:a05:6512:203a:b0:512:b362:e790 with SMTP id s26-20020a056512203a00b00512b362e790mr3016707lfs.34.1708421269260;
        Tue, 20 Feb 2024 01:27:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa5OX+BOUymJZ7SlIgyg3cW7L8Ltr9UOF5eSo06b5LnwaixDwHdhkSc1ftkjut2C8Il/ElUg==
X-Received: by 2002:a05:6512:203a:b0:512:b362:e790 with SMTP id s26-20020a056512203a00b00512b362e790mr3016699lfs.34.1708421269080;
        Tue, 20 Feb 2024 01:27:49 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ci3-20020a5d5d83000000b0033cf2063052sm12834029wrb.111.2024.02.20.01.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:27:48 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, Thomas Zimmermann
 <tzimmermann@suse.de>
Subject: Re: [PATCH 07/10] fbdev/sh_mobile_lcdc_fb: Remove struct
 backlight_ops.check_fb
In-Reply-To: <20240212162645.5661-8-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-8-tzimmermann@suse.de>
Date: Tue, 20 Feb 2024 10:27:48 +0100
Message-ID: <87ttm3iiy3.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The driver sets struct fb_info.bl_dev to the correct backlight
> device. Thus rely on the backlight core code to match backlight
> and framebuffer devices, and remove the extra check_fb function
> from struct backlight_ops.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

