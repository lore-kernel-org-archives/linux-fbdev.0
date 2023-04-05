Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A3EC7619A
	for <linux-fbdev@archiver.kernel.org>; Wed,  5 Apr 2023 11:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbjDELhB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 Apr 2023 07:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236967AbjDELhA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 Apr 2023 07:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE52C5B9D
        for <linux-fbdev@vger.kernel.org>; Wed,  5 Apr 2023 04:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680694564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w+DpvBDLH+Q2wPQSf5T5cg/6dNPP/wKGiFxJjQmEyog=;
        b=IxiXzVH1pPYRcK+6rSSimcWB6C9QxFOiWK0gXNGhrVrYKmDuPodPvLymsab9lzhRJk6fHj
        oercBs/cBIcx0x3jis+gVMqc4Up6VdJGkfl6EWU6VKVsVtzrdheTdaLmRfYyqayyrD3Hoy
        2A7fxB77OVxc9LdckrOaEPmiAKsrrFM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-aSM7my9iNumpvHgJvCGncg-1; Wed, 05 Apr 2023 07:36:02 -0400
X-MC-Unique: aSM7my9iNumpvHgJvCGncg-1
Received: by mail-wm1-f72.google.com with SMTP id d11-20020a05600c34cb00b003ee89ce8cc3so17024461wmq.7
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Apr 2023 04:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680694562;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+DpvBDLH+Q2wPQSf5T5cg/6dNPP/wKGiFxJjQmEyog=;
        b=GdXXtEgMiMzlwxy4yrLHbcWTfh1cd/o49S7GAZwfMy4ZvgJFLwpolXkxHC9ZZMXZ59
         9G3Fai+veFAXzpnJ7j9YrbVvsGDIl/TNIYAiAqMId4dvU5qA5xikqfJGkGZLpxGNopMn
         ZA3jV0Z3UAtmu7BJsx9Iwv8LmqKwuko3YE5VvjxF6cCukc2BRLlUBEOct/57+SvbKGA4
         W15IVs9F49DbDp/jQp1u4v0oy5CukM9NqDVy+GdZUMl/DcVIFDP3VgQjP/Bu2AJPuveH
         q27mi7Je/GmZb9jcd9gR94ouFc8a9emElFjM51tjCNqurvnhgSGou6Gj6geMEiiixeb/
         cCtg==
X-Gm-Message-State: AAQBX9dUhxhs5GA7HJcT0jnR36gOn32cfZDzoaWhuticzQp6rst5DiuX
        xkNB77yZZXYNL6XEjOcU9o8hCMIrBHgUc+fx5Zj7rA9sKlqfPmlqIsR+jwFTdmnZJg2CXBx915b
        t06n9b0G26jyIVnPv4MdgRXc=
X-Received: by 2002:a05:600c:2312:b0:3ef:6396:d9c8 with SMTP id 18-20020a05600c231200b003ef6396d9c8mr4156036wmo.5.1680694561793;
        Wed, 05 Apr 2023 04:36:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350bVORkVRtNCVnhi+nkM7YfPRljFYApx+IgQsLCU6O8KIvYjIzhapPCjaV21ZdY+Tdfz0i9VhA==
X-Received: by 2002:a05:600c:2312:b0:3ef:6396:d9c8 with SMTP id 18-20020a05600c231200b003ef6396d9c8mr4156021wmo.5.1680694561477;
        Wed, 05 Apr 2023 04:36:01 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y22-20020a7bcd96000000b003ed4f6c6234sm1954392wmj.23.2023.04.05.04.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:36:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 6/8] video/aperture: Drop primary argument
In-Reply-To: <20230404201842.567344-6-daniel.vetter@ffwll.ch>
References: <20230404201842.567344-1-daniel.vetter@ffwll.ch>
 <20230404201842.567344-6-daniel.vetter@ffwll.ch>
Date:   Wed, 05 Apr 2023 13:36:00 +0200
Message-ID: <87sfdebly7.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Daniel Vetter <daniel.vetter@ffwll.ch> writes:

> With the preceeding patches it's become defunct. Also I'm about to add
> a different boolean argument, so it's better to keep the confusion
> down to the absolute minimum.
>
> v2: Since the hypervfb patch got droppped (it's only a pci device for
> gen1 vm, not for gen2) there is one leftover user in an actual driver
> left to touch.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> ---
>  drivers/gpu/drm/drm_aperture.c  | 2 +-
>  drivers/video/aperture.c        | 7 +++----
>  drivers/video/fbdev/hyperv_fb.c | 2 +-
>  include/linux/aperture.h        | 9 ++++-----
>  4 files changed, 9 insertions(+), 11 deletions(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

