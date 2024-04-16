Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C03D12A17F
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 12:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271098; cv=none; b=ux6B3CsFmJMOxPk7ji2OS6k/o5UtE3ql5FBBRpBoy4rq7nJlZMt1t4eodgJfRZBDCLKztkND2Gazz+++T45pwsErhumaB9FersahMf3uHdR6MKj9bzAo5jxMa8FJVzUIkDeJU9KRbYuJLiyiyyrRaum2/2Kr4RUL8boYvKUkxk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271098; c=relaxed/simple;
	bh=bSnSz6h57jideRivLqbHOWOjPR1yihRp6AOqbNLxsCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q+PqB4w7Onb0rdtR1wmqirfQdBuh/MBCpOEw6kqQr4ZUzrzvEqzI1K6ZkK4Q+8On7Wp7sWIydK53VcA7sXeWWMp5TcUx514S0fY3dYUQEbgOaJhaNk7Ka+N3vOnoGpC291Rpd0xe8lx8/jaFrL9aY/plLKusUUe/0bRrxJkybAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2l1ksvK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2l1ksvK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713271096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XiFK03ko/yy02vdgZSeo/rA3ljj/MCQTnFbrFD6H+7o=;
	b=f2l1ksvKUMB71Hx/UJzbWXY2xlkx3V9CQHN3zVuGIIqeTvHuZLAX0fkDOf/ax3tdSs5zIT
	9ZK7NSQjC/MytUBl3L9GDODUlRlrFmAOnNCAK3N+ZBJpXP7As+kYsr/jN2lfkMlkhVMfcP
	/cIJeiXvPz2at0kbY0vDhzlLm5AIHOU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-m8PstjLNPXuOqjhJPr1ZfA-1; Tue, 16 Apr 2024 08:38:14 -0400
X-MC-Unique: m8PstjLNPXuOqjhJPr1ZfA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343c7fa0dd5so2910747f8f.0
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 05:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713271093; x=1713875893;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XiFK03ko/yy02vdgZSeo/rA3ljj/MCQTnFbrFD6H+7o=;
        b=kTi55r6fteJctLFyuwe44pm9l3EUuzyF86h7U0U8uFU8hs1PeFQyndhLinQotNmASK
         4zCATOptgPD7Y8pQMSH/VeR0Df8TrqMAYdoMPfl3mLte6AJyrNTKTma25L3Qf7QbkUa0
         8iesYiI//r3D1rQcNBmjoHS9GYdJTZjmOAqUpNBcwRbkYPZEzgrBj+eZHTsub9R1uNJ6
         AYpdDOP6oWxr5AT8EMYKtUgxNGbq8fjuPETnj1f4jhkwrg1uqFuSMzdH27xPShTWVTZr
         PFftCHi5F3igN3wmlsUyPTOyymoziQ1Sz2xarFP39/r/4tJMj2PtYrMtAF+vO52QkYlb
         wLsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTHJB9uIcAECROvTIsRd91eLmGExtZdnDGB17dhMas6T1L79WZD+axW/acz7Yw18kRn/cYbQL2bZ4Rwynfls7AgTAb2/4+GuALrkQ=
X-Gm-Message-State: AOJu0Ywlf4vP7nq3RVtvY3eqMYDBb5S8ZuqSj3YFEOpXp4PuYl6LzAA8
	iKhsxYrAe9NoYZIGlvto1qhdI3Dlk2hz7n+U87cnRqyIyJq0hD/3hFxU4eUOz/iiX7ctAI+XieQ
	ayL9K9LbTkp5FJdBAew2wz7LsPzQc37u1YMq0eL6W4NvUObBeQ+2bSWWK2Fok
X-Received: by 2002:a5d:51c9:0:b0:343:70bc:4578 with SMTP id n9-20020a5d51c9000000b0034370bc4578mr8677233wrv.70.1713271093646;
        Tue, 16 Apr 2024 05:38:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOq0P807x4yDNTITAv/qTK2qkNjsaxOXXBVDhhJodyLJcfCauJOhtgJPnqj/p319Ver50JwA==
X-Received: by 2002:a5d:51c9:0:b0:343:70bc:4578 with SMTP id n9-20020a5d51c9000000b0034370bc4578mr8677221wrv.70.1713271093283;
        Tue, 16 Apr 2024 05:38:13 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l26-20020adfa39a000000b00343e825d679sm14902264wrb.87.2024.04.16.05.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:38:13 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Kamlesh Gurudasani
 <kamlesh.gurudasani@gmail.com>
Subject: Re: [PATCH v2 35/43] drm/tiny/ili9341: Use fbdev-dma
In-Reply-To: <20240410130557.31572-36-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-36-tzimmermann@suse.de>
Date: Tue, 16 Apr 2024 14:38:11 +0200
Message-ID: <87bk695vpo.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Implement fbdev emulation with fbdev-dma. Fbdev-dma now supports
> damage handling, which is required by ili9341. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
> ---
>  drivers/gpu/drm/tiny/ili9341.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

