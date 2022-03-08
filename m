Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A974C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Mar 2022 09:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345262AbiCHJOq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Mar 2022 04:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345258AbiCHJOq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Mar 2022 04:14:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA5273E5EB
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Mar 2022 01:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646730828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zlzDZFRzgx9xVyZXX5HJhFOJlKtod0cn2NQcAWeFY8k=;
        b=PyAeDUWa9Om2EiPn4emVdfoUSZtleeeW3MgM7rcG38lxijmatpd6NCbLrI4nyhFl2wlL/r
        DD4gl7Xh74cislmAfCJn8So9R09AEQvGwZ1FVNjCxOrgN/revoNu/uk3gqE4wDCDstZY0h
        IqiusEvvPWttmWWX3OGeiJyd52VQnqY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-UXqnyH8bPHSQErGSItwfbw-1; Tue, 08 Mar 2022 04:13:47 -0500
X-MC-Unique: UXqnyH8bPHSQErGSItwfbw-1
Received: by mail-wr1-f71.google.com with SMTP id h11-20020a5d430b000000b001f01a35a86fso5230816wrq.4
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Mar 2022 01:13:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zlzDZFRzgx9xVyZXX5HJhFOJlKtod0cn2NQcAWeFY8k=;
        b=iTXCjCTT18AL5whWcoFM7UKZDRc9XScaAeHCSXH8A4w/c4Cql1V68n0qFAprTJL9d2
         mZq5jwZiOAAbA1olm11GdTXDFiIsBl8b4tPexjZ0b8UkfboDRfxmsEFyI11IshP/boz5
         5ujcazGmAplTjla6coqH5+t/KEUTpDiSReereW/tzhkYr3r9XTR34ZX8f4iQw2CYmkyk
         n/AVfgUkffy8Bk8KJgQk02YQJPVvJ79lStjxxmElWVU5hYcMjw3gO4RLLpp6aH1+WpWW
         9+pl6tIAeptfW7KUM3qQIc9qAvSNMwUoVJCF6HXxTsyWOxPddE+utledzOUYDxKJFzLX
         9F/g==
X-Gm-Message-State: AOAM531H27bSsqVn1P5u0OPYVIc7P2GpFvUZuyo+9reqEN4MzTm71//v
        5WGtnobbxkangoV60u4ehEbr9jQSXiYBfW/lGf57zx2Cj2G98mW1AeZT6ycVUcFP8PKeRqeM8cr
        B2kgWsVovIgjCGfPrZHmv9RY=
X-Received: by 2002:adf:d238:0:b0:1f0:6105:520a with SMTP id k24-20020adfd238000000b001f06105520amr11116402wrh.531.1646730826133;
        Tue, 08 Mar 2022 01:13:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKmkKxbfIdrIWp45PAltn78uV3fLKVuKMdJnj7tC85n4cuoVSGoh1IyCePxKQaBsiWu+Zm5A==
X-Received: by 2002:adf:d238:0:b0:1f0:6105:520a with SMTP id k24-20020adfd238000000b001f06105520amr11116389wrh.531.1646730825812;
        Tue, 08 Mar 2022 01:13:45 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm1554517wmc.47.2022.03.08.01.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 01:13:45 -0800 (PST)
Message-ID: <9ccf6f00-6611-7bbb-0ea8-ccf4f0a2920f@redhat.com>
Date:   Tue, 8 Mar 2022 10:13:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/9] drm: Support GEM SHMEM fbdev without shadow FB
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220303205839.28484-1-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220303205839.28484-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 3/3/22 21:58, Thomas Zimmermann wrote:
> Rework the fbdev deferred-I/O to not interfere with fields of struct
> page. Make the code more flexible and implement GEM SHMEM mmap on top
> of it.
> 
> This patchset removes the need for a special shadow framebuffer for
> fbdev mmap when using GEM SHMEM. SHMEM pages are now mmap'ed from
> /dev/fb directly.
>

Interesting. I wonder if you have any performance improvements after
dropping the shadow buffer.

> Patches 2 and 3 rework the fbdev deferred I/O code. It now allows
> drivers to have better control of the mmap operations. All references
> to fields in struct page are gone. The rsp state is help in a 
> separate pageref structure.
>

That's a very nice cleanup. This really was a huge layering violation.
 
> Patches 4 to 7 provide callbacks an helpers to implement deferred I/O
> with DRM drivers. Specifically, patch 6 introduces a callback to create
> a dumb buffer for fbdev. This will be useful for many drivers that
> currently cannot use generic fbdev emulation because of special placement
> needs of the BO, such as amdgpu or radeon. The drivers can handle the
> differences to regular dumb buffers in their new callback implementation.
> 
> Patch 8 extends the GEM SHMEM memory manager with a new helper for fbdev
> dumb-buffer creation. The returned BO has it's mmap set up to implement
> deferred I/O with SHMEM pages. No additional shadow buffer is requires
> any longer. Many drivers can immediatelly benefit from this change.
> 
> Patch 9 extends virtgpu to support fbdev dumb buffers. It's build on
> top of GEM SHMEM, but has some modifications that need to be implemented
> for fbdev as well.
> 
> There's no immediate fbdev performance improvement from this patchset.
> Most of all, it removes unnecessary shadow framebuffers and rsp memcpys.
> A shadow fb for a FullHD display is ~8 MiB, which we now save. The patches
> do reduce latency between drawing to the fbdev buffer to displaying
> on the screen. Watching a video on the fbdev console felt smoother and
> had less flickering.
>

Awesome. And you also answered here the question I had above.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

