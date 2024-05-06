Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323771E4AE
	for <linux-fbdev@vger.kernel.org>; Mon,  6 May 2024 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715001276; cv=none; b=avj++VLv+00qsmUfeKZc6PqkP+4usBX5t/Xoa+Cem9oWdneaxcMyUVpUZJdmJWfFzI/+wT7XBHCGYJvaNhhIixAUpuSMsfjclE3trX7MBCMrOXyJw1rQscQIl0AqDkTJsb2heOyERj/P5JuDuz7Mb5PYsvuhpselv53tO97EcKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715001276; c=relaxed/simple;
	bh=gQDbGwiGhGoP1FOYKZMRGyg3IPE71RSmNCxYCNoPegI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgHOOwkPRZVtYVOrKLORrpmAYb3MniWtdQGJW8dM45ohP3yFzefLNSSmG1JDIlRbOM62Mof/x3bNw4RGk2bghK0R6RiFbRmwlQ6UQUX7ebwBmzJfaIXfe5CLjEHVQL52fq4YsfIxhW4fLulqNsk464yZNE6J/oSIxmsYjSBNFrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Wqx8Dz/m; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Wqx8Dz/m"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e2da49e86bso3862471fa.0
        for <linux-fbdev@vger.kernel.org>; Mon, 06 May 2024 06:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1715001271; x=1715606071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcGOVp9unOUJdofB/8SfIMCkzzBFqbYaTzZjCQ22Ceo=;
        b=Wqx8Dz/mwAjHGehNZjDnhN7qsDlU2olQu2jVflmbgm5ZpcQwNhD7HEM4GQCuQD6YhV
         9+ZTxidPDFEXmlmNA+TLWQRqrDsfEUzccZqVVQ0TXIp4WP963+cYs2HBqdmvRgPItc/T
         ORACGmdSTeK1leltDcZFnK6nta9yf+B6+Olpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715001271; x=1715606071;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcGOVp9unOUJdofB/8SfIMCkzzBFqbYaTzZjCQ22Ceo=;
        b=Js0R8o2XAvhEKDMAUfRPtrLNWailtOgF/gK977lvP1LdMBZ6FBPgqr0CMJpKQl3sSC
         q9nKj98WdPY+zcrywvC8DIw6oCF1biEBGkwwhPHTs61MUH19S5NJNenF2c0bR7jh0uFt
         D7a1KPoBWYhk70rWvjbmgpqYNICCt0N7HvoBJ3f7nCuNFiCNWiV3NYJ080SzW+jD9LNn
         7u6e169+Loo/+/JU6PFmHe2QQy9e6bAc7rdTlbKS009dCrvo88nLwGUDLXUsrW0oVPdB
         WIHW9rO9R84EU7pWP19WeRzPvSuqkNAOshPA4n1LBA6jXsAdUqKDsi386ZftP95pA04q
         /nsw==
X-Forwarded-Encrypted: i=1; AJvYcCUmZyqq2/kleML1Zxs+Drbo/Acr90dYB8RflD8yynhhCRRE+Knru30SjNvZNokvfgLUhf69BhjvqBKyGDBRxCDcCSKyWnhCrvRyf34=
X-Gm-Message-State: AOJu0Yxz/J9wUdlC/zVuQH8c3DYJgHcEqZ9Gn942lOnmtuXOdQl0Gdu0
	QWnm4W+zO8h/cg8ndJOarJi0KaKPnUIYFuGv1X5kfdvtOSf2dp0Ai+tjdTYWkns=
X-Google-Smtp-Source: AGHT+IGi/la6Qcz7XisPeA2mbmqeuLa+J0eHqdFBkqiw++9QIWvkPyhu9oI7nfBs0pbXiB2cPZJTyA==
X-Received: by 2002:a2e:97c5:0:b0:2e3:ba0e:de02 with SMTP id m5-20020a2e97c5000000b002e3ba0ede02mr494955ljj.5.1715001271237;
        Mon, 06 May 2024 06:14:31 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c469100b0041b083e16e2sm19958456wmo.2.2024.05.06.06.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 06:14:30 -0700 (PDT)
