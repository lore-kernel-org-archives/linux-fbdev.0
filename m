Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F5A8F5E
	for <linux-fbdev@vger.kernel.org>; Mon, 22 Jul 2024 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721657584; cv=none; b=QoZh0iu2uepPRBsBsO6onbiJiMMFQxwad9ENicxu9sG+6xsGRh1sh+OK3U3DH+6EyizavcxB6aA8iQu6InX01ul8uj0R2RgD1GCCdGt67wTLy8dlSqy9k8uxtVVl+YnIts4s9t3DztndDsP3G7fGvG5JM2zwc287cZtf/HXzR6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721657584; c=relaxed/simple;
	bh=Ac0ZVFezlunGPwPXMVZW5bxBBc/RGcpHkhCF3Mu5yoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bU/th6Vd/L8UaQXaO7qMnSbSJ8FwYc4Q+wMeHznxWRPkZ0IgBKYjiOISvw/XjzXpfsoQGKA84lFhQGuLCNdki7nTh3ucwLTzKLDCyoDGVJ5r9NvpoKGGTqIL4vKtQjJj49SVgMDGlZyPKRkMu5XrPhBPXwF3WbPd+L40Y/uoSeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=giUCwqx5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="giUCwqx5"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42111cf2706so5035555e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Jul 2024 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1721657581; x=1722262381; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Tgbm5Spa6iNkRq2Ux0zzj+WvaN7ol/xJ5I1VMsf8wA=;
        b=giUCwqx5TOsMiiOYTyefyb54PRX1ac9GYkm+BaIVksZx6VEOTWewc9yyT07Z6KQ8dF
         NYfEWPhJ+GLgPwvNKu/lFiVImFNAb+XcI/hCc2qTsBr1YBuzwKFFtswrKwUQ3Afa+WDi
         IUFMEkVaESZkdO+rh2M4DtWWJosj/3FizblLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721657581; x=1722262381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Tgbm5Spa6iNkRq2Ux0zzj+WvaN7ol/xJ5I1VMsf8wA=;
        b=KjRrIXy0uCnUyYFriUJ/rYbhBvab0+fbICy9uGKcwqbCGcy3CtRKChNGi5cIeb5DFb
         QW95figqQEdyMqS7iqdLD5OrtrpqYFivgbeIz/dQRpK6Q0veUBv5+nBklw+xHHGF7dCY
         17gb7lltwxmPtfM216OY9PjyCN/KI5mMAYCuiD/uIB8hkelHT/98v6xmDOATvp1+tx1G
         F1kitWkUteJ04+x74vyelGNzYifHML9VIlXVrqOzglinqcOg+z+zTZ2KieHCQW14YR6u
         yJDwyT0kUgBVz0o2aNb4KlPKdLsYDbT29kj4NIi9fXbJ61FJgkB0/kqOSKlJTKRRmbkt
         fMpw==
X-Forwarded-Encrypted: i=1; AJvYcCVeHQcRjlFLLh2IlZqIZrCpLN7ct0vGGLySE0WHzCGxW2hW/xcPxVCq2ths+FqXd8vYpmBkWErJsfTORyGErz3gPXmD48WypVWiCZw=
X-Gm-Message-State: AOJu0YxVqlAySUaY3Pj/YgNXLiDPGLhDI3dnPF2oUhHdVmMuIGOaWz6c
	eEScYKXQpozO6gVfTmJ0gab+K6O2ekZkbrLGWX7us0ZeKBkM1hk+o/5vH65AB8Q=
X-Google-Smtp-Source: AGHT+IEWsvPxVi7zS2plkJNlwJ+meC0H3C4mcFP8YEp/srMJx9fmtOr9AjHG6UxguTL2eGdmswxsrw==
X-Received: by 2002:a05:600c:4f4b:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-427daa927f5mr33298725e9.5.1721657580586;
        Mon, 22 Jul 2024 07:13:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d6901781sm129162825e9.14.2024.07.22.07.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 07:12:59 -0700 (PDT)
Date: Mon, 22 Jul 2024 16:12:57 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/panic: Add drm_panic_is_enabled()
Message-ID: <Zp5o6fnBuTlxm-X_@phenom.ffwll.local>
Mail-Followup-To: Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
References: <20240717090102.968152-1-jfalempe@redhat.com>
 <20240717090102.968152-2-jfalempe@redhat.com>
 <ZpfeiMj48JQTQcOE@phenom.ffwll.local>
 <34305c58-38a6-4b5a-9777-69833aefa003@redhat.com>
 <60419d31-f467-4277-97da-23c9573af2bf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60419d31-f467-4277-97da-23c9573af2bf@redhat.com>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Thu, Jul 18, 2024 at 11:30:05AM +0200, Jocelyn Falempe wrote:
