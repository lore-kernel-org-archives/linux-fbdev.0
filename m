Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0852018EAD
	for <linux-fbdev@vger.kernel.org>; Sun, 17 Mar 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710679758; cv=none; b=BrL3rbYbh8f8Q/Z+ZPnhYU7sezZ1sSiq1erPdUtQvNpCAn6Dly2IJBBFBAOzKs323vkqQemU3/oYHmmDdKabOOLWZBXR7E6CVR3pZ6Nda24D6iQIMZvqEWF1UgaTpgkOyK1NVUSdUNw4WK5tDZHCwSc45zZMt0xiozbBHsWiqrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710679758; c=relaxed/simple;
	bh=NI+xMCYTH6kp3uc/3thfY0aIeJEKNVJjzBQWU38wnY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dCT+7vb7ah+fbo+LbIMPgDX8EcJhi1JBLHlhJs7RBWxRAMagUSoFXg51+N3gxVDJiRdtAJVdw5HxBnbQfYKeHW0LiJhb2oByxjKCjDzz4FWOxhdRhBjhIdbWkehOK9VdrWdF5qXSFxHDuZTbh7tSaHJ3lBRKe6wSGr8H2jX6+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipxeKbjn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipxeKbjn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710679755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qSPsm2ZZVDvV0AkFvIhTyz4e6z0+4CVE3yr2sbXPMBw=;
	b=ipxeKbjn/JhtNGFu4o4Es/SsKgwtKWXoKyvguLa8VgewjxYteCp/VcA7CcJjTRs1hnQd+Q
	mQkHVsCmJB+1KzMtR56IMWe+YBdrJLDwo9kVJSvKiwHPAFPnZjf+DY9lNMmkNWjhaiO2a8
	UuIYDAeptCmrPJZiPFAuEmbR5KmDw8w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-QN0mP3BYOL2ZOypsZFalxg-1; Sun, 17 Mar 2024 08:49:14 -0400
X-MC-Unique: QN0mP3BYOL2ZOypsZFalxg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4140408c7faso9637335e9.1
        for <linux-fbdev@vger.kernel.org>; Sun, 17 Mar 2024 05:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710679753; x=1711284553;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qSPsm2ZZVDvV0AkFvIhTyz4e6z0+4CVE3yr2sbXPMBw=;
        b=Njg9i3Fdcxho0oMQFP8pyf0k7mZ5turnlHwJ+/KTEb6pT7uAVBzp0z8EuufmEVitcb
         UZBCOIqz35Tq4ckkqQvzZk/6vKp6n2lHcunMX7N470zY+MKvjygl4yHPIKHqHP1iTBf5
         DIb0FsYMneHYDKUdGCZozi+g94Co2uivhpWIjuVmu5JmnRZGF4GWj3IJrTFVzEYihxWQ
         XHiAI1C6TFZzWZTR02AEI9dmgwKLzZ/9AbTRVWROiwI2P8zwXJRaHjDjNVfz522sICy9
         LFbHJ7z2SjKvR2kH2j8ahOTdFguQ4EdKOX5byt+uZV/XeybK/vrU81aER/xKJKWfgLyT
         sAsA==
X-Gm-Message-State: AOJu0YzTKlvCIyKccKO5ord2UiFUX3PS5luEZe942Yd0sL+m6bp6eFq7
	V8UFlwXuadAf2OwgXrlKJdr5oRkFjeOELKH5NDFXf3/btK5DH+CXgGkfPr4HdZsAmvlSy5JVqjz
	adMRjr49E66TXG9o64MPn7XVLp63zMTrX+LHwZ8Zx0fJAk6Y7Zwm6/JsR4j9G
X-Received: by 2002:a05:600c:1f85:b0:414:24b:2f4e with SMTP id je5-20020a05600c1f8500b00414024b2f4emr4685033wmb.39.1710679752781;
        Sun, 17 Mar 2024 05:49:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs3diPQvSiy1+AZquGxl82tDDaYoG/FSkcFhi7h/8bS28ZCJWxwnlxo1bAMtufKaIY9J43Qw==
X-Received: by 2002:a05:600c:1f85:b0:414:24b:2f4e with SMTP id je5-20020a05600c1f8500b00414024b2f4emr4685025wmb.39.1710679752393;
        Sun, 17 Mar 2024 05:49:12 -0700 (PDT)
Received: from localhost (231.red-83-48-46.staticip.rima-tde.net. [83.48.46.231])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b00413f035d58esm11642656wmq.10.2024.03.17.05.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 05:49:12 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 02/43] fbdev/deferred-io: Move pageref setup into
 separate helper
In-Reply-To: <20240312154834.26178-3-tzimmermann@suse.de>
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-3-tzimmermann@suse.de>
Date: Sun, 17 Mar 2024 13:49:11 +0100
Message-ID: <877ci1gh14.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Set up struct fb_deferred_io_pageref in th new helper function

the

> fb_deferred_io_pageref_lookup(), which runs when the pageref is first
> taken. Remove the setup code from the rest of the code.
>
> At first, the code allocates the memory of all pageref structs. The
> setup of the various fields happens when the pageref is required.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

