Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605C0C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Feb 2022 00:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239439AbiBIATd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Feb 2022 19:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbiBIATc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Feb 2022 19:19:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 293F6C061576
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Feb 2022 16:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644365970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+YfCnyxSCyr5vTP3YrAazeA9ULAGVzys2UZvocNOmGA=;
        b=Ts/dEPbO4woQGpfsghSDXDVZZcF6vJYScE/pVW/51pxVWgkGludc3wgQWCim0q/6VARIWO
        //IsO0R22hcVMmGJGw6bOrtlvUM8FOQzmwFq6C4vBVrrkJ2RJUZbD1KdvXAig1aum1Fs68
        AM0FISoNSkHLVZYrMzzRTmDy32FLsoQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-JaOIoZW3NvmMYAwPnz6wZA-1; Tue, 08 Feb 2022 19:19:29 -0500
X-MC-Unique: JaOIoZW3NvmMYAwPnz6wZA-1
Received: by mail-wm1-f70.google.com with SMTP id v185-20020a1cacc2000000b0034906580813so1823746wme.1
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Feb 2022 16:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+YfCnyxSCyr5vTP3YrAazeA9ULAGVzys2UZvocNOmGA=;
        b=v9+KR0ItqWmS0J67EnyubMXu88oeJ/pZAy2fS1m8lu4L12sm2k2yOcuyOjp58z+fgJ
         5Yhe+aml2qIl0RmCGpPpsAcdIU2ie7KiUBu/mbnHFaNVgNZpDF5hScaY2HkBQTdO0KzF
         /IFFCV7s7Xh+5cif2US6TzvqKlJC3sq4HRpE59pxUyLqvlAJR4pGFXsmrO4Ai1D+3jbI
         WfTwtRVIJZQtR6OJPWrxNMDvVh3giMzZxV/PId9T25LqHdkjuamXpzK2E42AxczLu8CP
         e5GeZwQd4RHnT6cY3ZyMESj/i96SNXxoAuOnwnfgzvLjbDHXmv0BG+k1bRsWiqJaREqS
         IHzg==
X-Gm-Message-State: AOAM530icuVqaBwm8QSi9+raPUesXjiMg05xpMLOWz4yLkDTDzPs3mmt
        HmGLKkHZzBjyU4XCujkAczT/q7Ni/y+f6htrWQHh9/mPSI1jjLHeruRQrD9a89rwE5iEOGnY8nj
        RS17NjBjYbwj7MsWlOohkMeY=
X-Received: by 2002:a05:6000:1363:: with SMTP id q3mr272615wrz.468.1644365968108;
        Tue, 08 Feb 2022 16:19:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwA2Lg39k9Sbo0xLJ5uWj2LvpSd71eFqK97Wop1ro0TUcBQLjaot/weyoE5zyFF03j8y59UbA==
X-Received: by 2002:a05:6000:1363:: with SMTP id q3mr272596wrz.468.1644365967877;
        Tue, 08 Feb 2022 16:19:27 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n26sm3877837wms.13.2022.02.08.16.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 16:19:27 -0800 (PST)
Message-ID: <4ae20b63-f452-fdb4-ced6-d4968a8d69f0@redhat.com>
Date:   Wed, 9 Feb 2022 01:19:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 18/19] Revert "fbdev: Prevent probing generic drivers
 if a FB is already registered"
Content-Language: en-US
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Zack Rusin <zackr@vmware.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Jones <pjones@redhat.com>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
 <20220208210824.2238981-19-daniel.vetter@ffwll.ch>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220208210824.2238981-19-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/8/22 22:08, Daniel Vetter wrote:
> This reverts commit fb561bf9abde49f7e00fdbf9ed2ccf2d86cac8ee.
> 
> With
> 
> commit 27599aacbaefcbf2af7b06b0029459bbf682000d
> Author: Thomas Zimmermann <tzimmermann@suse.de>
> Date:   Tue Jan 25 10:12:18 2022 +0100
> 
>     fbdev: Hot-unplug firmware fb devices on forced removal
> 
> this should be fixed properly and we can remove this somewhat hackish
> check here (e.g. this won't catch drm drivers if fbdev emulation isn't
> enabled).
>

Unfortunately this hack can't be reverted yet. Thomas' patch solves the issue
of platform devices matched with fbdev drivers to be properly unregistered if
a DRM driver attempts to remove all the conflicting framebuffers.

But the problem that fb561bf9abde ("fbdev: Prevent probing generic drivers if
a FB is already registered") worked around is different. It happens when the
DRM driver is probed before the {efi,simple}fb and other fbdev drivers, the
kicking out of conflicting framebuffers already happened and these drivers
will be allowed to probe even when a DRM driver is already present.

We need a clearer way to prevent it, but can't revert fb561bf9abde until that.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

