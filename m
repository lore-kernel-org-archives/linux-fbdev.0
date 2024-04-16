Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE6127B4E
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267883; cv=none; b=uOGMqcYAibncyI/WHHTmETdIXZZZqLYkuZp9ElfvFKp5K0IUVpIC6/30/RB0+A6fvsoTg86ir6NOPuPW1ljwwbMfDB1KIctSBbk1KFbdpXSWH/WReRhCgDDQmkksivn77cgQZA82pDtU4PsOB+gkQEM/Pfi84gOVf5aAWk5xmOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267883; c=relaxed/simple;
	bh=QZpT1KHN3Ra85iYsL9oCjeZNH/FA/S5mYHWG+FDh+RY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ovUsC9AmuM/grzzfn61H6ZsplEBRoa6S8dHZh4Nc4XExndWjSa7r8amd20Itj+p8Eqi4kDuS9vEvsEV8JIYdkfFmsnOnYrmhOwwxlrchXILpzbXhhm9YQRLly1r2MU+ArMuhTCatuQuxS341p/6TT5g/xhxblV1gQX7cx9lSwpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NxWdLvSk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxWdLvSk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713267881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZpT1KHN3Ra85iYsL9oCjeZNH/FA/S5mYHWG+FDh+RY=;
	b=NxWdLvSk9WIepsvmT/APbvbpImyWPyZiSE45GNr+UwV2D8pkvNcKksoe4rw8nokQFo2o5l
	XPaM5EOhm0oV4Qfel7mcIXhLxxNRZvzRxpxMKVxPoTtOAa1q9dyLX4CF0KweSWHc6WGnAD
	3G+argMgYlnJPVu93QIleqO43z04Ans=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-seqHCx7cPEmZamlV7YQR-A-1; Tue, 16 Apr 2024 07:44:39 -0400
X-MC-Unique: seqHCx7cPEmZamlV7YQR-A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-346b9be0a66so3157014f8f.0
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 04:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267878; x=1713872678;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZpT1KHN3Ra85iYsL9oCjeZNH/FA/S5mYHWG+FDh+RY=;
        b=Oloeb3V1g9fCxZHVXWyt2hacrmZczqUeyJRnbauVjE/cuWFE3jWT7zx4bdh/+SVdK8
         4ARXd55u54BUUAQKBixDpO5oMh+bB4r4nawzDHZmwcvSiVa9ORq2yc4yF/ym5D1ztq3C
         Cazo40+vXCD6v8vhKgyRr39S3HWHtAOKM6NZJAcVBt5A07Vr0wfCYKJMxa7UjSC2PtcN
         3Pn8PsKj7p8qh066EuO8DQWGUT6b/4jIoSqLSbPoSnR3UMxejuu2v7ySZ0WQntyHCJmg
         gXLKz0f2rtVRp+NznM3uOEZilSeqD0QH28tH5WBgcImB3UFMEx/yMMGxKTBSgG4NvacD
         BDUA==
X-Forwarded-Encrypted: i=1; AJvYcCUvutKltPOJMW+8ALP9nb+he/8pPVDxa0SGSvwlxXM5JnJ1JuSEE8d5im525dEEkq6peW+U+hVGh1Fo2/gaBpimT7aShwi4GvOONns=
X-Gm-Message-State: AOJu0YzFkX9ozN7NP6PEKMokVtHWFAWyHQn2rPyuM6iucXS5dhYOo/yW
	Hi7Dad98AihvT8AVaIz61I9/Om0LdWN2V70Tzb/7w9tc73h1ZlmSaL5Rqkl+FB0ehp2i5e7ZMrt
	8+rsEub9LS82n6u1A+p2eH/ADVR3i4ridPcFocwp9f/eylcoEVMhurE1FDXSE1KFP8wWR
X-Received: by 2002:a5d:630c:0:b0:343:7e98:e73e with SMTP id i12-20020a5d630c000000b003437e98e73emr7605341wru.40.1713267878353;
        Tue, 16 Apr 2024 04:44:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHv2uaDfVMQXt3r+gLl6LzXP3JoIZXKlb9D3CptY6IRFB5PAQrjI+yOFUxjeAqv9XQXa10LQ==
X-Received: by 2002:a5d:630c:0:b0:343:7e98:e73e with SMTP id i12-20020a5d630c000000b003437e98e73emr7605328wru.40.1713267877881;
        Tue, 16 Apr 2024 04:44:37 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s29-20020adfa29d000000b00348cd3e612esm1784260wra.53.2024.04.16.04.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:44:37 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Rodrigo Siqueira
 <rodrigosiqueiramelo@gmail.com>, Melissa Wen <melissa.srw@gmail.com>,
 =?utf-8?Q?Ma=C3=ADra?= Canal <mairacanal@riseup.net>, Haneen Mohammed
 <hamohammed.sa@gmail.com>
Subject: Re: [PATCH v2 20/43] drm/vkms: Use fbdev-shmem
In-Reply-To: <20240410130557.31572-21-tzimmermann@suse.de>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-21-tzimmermann@suse.de>
Date: Tue, 16 Apr 2024 13:44:36 +0200
Message-ID: <874jc17crf.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Implement fbdev emulation with fbdev-shmem. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Cc: Melissa Wen <melissa.srw@gmail.com>
> Cc: "Ma=C3=ADra Canal" <mairacanal@riseup.net>
> Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