Date: Mon, 6 May 2024 15:14:28 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	"open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
	"open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] fbdev: Have CONFIG_FB_NOTIFY be tristate
Message-ID: <ZjjXtEwWWZX43c6l@phenom.ffwll.local>
Mail-Followup-To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	"open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
	"open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>
References: <20240503192858.103640-1-florian.fainelli@broadcom.com>
 <8e1867fc-34da-457c-b95a-2d51ea97336a@app.fastmail.com>
 <05a5e893-12f7-49fd-9a9a-abd387571f9b@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05a5e893-12f7-49fd-9a9a-abd387571f9b@broadcom.com>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Fri, May 03, 2024 at 01:22:10PM -0700, Florian Fainelli wrote:
> On 5/3/24 12:45, Arnd Bergmann wrote:
> > On Fri, May 3, 2024, at 21:28, Florian Fainelli wrote:
> > > Android devices in recovery mode make use of a framebuffer device to
> > > provide an user interface. In a GKI configuration that has CONFIG_FB=m,
> > > but CONFIG_FB_NOTIFY=y, loading the fb.ko module will fail with:
> > > 
> > > fb: Unknown symbol fb_notifier_call_chain (err -2)
> > > 
> > > Have CONFIG_FB_NOTIFY be tristate, just like CONFIG_FB such that both
> > > can be loaded as module with fb_notify.ko first, and fb.ko second.
> > > 
> > > Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > 
> > I see two problems here, so I don't think this is the right
> > approach:
> > 
> >   1. I don't understand your description: Since fb_notifier_call_chain()
> >      is an exported symbol, it should work for both FB_NOTIFY=y and
> >      FB_NOTIFY=m, unless something in Android drops the exported
> >      symbols for some reason.
> 
> The symbol is still exported in the Android tree. The issue is that the GKI
> defconfig does not enable any CONFIG_FB options at all. This is left for SoC
> vendors to do in their own "fragment" which would add CONFIG_FB=m. That
> implies CONFIG_FB_NOTIFY=y which was not part of the original kernel image
> we build/run against, and so we cannot resolve the symbol.
> 
> This could be resolved by having the GKI kernel have CONFIG_FB_NOTIFY=y but
> this is a bit wasteful (not by much since the code is very slim anyway) and
> it does require making changes specifically to the Android tree which could
> be beneficial upstream, hence my attempt at going upstream first.

Making fbdev (the driver subsystem, not the uapi, we'll still happily
merge patches for that) more useful is really not the upstream direction :-)

> IMHO it makes sense for all subsystem supporting code to be completely
> modular or completely built-in, or at least allowed to be.
> 
> > 
> >   2. This breaks if any of the four callers of fb_register_client()
> >      are built-in while CONFIG_FB_NOTIFY is set to =m:
> 
> Ah good point, I missed that part, thanks, adding "select FB_NOTIFY" ought
> to be enough for those.
> 
> > 
> > $ git grep -w fb_register_client
> > arch/arm/mach-pxa/am200epd.c:   fb_register_client(&am200_fb_notif);
> > drivers/leds/trigger/ledtrig-backlight.c:       ret = fb_register_client(&n->notifier);
> > drivers/video/backlight/backlight.c:    return fb_register_client(&bd->fb_notif);
> > drivers/video/backlight/lcd.c:  return fb_register_client(&ld->fb_notif);
> > 
> > Somewhat related but not directly addressing your patch, I wonder
> > if Android itself could migrate to using FB_CORE=m FB=n FB_NOTIFY=n
> > instead and use simpledrm for the console in place of the legacy
> > fbdev layer.
> 
> That is beyond my reach :)

This one is. And it doesn't need to be simpledrm, just a drm kms driver
with fbdev emulation. Heck even if you have an fbdev driver you should
control the corresponding backlight explicitly, and not rely on the fb
notifier to magical enable/disable some random backlights somewhere.

So please do not encourage using this in any modern code.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
