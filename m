Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C18C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri,  4 Feb 2022 14:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359233AbiBDOMW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 4 Feb 2022 09:12:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232803AbiBDOMV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 4 Feb 2022 09:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643983941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KItnbBDoQWGxAStE9x/Omo/R1q/taazm8Gbl7PqYOjc=;
        b=Iu+McOYBk1NKxVrMiAES6qF0s6asngAZKoj9ef/3UuDd3UJPnaTIt+mBgNoj3LCip8vdez
        JQSql+ucyWioZWW/QMBh7ziitMNpyJ9zuJHyzYsaA6S2OQCymBs7MEVjyUUoCLBnClyOGD
        4EFiIPUNLxG8sXXHmE6DgjrAdGIYOAM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-61fIQodiPaaE1FIlZAGbxA-1; Fri, 04 Feb 2022 09:12:20 -0500
X-MC-Unique: 61fIQodiPaaE1FIlZAGbxA-1
Received: by mail-wr1-f69.google.com with SMTP id d25-20020adf9b99000000b001e298eecb85so1974252wrc.19
        for <linux-fbdev@vger.kernel.org>; Fri, 04 Feb 2022 06:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KItnbBDoQWGxAStE9x/Omo/R1q/taazm8Gbl7PqYOjc=;
        b=cvHanOIcu0fI1DvLs6Qpe+JitlorGRjY85otmByTTN/kdGxVZFwEhpusfWiYA1iS/4
         oDsMjLBfyq8ZgI7gOWCyXEPWCMijTq0rz1cs5jDJsI1k5lsWe1roZ5/zkismP5vdvmug
         YTHuY46c4MTCV67y5SVoeq8Vss+SrKjmQjTB6FCELsr5ZLbBISwO6NwX6AlEWnQrsmsc
         B/qonTxSL08bWoi1OaddrHbUm+V1Dp5Q6DrWBmSzwMHMFXLZ/jRg8PHpF6gUqb3Wfv4H
         mi+pszq60zcqrCONZJWCmrpStWj21lYM3Uca5NkHN3cm/13nMxJa0AqLf25CW/udsCth
         PlWw==
X-Gm-Message-State: AOAM530nAu7cib8BmDNsSsFyxZ/ptkIAIjACWya2bYduF3Zqkz9u0dkA
        ssBGSnV5Jo3eK9yRn3ZQh2BCJ5juCeSTW0XgGdF/mwkDPMQ9tEUwi0LR87D6ejx7+NGjpqutihI
        ft+XmvOJRa2DciCe6R2uoQfs=
X-Received: by 2002:a05:600c:1d8b:: with SMTP id p11mr2385838wms.115.1643983939111;
        Fri, 04 Feb 2022 06:12:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztIKbYGGYYsqOYvoXlouVCeffwnsLMQlwE5LqaJBGhLKzE5ulVDx77gLhM4YlpnNr0MzeTyg==
X-Received: by 2002:a05:600c:1d8b:: with SMTP id p11mr2385818wms.115.1643983938849;
        Fri, 04 Feb 2022 06:12:18 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m12sm2480308wrp.61.2022.02.04.06.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 06:12:18 -0800 (PST)
Message-ID: <5892749f-0bb0-68f5-c3d2-8ceedfc6b162@redhat.com>
Date:   Fri, 4 Feb 2022 15:12:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/4] MAINTAINERS: Add entry for Solomon SSD130X OLED
 displays DRM driver
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
References: <20220204134347.1187749-1-javierm@redhat.com>
 <20220204134347.1187749-4-javierm@redhat.com>
 <Yf0wzOP/kaubDAhP@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Yf0wzOP/kaubDAhP@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Andy,

On 2/4/22 14:57, Andy Shevchenko wrote:
> On Fri, Feb 04, 2022 at 02:43:46PM +0100, Javier Martinez Canillas wrote:
>> To make sure that tools like the get_maintainer.pl script will suggest
>> to Cc me if patches are posted for this driver.
>>
>> Also include the Device Tree binding for the old ssd1307fb fbdev driver
>> since the new DRM driver was made compatible with the existing binding.
> 
> ...
> 
>>  drivers/gpu/drm/drm_format_helper.c | 2 +-
> 
> Nothing about this in the commit message...
> 
> Stray change?
> 

Sigh, I'm not sure how added that change. Just ignore it, I'll fix it
on v3 or when applying if there isn't another revision of this series.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

