Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E3BC433FE
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Mar 2022 12:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiCIMxD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Mar 2022 07:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiCIMxB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Mar 2022 07:53:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89A74177D05
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Mar 2022 04:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646830322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MVrNBje8P4Tjl99yqsqfstxvyHvyJTjfoJ0XzHjnkFs=;
        b=XrmZTQFfzpQPPVCE4aQedVQYA6M4uIBxHqHNFF/QGiFlMZ4hk+bUigJ5GyivnritOwQvaW
        0fhJZ+UYYb4mq8A/w/HyF2inE/gwCniRiHC3s7B9C7QY+RZc15irwrLYqD9u+r2kyiMZBq
        BNrg7LGqDEU0VWaIsWFsKrY8TwXQoZY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-3oRmgtw_OSaetFryTxQiOQ-1; Wed, 09 Mar 2022 07:52:00 -0500
X-MC-Unique: 3oRmgtw_OSaetFryTxQiOQ-1
Received: by mail-wr1-f69.google.com with SMTP id a5-20020adfdd05000000b001f023fe32ffso726870wrm.18
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Mar 2022 04:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MVrNBje8P4Tjl99yqsqfstxvyHvyJTjfoJ0XzHjnkFs=;
        b=Kwmje2Tx88lhmmule0FOxNQ5V1baIZGkYf/9GAcEsehVG2CiAPxClc1E5PqSxXTXUh
         Tle39cdpe2/tFRZWtlWRbd5Za0pTt1uNHyBQaM6oBDR79CRCg0UyCduxFOAMLu8aT4uV
         lHSrj023FuapMmErfbGjyi9YZpiNfZuc2R+uqPJ2ayNRpIVHCEZjWLizJbMlWqUGe67j
         Ejky1CurKHYA8ixfACxsugr81CKU/GXiv7jjNZdcOb/VGUBNrCfxL5rmHdTqXbt6oh6n
         uX24l5BeyHUO1jWjJKkvrvFVrQfZ69EQP6pKROTwRzuNMY1tiKseprQ1VW9vL4uTtSkY
         ohug==
X-Gm-Message-State: AOAM530XE5JZ8qSkA9dbo7Zs24sMJ9iyXnVQwIBKKEyCla661LL8Wg1c
        wRMqmbj5R7FC97iG2yXaB++93HTfuOnRzSDp/C8i6o3IMOXcsnV1NJnE8yBT/m1iewk1YXUJGa9
        kjtEU+BDonjOXKJqBJi2Hay0=
X-Received: by 2002:adf:8b9e:0:b0:1f0:25ca:6d81 with SMTP id o30-20020adf8b9e000000b001f025ca6d81mr15523226wra.247.1646830319031;
        Wed, 09 Mar 2022 04:51:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznCED2hDWfMPlEh09LTikM9n8nFo++5o/PkgFE4Sete3s/9brY/cGIrZsveiDmJHMiONU+4Q==
X-Received: by 2002:adf:8b9e:0:b0:1f0:25ca:6d81 with SMTP id o30-20020adf8b9e000000b001f025ca6d81mr15523208wra.247.1646830318754;
        Wed, 09 Mar 2022 04:51:58 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n2-20020a056000170200b001f1e16f3c53sm1643997wrc.51.2022.03.09.04.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 04:51:58 -0800 (PST)
Message-ID: <d7a8d183-fe2b-99b1-9730-eddb040f6d1e@redhat.com>
Date:   Wed, 9 Mar 2022 13:51:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 03/10] drm/client: Use actual bpp when allocating frame
 buffers
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
 <8f29a983d42d9d68bd8cae2f9481d3c139f8750a.1646683502.git.geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <8f29a983d42d9d68bd8cae2f9481d3c139f8750a.1646683502.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 3/7/22 21:52, Geert Uytterhoeven wrote:
> When allocating a frame buffer, the number of bits per pixel needed is
> derived from the deprecated drm_format_info.cpp[] field.  While this
> works for formats using less than 8 bits per pixel, it does lead to a
> large overallocation.
> 
> Reduce memory consumption by using the actual number of bits per pixel
> instead.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

