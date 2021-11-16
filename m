Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B0EC433F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Nov 2021 10:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3961761AD2
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Nov 2021 10:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhKPKEm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 16 Nov 2021 05:04:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37738 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233228AbhKPKEk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 16 Nov 2021 05:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637056903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=533DJPrDDxlMGTv0pnxjgO+BwgxyEzDlbPhO6HwlUb4=;
        b=IMJbRc71ULBSUHRPlKAJ1ahgAjNowOWQB2GmfGP+vIwUepZsFkxjbpNP7vsa+u23uSzUzw
        IhsYXBYXk8eMPmSWezzdYvK0kjNCJZ3/DPkgs4g6wLAuBj8OvOEm1W9TwdLqBTFhtcVeUT
        VzDSNKR+SMFOf7JUZ6ZlejVOT3dh0uo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-E9WLAbTPOaKrv0NYFkYEpA-1; Tue, 16 Nov 2021 05:01:41 -0500
X-MC-Unique: E9WLAbTPOaKrv0NYFkYEpA-1
Received: by mail-wm1-f72.google.com with SMTP id v62-20020a1cac41000000b0033719a1a714so1179690wme.6
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Nov 2021 02:01:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=533DJPrDDxlMGTv0pnxjgO+BwgxyEzDlbPhO6HwlUb4=;
        b=lUEiZfzWnKhpe0YvMetk+84aqlvnN5GzZ/mzO0z9s7/wb64534yIaC5QTRnoAtvNSU
         BR61K2SDaHge4bTckgPq0xtMwdFhCQsLD6csacRlSIiSDCx3FUABHNd8rv7LN/Cmeu4O
         4T2BQLwvWS7hgNSb3IuAs/m1LIuTqJy3v+is1dHChUCLRXGQR6nMKN0Tb1pM/FTVxwCx
         BKeEejsGv/WGVOZ+rfL0n9DJDOUk3oalnihyTqb5bcVN//C23gSBk+MjPWGe1QbT9Pm1
         UGLN9AksgDmMxKA58j+tkS6FrqkLFGS3upqcx10DG+uFedAb3Qy3JRTwbPn2wkbaiSoK
         KyQA==
X-Gm-Message-State: AOAM531cWdZYIg3vkP4tU7G+kD+mRC0NsK6exB5nbB7jTfJ+Su8nzqdg
        34/+5UpIPYDOfNPwdY5FGdMKJjmjRGF8/D1cUCmANLpAhBI5o4HU66z6xgSipd76luG2uus+s98
        3M/RoU6ELPnacfdf0kHhwpDY=
X-Received: by 2002:a05:600c:24d:: with SMTP id 13mr6163781wmj.156.1637056900628;
        Tue, 16 Nov 2021 02:01:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlGjWi8alUIqPMmPz5/NWCmPlLiqtCNyw7It2G0hrbpLCRkisY1dNBJt1D//kFA9f//Tcinw==
X-Received: by 2002:a05:600c:24d:: with SMTP id 13mr6163736wmj.156.1637056900360;
        Tue, 16 Nov 2021 02:01:40 -0800 (PST)
Received: from [192.168.1.102] (91.pool90-171-47.dynamic.orange.es. [90.171.47.91])
        by smtp.gmail.com with ESMTPSA id t11sm16568630wrz.97.2021.11.16.02.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 02:01:39 -0800 (PST)
Message-ID: <7cbadb2a-b6e9-f264-9d95-b76c7071af27@redhat.com>
Date:   Tue, 16 Nov 2021 11:01:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] fbdev: Prevent probing generic drivers if a FB is
 already registered
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Peter Jones <pjones@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20211111111120.1344613-1-javierm@redhat.com>
 <CAMuHMdWA2V_KDpcpMw3yRKmN+6YDjmysJoz6D-6JjJs-3+XYTQ@mail.gmail.com>
 <579a584a-68af-d5c9-0547-30cb1592d46f@redhat.com>
 <CAMuHMdWotEN1TtTr7douLkQPkpXE-rQgamM3GOYO1XNHbUiguw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdWotEN1TtTr7douLkQPkpXE-rQgamM3GOYO1XNHbUiguw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Geert,

On 11/16/21 10:43, Geert Uytterhoeven wrote:

[snip]

>>
>> So this is already a fragile solution and $SUBJECT doesn't make things worse
>> IMO. Since not having something like this can lead to issues as reported by:
>>
>> https://lore.kernel.org/all/20211110200253.rfudkt3edbd3nsyj@lahvuun/
>>
>> We could probably do some smarter here by providing a function that checks
>> if the registered fbdev drivers matches the aperture base. But I'm unsure
>> if that's worth it. After all, fbdev drivers are likely to be disabled by
>> most distros soon now that we have the simpledrm driver.
> 
> Checking the aperture base is what was done in all other cases of
> preventing generic (fbdev) drivers from stepping on specific drivers'
> toes...
> 

Ok, I can re-spin the patch checking if the aperture ranges overlap. There's
an apertures_overlap() function in drivers/video/fbdev/core/fbmem.c that can
be exported for fbdev drivers to use.

Another option is to just say that DRM drivers should be built as a module if
the {efi,simple}fb driver are built-in.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