> 
> 
> On 18/07/2024 09:04, Jocelyn Falempe wrote:
> > 
> > 
> > On 17/07/2024 17:08, Daniel Vetter wrote:
> > > On Wed, Jul 17, 2024 at 10:48:39AM +0200, Jocelyn Falempe wrote:
> > > > It allows to check if the drm device supports drm_panic.
> > > > Prepare the work to have better integration with fbcon and vtconsole.
> > > > 
> > > > Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> > > > ---
> > > >   drivers/gpu/drm/drm_panic.c | 20 ++++++++++++++++++++
> > > >   include/drm/drm_panic.h     |  2 ++
> > > >   2 files changed, 22 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> > > > index 948aed00595e..d9a25c2d0a65 100644
> > > > --- a/drivers/gpu/drm/drm_panic.c
> > > > +++ b/drivers/gpu/drm/drm_panic.c
> > > > @@ -703,6 +703,26 @@ static void debugfs_register_plane(struct
> > > > drm_plane *plane, int index)
> > > >   static void debugfs_register_plane(struct drm_plane *plane,
> > > > int index) {}
> > > >   #endif /* CONFIG_DRM_PANIC_DEBUG */
> > > > +/**
> > > > + * drm_panic_is_enabled
> > > > + * @dev: the drm device that may supports drm_panic
> > > > + *
> > > > + * returns true if the drm device supports drm_panic
> > > > + */
> > > > +bool drm_panic_is_enabled(struct drm_device *dev)
> > > > +{
> > > > +    struct drm_plane *plane;
> > > > +
> > > > +    if (!dev->mode_config.num_total_plane)
> > > > +        return false;
> > > > +
> > > > +    drm_for_each_plane(plane, dev)
> > > > +        if (plane->helper_private &&
> > > > plane->helper_private->get_scanout_buffer)
> > > > +            return true;
> > > > +    return false;
> > > > +}
> > > > +EXPORT_SYMBOL(drm_panic_is_enabled);
> > > 
> > > This feels like overkill since you currently only have one user in the
> > > fbdev emulation code, but maybe useful in some other places ...
> > > 
> > > > +
> > > >   /**
> > > >    * drm_panic_register() - Initialize DRM panic for a device
> > > >    * @dev: the drm device on which the panic screen will be displayed.
> > > > diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
> > > > index 73bb3f3d9ed9..c3a358dc3e27 100644
> > > > --- a/include/drm/drm_panic.h
> > > > +++ b/include/drm/drm_panic.h
> > > > @@ -148,11 +148,13 @@ struct drm_scanout_buffer {
> > > >   #ifdef CONFIG_DRM_PANIC
> > > > +bool drm_panic_is_enabled(struct drm_device *dev);
> > > 
> > > Since it's internal only, this should be in
> > > drivers/gpu/drm/drm_crtc_internal.h and not int he include for drivers.
> > 
> > Yes, that makes sense, drivers won't need that API.
> > 
> > > With that:
> > > 
> > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > 
> > > >   void drm_panic_register(struct drm_device *dev);
> > > >   void drm_panic_unregister(struct drm_device *dev);
> > > 
> > > These two are only used in drm.ko. Can you please move them to
> > > drm_crtc_internal.h too and drop the EXPORT_SYMBOL in a follow-up patch?
> > > We're trying to limit the exported interface and official headers to
> > > really only the pieces drivers actually need.
> > 
> > Sure, I'll add this to my next drm_panic series.
> 
> I think this also applies to drm_panic_init() and drm_panic_exit(), that I
> introduce in my QR code series:
> https://patchwork.freedesktop.org/patch/604890/?series=135944&rev=2
> I will move them to drm_crtc_internal.h

Yup.
-Sima

> 
> > 
> > > 
> > > Thanks, Sima
> > > 
> > > >   #else
> > > > +bool drm_panic_is_enabled(struct drm_device *dev) {return false; }
> > > >   static inline void drm_panic_register(struct drm_device *dev) {}
> > > >   static inline void drm_panic_unregister(struct drm_device *dev) {}
> > > > -- 
> > > > 2.45.2
> > > > 
> > > 
> > 
> > Best regards,
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
