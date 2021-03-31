Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D043C433ED
	for <linux-fbdev@archiver.kernel.org>; Wed, 31 Mar 2021 18:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2640A60FEA
	for <linux-fbdev@archiver.kernel.org>; Wed, 31 Mar 2021 18:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhCaSCP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 31 Mar 2021 14:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbhCaSB6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 31 Mar 2021 14:01:58 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D43C061574
        for <linux-fbdev@vger.kernel.org>; Wed, 31 Mar 2021 11:01:58 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso19753279oti.11
        for <linux-fbdev@vger.kernel.org>; Wed, 31 Mar 2021 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4K5zPZIuiVluSh09CO3IH0l6Lb1bIIBLcHXwpcKq9tM=;
        b=uvTaLfmdt17NzhHQBrU+oL6u5/FycFTmSMX3HX26baH5iyQJBQA5lzJOcN/ihca4W4
         NXnFbdPD1Lmf+gAG4C5Osfdax0ta6uK0wj2pYuYhh3m/PUfAtbrLQlO1dcrmeI05H1Th
         Kc364HlRP2I1NAYqI4WarCKYFSdANS9R3CPU8qjZwPSH4Gxrqh2sZACShNBob878Kxza
         HcwqXphagey6qUkCEXQ2v7mfmYoCyxbYqzxoLLCa7ORmTAQFPASXRBxekZ5ez0CHMqDa
         ITm13h5WFrX/BqR9YfGDWOISYUT15S9CQVhFss6mnJ3Kph26OLoGywgTN0ei+k0QYj/s
         xd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4K5zPZIuiVluSh09CO3IH0l6Lb1bIIBLcHXwpcKq9tM=;
        b=dmMnIU6SLEIJumBrgdXLVEn6+mqyHVW6DR0l8aUr4NE7JEaCzreX+b2Jid2A5OXO+0
         5yMXolKaVAuAgq+U4sX+1k+vvEA86BfwXiI0sdhcF2yJIGXXA839D9uT8BLEIfIutLhJ
         6kOWC9xdjRrdsDmQk0xy4Q4q6yDqpMEVaW8y3nhCd4kRc9O/IcaEEZaWazCnVUXnxrR7
         DHSLxJKfpVdm2CoJZfhsxhAzVSRYcFwfwdhWNvx0DlB0yGKQDkPZ9IMiCh72bCH8AfZK
         yd+37Mh9W638BJyNbalbV4QDb9En/Ctm50A13QPgqOmyAzUN9zvnsg4eBWzc78OGTBtc
         +CFA==
X-Gm-Message-State: AOAM533eBv1HWJR9/ZL+d8ctD5a/XG3E3Ur3NC7eagf0N5VPWnZexpoM
        EM23/wGUUGPjQtHisI5+7JkTVsZsBdVCLXiBpjE=
