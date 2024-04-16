Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567E8127B4E
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267349; cv=none; b=qnBb1jS9ofvlbL868PEHIUbDjKwczMPRgeAJXB0yeMDUoN6/I9uXB9PjrZcwp9fzXrwzXUW4uWQmbRPCNLHdV0Nd1AN0Yot8DMWnu/4UZr6s4YzsbbpByuvjbLK/Y31Nm4FaeWyQUVa7RYPkj9WHRyH3Nu42jwKfcTih9Xa+j/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267349; c=relaxed/simple;
	bh=WfAqmcubzp1WTGozzDa/V/CdGpJ/Y532KeKLZEMLUIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UrHP4cGKFc77utKF/KvFdYx992mhYJ0R2x6AyLA14KFlf944NnBt975OzNdfRz3yQwEP3NbRA8NX3JFCCya/8asYKrG1xyMLAMCHowm1zCF5SSUxy8ez3SHpc6Y6i8FhzLz2Vu2lw0S20ZocLzl4oPxG/2NFgTjzobf4F+1iDxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBZ3YjT6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBZ3YjT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713267347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFzLrdpsAuEJPi669kzJMOzEGwWeiqROeSymInIGJc8=;
	b=IBZ3YjT6Vo+tCdSE3zvGWIj0FHuNW4KzCSWaCGZycB3lWeZY8zGVDGlFTZ866vJVm41+ep
	a+hLFn6sTZQfoxjBcsZxUGpqrkXVwft6QcP7fds9c8iBqGe6xhHomB3ABVRrctTafnRIIe
	JR64v/N5tA/+ENwWKIPTHehgkmys+lw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-fImy97o9N5mC5CumXLlNGA-1; Tue, 16 Apr 2024 07:35:46 -0400
X-MC-Unique: fImy97o9N5mC5CumXLlNGA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343c7fa0dd5so2867937f8f.0
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 04:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267345; x=1713872145;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFzLrdpsAuEJPi669kzJMOzEGwWeiqROeSymInIGJc8=;
        b=wiQ9807F2yn76xXKo0GYa1TPryMB6I+rCkxoE9/dVR3OTxX1dn27advMeZqCxMrM+X
         PjactsIsaGw13QD+MzZ9d25M9seAA7igHoJrjgbd+OeJzbirFJQTAvbAgCXW5fwfou1+
         tgy3h40PS5oG44QTaILmtVTKzrqY4n1amQFRWH6knvvFD2siHFUGZZC7SdrVgGerfTcE
         ackFbZrgeBKIMeP4jAvbMmOv28/cR0xsxq6nF374laP17Gtjjg5NXDicfULPxuz7D5MZ
         bMWmmbaxrh4wAIeWzQXcn5biI0Wu3E2Y1Lp7N30QpjgD9ML15WWr8MIIrzaoW+K8L5my
         kG+w==
X-Forwarded-Encrypted: i=1; AJvYcCXcEBC+1CfrV80OLyDERJ5+kNuWFrvfzqgAsmaXs50llQeiUcv1wKyB/y46h6HyXtm+tmvZa/aLGsZPp8N0f2TejrcgTDoYI8TV458=
X-Gm-Message-State: AOJu0Yw7DcagjF6k1saeH5iWJQ5RYWrkEUxll9P2a8/OmPRhTcSRgXt2
	aMNSICBUkg6zedtaiZyaof5V+FmvR2Xkn0tPt7RgZZyblHLALVLvx/+9o9cAHGsS5HwRStpQ9sZ
	YfZylAeabDRETnVQ/7jEq2WLaKD/7DmJwScepDBJAPcCIGmstkmlGilK8kbdN
X-Received: by 2002:adf:e2c8:0:b0:343:6e18:5f09 with SMTP id d8-20020adfe2c8000000b003436e185f09mr8995327wrj.12.1713267344888;
        Tue, 16 Apr 2024 04:35:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoYLuCkWWmzkqZ3Ar91Nqc34yB2NaDu4hW1xxK8WU603DhOp2GOeUJuetecJ7khZCb1oFPpg==
X-Received: by 2002:adf:e2c8:0:b0:343:6e18:5f09 with SMTP id d8-20020adfe2c8000000b003436e185f09mr8995313wrj.12.1713267344467;
        Tue, 16 Apr 2024 04:35:44 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j20-20020a5d4534000000b003434f526cb5sm14575080wra.95.2024.04.16.04.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:35:44 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 13/43] drm/solomon: Use fbdev-shmem
In-Reply-To: <20240410130557.31572-14-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-14-tzimmermann@suse.de>
Date: Tue, 16 Apr 2024 13:35:43 +0200
Message-ID: <87il0h7d68.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Implement fbdev emulation with fbdev-shmem. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

