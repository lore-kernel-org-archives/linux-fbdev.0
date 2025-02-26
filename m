Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B22153D5
	for <linux-fbdev@vger.kernel.org>; Wed, 26 Feb 2025 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571533; cv=none; b=VNn7s0vp/EgRaVmWBGzxYOtPKj6rABxwWAn4nw3DXq81bIJV0Um9HcixvaqWWgRqx/SiVKI+OAKjAz1p4mTcluxGLt4q7ov0dvpyNfi4CXbQVZS++uVdDhHQgTDe4vKs4r3a/sPPIRvra1inh0Y2uq8s7eq0+xjHAx8FJAY6ZMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571533; c=relaxed/simple;
	bh=fP0sGdp3jpwxy/Pb8vlYK55k1s7gQsE0DIkSN6h8f5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O3Qj1pTTTs+boNPKaYhfQ9x5fV1msHS9AppBMuI1Y+2q2bS6Xsj4MgWJZPhSZsOSuJNH1jksWsqVfqUXV4EQTKMxlAZAyCRzNcPbTGc7yDrHhcL9PFXfEEG5LhNpEINJoqDuWegroYtgCCs2snfyx5kVqpbWYqahzd1bEN6oWSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/Arcw3C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/Arcw3C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740571531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZONKr8gjSUHK5a82Fy5e7G5ZxvpLwOBguDakYGue1KI=;
	b=A/Arcw3CKGtHdUGEQcRIIrB/LkSI+QARDZFhzWrojTYJ17NsiYSsGreD9IYSqOzZL8PZQA
	Qezj67UG9MOISmyTYfnm5TqlrJfNSDXsWC3qzm4gH8Kd77csAXIQ9mFTvkycI6/Zr9QyoU
	joPv3TBaLt9wj4ygW4tzAPb8p9/wtP4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-vAFd4VvuO_6JMZhTunvtmA-1; Wed, 26 Feb 2025 07:05:29 -0500
X-MC-Unique: vAFd4VvuO_6JMZhTunvtmA-1
X-Mimecast-MFC-AGG-ID: vAFd4VvuO_6JMZhTunvtmA_1740571529
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394c747c72so28665935e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Feb 2025 04:05:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740571528; x=1741176328;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZONKr8gjSUHK5a82Fy5e7G5ZxvpLwOBguDakYGue1KI=;
        b=NAjeAsBw3rJ7TemgGNEYDsLKRM1kfjUJI8Aal9hxNyAvNLsIG+7vnPxcCktEodPGs/
         iEkSEgMiu4u4E0tVQMYVyOKBG4q48otbc08R/CFuMrsIvWhkPi/pvgMxHi4V3gI7HdNm
         F6HrMisFkEtj39pzVOC7cJxFMBnbFA7ZMLi516+6Ra5Z4OSUDzgqfA4Qw0fJEARj4OLO
         fl+Ig/cONlQBGgXix9L9r4keA1GVc3KIDWhra/ujVyHcj7LVNS4k04ke4bcTX/e2wcpB
         5++FGG0twKnl9Apkc2gDsXdNAZx5Cl6bbxaPNXXp3EwP5+aMseS0jgeTGO6YZk/7PjvU
         ON/w==
X-Gm-Message-State: AOJu0YwcPHq2+622b8wCAcKYIMiaScwKPZ7oxFWgKfpG7lJI3SSX+mAk
	DQG7n9DF3r7ToZXi+bhuwXZylmB1VNfbIyumPf9vQpxQwZRY6N4EaDMfDJYfpMPoXqETcZ3RhSm
	OWl+BG7k/GYJ+8XYXgisPBfozKf2q8yvNjyW4xicaOdNOe4E5VY9xrdZdH/DLcKdDBBdD
