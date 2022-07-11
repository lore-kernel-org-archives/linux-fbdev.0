Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20728C43334
	for <linux-fbdev@archiver.kernel.org>; Mon, 11 Jul 2022 11:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiGKLXi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiGKLXB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 11 Jul 2022 07:23:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1207037F89
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 03:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657536640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fJygbU8DB1FiBG5kEv9BqrgeJXrXPjMOQW0TEO91yo8=;
        b=PQQwDvheedgholVZZTuChmWdkdevqtmMD6/AAwrnRKhaFEzjbkw1JgACfaUPU8lPmJjEUo
        dAr9P9GGGJ/GkEaw4BPn7ZPIpsrCJN2uF0EsgWgIl/41UXb7D+yrDkkdSySF0F2tGXf2SE
        xhxnEq3YpoEXzZuyZM8j199j94uy58g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-nKy7TmHUPMOMVQSltVJ0QQ-1; Mon, 11 Jul 2022 06:50:38 -0400
X-MC-Unique: nKy7TmHUPMOMVQSltVJ0QQ-1
Received: by mail-wm1-f71.google.com with SMTP id k62-20020a1ca141000000b003a2e342a55bso1955883wme.1
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 03:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fJygbU8DB1FiBG5kEv9BqrgeJXrXPjMOQW0TEO91yo8=;
        b=a8z6VVfh1d6XNMgqiuvItDy4XF7KiWJpUgx1dq2GpDqJ/h0GqcTrET3vh2tsY4dxbL
         bv18nWx/NK1qL6RXnzdnfw4FG5baZzjcob3w2PDYzToNTviUX/Eb4gq6PFAD0Sj7KQ5N
         taFUnlVx83402rxNIxzxQV3e0uQMXFg3zkOMecbkRNc/yW/DhLERCipfO64l7+jp4RSK
         TmCD+kq0oltQ+vxwt0LmEUBlkv5u3IP4vMcE7dZWQxhreOfRYOyNoV6QJ1nCFaQs7tib
         P2SpQF+Upe47Acn0YYLILbOT8Fc7/MQLd5UTJ2x+wMOR7T1ejkuZIoFxmXzlaZ3FTOBo
         j6eA==
X-Gm-Message-State: AJIora95imAYWelV5phMq3aVVmVFCcQ+BzRzw2/0DoFUZw5/7wwR5gKf
        UkjmqOWZbqbpONKz7xQ4Awwa5gPJzzPlGdeYXdi6Phn0HwTKX9bcDsW1TBXR1Uj9JybiahC/rt/
        +3ssigBlm6Nx/etc57KvokTw=
X-Received: by 2002:a5d:6e03:0:b0:20f:ca43:badc with SMTP id h3-20020a5d6e03000000b0020fca43badcmr15688990wrz.547.1657536637585;
        Mon, 11 Jul 2022 03:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sqrhuJBI2xK3PCG7LV6zpLGuGhwp9soZtin6v+gEj3U32QOjYtCPeSaN3ySxWPQEOj9vpEqQ==
X-Received: by 2002:a5d:6e03:0:b0:20f:ca43:badc with SMTP id h3-20020a5d6e03000000b0020fca43badcmr15688976wrz.547.1657536637359;
        Mon, 11 Jul 2022 03:50:37 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c1c8500b003a047f64496sm6509025wms.7.2022.07.11.03.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 03:50:36 -0700 (PDT)
Message-ID: <b499ad15-e681-1f2c-dc11-2d94c1066ecd@redhat.com>
Date:   Mon, 11 Jul 2022 12:50:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 02/11] fbdev/vga16fb: Create EGA/VGA devices in sysfb code
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, maxime@cerno.tech
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org
References: <20220707153952.32264-1-tzimmermann@suse.de>
 <20220707153952.32264-3-tzimmermann@suse.de>
 <fec8dcc1-c490-3bb6-2d2f-805d690d3f95@redhat.com>
 <95302954-76bc-3da6-70ad-25a8a22a37f0@suse.de>
 <253d0bea-f197-4208-b5e6-39c22ab91833@redhat.com>
 <fafde6fb-17ee-1c18-9e5f-96e60a08d98e@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <fafde6fb-17ee-1c18-9e5f-96e60a08d98e@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/11/22 12:42, Thomas Zimmermann wrote:
> Hi Javier

[...]

>> That's why I think that "vga-framebuffer" as driver name would be misleading.
>> Specially since it would also bind to the "ega-framebuffer" platform device.
> 
> I messed up device and driver name, such that misunderstood your remark.
> 
> As we use the id_table field for matching devices, the driver name 
> doesn't matter. [1] So let's keep the driver name as vga16fb. The change 
> above must have been left over from an earlier prototype patch, I guess.
> 

Agreed. The driver name is used as the last resort to match a device
only if there isn't any device ID table (ACPI, OF, platform, etc) but
that's discouraged. Specially when the same driver supports different
devices as it's the case for this driver.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

