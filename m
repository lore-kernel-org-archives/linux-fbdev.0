Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FE6C7619A
	for <linux-fbdev@archiver.kernel.org>; Wed,  5 Apr 2023 11:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbjDELez (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 Apr 2023 07:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237538AbjDELew (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 Apr 2023 07:34:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF91E1BD7
        for <linux-fbdev@vger.kernel.org>; Wed,  5 Apr 2023 04:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680694445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tk18jdSB5PL8M24Q9AEmOWNrBMpUmu7JVWWnzwGtR04=;
        b=RDMjBTgdBtqnOTiuirzqkZHhUhdhZuFVUIagDHmYI22DiD4yMunu7FaHJQ9ZiD6bwt/z6m
        yX+JypsrXC+bqjT2qooTifsaiDQzESL3F3sdBPCHNOF9X0Wx/v8Kjd72wMPYbSd1uaLDLh
        acAe54bGdLJ3nYk9AAb8ya/NH8EKLm4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-YGluW66GPKqJVYFHNnbR2A-1; Wed, 05 Apr 2023 07:34:03 -0400
X-MC-Unique: YGluW66GPKqJVYFHNnbR2A-1
Received: by mail-wm1-f69.google.com with SMTP id bg33-20020a05600c3ca100b003ef6d684105so14730815wmb.1
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Apr 2023 04:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680694442;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tk18jdSB5PL8M24Q9AEmOWNrBMpUmu7JVWWnzwGtR04=;
        b=gJNrV6X8kwAsQBNRM0h27O1VL+krwMVhaM3RnFPvk7YLXQ4LAKjnbSERZMKK3DaSCK
         Wq8xzvanmJMx2XStmAU1asl2kId5GCyuvUojw0MYwk0cBZNJRjcNys4UFmAcAULMKn4l
         sUQJtVajNhFQoHhy5plCYOKMknvyfMKCc8LrSr9e44A1ZokDH8L7+X02Nj8qmBThWIyb
         W3rKUUPKf7jSFbRjIBK/km72Pv6eXRYYyms1kG/VeTOB+exjNgqy5fyAUwAVJ2zzqbaa
         q0U36VUy+6UCKDOprf0QBCkhLowufIYJF2ICG8HSx0DcDoXunvdxYZ/aTaTnxIsUXv3L
         CtxQ==
X-Gm-Message-State: AAQBX9eHAFz+Y30ILCAYclScnlKBYsJUoIcDigopGDyAKZVNehdiBgpp
        8D+M0hZe0rD5b3l+WNdwY/SW/NRd74jnMvrtUTFOcpgpw7X6DEUqtPRi7Q9OuXCkXEkda6rnwXN
        hNLSfzwd0D6u50IdwV69Tbks=
X-Received: by 2002:adf:f2d1:0:b0:2cf:f0c3:79ba with SMTP id d17-20020adff2d1000000b002cff0c379bamr3508285wrp.67.1680694442710;
        Wed, 05 Apr 2023 04:34:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350YUjKA961Ix1B03KyblFGKgk9FaYELj3MXThs4Hw8qWQfuaORfFYONMGsntnJe5AvWYZuwF8A==
X-Received: by 2002:adf:f2d1:0:b0:2cf:f0c3:79ba with SMTP id d17-20020adff2d1000000b002cff0c379bamr3508272wrp.67.1680694442440;
        Wed, 05 Apr 2023 04:34:02 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u17-20020adfed51000000b002c6e8af1037sm14710349wro.104.2023.04.05.04.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:34:02 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 5/8] video/aperture: Move vga handling to pci function
In-Reply-To: <20230404201842.567344-5-daniel.vetter@ffwll.ch>
References: <20230404201842.567344-1-daniel.vetter@ffwll.ch>
 <20230404201842.567344-5-daniel.vetter@ffwll.ch>
Date:   Wed, 05 Apr 2023 13:34:01 +0200
Message-ID: <87v8iabm1i.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Daniel Vetter <daniel.vetter@ffwll.ch> writes:

> A few reasons for this:
>
> - It's really the only one where this matters. I tried looking around,
>   and I didn't find any non-pci vga-compatible controllers for x86
>   (since that's the only platform where we had this until a few
>   patches ago), where a driver participating in the aperture claim
>   dance would interfere.
>
> - I also don't expect that any future bus anytime soon will
>   not just look like pci towards the OS, that's been the case for like
>   25+ years by now for practically everything (even non non-x86).
>
> - Also it's a bit funny if we have one part of the vga removal in the
>   pci function, and the other in the generic one.
>
> v2: Rebase.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> ---
>  drivers/video/aperture.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