X-Google-Smtp-Source: ABdhPJyskPYpxQZF8vBpiOLUII45sLYRLHXeb4avX6Gg05BtCpdc4K7zuIfpRYw+fPN9kXb/3cYSS3NMQ1Rt5RGZ/Sw=
X-Received: by 2002:a9d:7288:: with SMTP id t8mr3760385otj.132.1617213717845;
 Wed, 31 Mar 2021 11:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHJvkbsexf7kM-11ZdrM+pHUUyvttB8fyJMfcsQAC1233jp8LA@mail.gmail.com>
 <CAHJvkbuu5WB=QTu0EUgSGcoK6KMbP2j8NA0o+XTdtkwadNpsxg@mail.gmail.com>
 <909002f5-691c-1cbb-1e44-a99217be8791@gmail.com> <CAHJvkbsMY689cK3uq_O+i6jiqgLmSAUcrD43oHxpSsVwyhJ1Mg@mail.gmail.com>
 <b1137716-d6dd-6572-3d45-d0063caef26e@amd.com> <CAHJvkbvkwAw2-pRo=rvnB98XxgtNCE-QAzv4HZ-KceH-vZkKoA@mail.gmail.com>
 <3d3563f3-f093-f293-e237-b87306a4cede@amd.com> <CAHJvkbvQ-JJ4vhc3MHNiQ2Jb7dpHUTQBcZ4L1KDnSV=WXDPsOA@mail.gmail.com>
 <7914f67b-e011-36ec-3f6d-1614ce96e3c4@amd.com> <CAHJvkbvQ3jTyoHfQjOkSqierLQfFTb7kqZwdfxs86yunvCvj6g@mail.gmail.com>
 <f000cbf3-cea2-c574-2b93-6c5f45ca28e2@amd.com> <CAHJvkbuxkJeXCqh3FYW2q7FREM9-6CQrJ0EYCLp0v_z4SL3h_A@mail.gmail.com>
 <0eee8e42-5da8-1ce3-bff7-fe6e2ab18cde@amd.com> <CAHJvkbvH+yf-O04Jj9CURjaFfaYE9CSzqBQPe5oPuy5U_f3hag@mail.gmail.com>
 <6a71add4-d2d0-c17a-de8a-6e2b6e248483@gmail.com> <CAHJvkbviwB3JLU84P+mb58rvxaKOahO+B9LPMw3n8nGKvTHAOg@mail.gmail.com>
 <e9dd4112-c0d6-8081-8f4a-e857b3097d58@amd.com>
In-Reply-To: <e9dd4112-c0d6-8081-8f4a-e857b3097d58@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 31 Mar 2021 14:01:46 -0400
Message-ID: <CADnq5_PAYJs1GtnpaUuZZDho0Y04wDcCQ__JBOoDquOq6RQ4SA@mail.gmail.com>
Subject: Re: Interlaced resolutions hang the desktop
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Alberto Salvia Novella <es20490446e@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Does disabling pageflipping via the xorg.conf help?

Alex

On Wed, Mar 31, 2021 at 1:40 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Yeah, agree that must be some kind of bug in the upper layer of the stack=
.
>
> Most likely some userspace component is not handling the specialties of i=
nterlacing correctly (different vblank timing every other frame).
>
> It probably only works on Intel and after restarting the display manager =
by coincident.
>
> Sorry, but as I said this is a use case which basically nobody is using a=
ny more and because of this the different parts of the stack are not tested=
 well enough for this.
>
> Christian.
>
> Am 31.03.21 um 17:47 schrieb Alberto Salvia Novella:
>
> Restarting the display manager service works and, more importantly, makes=
 the bug no longer reproducible.
>
> Restarting the window manager doesn't work.
>
> Changing display manager makes the bug still reproducible.
>
> Maybe this is due to xorg-server, isn't it?
>
> On Wed, 31 Mar 2021 at 16:55, Christian K=C3=B6nig <ckoenig.leichtzumerke=
n@gmail.com> wrote:
>>
>> Well the hardware is working fine as far as I can see.
>>
>> Can you try to kill the X server over SSH and see if you then get some s=
creen update?
>>
>> Regards,
>> Christian.
>>
>> Am 31.03.21 um 16:52 schrieb Alberto Salvia Novella:
>>
>> Output.
>>
>> On Wed, 31 Mar 2021 at 16:36, Christian K=C3=B6nig <christian.koenig@amd=
.com> wrote:
>>>
>>> Mhm strange.
>>>
>>> Can you get me the output of "sudo cat /sys/kernel/debug/dri/0/radeon_f=
ence_info" when the problem happens?
>>>
>>> Thanks,
>>> Christian.
>>>
>>> Am 31.03.21 um 16:33 schrieb Alberto Salvia Novella:
>>>
>>> - The computer still replies to ping.
>>> - The journal shows no errors, but a few warnings.
>>> - The mouse doesn't freeze.
>>>
>>> On Wed, 31 Mar 2021 at 10:09, Christian K=C3=B6nig <christian.koenig@am=
d.com> wrote:
>>>>
>>>> Can you access the system over the network and see if there is anythin=
g in the system log?
>>>>
>>>> It sounds like the display stack has crashed, but when the sound keeps=
 playing the system is most likely still responsive over network.
