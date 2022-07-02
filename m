Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6A4C43334
	for <linux-fbdev@archiver.kernel.org>; Sat,  2 Jul 2022 16:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiGBQ0l (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 2 Jul 2022 12:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiGBQ0j (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 2 Jul 2022 12:26:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25752FD1B
        for <linux-fbdev@vger.kernel.org>; Sat,  2 Jul 2022 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656779192;
        bh=SDqv3erOc/+QmehnfQgcAWWkmR8Gf6EQuzVoY5gdwII=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=iEr0xED/rJ/IwVtavXKvB+oW1883A32pu+1r/lWtIBY7ZJ2xt6Fzovorjmbw0e5UY
         r3cgPDK7/ZQmu37xRgQTpb6TQ0QakTBTBv7imWKMNQ2wo6HtVWK5+lHsQTaxTeEuy1
         zo6THjrOR1sDkVHbclr1O60ntMffQTubzzzHnRb4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.191.144]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1o0QhC2Cww-00SAxx; Sat, 02
 Jul 2022 18:26:32 +0200
Message-ID: <aaa9d0f8-323a-b59f-b626-09bd1b8ebe73@gmx.de>
Date:   Sat, 2 Jul 2022 18:26:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/5] fbmem: Prevent invalid virtual screen sizes in
 fb_set_var()
Content-Language: en-US
To:     =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
References: <20220629200024.187187-1-deller@gmx.de>
 <20220629200024.187187-5-deller@gmx.de>
 <CAMuHMdVJ0PsDyTdGoOHPOKdaR7AffG2FpFmw6fxoNdXx9y-J4A@mail.gmail.com>
 <1ba5f6d6-1c31-a8fb-867b-e2a7fda7da56@gmx.de>
 <CAMuHMdVMp-ywWmDevdZTwHHhdiHnsFhze376guTEMd1T=tb-Pg@mail.gmail.com>
 <CAMuHMdVs1J0kvA2Kinx121vF=35dUEY+1Jrx3sjF3NHoD=wMfQ@mail.gmail.com>
 <f6c687a5-539d-965f-fc2a-6ff3044798a8@mailbox.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <f6c687a5-539d-965f-fc2a-6ff3044798a8@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZLJYPL0WQOBvSoQU77Dl0kjvDDJEI+BDND2RUgQkL1eHT5kdpXa
 tnrhQzwe0nYCiTl51pgssvI/Ex/r5+lHUGu+eamkjInzE6JzIyHu05juP0QYSWOPzNHd5HN
 OcdRPQdopmGvmyVRj25jxbf9FvtPeveYuYZcICyAmtorWEZonl/p2GbausTfGHAsshnZyPd
 8ypK99UliRreD1My3x5OQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rABTlj1YF/8=:33P0vyg/KwTtVAdcfKvyEE
 yXCh8KJvPx7Y5gcrXnXlg0FqGHXCeBXdNimtdulmNXdisCixBxf4P/QCfYRHeycs5RoiizMaz
 X6aL+HM/ClDbIG+QKXnBN0GhMDoUgb2DGeS90k35KoQ3ysLhkOrvid97ToG4rt0cNoudwvp6k
 JXMvDgI+3b6IvEuRSgnXhIiWjKkaPCDRktRqvL5AQkWOsN7CNRst3fslI7igyyGtAu5gK4cGh
 Bab0jrnPSjcipqoiDRhcQW82We22NHh0r5Zv1T1RzeNDygkg6s5wdJ9LpZH/4k+gB6LajaTgn
 QAAq02pTNrLvYk5nMpihHVRtFybb5b3bgmqUwBqo2JN1I92hAW6aha92fNpCW2wX9Oys3xHCF
 7QwcL/krZT5ArLZbAWy2MT8yKEUggsM5F5y9X8IZ/P9s8EkMSFwRb3K/aU/SBZYBqcnacN7tn
 z/qeRAwtShIe5m7v9w7eTrwbXSu2ewTAAl5mBR8evwS/coQQyq8Rwr5yETgaZd1t/bA5E42jL
 wOaAL0M5J7F3Sjp9G93BSdYYF+h6y1IffQHEPYyFLYKMan9ozA12vFnW0vuh6eU/97vllE+IH
 W3AAA+6mdJKD6HROU1mdkk/GTupHtipi1df4OejvBoSVN9tq4WVwwQKim1GyAPnIVYSPWkTsw
 Kew4yX4t5dLT01UuuA3jZEVGVWDabXFYDfkBM12dnSmdDVzKnxmN6aGBGhYLwgwthKivQ6old
 cdvgeZT6yb07UkM2JDN7Q6d7HbuFgqjGaxZunzztimV35TU09jQzDRW6tDhKbOOy1kOMbwvtd
 xr/zL1ayfXU9qHr1w6wUasxdq5Xk07fQq/uJEIxcoCG45FWix5PLbeCic9E/wEb7zxJABINMc
 /yL/S93GpI3F2gOna7nUAVtHiST5huqxdXQYDcm6ELrjnhm8SVNSxX29eHMiPY91FN5ObqOr1
 UCtPiSh/tkOv9yIboTDGJmybc2A9YIYqfiISdtn5oubXNe9EOKkETEOq0O4WrJSUTkqccYl9c
 IZnks0oPUcwf0srey1DwHUYdxlsNuSTW3g6bOXD4xz/dz3CGf0uYjqCzzseDCNRnz7/7UGbfq
 Up3VolG+LvEnEZJNUwloiBgGSeN8Mm4DIoSL/M3mNauS7EGsuXdQnk0dA==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/2/22 14:05, Michel D=C3=A4nzer wrote:
> On 2022-07-01 16:49, Geert Uytterhoeven wrote:
>> On Thu, Jun 30, 2022 at 9:38 PM Geert Uytterhoeven <geert@linux-m68k.or=
g> wrote:
>>> On Thu, Jun 30, 2022 at 9:17 PM Helge Deller <deller@gmx.de> wrote:
>>>> On 6/30/22 21:11, Geert Uytterhoeven wrote:
>>>>> On Wed, Jun 29, 2022 at 10:00 PM Helge Deller <deller@gmx.de> wrote:
>>>>>> Prevent that drivers configure a virtual screen resolution smaller =
than
>>>>>> the physical screen resolution.  This is important, because otherwi=
se we
>>>>>> may access memory outside of the graphics memory area.
>>>>>>
>>>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>>>> Cc: stable@vger.kernel.org # v5.4+
>>>>>
>>>>> Thanks for your patch!
>>>>>
>>>>>> --- a/drivers/video/fbdev/core/fbmem.c
>>>>>> +++ b/drivers/video/fbdev/core/fbmem.c
>>>>>> @@ -1006,6 +1006,12 @@ fb_set_var(struct fb_info *info, struct fb_v=
ar_screeninfo *var)
>>>>>>         if (var->xres < 8 || var->yres < 8)
>>>>>>                 return -EINVAL;
>>>>>>
>>>>>> +       /* make sure virtual resolution >=3D physical resolution */
>>>>>> +       if (WARN_ON(var->xres_virtual < var->xres))
>>>>>> +               var->xres_virtual =3D var->xres;
>>>>>> +       if (WARN_ON(var->yres_virtual < var->yres))
>>>>>> +               var->yres_virtual =3D var->yres;
>>>>>
>>>>> This should be moved below the call to info->fbops->fb_check_var(),
>>>>> so the WARN_ON() catches buggy fbdev drivers, not userspace fuzzers.
>>>>
>>>> Yes, makes sense.
>>>
>>> And print the name of the frame buffer device driver, so people know
>>> who to blame.
>>
>> Or better, do not continue, but return with a failure:
>>
>>     if (WARN(var->xres_virtual < var->xres || var->yres_virtual < var->=
yres,
>>         "%ps for %s is broken\n", info->fbops->fb_check_var, info->fix.=
id)
>>             return -EINVAL;
>
> I'd also recommend WARN(_ON)_ONCE, or users with a broken driver might g=
et spammed.

Yes, that's probably better. Will do.

Thanks!
Helge
