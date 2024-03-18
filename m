Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FEE2C6AD
	for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755304; cv=none; b=tAfYn/OBy1KvwMgY7kSiVXf8WeaRWtDV6NhhYh+etjAvEUEpN50XjrgGqbDSvSwTPijeOsNbjJJbAc4esMWYkDVNoWyk8xeZW9YHP09rzgz93MLn2yk+1skX+2eWFtLL28m0lztS7KxBwQO/O+5o+JdNXgpQx5xh7puxO2XwgWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755304; c=relaxed/simple;
	bh=a2e19NIrLL15aA4XDReCYJO+B4YHXQsIHrzq0K0DE5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UpxgKlhWnXLbFnU0V8Q67GQzo596AXJWH88QM7AbIxdiMoC2FBNl1vKYi8vOhbk6rOSC3x9xo9rNYGBKxsF8PBPTAXFOjVlHiPQMn+ili6gwz2mKtb1WACh520DkCuEDR3F49TtkQyQ8TwIi2HIyBut9GtdAJVSJn60T92tgTnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZKQ28FT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZKQ28FT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710755301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4y4SgSMn0xhvmoHXkMRxARRoLMhg77gR29I4xBsDe8=;
	b=LZKQ28FTW2evtqzzXtrigNIcD6IakQILD8HVAx32MCoMKBGEdYPN4vPLwS9JqmWsCxtIuE
	K2/OOOR4kJDm0BUQMV7dbFEAHONgWFdO0kTI2q2tIIg5fAwF6XlZHCn7lcOPc7a182ePp4
	EmtC4iyYOMrP26u2ScCGKfOpUnJdudE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-2Fef-NV2POi3_K5SHJa9EQ-1; Mon, 18 Mar 2024 05:48:19 -0400
X-MC-Unique: 2Fef-NV2POi3_K5SHJa9EQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e435a606aso22196445e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 02:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710755298; x=1711360098;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4y4SgSMn0xhvmoHXkMRxARRoLMhg77gR29I4xBsDe8=;
        b=kFTk+oAUAbr5w3WoI9bIEwW2vnFcAoH28fe+ZOcxQ1tU7sOMB7n7yux7RZu99Z0OUe
         EZH5BWhe+FwNToTLqH+S4fyKwX54PXsI5uR/7DfrDZvr17XBg2CR2Yy6gB5seLfnGWXl
         A6Ct60N52i4oEhKLLatSNsf3rWF24Ka/0UvfSjpwS/krHx+r563noO9nD/OyQIuNTMcR
         tcbE4VrgQ94DjostUNg5Wyeb5rotH/alpuP5FkBMMgQkzjh1yts41Tt/BAlNtY0mJWpv
         OdUiAlK7tC4yT7kWLIwbeZ8haLdPtUiH3VNxikKdFYqwFUkBB9G8QwdPqIKqRI7va3yA
         lGdw==
X-Forwarded-Encrypted: i=1; AJvYcCWUJsqdR/UzB5RTwdyhjb6EBJ70gRZ92hW77eY7SGcU5HQbOVOm9VFTYWQxDMnOyii+aLXZNnwpYEjj+qthvxxkplsxftJ0bK4onss=
X-Gm-Message-State: AOJu0Yx8G/oNfPWEKlfoOjA5PclI2VmT/rrSbLJY3GVoX+id91aSgUgG
	a1OwfmnhvrQVnNANDWl8VGtjTNmaDYn0Vs/A2plKhgGcei5dTOwO2Zo4FY85hq2+ldjSKBslPKx
	AXxx0EeuP4kb0WBlSmPAnyBq9MLwfOZBaVcWjWZ2XBluyyxl4sGjkay+Oq1Y87Mm/pBDI
X-Received: by 2002:adf:f3d2:0:b0:33e:8ba7:e53d with SMTP id g18-20020adff3d2000000b0033e8ba7e53dmr8843526wrp.7.1710755298493;
        Mon, 18 Mar 2024 02:48:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWQR49MtOFntHhQbEWdf58/z7aANwNdxsBw8JKFRo6fJ8CfctzQV4HlXJ4mhfSmdeTYWfwNQ==
X-Received: by 2002:adf:f3d2:0:b0:33e:8ba7:e53d with SMTP id g18-20020adff3d2000000b0033e8ba7e53dmr8843502wrp.7.1710755298029;
        Mon, 18 Mar 2024 02:48:18 -0700 (PDT)
