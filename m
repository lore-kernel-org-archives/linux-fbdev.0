Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37051C76188
	for <linux-fbdev@archiver.kernel.org>; Wed,  5 Apr 2023 11:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbjDELcb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 Apr 2023 07:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbjDELca (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 Apr 2023 07:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DC710D5
        for <linux-fbdev@vger.kernel.org>; Wed,  5 Apr 2023 04:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680694307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DdvlAOB2HBtoxdSNuZT4WKN+Yt+RUmrcPHkXhNSXjuo=;
        b=V/utAZpsmJU6IGmd9W4JhGNlydEp2iZsBMhjGWS7jtrsCFgVeRLHvelWEFpmZALaDz+xse
        CyzEg64vrr/rEPSqndPJdkPQbvrkveDPon9InKiEcE9cfqs/CrGNIOhmDP6UCqu9I4D381
        UIdweZfNjVgg+LLkee86DtPn2ukIm/8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-bPOyg5KiO0uvcwwMrZd23g-1; Wed, 05 Apr 2023 07:31:46 -0400
X-MC-Unique: bPOyg5KiO0uvcwwMrZd23g-1
Received: by mail-wm1-f71.google.com with SMTP id bi27-20020a05600c3d9b00b003ef6ee937b8so13812733wmb.2
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Apr 2023 04:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680694305;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DdvlAOB2HBtoxdSNuZT4WKN+Yt+RUmrcPHkXhNSXjuo=;
        b=G4F8SGbXm3bt6IZiAiPqQnVBlqUhFBj5xP7ZmXXqmQXpZkiBug+VVjxYGLqMbv9mlo
         z3Qn1KZgFA8q5pCtXaofloha5dLZgImAEGROLAzA2FVoqJ64oc/aeD4pNpk9vKGnS78n
         GBkcSQcpVOilTfsJhIYv6/eknI5R29uQyq+j9uYm80zI4jJ/PCLZ0DsHIb0Y/ts0y/S1
         l1hu2vtkbDydvsvlU30Rtai3qXIwRX0g/hVQMNmnr6XzeBKxuMmMsWwp9SiLpBqthvwY
         FP5wR8slIjVERRO4XPBVt+GrjGY+d0gA808UGga46XxP1XzMxoD/CQv5D8ovO4xG8wN5
         +Vhg==
X-Gm-Message-State: AAQBX9e95Z2gm9DupeG4oWP9v/bBSkJkh8sGfhDnaTAqUHS5/eQgWDtg
        q2Dm9eIRCJPjfJb7n5ZtxgrVyR6T/astK6lydzmHXMMev2Bs18WlGreopGR7qrRAf3GyGFUJrib
        ETiE3HYDWhx1Hjiqfk29CI14=
X-Received: by 2002:a05:600c:22d6:b0:3eb:2da5:e19 with SMTP id 22-20020a05600c22d600b003eb2da50e19mr4612741wmg.27.1680694305744;
        Wed, 05 Apr 2023 04:31:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350bgJR+9jItxcQrvJsguKxNFfDjUdTz+JTjRLTm6qB71szWLKTQghclWZR4h05St1GZL+1Uwmg==
X-Received: by 2002:a05:600c:22d6:b0:3eb:2da5:e19 with SMTP id 22-20020a05600c22d600b003eb2da50e19mr4612726wmg.27.1680694305488;
        Wed, 05 Apr 2023 04:31:45 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c210d00b003f0373d077csm1879783wml.47.2023.04.05.04.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:31:45 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 4/8] video/aperture: Only kick vgacon when the pdev is
 decoding vga
In-Reply-To: <20230404201842.567344-4-daniel.vetter@ffwll.ch>
References: <20230404201842.567344-1-daniel.vetter@ffwll.ch>
 <20230404201842.567344-4-daniel.vetter@ffwll.ch>
Date:   Wed, 05 Apr 2023 13:31:44 +0200
Message-ID: <87y1n6bm5b.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Daniel Vetter <daniel.vetter@ffwll.ch> writes:

> Otherwise it's bit silly, and we might throw out the driver for the
> screen the user is actually looking at. I haven't found a bug report
> for this case yet, but we did get bug reports for the analog case
> where we're throwing out the efifb driver.
>
> v2: Flip the check around to make it clear it's a special case for
> kicking out the vgacon driver only (Thomas)
>
> References: https://bugzilla.kernel.org/show_bug.cgi?id=216303
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> ---
>  drivers/video/aperture.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

