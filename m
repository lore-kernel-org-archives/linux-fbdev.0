Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0625A10B
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271386; cv=none; b=XFHjiYQjHO6NH1QgC5ZaBvHoyHG081WMfM18t9rYm7vSId111SJ9bWDmcKZopCALuOTlFsW1fhC4pEqEE/uCCNscCZ9NkX2LXG74ZY7HcMLX7B0VkS4xVy916RDB3mc2olcLIHBWQ+/EsOl6Bs0czERwvJ3s4+UOOABlMi2astc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271386; c=relaxed/simple;
	bh=8ZQfDvNnVhfCGJoBxreuHdTcbRRbTrKnHF7f0x5/Zwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GimY4wQeVOvxLxXvA5G9ARurKQJgjnTQuNBEfTol8wtyXEG5CV2F5cCkmqzY9LUFWakf4tXwcOQtLpdbo/+gRzBLhdKolHR8nZLqJ7tyaivg5pSNANVVokWp23xwTjieWU399u83ACIxSp4v62ZhfU7JU1p5BF6ZZFVWiJTzl0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OvXrqIc5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvXrqIc5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713271384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jp49m6q3lvmw6iA15TwLy3GUIM4dsmTXh/SR2TtsRNM=;
	b=OvXrqIc5TMNKNcuSlEtKMlrl9V3POhsQ/1/dMFzevGlJXe4d7lhCkDJvEiCap/Og4pKFQC
	nkoCELhprLKZHYsuC9fBlVh1p+ZXKfMpFqN7l6Ou0XNiEYsBK86zswFrgzn9IoXKs0RO2c
	57x4YMCWv0OU1TvT5KBy1wd3y4IyH4Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-PSKzgdYfMtuCDXu_KYdRRg-1; Tue, 16 Apr 2024 08:42:58 -0400
X-MC-Unique: PSKzgdYfMtuCDXu_KYdRRg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-346d3020e08so2918937f8f.2
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 05:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713271372; x=1713876172;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jp49m6q3lvmw6iA15TwLy3GUIM4dsmTXh/SR2TtsRNM=;
        b=APD37NG+HOusWqm1Ej+RLwWzcO3/AKXtBCmNUJKWAbufgJfIN6p/xv9oxTazvLR1kY
         MpeeKQxZrUYxZpTRKlQQEdsNn1xVruS9+hU2VYIkjj2kBetVErgRRTVM8XRe2L25rTmx
         qaxGK5TQpZNEqn3JNAGlcx0mOtaf2LmbjI+jZmZwSshX4sUn/HO5Co3VGM0NozTnEpyu
         XVFbTOsCxbdoDBU2Lta7FulF9f7OtVsmsEnY/eVoZulCFWG96ckhoyViO7R4+1ImBPel
         ftM0S2/zsA9mav+mNr94a1gqSK8QS0l+xstiKz4u6x5KlslziYYevF3uA7wMY0nJTjU0
         wOVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV6AJkPPK7XXURl/7EQskY98c6C7l1+XD33eVQGqNMAdldUjWU6GC3+aCrA4pGMyf0eVgRacoF9OpKYa3VW6OEzxROMSNCjrH3ObE=
X-Gm-Message-State: AOJu0YwnN2yH6IkFHXV6luKAwQAKyvmZNtk50PjLPJt50efdMi3kZJcr
	KWvC7X7tSxQScj/X+gp1ew9AruTr8wX8izfBXXkKa2wM5xFCw8ed0nZAYXv2X+P7pkf2uhNY/jT
	ni8MqQv7cEOVWag5wwrzRt46wk27O/jEwsUctlRRkiLF+ZBTKEy+QzS2W8alW
X-Received: by 2002:a5d:59ad:0:b0:343:96b2:c12e with SMTP id p13-20020a5d59ad000000b0034396b2c12emr10492729wrr.15.1713271372084;
        Tue, 16 Apr 2024 05:42:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWAwkGQawPnsu/BKlaYNsy3l/ywFd+6gzgL6urgpasKJvexa/njCiAedgEaXEOrEB/bm/ZGw==
X-Received: by 2002:a5d:59ad:0:b0:343:96b2:c12e with SMTP id p13-20020a5d59ad000000b0034396b2c12emr10492712wrr.15.1713271371692;
        Tue, 16 Apr 2024 05:42:51 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r26-20020adfb1da000000b0033e745b8bcfsm14963657wra.88.2024.04.16.05.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:42:51 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 43/43] drm/fbdev: Clean up fbdev documentation
In-Reply-To: <20240410130557.31572-44-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-44-tzimmermann@suse.de>
Date: Tue, 16 Apr 2024 14:42:50 +0200
Message-ID: <8734rl5vhx.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Rewrite some docs that are not up-to-date any longer. Remove the TODO
> item for fbdev-generic conversion, as the helper has been replaced. Make
> documentation for DMA, SHMEM and TTM emulation available.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

