Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAF21D530
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270815; cv=none; b=Rc36kXXkr7NXK7z7KhTCZw2p6tDNFXNkUDQhWMRYjUoJTZP99EDNWHl1hGFXLRV1+SabW8/fcXPyRwb4HPi3aQAlkg7txEg4p9ZaqYr0Z6isbxLBcJAfr1ET6ttRHBigGhrvRzSgFkFiFSQiGIH23TMkH0nPkmy3fnaRWZUYFqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270815; c=relaxed/simple;
	bh=E2hGTqohdEkPzPEo7e2hPuOyi9FvV85Vyv5552epGjg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ulfB7Eg4LEWKZr4hMmNh3GLZi9RZpA2mcFwgEYlkf7vnfHha6M8y35VsMAvZoPkihXDJdKyABX5Xbod17MefFA/lC5eopiuUXJCWgq4FtMAK2oWdrgF54oEICtCkP4upmhlBePbGSvSUvOB6r7HaUh0Y3jiJPmcMLp047Bjh6Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ftk5y6Y6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ftk5y6Y6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713270812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v7Qp1T9S7HE2g/JJFKnqDgN9CYpgdMoSmaFgUHqF32E=;
	b=Ftk5y6Y6a3z+SfqjiLZT5K2s6isq5KMEiHlLdQwB4SDMYb6e+OV9gedsvpBmKpizxI1NKJ
	fTWxTYlIayWHkyeU75KLFRIksY+cJH/zZpZ1MWrKMr+S8d981edUbFXu2oSOEFp62uopxR
	tFmt3ICCiu/ul8pEPk2B4RWl/XyYpW0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-09h2nW7TNzmH9QVNlr7iGQ-1; Tue, 16 Apr 2024 08:33:30 -0400
X-MC-Unique: 09h2nW7TNzmH9QVNlr7iGQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-345aa380e51so2435004f8f.3
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 05:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713270810; x=1713875610;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7Qp1T9S7HE2g/JJFKnqDgN9CYpgdMoSmaFgUHqF32E=;
        b=RsyBGaUJTNnFrwVlmpRltFq1URbNLlu96orp/R2Q8H+bpnCMo/teGBT3SMYUHstxYC
         DQN1VrqFhFw/b2RktuU7zfj2l6kGMMAxRHCYAKtFVkJVcsG9CVbp1j7lIc1TghlltMCz
         xuD9/w4/YheB6usLXYTSXO0EsS6o0kV7Uz3sV7Nv8IvZwweRj0AR5yyChTsrE7joSAkO
         bpuuMsSuJgSTt5kQeniQN0Ann2vzgg04yrEtvmef306CDPDwW8BOC8/1E77EU42lSOcm
         4bPomCxwCwrouBEC49peJDbWtV+7gxLUObiuiFvUrVU66t8NvHpIJHEzbWEAP6uExjnN
         ED+g==
X-Forwarded-Encrypted: i=1; AJvYcCU+xv2jwxZI0Zjbl1PQcVbNPg7E68JtqHcW3Q1P5u2JfbK9fZDvi94h+2RjC0BaZYCiIjan3Bg9ES/Gju7QaG5chV17/HaUKw7bCTw=
X-Gm-Message-State: AOJu0YxQcgmA2ud/R274y1u8J4Qz1/p8MfF3VMlGc5N3iUcHCJGqCcQ0
	AAKCrhVvAHgLIy0MlbSV7GYwZebcRlDd7mlSOF69cQB5eQFvK5krHojq4EVghgoU5LpBopAOctS
	elJbnlAKmesx5c8dpBgCVt6ndiCp/bjNfWjqii8DzTzE9C87c0qHQjW+nSWxP
X-Received: by 2002:adf:ec0c:0:b0:346:ad3d:e4bd with SMTP id x12-20020adfec0c000000b00346ad3de4bdmr9295352wrn.17.1713270809731;
        Tue, 16 Apr 2024 05:33:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSGIVn0oN8p0J5DpAR4GFROh4k+wVlggK07cYyOtf/EtHkuYsVImIhcSZt2w1Z/UnzTXDUDQ==
X-Received: by 2002:adf:ec0c:0:b0:346:ad3d:e4bd with SMTP id x12-20020adfec0c000000b00346ad3de4bdmr9295337wrn.17.1713270809373;
        Tue, 16 Apr 2024 05:33:29 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i4-20020a5d6304000000b003437ad152f9sm14780054wru.105.2024.04.16.05.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:33:29 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux
 Team <linux-imx@nxp.com>
Subject: Re: [PATCH v2 24/43] drm/imx/lcdc: Use fbdev-dma
In-Reply-To: <20240410130557.31572-25-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-25-tzimmermann@suse.de>
Date: Tue, 16 Apr 2024 14:33:28 +0200
Message-ID: <87sezl5vxj.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
> damage handling, which is required by lcdc. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> ---
>  drivers/gpu/drm/imx/lcdc/imx-lcdc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

