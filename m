Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B654BDD
	for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781924; cv=none; b=MHCzBuxyVFP2l4tH0Rv9UIaqj3j6ulQELIhfeAPmy/OdPRgopNHDBlR2MEj7Ax7aTZI9Q73bgNGwIDT8atMUGVoWrfC17bXwg0Pjb63ajWWg7vRkNvRzxysxSbx6JF+4pokdb6ivSXGYzK+FAYp2L38fZ5RaYUYAr2n6+rOCwCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781924; c=relaxed/simple;
	bh=6im0vYMteSzj6LMQk0kbEmNHwwrheTH4SQNBxrKYpaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jUTG+Uw1trUyV9E5Wju4fuiOI252OZaEo7R1SNSJUfPCc3gkAxEL4hTr/NTzJQnShU+LhXPFYEfNw1FL7Y9Qmflx75f51Jly9y5r86USVbYtl6MzsaQVdTuJ91OjHxKRuBFqYNW/a5n14i1u8rDwiXTIUxU/p1pzscvmHRx0X1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XRaom1ps; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRaom1ps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710781922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3vRhrKj0eRcdwyPwJxDdsdwXT1UnIfJmB27QpA0tWJU=;
	b=XRaom1psS3Tczzb2ECtJ/o9InBsa+xOPRYJ4ily5G+bP396v26Cf4UWyPIvwnmCgUdqDGw
	qEYwa9bmLN99RDY5I6z71nVXjhsSYuFpOC7SvWW0wGOSgAtN9aUftcx1k9IenD/LR/nzaX
	3bZl6m6WRNgyCx0z4KrBA2JY3firiOs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-hGefxqzrN0W_E6Ttg5piOg-1; Mon, 18 Mar 2024 13:11:59 -0400
X-MC-Unique: hGefxqzrN0W_E6Ttg5piOg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33ec6c43a9cso3506806f8f.1
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 10:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710781918; x=1711386718;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3vRhrKj0eRcdwyPwJxDdsdwXT1UnIfJmB27QpA0tWJU=;
        b=YSnvIvLhN4/P1bEfxiC0CX1BpzlydLh2PsFHZHy9rxntr5qM/KTN2kFJb+3J4BNcI1
         XlBrqf5Q2508oILmLX3SbjMD6IzHctTUGMHO/vOx9sR3B2hD7eWFf6eeNywtQzKwZA5i
         79OdmLHoGxMCO+s7DcjZ6ANy2mRoz04Ubr04IIOhJz5RzVZamwN81HiyjzLiKSizkzK1
         U7a/DoSTvopaVULhaMzo1IUvZnrlW8r+poafA8HJtrJfo+1Ifhezal7z9xUY5acOjwuy
         aI4ZQIDhWvXKT8MEC+MFghks+XzBzV7/tFa4hxVCmBBVEm7EUnnSgUoh/77SOc6WMSZj
         WByQ==
X-Gm-Message-State: AOJu0YyZLQmR8Ze5SWglMe7wtZND49ZJeWD/JAtOOoF0xoBcmi5a14iR
	sdYn6eQqq6kyu70UdWtjkzoj7+SK6hw3BOYJxCfTN1GpHErDcWHmK/a4zbzg0YN6jXP2Bf+T7kf
	QlEyIvWCUCq+UBaQhN+/2iLX5kL1+MHC5sKH2X4/GWW4JcYX2J72SptotapSa
X-Received: by 2002:a5d:65ca:0:b0:33e:7873:e235 with SMTP id e10-20020a5d65ca000000b0033e7873e235mr6095769wrw.43.1710781918430;
        Mon, 18 Mar 2024 10:11:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqEfk0sICBaJNhEW1F/tUVU2GCwld0u8wBxQ3mmJGAa7E6HV9dWIbdUf1By66F59dzlYyHog==
X-Received: by 2002:a5d:65ca:0:b0:33e:7873:e235 with SMTP id e10-20020a5d65ca000000b0033e7873e235mr6095758wrw.43.1710781918016;
        Mon, 18 Mar 2024 10:11:58 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v3-20020adfe4c3000000b0033e052be14fsm10228243wrm.98.2024.03.18.10.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:11:57 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 07/43] fbdev/deferred-io: Provide get_page hook in
 struct fb_deferred_io
In-Reply-To: <20240312154834.26178-8-tzimmermann@suse.de>
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-8-tzimmermann@suse.de>
Date: Mon, 18 Mar 2024 18:11:57 +0100
Message-ID: <87il1jform.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Add a callback for drivers to provide framebuffer pages to fbdev's
> deferred-I/O helpers. Implementations need to acquire a reference on
> the page before returning it. Returning NULL generates a SIGBUS
> signal.
>
> This will be useful for DRM's fbdev emulation with GEM-shemem buffer

GEM-shmem

> objects.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

