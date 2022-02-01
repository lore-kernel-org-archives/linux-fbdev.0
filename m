Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE06C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Feb 2022 14:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbiBAOBt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Feb 2022 09:01:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238944AbiBAOBs (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 1 Feb 2022 09:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643724108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0xhLey8NZwZfvq1aWQDBdLCgJjMsiCxuS9yKl0tV4E=;
        b=MkD6nQRY2OZ0VdlKZ2hsjj54s6reAu16xL6TuAK8gtz8ookZ0SzTabDXIbRKLm9yNfzINT
        pqlfhhdLAvX5nYTms64d7xi+oiS4ne052lo5Fjzc254ASmCyP+1/c2ddY+ZYO4Llwyyb6Y
        JRk4XvCcn3oYbiD79Lf81678VdOoxA4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-mqwRinRyMB6FSX9gDgpJZQ-1; Tue, 01 Feb 2022 09:01:47 -0500
X-MC-Unique: mqwRinRyMB6FSX9gDgpJZQ-1
Received: by mail-wm1-f72.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso996995wmb.6
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Feb 2022 06:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t0xhLey8NZwZfvq1aWQDBdLCgJjMsiCxuS9yKl0tV4E=;
        b=kbd455q6lZtEE/nQ/+lu/jF8BdbZ/5wXzMmV7N1E5cXLhodr+kzg3Nv6WK0O3BGCtf
         bt6T9UF4qaHu1kyvUaMWik9naocE99ecdd1mhdQqg3kUv46yrs1AnP6qufPGvBW8b9iN
         geN0fxYn2jVQYcx7h5/Cd9rP2bFelQqvlku4sKNRiFibpYsFlP9dpZMJbPl9Af9eR5ir
         mxazmBFXdW7hga91Psh9MjsyLPgIZ9pm9gnVcXVTvQDwDUpWA7ima/aOiuiecm+LyLYH
         008EcKFnv1M1FmP3mFKUtFQScbxylmKRCciFOJDwCcIMRh7oNO/+d+Tq3/clkG9a5joO
         g7AQ==
X-Gm-Message-State: AOAM531hw82fXaMOEN86QHUAv5eExFVvmSEzFIUa2TuBLcu4ShULvGEv
        MPuVAUVTeb62vVus9H49EEPmVUC1YA8wqB7CoQX7JZO3vmUyzLn3ux+LZoUw3IZhl30tj0pWKbP
        oSLkaaZgkDqtvvVQP1UCfq3c=
X-Received: by 2002:a1c:6a14:: with SMTP id f20mr1907005wmc.177.1643724105435;
        Tue, 01 Feb 2022 06:01:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxiXh7XT/y9EhbXaaYFMW+Z8FLorkbaMP6N2gEv45FSVWMJcQUX+XJyy9OHO0UQo8Hz5UgkJg==
X-Received: by 2002:a1c:6a14:: with SMTP id f20mr1906977wmc.177.1643724105240;
        Tue, 01 Feb 2022 06:01:45 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v5sm2032210wmh.19.2022.02.01.06.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 06:01:44 -0800 (PST)
Message-ID: <3ebc8a81-a27f-9ab7-d247-5203f286eeb2@redhat.com>
Date:   Tue, 1 Feb 2022 15:01:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 01/21] MAINTAINERS: Add entry for fbdev core
Content-Language: en-US
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Suarez <cssk@net-c.es>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sven Schnelle <svens@stackframe.org>,
        Gerd Hoffmann <kraxel@redhat.com>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-2-daniel.vetter@ffwll.ch>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220131210552.482606-2-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 1/31/22 22:05, Daniel Vetter wrote:
> Ever since Tomi extracted the core code in 2014 it's been defacto me
> maintaining this, with help from others from dri-devel and sometimes
> Linus (but those are mostly merge conflicts):
> 
> $ git shortlog -ns  drivers/video/fbdev/core/ | head -n5
>     35  Daniel Vetter
>     23  Linus Torvalds
>     10  Hans de Goede
>      9  Dave Airlie
>      6  Peter Rosin
> 
> I think ideally we'd also record that the various firmware fb drivers
> (efifb, vesafb, ...) are also maintained in drm-misc because for the
> past few years the patches have either been to fix handover issues
> with drm drivers, or caused handover issues with drm drivers. So any
> other tree just doesn't make sense. But also, there's plenty of
> outdated MAINTAINER entries for these with people and git trees that
> haven't been active in years, so maybe let's just leave them alone.
> And furthermore distros are now adopting simpledrm as the firmware fb
> driver, so hopefully the need to care about the fbdev firmware drivers
> will go down going forward.
> 
> Note that drm-misc is group maintained, I expect that to continue like
> we've done before, so no new expectations that patches all go through
> my hands. That would be silly. This also means I'm happy to put any
> other volunteer's name in the M: line, but otherwise git log says I'm
> the one who's stuck with this.
> 
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: DRI Development <dri-devel@lists.freedesktop.org>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Cc: Claudio Suarez <cssk@net-c.es>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Sven Schnelle <svens@stackframe.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

