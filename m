Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84282C43334
	for <linux-fbdev@archiver.kernel.org>; Thu, 30 Jun 2022 20:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbiF3UKr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 30 Jun 2022 16:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbiF3UKq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 30 Jun 2022 16:10:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D2845519
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 13:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656619839;
        bh=geEEnwlXYqpsLGPSVAJu1qRckdKwp8OzdGzmlUEcfKo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=U1L1roCAE+9U09+NWBf41CbTJCz2Ts19XMnwCO0+BXpwMtphOD3Yt5Kv5Dzcz3q30
         cy+184RsKz7alIMjoywPykRwa4dHpbO7dEfxsAEFKY4cq+sSLlt3Q3C66bVB7ZGYLG
         37WjstiMg3BlIERhQKyCGq8TYdbZ5uhHhmXeJtZ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.136.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhU5R-1nTHp73QY7-00egBt; Thu, 30
 Jun 2022 22:10:38 +0200
Message-ID: <cae3dc86-8156-eef5-1af4-b16cb2a42849@gmx.de>
Date:   Thu, 30 Jun 2022 22:10:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/5] fbcon: Fix up user-provided virtual screen size
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
References: <20220629200024.187187-1-deller@gmx.de>
 <20220629200024.187187-3-deller@gmx.de>
 <CAMuHMdXJRBywf+h_u1jgA6X7hLSByDDwSkskff47a0BHfd93iA@mail.gmail.com>
 <0c418b7d-474a-3f93-a1fb-2f13c4d19941@gmx.de>
 <CAMuHMdUoMJ6CmiKDh4MW_b-7uoxEF+H6QimsA7SfcE5kjo17vw@mail.gmail.com>
 <d57655b2-44d1-4083-c4e9-ef4f004f2b64@gmx.de>
 <CAMuHMdXk9Kz4-pv7-M9tufj-pruhOZWw_b51fegkr2JSqzL65g@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAMuHMdXk9Kz4-pv7-M9tufj-pruhOZWw_b51fegkr2JSqzL65g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AYK0k/AV2WeQzfoNRsYjBwVfiSTYjGqg9l40Rkl619Wppm3CHJi
 wr5oG4lCEDWTow50ZgrmHUkOI9ZmWVTNUMfoyyPqFKK0Vk/9hOOCtDiJ6q6Z2CUshO0qwfR
 2/2TCSgCiXinJvKqbBo7TVj1Q1dpfEjLdDEcjPNnr7OsyxInp9GaWN36VNmb6jCzejuDNdX
 3WwUKpMHuDdJAxeV/a3+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uanKE6KmmBY=:DMCX/ncb4UJRsKqMxK5ob6
 rzhI1FN7BwUP7MPiqyOoeOJk2dgxGXB8p+hu63ioWKwfy9ntdrKQUvAtwfJSC/3s9ds8fFNlF
 6v7sf0eeD6Zk9qjmzO5ygBivtCB0xaI1+1q67yM6WPU6CncxnUUcHrcJqp5HihxcKBtuIyPcH
 GL3PnRwDfckU9JtcE7rU5A/AA8/40x1v2ka6ScO0rf7H1JVOdFlRO8VaVmaQVsov/ncNO/5Ag
 l1rCQ/Y4uU4uwxClBRvJaGjM1VdX3TjGaNl6UvyhXxt9/59dzRJ1uLAOH1jwA5g3rcTcWwtF5
 6Tbf2V9tbmSzjLrlPZb3JyBrj/RNamBpM5hLCWcKEvXx2zw2KhpQYTMmPUIEcI20vy9N7igKW
 aEydmpAyI9QBQ90E371gNpSTuNnANTi7hG3tZR24YijmbcF7EzC1U64nojKEVqxspAudxTyRi
 8WOQswosWHADuqynk/3nPmdCuy2P8APrVGUKjADT4GaKmKq+gLrPQpdQMZ7dcVz2VbQWo8oTn
 ln8f74TUMQSltV1eJFIir1NQAl22gDbQ+w08hz3POr961BoO6K8ChJg0y5bbriY3qQ1N+CbSM
 GAwSNEpnprMLug6QuP71bv9XhbPenkuIXsMdNgGDLGVONtb1tD+w+FzjeSmJoJIFxlRNL6ZGD
 lx826LHzcxTMIqlwobwpNcCYDaEWdP3KMvw4kAygqTU7YN8MJkhhTHm+BuUgELSF4LwOpoYKY
 7yf4td9ccaNbU+Fq68e78t30aT8n07np4gRRoUyCvNx5jjT9Dy4EUeGjiZPd5SP2rNSRhJi++
 sFvGkJLFYTM9zJr6QncmMo/N/UgX+ql8uBnh7fz1stBUhCDe+KThRx1eTYPitBkaCHXQr+pgu
 qk3s/47DzQRwfNmIgucRUs6R9KlCE1ePEetoQlb8H2lfaRvhGBlzpcxbNLYbQiNCY/NwXEnbh
 fiy9KGTcTyypwV0i8kpI/28j5UcZfbliRbCvYimRX8BbpiAxc03DNvwwFnYbfOS1ghugCMQ0f
 xOHn7DqmvAb7t8WQ0nMWubc1qrCERrK/CPUusHcLa1EMveepCx1SHNyw6RobCVWPeS1HkRHYh
 Rc5CYH7T3SmINDgx4omsOmRpdhTacx4rDmInsPTw9+ZSh8Ea/Gp+IPY6Q==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 6/30/22 22:00, Geert Uytterhoeven wrote:
> Hi Helge,
>
> On Thu, Jun 30, 2022 at 9:46 PM Helge Deller <deller@gmx.de> wrote:
>> On 6/30/22 21:36, Geert Uytterhoeven wrote:
>>> On Thu, Jun 30, 2022 at 9:31 PM Helge Deller <deller@gmx.de> wrote:
>>>> On 6/30/22 21:00, Geert Uytterhoeven wrote:
>>>>> On Wed, Jun 29, 2022 at 10:00 PM Helge Deller <deller@gmx.de> wrote:
>>>>>> The virtual screen size can't be smaller than the physical screen s=
ize.
>>>>>> Based on the general rule that we round up user-provided input if
>>>>>> neccessary, adjust the virtual screen size as well if needed.
>>>>>>
>>>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>>>> Cc: stable@vger.kernel.org # v5.4+
>>>>>
>>>>> Thanks for your patch!
>>>>>
>>>>>> --- a/drivers/video/fbdev/core/fbmem.c
>>>>>> +++ b/drivers/video/fbdev/core/fbmem.c
>>>>>> @@ -1106,6 +1106,11 @@ static long do_fb_ioctl(struct fb_info *info=
, unsigned int cmd,
>>>>>>                         return -EFAULT;
>>>>>>                 console_lock();
>>>>>>                 lock_fb_info(info);
>>>>>> +               /* adjust virtual screen size if user missed it */
>>>>>> +               if (var.xres_virtual < var.xres)
>>>>>> +                       var.xres_virtual =3D var.xres;
>>>>>> +               if (var.yres_virtual < var.yres)
>>>>>> +                       var.yres_virtual =3D var.yres;
>>>>>>                 ret =3D fb_set_var(info, &var);
>>>>>>                 if (!ret)
>>>>>>                         fbcon_update_vcs(info, var.activate & FB_AC=
TIVATE_ALL);
>>>>>
>>>>> Given "[PATCH 4/5] fbmem: Prevent invalid virtual screen sizes in
>>>>> fb_set_var", I don't think we need this patch.
>>>>
>>>> We do.
>>>
>>> Why? It will be caught by [PATCH 4/5].
>>
>> Right, it will be caught by patch #4.
>> But if you drop this part, then everytime a user runs
>>         fbset -xres 800 -yres 600 -xvres 200
>> users will get the KERNEL BUG WARNING (from patch #4) including
>> a kernel backtrace in their syslogs.
>
> No, they will only see that warning if they are using a broken fbdev
> driver that implements .fb_check_var(), but fails to validate or
> update the passed geometry.

IMHO this argument is mood.
That way you put pressure on and need such simple code in
each single driver to fix it up, instead of cleaning it up at a central
place.

Helge
