Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889FF41C76
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271130; cv=none; b=Xwx+d0rhaM/HcWv430MV/N5UpXT6KpjM9rSuxTmEhizERMo6S+oNjG/g/m7ns4X70fKNFJ1//ltlPlct8HhYsmVKV9FDx8VEgUAqvOpYKiRHzoENEo8wTgKNt6Q6ATxEOK1EaUaiAjuFmtPdgS+Ggwwf3tKUdrZ5R8TOFdHPw4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271130; c=relaxed/simple;
	bh=jwtkflRgj8o3AvQodjG4HRQCnhhXX+ezpu7GD0Hyxw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OWElZd16xz074nlGpEW6P9qVIbdcHHgmH5AXOPcoK0kn1wkrD5+iqALDVCc6NnJXYKeltUnN1TLxFAR14gIxym9MbzjDhxMZkrpc1v1trwxDaKVzuxyirdB57doxCbtCP0PTZT5N+CSypMf3is+0Nwzsh6iXHcrxdDqwzNDdAtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G0frUAFn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0frUAFn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713271128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/y2H6OrKrrJeh3GZF/seqRcZgk3Qwmi3QivWg+s/E3U=;
	b=G0frUAFn1I2TF361yUp97eb7581v50GJ7ODgPm9zMqYtdHHxXqPr2JNGWw4ud8BmMRcTs8
	Z9t4bvfAar0bDgh7eyuoOgB7hxjBqDLXS7albJev3ospaWjdQnIpj1bsacAjYGlitNQaLK
	hzKtfEV5lp8f/SSz/x5AxsFDnhFK6YU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-Y_CmbnebMdmFukAWMJqYJw-1; Tue, 16 Apr 2024 08:38:45 -0400
X-MC-Unique: Y_CmbnebMdmFukAWMJqYJw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-416a844695dso20405935e9.2
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 05:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713271125; x=1713875925;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/y2H6OrKrrJeh3GZF/seqRcZgk3Qwmi3QivWg+s/E3U=;
        b=h0HvMSNkCFBKWf9yRmx/0KdP6Ags0nRt34wOpkUDo122fxwt58+J6y7PiOJGSsPMxD
         mxhQDHgTktyrbu7UAtBqyjDw1/ILGymzp5EELJWs+3BTtsPkKXsSZg53jGjTAst018Fd
         V+0Huk/wpJcsKGUeGJtY+HXgwI2Mfh5RvfR25VFUoYxSNcjH4cxRoEZP9hG5BsCfjgu0
         dvMfVF/8bRYjh8LjcxcNl9NYbCMjgazrYbGOKnFSVMbIOFDHnh0jeRiXVEWtzDztf0i9
         di5fMCxXg1s+OUTJY9QX2sW1CV2BUgovXh+SWCyu/OChuD7AWbQo7aqs+zEckc/atXFM
         gURg==
X-Forwarded-Encrypted: i=1; AJvYcCVvnUdnzmXMsUEd+RVwwVq/XUXXDfNJsRNX+voPjA8yL2Kq5+plGBHsOwZ+PIYj3wOuT7hBM++oUri7AVVv1iDZahe6mIXgm/YuwQc=
X-Gm-Message-State: AOJu0YxGxT6ZglH/INqsY6RpXeRMhGbiB3AOo5Ztd1sYoiLBUPtLWBUI
	aLjfaPH68XNOUjXR+bapx6ecbbT6Pa4DK60U2sGaHsnRy8QkYSxJdHHpQGd4Hdc5gzL/onl/v5u
	XGnsElHKuHDnzq+rqVHg+2LYtBLH5OTFjJ8B6sipUckM4eckcsBQIkGFVJ4Jk
X-Received: by 2002:a05:600c:3491:b0:418:2343:1eb with SMTP id a17-20020a05600c349100b00418234301ebmr7581039wmq.5.1713271124715;
        Tue, 16 Apr 2024 05:38:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3NJNYx3yvWD4RdKtpJ7ZV3zw6Q0wL44la1xd+fu5I1R4I/8zqLpuZ0pLsN0/bEMQiBuF1+A==
X-Received: by 2002:a05:600c:3491:b0:418:2343:1eb with SMTP id a17-20020a05600c349100b00418234301ebmr7581027wmq.5.1713271124466;
        Tue, 16 Apr 2024 05:38:44 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c444900b00416b163e52bsm23211273wmn.14.2024.04.16.05.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:38:44 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 36/43] drm/tiny/ili9486: Use fbdev-dma
In-Reply-To: <20240410130557.31572-37-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-37-tzimmermann@suse.de>
Date: Tue, 16 Apr 2024 14:38:42 +0200
Message-ID: <878r1d5vot.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
> damage handling, which is required by ili9486. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/tiny/ili9486.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/tiny/ili9486.c b/drivers/gpu/drm/tiny/ili9486.c

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

