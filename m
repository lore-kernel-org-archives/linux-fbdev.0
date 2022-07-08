Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DD7C43334
	for <linux-fbdev@archiver.kernel.org>; Fri,  8 Jul 2022 19:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbiGHTg1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 8 Jul 2022 15:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbiGHTg0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 8 Jul 2022 15:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A72A5C9F1
        for <linux-fbdev@vger.kernel.org>; Fri,  8 Jul 2022 12:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657308985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bp4/uJx0q3CBRP6uPPQZJlkmcVebKMMiiHAd6ojauiM=;
        b=Nbby7OpVAtxuOSJM1DoD6m/6XEHExGTp3PMI1Ah3Sy/vAnVDe+IlVXjU1CepI+QkRU9b/D
        EIZOvJI4j0AHaG5ReKOUKs9pSUOBuOwbFdz/an74VS6K7Vvob9E9cyi7BBGLESYSyOkrzJ
        ItV6oQvg0vPbLvbVaKXuqUTFvOYaSk4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-QmTn-SHnPfWw2ZML_K1FBQ-1; Fri, 08 Jul 2022 15:36:24 -0400
X-MC-Unique: QmTn-SHnPfWw2ZML_K1FBQ-1
Received: by mail-ed1-f69.google.com with SMTP id y5-20020a056402358500b0043592ac3961so16454261edc.6
        for <linux-fbdev@vger.kernel.org>; Fri, 08 Jul 2022 12:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Bp4/uJx0q3CBRP6uPPQZJlkmcVebKMMiiHAd6ojauiM=;
        b=1P96eC7P2rawxXPJKctj1Klf1Ei+C7Csq/eL8nX57fPc7l9/Hz8Gpr2PREUYR4WJQR
         YtqGT4Is2JJeoZi4jMVeQZ6YWU2mWJt5Kk/V7qAQQRXmUDCn1MIC04mRBYFWEbg1ySGC
         ouzWjyvVojDnzWrmMZXo1zPtXdpYZvKPinvut2K2H2I3fNb407VMWPeFvpr7r6HbhotG
         N6X58hudtKHPMijCrxUuO1AsfP1CBDJIsngl21gAIBbJR5nD3el/INLmb2ax3Z181ge2
         DZpXmmFV5M201CheL8iU1GCKONzgGCMUTNNU6c1lvxzDOqI9T5cO7VLJttGwH/j4D7z5
         2PHw==
X-Gm-Message-State: AJIora8rhATKNaT+w7i2WGrDa2yDzqTHNhpOhyZ++mneiiaRtiJYtkKV
        +MCsf0rqcTqya125SynChIOMAGHbrudGPK7jJCosRa8CIuqHYcgwEnUFyIIGJgqsNfqj7uk2KT8
        AcCDpFsMTiJOJgXKcJTfJUiw=
X-Received: by 2002:a17:906:84fa:b0:72b:3257:527b with SMTP id zp26-20020a17090684fa00b0072b3257527bmr894464ejb.477.1657308982249;
        Fri, 08 Jul 2022 12:36:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sHAlOPlSVNJxOUyi7dexo+dGkJEXRhxhmOBsygKoLu/bOnqki5Dcyoqj9A1H/3E27ZRhYkHA==
X-Received: by 2002:a17:906:84fa:b0:72b:3257:527b with SMTP id zp26-20020a17090684fa00b0072b3257527bmr894456ejb.477.1657308982085;
        Fri, 08 Jul 2022 12:36:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id p16-20020a05640210d000b0043a1bc2ebbcsm13332097edu.3.2022.07.08.12.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 12:36:21 -0700 (PDT)
Message-ID: <da9636ac-9455-75a6-7284-8c601d23a37e@redhat.com>
Date:   Fri, 8 Jul 2022 21:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/5] drm/modes: Command line mode selection fixes and
 improvements
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1657301107.git.geert@linux-m68k.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <cover.1657301107.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Geert,

On 7/8/22 20:21, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series contains fixes and improvements for specifying video
> modes on the kernel command line.
> 
> This has been tested on ARAnyM using a work-in-progress Atari DRM driver
> (more info and related patches can be found in [1]).
> 
> Thanks for your comments!
> 
> [1] "[PATCH v3 00/10] drm: Add support for low-color frame buffer formats"
>     https://lore.kernel.org/r/cover.1657294931.git.geert@linux-m68k.org
> 
> Geert Uytterhoeven (5):
>   drm/modes: parse_cmdline: Handle empty mode name part
>   drm/modes: Extract drm_mode_parse_cmdline_named_mode()
>   drm/modes: parse_cmdline: Make mode->*specified handling more uniform
>   drm/modes: Add support for driver-specific named modes
>   drm/modes: parse_cmdline: Add support for named modes containing
>     dashes

Thanks, I have some remarks on patches 1/5 and 2/5 the rest looks
good to me. 

For 1/5 and 2/5 with my remarks addressed:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

For 3/5, 4/5 and 5/5:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> 
>  drivers/gpu/drm/drm_modes.c | 57 ++++++++++++++++++++++++++-----------
>  include/drm/drm_connector.h | 10 +++++++
>  2 files changed, 50 insertions(+), 17 deletions(-)
> 

