Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85443C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Mar 2022 13:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiCINkc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiCINkb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Mar 2022 08:40:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BAEC4C7AD
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Mar 2022 05:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646833172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hxJPMn5J6L7pDstxJt5mOgE1pVrNFlShCuIhtS3CI8s=;
        b=TFYWktsgqqwZ67O/n7tL3HSIba6ugwInPiRRLqe8sEJwa0liIWmYg2j+VbZXlrZuTEtJa+
        3JJNfOup+GJTgJ2fpoRliYWWZl0MJzphmR3FEAtipttZieBNlYHU3d1bxXcSmUqiKeeW9E
        ykANW/y7fSBWu6gs8umJnHY3DAVePhc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-yk79Cn32O4GH3T9sCg6x1Q-1; Wed, 09 Mar 2022 08:39:31 -0500
X-MC-Unique: yk79Cn32O4GH3T9sCg6x1Q-1
Received: by mail-wm1-f69.google.com with SMTP id c19-20020a05600c0ad300b00385bb3db625so2603497wmr.4
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Mar 2022 05:39:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hxJPMn5J6L7pDstxJt5mOgE1pVrNFlShCuIhtS3CI8s=;
        b=t98wRqUJdgYW/R49dhdAMhVUHiIx0HXQhPbbwe0FBzSg4c66OVbqxM2jGEPxPunB6M
         FjS0w0IZQElUCq8Sg/p0538WahXG2dA/FstHnmmiGeLCuO3M2vNjU7Mtn43FGBFWF6a3
         IHOMJM/1fxlnuB2gSkEURRsLDAhwi299yNADDPe/N/RwSQ5Oto5w0kHGk09btTgHUB3V
         fOB9mYOWZAnGUhkW8yuQqOgaA0Qq9H60pFUjy/yCjDijy1SP4OhwG68Fjf5aYYATI7OT
         /DnWsfLQgQL7qmrb5h4bozKeA2seOE8YiLy10L5swwJdHufSCP+S6fVkZAJmVcWRWrl1
         LtNA==
X-Gm-Message-State: AOAM533RtF8KZpG7moWVm1XOC7DntvUKMmJAUr8HtkS2G8RI/onO4Sie
        HvgFCU9rWbCT9Ga8cnIh/NALl+b/KDt7npXSx84d9+kpags6Vl7h2APWmUqxExn2XwSamFwHON3
        5fF9BXE2kCkCBYP/mz98a2QI=
X-Received: by 2002:a1c:6a01:0:b0:37f:1b18:6b17 with SMTP id f1-20020a1c6a01000000b0037f1b186b17mr7467017wmc.146.1646833169796;
        Wed, 09 Mar 2022 05:39:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUiXVqoM47oNz6ncRVRIq/E3m1+h7KnHuneTo0rnDdEN8qOnGhuo4BXntkJRz7KSBVfpVw1Q==
X-Received: by 2002:a1c:6a01:0:b0:37f:1b18:6b17 with SMTP id f1-20020a1c6a01000000b0037f1b186b17mr7466991wmc.146.1646833169595;
        Wed, 09 Mar 2022 05:39:29 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y10-20020adfee0a000000b001f0639001ffsm2618429wrn.9.2022.03.09.05.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 05:39:29 -0800 (PST)
Message-ID: <d1003594-dc26-23d4-a402-2951b3ed395d@redhat.com>
Date:   Wed, 9 Mar 2022 14:39:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 RFC 09/10] drm/fourcc: Add DRM_FORMAT_R[124]
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1646683502.git.geert@linux-m68k.org>
 <98c062f1b5c71427d5ba6c7bca706d04b1892162.1646683502.git.geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <98c062f1b5c71427d5ba6c7bca706d04b1892162.1646683502.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 3/7/22 21:52, Geert Uytterhoeven wrote:
> Introduce fourcc codes for single-channel light-on-dark frame buffer
> formats with two, four, and sixteen intensity levels.
> 
> As the number of bits per pixel is less than eight, these rely on proper
> block handling for the calculation of bits per pixel and pitch.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

IIRC the agreement was that it was worth to have both Cx and Rx fourcc
formats separately, so this patch makes sense to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

