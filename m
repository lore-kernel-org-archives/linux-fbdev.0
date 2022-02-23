Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3167C433FE
	for <linux-fbdev@archiver.kernel.org>; Wed, 23 Feb 2022 17:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243238AbiBWRIX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243254AbiBWRIW (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 23 Feb 2022 12:08:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8897869CC1
        for <linux-fbdev@vger.kernel.org>; Wed, 23 Feb 2022 09:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645636072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/lDTI0t8i1/9SFZQVCSdA4ArXAFqxYpZ/S4YM79am4=;
        b=a2HcX/Mr+u0yvCBj3OIOE4UjYukz4bhtqDwafnRuLbk8MfSQGnLc0jgnyxDegav8o0GCmh
        1yk0FcOidDYn/UN0srXKrngiOTxmL5l8DtK6vpDERjVm0OrwYTcbxq1jFHt5z8vMCoA25V
        kEZA80J1gybsEJuA+snDqZorlrAJXa4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-vSKePdJcOlib-xQnuGvTUw-1; Wed, 23 Feb 2022 12:07:51 -0500
X-MC-Unique: vSKePdJcOlib-xQnuGvTUw-1
Received: by mail-wm1-f72.google.com with SMTP id w3-20020a7bc743000000b0037c5168b3c4so1388848wmk.7
        for <linux-fbdev@vger.kernel.org>; Wed, 23 Feb 2022 09:07:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Y/lDTI0t8i1/9SFZQVCSdA4ArXAFqxYpZ/S4YM79am4=;
        b=jV7iBKzESyhMKLl+IG0lMD2puAcrK/FFZp5qCE4HJmxkQHt36ZmXpD0RsJxOKmdrG7
         OnAvcpsGpDniYBPH9mNdeLZPLDct/HvpXtQjmIHCn6OeWGXhTewBtsOqpS8ijXz189cP
         bavg/DC8I6iCs2sQH6y9P08oEBQHQPJxeaX53aWv5b0BFrRb4xp2Ro6umg91/84K2zfH
         AheYwKItwPk7KKtz07z1NS3vOltIjPhnM/lNy7FGRTXSAc3LR9SCThmnqV+NSTwV2CZ1
         oC6+pZjD6RAGVUSvhoXRtziyP6rqMeeI1wAkOcTGPgcRfxsZjeYmX7G0kw929FD5/zXc
         nAMA==
X-Gm-Message-State: AOAM530EutnHOt26lBWaXXKo6jmAqpSQdUlROftCJpVaAIsdbd+n/9De
        FlB727FUW6ee/CiKSp8cKTU6AO9SzGLHrxK+hVQFNXqzr6mhsark7/M7QFzHrT4dzRdh/24zbWq
        +GSwRngA1/23Wf+JIS85bPQE=
X-Received: by 2002:a5d:6d8c:0:b0:1ea:7d52:c05c with SMTP id l12-20020a5d6d8c000000b001ea7d52c05cmr419024wrs.663.1645636069890;
        Wed, 23 Feb 2022 09:07:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKZR4WkrB+FwsLwgzEloqYu3XoJEbjd0+5Z1wDhDJLU+YlKf5ciM8sXEoYOr7Uc1PYibAXgw==
X-Received: by 2002:a5d:6d8c:0:b0:1ea:7d52:c05c with SMTP id l12-20020a5d6d8c000000b001ea7d52c05cmr419005wrs.663.1645636069646;
        Wed, 23 Feb 2022 09:07:49 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j10sm102001wmq.20.2022.02.23.09.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 09:07:48 -0800 (PST)
Message-ID: <15d5a0ce-ca58-e670-99e4-a79e07a0fe22@redhat.com>
Date:   Wed, 23 Feb 2022 18:07:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] simplefb: Enable boot time VESA graphic mode
 selection.
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
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
 <f832a836-b6ee-ffc5-6f83-86c9ba475400@redhat.com>
In-Reply-To: <f832a836-b6ee-ffc5-6f83-86c9ba475400@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/23/22 17:54, Javier Martinez Canillas wrote:
> On 2/23/22 17:45, Michal Suchánek wrote:
> 
> [snip]
> 
>>>>
>>>> To enable use of VESA modes with simplefb in legacy BIOS boot mode drop
>>>
>>> I think you meant "VESA modes with the sysfb driver" ? or something like
>>> that since otherwise it seems that you meant to use it with the simplefb
>>> (drivers/video/fbdev/simplefb.c) fbdev driver, which doesn't support the
>>> "vga=" param as far as I understand (it just uses whatever was setup).
>>
>> And the vga= is whatever was set up by the realmode code. And the config
>> option for realmode code to do that is selected by vesafb and not
>> simplefb so it does not wotk for simplefb/simpledrm/whatewer when efifib
>> is not built into the kernel.
>>
> 
> Yes, that's what I tried to say. But your commit message says "To enable
> use of VESA modes with simplefb in legacy BIOS boot mode" and that isn't
> accurate AFAIU (unless you meant sysfb instead).

In fact, probably the subject line should also be something like following:

firmware: sysfb: Enable boot time VESA graphic mode selection

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

