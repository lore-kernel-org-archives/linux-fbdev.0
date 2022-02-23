Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4019C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed, 23 Feb 2022 16:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243042AbiBWQz2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 23 Feb 2022 11:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiBWQz1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 23 Feb 2022 11:55:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A9DB1CFC1
        for <linux-fbdev@vger.kernel.org>; Wed, 23 Feb 2022 08:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645635299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VGsFxlL4JeFa1QdhcUJScvi/ilLeoFbRM78k1G2b9hU=;
        b=Tl1J67Jeoh2rJl6U0NNdA9vnV/A4XRdzrKJNx9hLLlIAz6ri0ZsyDGfzBbgwuuaWYNaRso
        B4x9wgRfbJpfKf45gIMZ72wSExzLJcJEe45iJdloLsKezWYDu7PHVgjUFSYmuChyogVGRr
        biImOL2eyRnNSj3ZXm2UYusa1brmJWU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-U5MxWjvVPnymsAduMospGw-1; Wed, 23 Feb 2022 11:54:57 -0500
X-MC-Unique: U5MxWjvVPnymsAduMospGw-1
Received: by mail-wm1-f72.google.com with SMTP id i131-20020a1c3b89000000b0037bb9f6feeeso1373087wma.5
        for <linux-fbdev@vger.kernel.org>; Wed, 23 Feb 2022 08:54:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VGsFxlL4JeFa1QdhcUJScvi/ilLeoFbRM78k1G2b9hU=;
        b=X/Ngt1Nq+REfZhKdAsXirzx/FctFt4Z9khhPTVMslZO0lh3MjFfy9v6oi9ga9w0gXQ
         QoJzH79ELMj08ut1j49oabS+wHyuFOdrv+CT6H7UWsKy1/GDlYCnBdoesRzRja8NLd4U
         yqmGukfFw+gptmcv6rOM0CQacsFUCU/Oz2tM92COOdNcNCCCyk2dhlgobkS42bPsacQQ
         rJphS4AnLBn0nbD8LZkj7PJJz0Wf8aIliLG8/jUapOLCh7HNsB+iviZ/D6zAgTGM9tQP
         H7K59FMbMcb2b+cOTYbtI34/foIw/UKKk/PZ48QcV38CeMdEOA4EClEDb8K3EBc3QLwA
         Dm7g==
X-Gm-Message-State: AOAM530upkZxgJRF5dLWD5DTY3jvUqBgJv+TFmYPpzHj2TC6Ze8DoSCx
        JFzU5RGEMD3GuSsMPU5CizgjvOzXp5FoeNy0TrBSJO19cc3Mp1nZ+avK7IhZzjZGUyXFQ0zd9dP
        QLiyml9gL6HkFM5DGsxBR9gI=
X-Received: by 2002:a05:6000:11c9:b0:1ed:b92d:8c68 with SMTP id i9-20020a05600011c900b001edb92d8c68mr387243wrx.692.1645635296721;
        Wed, 23 Feb 2022 08:54:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwh2m/1l5+uIPpemZfPkQyC83sbpmuOCBmgtWvmNNgg8mQBYxAIW77Ao8GytoqMFEHFUp6k6Q==
X-Received: by 2002:a05:6000:11c9:b0:1ed:b92d:8c68 with SMTP id i9-20020a05600011c900b001edb92d8c68mr387231wrx.692.1645635296423;
        Wed, 23 Feb 2022 08:54:56 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n2sm79430wmq.6.2022.02.23.08.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 08:54:56 -0800 (PST)
Message-ID: <f832a836-b6ee-ffc5-6f83-86c9ba475400@redhat.com>
Date:   Wed, 23 Feb 2022 17:54:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] simplefb: Enable boot time VESA graphic mode
 selection.
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
        Helge Deller <deller@gmx.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        linux-kernel@vger.kernel.org, linux-video@atrey.karlin.mff.cuni.cz
References: <a789e375-a23e-6988-33bc-1410eb5d974f@suse.de>
 <20220218160436.23211-1-msuchanek@suse.de>
 <33b80f9c-d54a-5471-a58b-7a783a7a9e5b@redhat.com>
 <20220223164528.GE3113@kunlun.suse.cz>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220223164528.GE3113@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/23/22 17:45, Michal Suchánek wrote:

[snip]

>>>
>>> To enable use of VESA modes with simplefb in legacy BIOS boot mode drop
>>
>> I think you meant "VESA modes with the sysfb driver" ? or something like
>> that since otherwise it seems that you meant to use it with the simplefb
>> (drivers/video/fbdev/simplefb.c) fbdev driver, which doesn't support the
>> "vga=" param as far as I understand (it just uses whatever was setup).
> 
> And the vga= is whatever was set up by the realmode code. And the config
> option for realmode code to do that is selected by vesafb and not
> simplefb so it does not wotk for simplefb/simpledrm/whatewer when efifib
> is not built into the kernel.
>

Yes, that's what I tried to say. But your commit message says "To enable
use of VESA modes with simplefb in legacy BIOS boot mode" and that isn't
accurate AFAIU (unless you meant sysfb instead).
 Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