Received: from localhost ([90.167.94.24])
        by smtp.gmail.com with ESMTPSA id m10-20020adffe4a000000b0033de10c9efcsm9324992wrs.114.2024.03.18.02.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 02:48:17 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Zack Rusin <zack.rusin@broadcom.com>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 01/43] drm/fbdev-generic: Do not set physical
 framebuffer address
In-Reply-To: <20240318-dark-mongoose-of-camouflage-7ac6ed@houat>
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-2-tzimmermann@suse.de>
 <CABQX2QPJJFrARdteFFZ8f33hvDx-HSyOQJQ7AMFK4C8C=BquTQ@mail.gmail.com>
 <e684558e-8308-4d73-b920-547f9012a2cb@suse.de>
 <20240318-dark-mongoose-of-camouflage-7ac6ed@houat>
Date: Mon, 18 Mar 2024 10:48:16 +0100
Message-ID: <87y1afg9b3.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maxime Ripard <mripard@kernel.org> writes:

> On Mon, Mar 18, 2024 at 08:59:01AM +0100, Thomas Zimmermann wrote:
>> Hi
>>=20
>> Am 18.03.24 um 03:35 schrieb Zack Rusin:
>> > On Tue, Mar 12, 2024 at 11:48=E2=80=AFAM Thomas Zimmermann <tzimmerman=
n@suse.de> wrote:
>> > > Framebuffer memory is allocated via vmalloc() from non-contiguous
>> > > physical pages. The physical framebuffer start address is therefore
>> > > meaningless. Do not set it.
>> > >=20
>> > > The value is not used within the kernel and only exported to userspa=
ce
>> > > on dedicated ARM configs. No functional change is expected.
>> > >=20
>> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> > > Fixes: a5b44c4adb16 ("drm/fbdev-generic: Always use shadow buffering=
")
>> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> > > Cc: Javier Martinez Canillas <javierm@redhat.com>
>> > > Cc: Zack Rusin <zackr@vmware.com>
>> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> > > Cc: Maxime Ripard <mripard@kernel.org>
>> > > Cc: <stable@vger.kernel.org> # v6.4+
>> > > ---
>> > >   drivers/gpu/drm/drm_fbdev_generic.c | 1 -
>> > >   1 file changed, 1 deletion(-)
>> > >=20
>> > > diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/d=
rm_fbdev_generic.c
>> > > index d647d89764cb9..b4659cd6285ab 100644
>> > > --- a/drivers/gpu/drm/drm_fbdev_generic.c
>> > > +++ b/drivers/gpu/drm/drm_fbdev_generic.c
>> > > @@ -113,7 +113,6 @@ static int drm_fbdev_generic_helper_fb_probe(str=
uct drm_fb_helper *fb_helper,
>> > >          /* screen */
>> > >          info->flags |=3D FBINFO_VIRTFB | FBINFO_READS_FAST;
>> > >          info->screen_buffer =3D screen_buffer;
>> > > -       info->fix.smem_start =3D page_to_phys(vmalloc_to_page(info->=
screen_buffer));
>> > >          info->fix.smem_len =3D screen_size;
>> > >=20
>> > >          /* deferred I/O */
>> > > --
>> > > 2.44.0
>> > >=20
>> > Good idea. I think given that drm_leak_fbdev_smem is off by default we
>> > could remove the setting of smem_start by all of the in-tree drm
>> > drivers (they all have open source userspace that won't mess around
>> > with fbdev fb) - it will be reset to 0 anyway. Actually, I wonder if
>> > we still need drm_leak_fbdev_smem at all...
>>=20
>> All I know is that there's an embedded userspace driver that requires th=
at
>> setting. I don't even know which hardware.
>
> The original Mali driver (ie, lima) used to require it, that's why we
> introduced it in the past.
>
> I'm not sure if the newer versions of that driver, or if newer Mali
> generations (ie, panfrost and panthor) closed source driver would
> require it, so it might be worth removing if it's easy enough to revert.
>

Agreed. The DRM_FBDEV_LEAK_PHYS_SMEM symbol already depends on EXPERT and
defaults to 'n', which implies that isn't enabled by most kernels AFAICT.

So dropping it and see if anyone complains sounds like a good idea to me.

> Maxime

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

