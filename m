Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1416FC43334
	for <linux-fbdev@archiver.kernel.org>; Tue, 28 Jun 2022 20:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiF1Url (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 28 Jun 2022 16:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiF1UrU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 28 Jun 2022 16:47:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5B33054D
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Jun 2022 13:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656449225;
        bh=eDoVuzDxCxPi3qPYEVUj47AGfeQXf3K1MJM1MBnMNnE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=A36xpVrH4KLzBeg2k+WtUngyYyw5eZ5kJBHXWEwJOx+aNV5uHLKLL5cwEWJRo7EuD
         v0Qn3uLxmyzhhPGZBtMM3WuGTkRJPc/PMsKhHWg8Wn8MN0neykiVob/Rpib0KuQ6wI
         IP7N4uI4OSKb/mNjaFrmM9wD+/p0miKJg0eKk+qM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.161.166]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3lYB-1o5TAI3CvT-000q0S; Tue, 28
 Jun 2022 22:47:05 +0200
Message-ID: <693f272d-ee01-f4aa-98e6-62e8405340f6@gmx.de>
Date:   Tue, 28 Jun 2022 22:46:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 2/4] fbmem: Prevent invalid virtual screen sizes
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
References: <20220626102853.124108-1-deller@gmx.de>
 <20220626102853.124108-3-deller@gmx.de>
 <CAMuHMdV9atrvjFamenRY8UOVZSS2a+Gxsxxo+WfuCpBfuV+n2A@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAMuHMdV9atrvjFamenRY8UOVZSS2a+Gxsxxo+WfuCpBfuV+n2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uJZqR3Gv30rLWenclLIkvjbmlqAgFgx74GMyiu+I+em35jxbK5a
 KhWWwDwMQW3vyPHvSevAhoGp01/BaIDBL3Jn+CjbzwKDBVcLTV2jGHhLxbz8xMNC6U0ZgfA
 CkZZVNzkqpSPXQn3WNWZk9CsL3Jjqk2ozU7zvEKIAwosm0KLqNnllaI/hYuG37/zUMefgNR
 dIOULSMW6c+kO+n5XR+UA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0KFJK0862s8=:dUfetZndGPARqBBImHvFur
 YylVU56m3JqfooWBITaQCUPt4BFTGtMY99H2hUbWEm/Gul4XLm3iq/ZpDoUDfl4FocceIHUmi
 SzRV/V+0lOjxtyvQuHCyGRUJwb21Eumh4C1mA5sy5ij+XIrvDR5aZA/WXc1hVNuzzakg28LPW
 QFHvxVsmPY2N/4mveW+i6jXAcUeleuSBhUFGraiRLGvEmAUZ9b7AaV8lTda9Lj3mT6mnhA+/i
 RKKDLlbgAP9lldNuCTaUawK6cYgQ+KIXoJnCpEh3SqSaSiQr51XPEyre3catip6SWWKQ1egjU
 OrMJhZCgNRvRpHpielu0CeIoSMU6c3L/Jlos5J5dsRZ+675sk0hQ3jDw5tpv4GZeJKPYRt2Z/
 tw243O2ShNm8WasidInG0h/4IV99Ia0XxLvscHZE5W0I3qJFOdo3JN91e3rksHs+y/r5bmFSA
 QWWPkvh1fGtz1J/cTOb6uhquLoTME+9/ReNzYDMfAyXuRAO6RNdMfzvAr0xt52+OiSrxe5zjq
 kxh9AA6GbR/Q/d9i7PugFmz5e9/8iSrhhbx19wCjNArTXurwkWKlpdcFmaWal4N5K+gKJrUqo
 GF+kJHZtYvT/YWIVGyd45K14iSyR51ZxJ7b48I8byIXbf755jbSTWQnNL8UF2EU0A7UMqk00W
 ukMpjuDs1uURb4XnsnmL80mO5/lbzAN+Yxh9Bn0wti4bWQEIMtc8pFCelmjf4ZaPtbfJAIJxo
 0WtG9elSgP06G7709qjAWptprK8P1FATSfKAKBfnsgaGuJNrtpYH19oAfnJNwrmWJPp8rzHZU
 qyt67sBkPxSsa78LsHFRR+sXtxTw4FoKnbM5V1KRvicVGIRrSlGi/TQzUujaYHXGVkM4VrTcK
 xSAx/Of0jZyxzauSehNLNrv4DrqzU447uAw55tKpffsa0TpSHMdoqqvQRP0GK2zdB5S04r2yc
 pqFSJtot0C3430JiRsY1ZynrE3j1DZIaU17FVQdBX15dxaWb7yK4cplkFqA3qfxQHOgHH4HMm
 exbBSt7wGJlWQywxHk1YGPZWGnNE13nGf/dIqhMAiyrCVwJQWHv8Sdv81Er/cvSTnUk3ILmSp
 E0FCRAz0WprGf6o7FzhJ0c2aWDpNuchIok3D2zvt1fnBH9SEmrka5Z8BA==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Geert,

On 6/28/22 10:36, Geert Uytterhoeven wrote:
> On Sun, Jun 26, 2022 at 12:32 PM Helge Deller <deller@gmx.de> wrote:
>> Prevent that drivers or the user sets the virtual screen resolution
>> smaller than the physical screen resolution.  This is important, becaus=
e
>> otherwise we may access memory outside of the graphics memory area.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Cc: stable@vger.kernel.org # v5.4+
>
> Thanks for your patch, which is now commit fe04405ce5de13a5 ("fbmem:
> Prevent invalid virtual screen sizes") in fbdev/for-next.
>
>> --- a/drivers/video/fbdev/core/fbmem.c
>> +++ b/drivers/video/fbdev/core/fbmem.c
>> @@ -1006,6 +1006,12 @@ fb_set_var(struct fb_info *info, struct fb_var_s=
creeninfo *var)
>>         if (var->xres < 8 || var->yres < 8)
>>                 return -EINVAL;
>>
>> +       /* make sure virtual resolution >=3D physical resolution */
>> +       if (var->xres_virtual < var->xres)
>> +               return -EINVAL;
>> +       if (var->yres_virtual < var->yres)
>> +               return -EINVAL;
>
> This breaks valid use cases (e.g. "fbset -xres <larger-value-than-before=
>") ,
> as the FBIOPUT_VSCREENINFO rule is to round up invalid values,
> if possible.

You are right, fbset doesn't change the virtual screen size (unless the va=
lue
was given), so indeed we need to round up vres values in FBIOPUT_VSCREENIN=
FO.

> Individual drivers may not follow that rule, so you could indeed end up
> with a virtual resolution here if such a driver fails to sanitize var.
> So either you have to move this after the call to fbops.fb_check_var()
> below, and/or change the code to enlarge virtual resolution to match
> physical resolution (at the risk of introducing another regression
> with an obscure driver?).
>
> So I'd go for moving it below.  And perhaps add a WARN(), as this
> is a driver bug?

That was exactly how I implemented in the first round, but changed it
due to feedback.
I'll respin the patch.

Thanks for reviewing that series!

Helge
>>         /* Too huge resolution causes multiplication overflow. */
>>         if (check_mul_overflow(var->xres, var->yres, &unused) ||
>>             check_mul_overflow(var->xres_virtual, var->yres_virtual, &u=
nused))
>
> Note that doing the multiplication overflow check before calling
> fbops.fb_check_var() is fine, as too large values can never be
> rounded up to a valid value.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m=
68k.org
>
> In personal conversations with technical people, I call myself a hacker.=
 But
> when I'm talking to journalists I just say "programmer" or something lik=
e that.
>                                 -- Linus Torvalds