>>>>
>>>> Thanks,
>>>> Christian.
>>>>
>>>> Am 31.03.21 um 10:05 schrieb Alberto Salvia Novella:
>>>>
>>>> What happens is this simple: after a few minutes, about 6 or so, the e=
ntire content of the screen stays still. In some minor situations only the =
applications panel of KDE Plasma.
>>>>
>>>> If music is playing it continues playing, so only graphics are hung. Y=
et in most cases the power button won't shut down the computer, as it usual=
ly does.
>>>>
>>>> At least this is the case using kwin on x11, and not on wayland. It on=
ly happens on "radeon" and not on Intel or "radeonhd".
>>>>
>>>> On Wed, 31 Mar 2021 at 09:48, Christian K=C3=B6nig <christian.koenig@a=
md.com> wrote:
>>>>>
>>>>> Correct, but a TV is intended for videos only. That's why it implemen=
ts only the lower HDMI standard.
>>>>>
>>>>> Interlaced transmits only halve the lines with each frame, so a 60Hz =
mode effectively either becomes a 30Hz mode, halving the vertical resolutio=
n or adaptive motion compensated which the know visual artifacts. Depending=
 on what the deinterlacing setting on your TV is.
>>>>>
>>>>> You could just add a progressive 1920x540@60 or 1920x1080@30 mode man=
ually and would have the same effect with probably better quality. See http=
s://de.wikipedia.org/wiki/Deinterlacing for reference.
>>>>>
>>>>> If you can give us some more information what is happening when the s=
ystem freeze we could try to narrow this down, but we can't spend much time=
 on a very specific use case in a driver which is in maintenance mode.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>> Am 31.03.21 um 09:21 schrieb Alberto Salvia Novella:
>>>>>
>>>>> 24fps is intended for video only. Anything interactive at 24fps, as j=
ust moving the mouse around, is extremely choppy.
>>>>>
>>>>> No way anyone would prefer that over an interlaced resolution or a lo=
wer resolution. That is, by far, the worst option.
>>>>>
>>>>> Just try it on your screen, set it to 24Hz or alike, and tell me your=
 experience. You can't even tell where the mouse is going to go.