X-Gm-Gg: ASbGncuC/l5mVvUjpv1O7Jd+2Mk3lW9KspBvthgO+s/GV7KCwE3sqKSpfZ2DfUb8Ma0
	NXyMKQLMPdzkZ3bs9VAOuwIyua/XLsHToQJ87Ig0UavykczpDRaG2w22ivWyJ6N5JLd6dW2a/YZ
	7AkKiyfa447N3N2W6j1A/TIskFqzZVNjXcJ4DV2AsMgA2Q3562yKt4KUPADvZIFu2vlSfdyUeZD
	x++OKCqPtgL+PmVX6I80UhOLEM5IfEd/O1YJc3gbvmcnMbaqbqheQU46C0CpyzLNxPcBkAJ3V3K
	P9TiFnPpgnY0Q9Wo4quoDZPDDJPUEdCuZWs/XE0JZ2a2tfZvXQU6p725eQ7PQMMvncP0LVtVrQ=
	=
X-Received: by 2002:a05:600c:458e:b0:439:91dd:cfa3 with SMTP id 5b1f17b1804b1-439ae221d72mr172909785e9.29.1740571528148;
        Wed, 26 Feb 2025 04:05:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnrm0qM7DRHfCVZy3zVClFVQEZc0d79QmfHyW/xrSQhIhkvownRWDY6I4pd1YTGG105oIX1w==
X-Received: by 2002:a05:600c:458e:b0:439:91dd:cfa3 with SMTP id 5b1f17b1804b1-439ae221d72mr172909435e9.29.1740571527760;
        Wed, 26 Feb 2025 04:05:27 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5871f4sm19373245e9.39.2025.02.26.04.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 04:05:26 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Arnd Bergmann <arnd@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dummycon: only build module if there are users
In-Reply-To: <79d35e3b-9a0d-41a5-ab07-797bfa1e19cb@app.fastmail.com>
References: <20250225164436.56654-1-arnd@kernel.org>
 <4d047af3-fd30-4fa4-aa3d-c0359856d750@suse.de>
 <a2c0e681-2cdf-4dc9-82fc-be35f54ff795@app.fastmail.com>
 <29ecc7c4-2887-4989-a1d3-aa76b44c0387@suse.de>
 <79d35e3b-9a0d-41a5-ab07-797bfa1e19cb@app.fastmail.com>
Date: Wed, 26 Feb 2025 13:05:23 +0100
Message-ID: <87mse8zzb0.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arnd Bergmann" <arnd@arndb.de> writes:

Hello Arnd,

> On Wed, Feb 26, 2025, at 09:16, Thomas Zimmermann wrote:
>> Am 26.02.25 um 08:55 schrieb Arnd Bergmann:
>> Here's another general question. vgacon and fbcon only seem usable with 
>> CONFIG_VT=y. Wouldn't it make sense to have them depend on CONFIG_VT=y? 
>> dummycon could then be implemented as part of the vt code, maybe even 
>> become a vt-internal thing. The console code is complex, so I'm probably 
>> missing something here?
>
> I think in theory one may have a system use fbcon purely to get the
> boot logo, but not actually support VT.  I had also assumed there might
> be a way to use fbcon as the console (i.e. printk) but not register
> the tty, but it looks like the console code still requires vt.
>
> After I looked at the vt and conswitchp code some more, I wonder
> if we could go the other way and instead of integrating it more
> make the conswitchp logic optional: most of the complexity here
> deals with switching between text console and fbcon dynamically,
> but having any text console support is getting very rare (vga
> on alpha/mips/x86-32, newport on mips-ip22, sti on parisc).
>
> If we do this, the conswitchp code could be merged with dummycon

This sounds like a much better approach indeed.

> in drivers/video/console, with the simpler alternative just
> calling into fbcon functions. I'm not sure if we can already drop
> vgacon from normal x86-64 distro configs, i.e. if there are cases
> that are not already covered by any of efi-earlycon, efifb,
> vga16fb, vesafb/uvesafb or a PCI DRM driver.
>

I believe vgacon is still useful for x86 with legacy BIOS, because
vesafb (and simpledrm) only works if the user defines a mode using
the vga= kernel cmdline parameter.

>     Arnd
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

