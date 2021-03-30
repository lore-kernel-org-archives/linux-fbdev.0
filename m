Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EBEC433DB
	for <linux-fbdev@archiver.kernel.org>; Tue, 30 Mar 2021 16:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18DC619C0
	for <linux-fbdev@archiver.kernel.org>; Tue, 30 Mar 2021 16:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhC3QIs (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 30 Mar 2021 12:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhC3QIY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 30 Mar 2021 12:08:24 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CB2C061574
        for <linux-fbdev@vger.kernel.org>; Tue, 30 Mar 2021 09:08:24 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id c16so16994423oib.3
        for <linux-fbdev@vger.kernel.org>; Tue, 30 Mar 2021 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v1jUxjj5V5n03eDiw5YB0C8hg71h+NdCNCSZT32d57I=;
        b=hATVEsRNliJzan/+n74Hg/XJxJOx760se7c62/KF9lNha4XKOQuIrLTXJSKDQuAxlQ
         ZouHlB5mgfl8NtpgRIRvlINSS81M6NjnxEaN5iKkJyK08eGu2SVqBoz/WN/gO3/pnx7v
         wOSllCAj1G5kR1wKiIy2l84D3N9Xjm93VFdsiupnp9ANosCNmjBQnKMZEpvGQOxTXou1
         gTs0H+jrbzm3hxLjhOOtHu32vHUDIGB5uoPrTucwptMFkmkIAPyQYkFnlIZtoCSI6IAx
         0ehsDziHciCD4gM/wACU7nXoXEz+izLdnMKNkk882ayaxE99BNfLuK9XWLj01NmcG5po
         WnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v1jUxjj5V5n03eDiw5YB0C8hg71h+NdCNCSZT32d57I=;
        b=S1lneIbfhowpdFzwxDGB49ArLZTCKLov4yHPBrCHcDGbGL9DUwu9y21ZuDZZLYITW3
         8L96En3INC3Q5NnluhljSKwtpXsI6548LmWmSNkgQ9QqSLpYfXBaP01Xj1uQW4yTkLwo
         ke70oaRB7IEH7pO0Hh4+imF4z9ck7EsHtlZCQEQSyKfM0yJzDHkSuIZYV9OFvvCwPqyf
         w68sq0Co/UR01hSR7I4qZA8JRE9NjEpo2lDRaFCh3sxh7e/4qV3Vc9K+ltz+ueqxVYWr
         3t0LIt9tx0RcBpi/yScCAgLhtYiU33LfTF9S4JhfQxj2v9h5tvs1IVzijSRjYnHwL/li
         4rrw==
X-Gm-Message-State: AOAM5303fmqZCMSZwO6T0utKbWB3dHMT981g4mwUVf0fQXl9mHOMybx8
        uZGPkRI7+/+JkqTuEHrZPsN4nK6u32MvUU4gdg3359g5
X-Google-Smtp-Source: ABdhPJwKUsT+r6LVIMihxZOkGFIj9AhdyQFVhmnXgQgIU2Nv1YKdzY2xyvQNBbPj4bLz3JUi7OnLik525wHJdtmU/bY=
X-Received: by 2002:aca:4748:: with SMTP id u69mr3601361oia.5.1617120503756;
 Tue, 30 Mar 2021 09:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHJvkbsexf7kM-11ZdrM+pHUUyvttB8fyJMfcsQAC1233jp8LA@mail.gmail.com>
 <388b2a9d-0e63-b70f-28ed-6297a524fb76@amd.com> <CAHJvkbuu5WB=QTu0EUgSGcoK6KMbP2j8NA0o+XTdtkwadNpsxg@mail.gmail.com>
 <909002f5-691c-1cbb-1e44-a99217be8791@gmail.com> <CAHJvkbsMY689cK3uq_O+i6jiqgLmSAUcrD43oHxpSsVwyhJ1Mg@mail.gmail.com>
In-Reply-To: <CAHJvkbsMY689cK3uq_O+i6jiqgLmSAUcrD43oHxpSsVwyhJ1Mg@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 30 Mar 2021 12:08:12 -0400
Message-ID: <CADnq5_O3cOD-zPB4kg_+qh=9oa=LayAsP38KK=R8480w7ish_g@mail.gmail.com>
Subject: Re: Interlaced resolutions hang the desktop
To:     Alberto Salvia Novella <es20490446e@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Mar 30, 2021 at 12:06 PM Alberto Salvia Novella
<es20490446e@gmail.com> wrote:
>
> This is why I'm using interlaced:
>
> $ xrandr
> Screen 0: minimum 320 x 200, current 1920 x 1080, maximum 8192 x 8192
> DisplayPort-0 disconnected (normal left inverted right x axis y axis)
> HDMI-0 connected primary 1920x1080+0+0 (normal left inverted right x axis=
 y axis) 16mm x 9mm
>    1920x1080i    60.00*+  50.00    59.94
>    1920x1080     24.00    23.98
>    1280x720      60.00    50.00    59.94
>    1024x768      75.03    70.07    60.00
>    832x624       74.55
>    800x600       72.19    75.00    60.32    56.25
>    720x576       50.00
>    720x576i      50.00
>    720x480       60.00    59.94
>    720x480i      60.00    59.94
>    640x480       75.00    72.81    66.67    60.00    59.94
>    720x400       70.08
> DVI-0 disconnected (normal left inverted right x axis y axis)
>
> I think the driver should only support resolutions that are progressive, =
but also at least of 50Hz.

The supported display modes are dictated by the monitor.  Do you still
have problems with progressive modes?  I'd hate to disable interlaced
modes if they are working fine for others.

Alex


>
> On Tue, 30 Mar 2021 at 15:41, Christian K=C3=B6nig <ckoenig.leichtzumerke=
n@gmail.com> wrote:
>>
>> Mhm, no idea why an interlaced resolution would cause a crash. Maybe som=
e miscalculation in the display code.
>>
>> But apart from that if you just connected your PC to a TV I also wouldn'=
t recommend using an interlaced resolution in the first place.
>>
>> See those resolutions only exists for backward compatibility with analog=
 hardware.
>>
>> I think we would just disable those modes instead of searching for the b=
ug.
>>
>> Regards,
>> Christian.
>>
>> Am 30.03.21 um 11:07 schrieb Alberto Salvia Novella:
>>
>> I guessed so.
>>
>> The GPU is a Radeon HD5870, and the screen is an old Telefunken TV (TLFK=
22LEDPVR1).
>>
>> Since my real display got into repair I used this TV meanwhile, and to m=
y surprise it froze the system.
>>
>> On Tue, 30 Mar 2021 at 10:15, Christian K=C3=B6nig <christian.koenig@amd=
.com> wrote:
>>>
>>> Hi Alberto,
>>>
>>> well what hardware do you have?
>>>
>>> Interlaced resolutions are not used any more on modern hardware, so the=
y
>>> are not well tested.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 30.03.21 um 10:04 schrieb Alberto Salvia Novella:
>>> > The entire desktop hangs after some minutes when using the module
>>> > "radeon" with an interlaced resolution.
>>> >
>>> > Easier to trigger by playing a video on Firefox, at least on kwin_x11=
.
>>> > Wayland didn't exhibit the problem.
>>> >
>>> > Other display drivers, from different computers I have tried, didn't
>>> > allow those interlaced resolutions all together. It seems they know
>>> > there will be problems.
>>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