>>>>>
>>>>> On Wed, 31 Mar 2021 at 08:44, Christian K=C3=B6nig <christian.koenig@=
amd.com> wrote:
>>>>>>
>>>>>> Hi Alberto,
>>>>>>
>>>>>> well a frame rate of 24Hz is perfectly reasonable for a TV and deskt=
op usage.
>>>>>>
>>>>>> This is probably caused by the TVs limited HDMI bandwidth and a refr=
esh rate of 30/25 Hz for the interlaced mode isn't much better either.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>> Am 30.03.21 um 22:59 schrieb Alberto Salvia Novella:
>>>>>>
>>>>>> The frame-rate at 24Hz is extremely poor for normal desktop usage.
>>>>>>
>>>>>> If the highest resolution, aka 1080p, uses that refresh rate then th=
e desktop will default to that frame-rate.
>>>>>>
>>>>>> Other progressive modes don't exhibit any issue.
>>>>>>
>>>>>> On Tue, 30 Mar 2021 at 18:26, Christian K=C3=B6nig <christian.koenig=
@amd.com> wrote:
>>>>>>>
>>>>>>> Hi Alberto,
>>>>>>>
>>>>>>> I think the driver should only support resolutions that are progres=
sive, but also at least of 50Hz.
>>>>>>>
>>>>>>>
>>>>>>> Why do you think so?, the 24Hz resolution seems to be the native on=
e of the display.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>> Am 30.03.21 um 17:37 schrieb Alberto Salvia Novella:
>>>>>>>
>>>>>>> This is why I'm using interlaced:
>>>>>>>
>>>>>>> $ xrandr
>>>>>>> Screen 0: minimum 320 x 200, current 1920 x 1080, maximum 8192 x 81=
92
>>>>>>> DisplayPort-0 disconnected (normal left inverted right x axis y axi=
s)
>>>>>>> HDMI-0 connected primary 1920x1080+0+0 (normal left inverted right =
x axis y axis) 16mm x 9mm
>>>>>>>    1920x1080i    60.00*+  50.00    59.94
>>>>>>>    1920x1080     24.00    23.98
>>>>>>>    1280x720      60.00    50.00    59.94
>>>>>>>    1024x768      75.03    70.07    60.00
>>>>>>>    832x624       74.55
>>>>>>>    800x600       72.19    75.00    60.32    56.25
>>>>>>>    720x576       50.00
>>>>>>>    720x576i      50.00
>>>>>>>    720x480       60.00    59.94
>>>>>>>    720x480i      60.00    59.94
>>>>>>>    640x480       75.00    72.81    66.67    60.00    59.94
>>>>>>>    720x400       70.08
>>>>>>> DVI-0 disconnected (normal left inverted right x axis y axis)
>>>>>>>
>>>>>>> I think the driver should only support resolutions that are progres=
sive, but also at least of 50Hz.
>>>>>>>
>>>>>>> On Tue, 30 Mar 2021 at 15:41, Christian K=C3=B6nig <ckoenig.leichtz=
umerken@gmail.com> wrote:
>>>>>>>>
>>>>>>>> Mhm, no idea why an interlaced resolution would cause a crash. May=
be some miscalculation in the display code.
>>>>>>>>
>>>>>>>> But apart from that if you just connected your PC to a TV I also w=
ouldn't recommend using an interlaced resolution in the first place.
>>>>>>>>
>>>>>>>> See those resolutions only exists for backward compatibility with =
analog hardware.
>>>>>>>>
>>>>>>>> I think we would just disable those modes instead of searching for=
 the bug.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>> Am 30.03.21 um 11:07 schrieb Alberto Salvia Novella:
>>>>>>>>
>>>>>>>> I guessed so.
>>>>>>>>
>>>>>>>> The GPU is a Radeon HD5870, and the screen is an old Telefunken TV=
 (TLFK22LEDPVR1).
>>>>>>>>
>>>>>>>> Since my real display got into repair I used this TV meanwhile, an=
d to my surprise it froze the system.
>>>>>>>>
>>>>>>>> On Tue, 30 Mar 2021 at 10:15, Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>>>>>>>>>
>>>>>>>>> Hi Alberto,
>>>>>>>>>
>>>>>>>>> well what hardware do you have?
>>>>>>>>>
>>>>>>>>> Interlaced resolutions are not used any more on modern hardware, =
so they
>>>>>>>>> are not well tested.
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>> Am 30.03.21 um 10:04 schrieb Alberto Salvia Novella:
>>>>>>>>> > The entire desktop hangs after some minutes when using the modu=
le
>>>>>>>>> > "radeon" with an interlaced resolution.
>>>>>>>>> >
>>>>>>>>> > Easier to trigger by playing a video on Firefox, at least on kw=
in_x11.
>>>>>>>>> > Wayland didn't exhibit the problem.
>>>>>>>>> >
>>>>>>>>> > Other display drivers, from different computers I have tried, d=
idn't
>>>>>>>>> > allow those interlaced resolutions all together. It seems they =
know
>>>>>>>>> > there will be problems.
>>>>>>>>>
>>>>>>>>
>>>>>>>> _______________________________________________
>>>>>>>> amd-gfx mailing list
>>>>>>>> amd-gfx@lists.freedesktop.org
>>>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
