Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B56C19F29
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jul 2022 09:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiG0Jal (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jul 2022 05:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiG0Jai (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jul 2022 05:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77F7ADCB
        for <linux-fbdev@vger.kernel.org>; Wed, 27 Jul 2022 02:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658914236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WnlbuoDO11+s0PkrtymLUg/RTeerO1YGjIAWzaLsXI8=;
        b=GWmiJY/cAdAUMg8tqpfibFPk+4JnI3GCML7lngOj+EaWBeCKyP7kR2KyKaQGDrsUw/eUXX
        PuE8EyuBpwUr2f84o/qRytJDNqH6nOkS6BjJCa6HwTGHwLWc6Zo3n5tnHjD7UDSvb3NQ79
        n5dAasDHXuEtLkTzXBJbY7cjyXLf89M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-9pBcfcdpPhmKxRB5bdyS2Q-1; Wed, 27 Jul 2022 05:30:35 -0400
X-MC-Unique: 9pBcfcdpPhmKxRB5bdyS2Q-1
Received: by mail-wm1-f72.google.com with SMTP id q19-20020a7bce93000000b003a3264f3de9so358833wmj.3
        for <linux-fbdev@vger.kernel.org>; Wed, 27 Jul 2022 02:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WnlbuoDO11+s0PkrtymLUg/RTeerO1YGjIAWzaLsXI8=;
        b=qnm8dj3q55NlL1HkvO4ufSi8Lf3hsmYks6gO1ZNGdKexeeczyW+J5lJN5AURkErLST
         qPq0nDsRm+S7DbZHBAYfKhWRqtnAp8kullTuSKjG9S8VHxLiEb8AqCa0p99AdC7zrnr1
         YgGrn8P0b7MoQdic3nQkC9hd8PXPUROgRoVWaDi4RBmzoEmRc8l9ZpV8XzfsLZy/yiy4
         fUolQIo4HfJfB1cojUTc7fkVSuFikkrp5NICRUHTsN5vErJVXb+QKSTZ+rsBEPWN6Hev
         KYM5pkF3PQ+P/X3Sk5HxfcP4b7spqD0SHlb3HrqHmN/RMfUARljV/+6s8ZLn6EpjPHZs
         ymGw==
X-Gm-Message-State: AJIora+SYp/YDmzCwUm39YLHWIL3t8NSCp4C/Ul5YIvG0o8Mn/hV8cj9
        ZSpJtWXlUAnm6gze618KB5nhGP2PhZd/AdEKnbrFu87Yj2WGUiMdCPKftawwWQBhmmqEKtqGk7L
        Vsytu7pKtEwC2VM998s+5fLk=
X-Received: by 2002:a05:600c:41c6:b0:3a3:4cab:74c1 with SMTP id t6-20020a05600c41c600b003a34cab74c1mr2242287wmh.175.1658914233594;
        Wed, 27 Jul 2022 02:30:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uXQimwmNj3iiuQIjR5+7GqsX0PKlNmy42WJ5vwSnDC//JqOwhL7VkEb/l38nriYGA+tApYpA==
X-Received: by 2002:a05:600c:41c6:b0:3a3:4cab:74c1 with SMTP id t6-20020a05600c41c600b003a34cab74c1mr2242250wmh.175.1658914233261;
        Wed, 27 Jul 2022 02:30:33 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w6-20020adfec46000000b0021ed0202015sm1037150wrn.10.2022.07.27.02.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 02:30:32 -0700 (PDT)
Message-ID: <123b9590-8a5d-70b3-b27b-59e71d4cf6da@redhat.com>
Date:   Wed, 27 Jul 2022 11:30:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 02/10] drm/simpledrm: Inline device-init helpers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
        daniel@ffwll.ch, deller@gmx.de, maxime@cerno.tech,
        sam@ravnborg.org, msuchanek@suse.de, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, geert@linux-m68k.org,
        mark.cave-ayland@ilande.co.uk
Cc:     linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org
References: <20220720142732.32041-1-tzimmermann@suse.de>
 <20220720142732.32041-3-tzimmermann@suse.de>
 <be24a47c-c41a-411a-da63-c699b53cb459@redhat.com>
 <314820f8-3609-9182-97eb-ee30e240d114@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <314820f8-3609-9182-97eb-ee30e240d114@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 7/27/22 09:50, Thomas Zimmermann wrote:
> Hi
> 
> Am 25.07.22 um 17:01 schrieb Javier Martinez Canillas:
>> Hello Thomas,
>>
>> On 7/20/22 16:27, Thomas Zimmermann wrote:
>>> Inline the helpers for initializing the hardware FB, the memory
>>> management and the modesetting into the device-creation function.
>>> No functional changes.
>>>
>>
>> Could you please elaborate in the commit message why this change is
>> desirable?  Without this additional context, this feels like going
>> backwards, since you are dropping few helpers that have quite self
>> contained code and making simpledrm_device_create() much larger.
> 
> To clarify: I want to make the init code more easy to follow. These old 
> init functions still had to be called in the right order as each > possibly depends on settings from the others. It also feels like it's 
> easier to extract common code for ofdrm. And the pipeline is static, so 
> it doesn't require complex chains of helper calls. Having everything in 
> one helper seems beneficial. (It's a trade-off, I know.)
>

I see. That makes sense to me. Could you please add the explanation to
the commit message ? And feel free to add my Acked-by for this one too.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

