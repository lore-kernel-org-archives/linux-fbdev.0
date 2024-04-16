Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397E31292F9
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267859; cv=none; b=q3jeRx5QUxympLjJcZZ8ADAHZsfdUg3hjX+y04DP19sIeJlub8jID9RtDZNuho0MS+0LKrDi0Vx/JgU8wSkhBS83Mx0KeL4qr3f+5USpykYajILT21yGZK7xndUcms70Q9ew8c0s03jdCDJtYMQR31Ni7oLHzRscBNA20BoX9hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267859; c=relaxed/simple;
	bh=oQ5LNaViIS1yCT8tRJm9HchsYR/nUNC3c0qm2tqDKYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q6yzvb30sIBYK5i39M1eei/Lc3v0rk3q3JfgeH+qpsaeyb497JP9+2BtlU4zZjVSC3uZT5KuGg5D1XrYSnPWd84xpeYCkto6tA9BdYSchl7RQYgOjDFiJQo9sod4We8X2EUbViW0WsKBZoYA+8WLLMiEnTq+OQ9uJrzC2m8SJ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMLHQgNd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMLHQgNd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713267857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WPv8+7fIKkpHm0ynwckuUQRsHAq15wX0Hy1ijdKsEto=;
	b=bMLHQgNdjVaE5ckWIsaWbwgEaiI9vb6bkDAKNVxxH5gwitaGl7qODhEjsfXwskGG7zoYDN
	s2crAgAl0DsahI7LVKvAksISMRxct3sKW1bIenPdRCbCnuDdnwEIFDwfeQGnKVE9Uv/OJb
	w+kKH0FQ6rgGnAxeuB8bsiB4fIOXI7I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-IIgyD-yONKWLdzooB78Kwg-1; Tue, 16 Apr 2024 07:44:15 -0400
X-MC-Unique: IIgyD-yONKWLdzooB78Kwg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4187fb76386so4773095e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 04:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267854; x=1713872654;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPv8+7fIKkpHm0ynwckuUQRsHAq15wX0Hy1ijdKsEto=;
        b=rXfrSIrABiNO5YDlPOMU9g58+Ts3FE+NjuM/qoZG1DY7iHvf0bbZGZjc4QBmRjhsd8
         UUEUaDJFDtOR4ct4gfYg+ihupyxK+tXrdvDcl/7wvXw6XwZrmmc0CWMvd0r18N99xTA6
         hc1zwwQSUeNOiXLS0StRteUSbJ/m7U76hwcsn3KSyvvlnSVXxo+HqE7iBOjKTzeWXsED
         KukgQHgFNRhzNeRzJbtPGtsGKbHI3ZzOMrvTUxrkjrqWWSKrNfFwBbn+uWImFs2z9sGA
         5Q767sTrioCGpbB8k2Jv93B4S7cNlgLNMCFcmsrAxikMtn3eOnIgcvlVWTksO9kXEMYa
         QhOA==
X-Forwarded-Encrypted: i=1; AJvYcCVSGG5ro5dHwLAqTrE71gTNzaj744ZGHkMwwHx7l/thGTxWCDGxfVaa1pxtLzqzXBDRXItRn1vjfkBSbWgbqvE7pf3sYrShvHDsNFs=
X-Gm-Message-State: AOJu0YxeYOBTnhJEH7vpvKijl4Uy2aDoqwnCaGPzQlmGXRQjBCYQK2Hc
	uvVQuBcccH4zkB0ePxjJJwq3bpd7ieV110hegzB0wr0MkG7hIN01aI17tpoNuxA61nTieOm+Wtu
	fysCCB6CeqKSeb0uutABoKx6zBINtKRlBzBeSqPCiaklUvnMH4zIY2tF29PJ0
X-Received: by 2002:a05:600c:154b:b0:418:829e:efa5 with SMTP id f11-20020a05600c154b00b00418829eefa5mr2749062wmg.20.1713267854441;
        Tue, 16 Apr 2024 04:44:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpkddCTQOB59gf1jTW4qRPiWMyYG4kE21ugC5rTENiIr+upORu58OYHGQU37BNwpnmtKfBiQ==
X-Received: by 2002:a05:600c:154b:b0:418:829e:efa5 with SMTP id f11-20020a05600c154b00b00418829eefa5mr2749042wmg.20.1713267853964;
        Tue, 16 Apr 2024 04:44:13 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q6-20020adff946000000b003479bec98cesm7255243wrr.115.2024.04.16.04.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:44:13 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@redhat.com>, Sean
 Paul <sean@poorly.run>
Subject: Re: [PATCH v2 18/43] drm/udl: Use fbdev-shmem
In-Reply-To: <20240410130557.31572-19-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-19-tzimmermann@suse.de>
Date: Tue, 16 Apr 2024 13:44:12 +0200
Message-ID: <877cgx7cs3.fsf@minerva.mail-host-address-is-not-set>
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
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/udl/udl_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

