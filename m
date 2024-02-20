Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3875F480
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421556; cv=none; b=VKZtZUp0ad56OR1QOLrKdzDxDB0DbHoUKvx7Q7RFowcYEF99zleq6GZi3qFU39lKtMnNJX0f2kzNL/ZEbfMBRA/SKCyVnwSuynaltBtEU3UBcXUmfYb6IKpmY/UM6svNg7hB8k7FgzEZwuoW4+fyPdQsts3wua07J5G3jg4prHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421556; c=relaxed/simple;
	bh=WrnpVBUoYjGoDOOrj0S02mflbU9UnxAKN3MjYxaIOA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qfHHt90n0oC/sbcZxWS8AaupChq1m+MlGBqecr7WV9HWj6z5PG9EUrhAPhjLvMD4HHw5kA4S//Nj1YYAqkB/8GImv9ERHsOxoDAGv4P3JxOic5fDz/bRq9340PzwpHpVIj5K/JY5kC5WvFAgjVARS/BIqlHaRZ2P5Yd1/FA1v8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IP1A277j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IP1A277j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708421553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obRxtLx6rLeO3YU/rqnXda0xS0dHIkiSbzya77n1Jfs=;
	b=IP1A277jZBxXo4BKK+8NajA700NzNhBGYcBlA12okI1IZGn+ZJLTLJDxng3Aqn220D/FNz
	BSsiRp6fVMzhcHekr74nEWJMg49XynfMourT6eK60UGVimSL8jFvwscyVJW3tnXSIMeOox
	fPHZ5vZsbgfhsxm5pc9BB8NQjy99big=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-R_vSmFIyNjC8OHda8jYzLw-1; Tue, 20 Feb 2024 04:32:31 -0500
X-MC-Unique: R_vSmFIyNjC8OHda8jYzLw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-512acebbafaso2085562e87.2
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 01:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421550; x=1709026350;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obRxtLx6rLeO3YU/rqnXda0xS0dHIkiSbzya77n1Jfs=;
        b=QXq6UY9VkHAlnuMd7De4RGFhQAeEvUJKw3R9fgOkUP3Uyp7ycz+/CEeDln/PL5ELvC
         Xkr7AN41AB0tb+9k1ry7zHftD1wdX1D5wxIku/Hf6+CTMhZZjnV6HtFhWXK8KPkldRVf
         kZ6a1E5tYtKMyB64asApFm0yUr2XuiTQf6rCd8xDTT/MEqJH7xhoJQHN3WyzrKpNdl9E
         Js3EgW8jIuJ5FbmCzFrhtWDVoR07Hjo6qWxDe0g2nu8+zXjuj4OLI5TH9FZpEVpcZp6r
         VUeBY5wem5HbivlD0VUVfLutsT7djWoumwcVrPj4K2gxBxD0BHMcDZbxMgTaFpRwbEho
         3liA==
X-Forwarded-Encrypted: i=1; AJvYcCWh4ILgKd2ciKZzT8+QYDTsEwsoxHspnmkiTPXV4e7g+0YT2xQjdIkRsYcVR5IGNbZtbyzumEn2SdWntB/jc6Dazo7kkQHNCtD8r1w=
X-Gm-Message-State: AOJu0YxTCemyTLo+5If1hQNhotWrDeQRUpsS6yGO36uTgF07L2qz2Uwt
	lgLKu0gJ8k9Xb5I8kkdsg0V/J4fm+m3yIV1Xc5yDmUCl9phRhLLWeVqjY1VJhhIkE7GZXYFs1F9
	SZMbxwnPR4Epgm0jyXhYM4Ea0pvOa67QPtiE/6kij85sZeZBDMyTCg0W+zJPL
X-Received: by 2002:a05:6512:239c:b0:512:ae18:7492 with SMTP id c28-20020a056512239c00b00512ae187492mr5795449lfv.11.1708421550180;
        Tue, 20 Feb 2024 01:32:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFK1ISvscWSiC+8duilezYgsz5C5byx70dEu3G6Io79efRQOyltpTKPLus1FsPEKi437suJg==
X-Received: by 2002:a05:6512:239c:b0:512:ae18:7492 with SMTP id c28-20020a056512239c00b00512ae187492mr5795423lfv.11.1708421549884;
        Tue, 20 Feb 2024 01:32:29 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b0041256ab5becsm11246103wms.26.2024.02.20.01.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:32:29 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, Thomas Zimmermann
 <tzimmermann@suse.de>
Subject: Re: [PATCH 09/10] fbdev/ssd1307fb: Remove struct
 backlight_ops.check_fb
In-Reply-To: <20240212162645.5661-10-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-10-tzimmermann@suse.de>
Date: Tue, 20 Feb 2024 10:32:29 +0100
Message-ID: <87o7cbiiqa.fsf@minerva.mail-host-address-is-not-set>
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

