Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA3FC433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 30 Jun 2022 19:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbiF3T0q (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 30 Jun 2022 15:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbiF3T0p (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 30 Jun 2022 15:26:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5F943390
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656617197;
        bh=0DHbxziPs0MathoH1SF2+qVkbBZrUDPNAz0Z6UAyt2A=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QLjpIpSkVwMqf7mkpBjU+XAuquyyQTuPa6c0nmovuP8e712Auc0xXmF9uLMpRCJr2
         4625H5vJLJ27k2Ta1DRqTc4f+inDPoWFlKDtcnUFjla3dDp/1hYAAP5Mj9578MPJ3u
         WFsFuCTYGnO+4JA6e8Ka2N9cM5PTEprx/S1nIitI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.136.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZktZ-1oASQk1jFf-00Wq6s; Thu, 30
 Jun 2022 21:26:37 +0200
Message-ID: <2c7c0791-2815-5e52-8959-a4ae179206a5@gmx.de>
Date:   Thu, 30 Jun 2022 21:26:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/5] fbcon: Disallow setting font bigger than screen size
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
References: <20220629200024.187187-1-deller@gmx.de>
 <20220629200024.187187-2-deller@gmx.de>
 <CAMuHMdWW-oh_q7zE6riS8o+tgRmcOxxO_93-FVy9CVCcAOakhg@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAMuHMdWW-oh_q7zE6riS8o+tgRmcOxxO_93-FVy9CVCcAOakhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l5Q5nu6gsNAqI7MD+2NMxKj0W0MUOKZ87/jfhP2L5qBKOmHkK2u
 qrDr8lqa6Ba9rcVEyOU80EEf2uXN+uQXRwtOVmAdbsPRaJp5NduWX2BvWuNG80+G1QVHRbK
 0OXWNmUJowR/C481TI+TLFAjGtK4F00XyB2Xs2UwHa/6/wLAGBRs+4ElHzZQpxyTcKGmksE
 xirqOwqVLZiGb8mVxemrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FGc3X1B9TXU=:FG9I+FYg9rsJT1JGeex4jY
 3dOcqb5fv8qtp/cXJlovlD6yVEwXfzmjh1U68js8rg1rLMgUQMdmRMqO7fBN3D3ZlABT2homX
 9WaZAmwf2CFZ1OjNvjFXvn7iczxaoUVMEKOMl3ZroQmv/wZfhP7aBsPI87mZo3Br6VZfd8iKx
 S7Q6s7KQA+BCJZ9wdc0emDmxN/7PemqSh9ypiqHyk/sF90fbh4vWDvMG667ZYiWV0kz8hNScs
 selESM7XLjOgGu+0yp22lOXrO2oo5xb9je3RjDNf6Zs/NZ0Er+24smAvpvX8QjJPvbqD02Jmd
 OjOInwnYJ/uGO882GBFQnfE05KCotYSlRB0no9I1JGCO0p16mfS5OkNxdye/AqO0KHcTIYRT4
 DHxOWRFY7VNOhl7vUAF1a7kcXN3WsLdFJvRP4z+0IXvbnk3zH9MEl/orDGAyzpMGRIsQ1GzJU
 u07oq5Y/6kqimklZZ7yt3rQJi6QxOS76KrXRwGJjQgoq+umev1Bvlc9asQsDJtTZsuxj7is6s
 B30/83l7Ynf2GLJqtRjNrJq6MXjvGTWjr2Pmh3kUEkz7MNMQutG3vLZ+ay4JNebNi1p125Epl
 yLk9joea0G4ufloihfz+JbaQiUv8O+21WJjYlJbSRhqwm4T8W8x/1Unq2Jf9Z+6MzQ2lLNfCa
 bRzG4+tgvAgq6aYTS2fFUClyD5uvExIgVtAx4CnodtjCKq5MmyTkX8O9uY0fCgouvJB965sHN
 7y1qcVreLs0xikas6y4T9enRF+0+EA+dEi9M8dXlEZpyPcVfMY3wSBw3CqMFfkTqLcnYlQDsP
 C12XMrwLzg8xTN8MkLUXtB1sAj1++TJbd2lHn8OSFYW+pNmPsL+896I6ONpxEkHSJpMvYv+Mz
 1u02ZOp/HqmA6DkUd2N0uua1ylMmTMPdO35WXAGIWmgmPPoF1S24Ox9bHxX17VM/T3uTLGbW8
 Zhv3ySpeSFDfCQtn+RQsB6NU3AfeNGMGvfYehU1JNaTDP/eRqx/BD+W6xV69iZvbfAXoD5LbY
 Y8OdWjS2txea2K37ffTZlVpFXqjMGUEz2+48p6sOIwNt6ETgOknSq+jQ4+CC+mQSu9qdIJP9m
 q8fT4xe54HpilrxWK8XoFFqGVOCuHJLIxC+mhWHLUEyqur1Y0mnCkORWg==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 6/30/22 20:51, Geert Uytterhoeven wrote:
> Hi Helge,
>
> On Wed, Jun 29, 2022 at 10:00 PM Helge Deller <deller@gmx.de> wrote:
>> Prevent that users set a font size which is bigger than the physical sc=
reen.
>> It's unlikely this may happen (because screens are usually much larger =
than the
>> fonts and each font char is limited to 32x32 pixels), but it may happen=
 on
>> smaller screens/LCD displays.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> Thanks for your patch!
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
>> --- a/drivers/video/fbdev/core/fbcon.c
>> +++ b/drivers/video/fbdev/core/fbcon.c
>> @@ -2469,6 +2469,11 @@ static int fbcon_set_font(struct vc_data *vc, st=
ruct console_font *font,
>>         if (charcount !=3D 256 && charcount !=3D 512)
>>                 return -EINVAL;
>>
>> +       /* font bigger than screen resolution ? */
>> +       if (font->width  > FBCON_SWAP(info->var.rotate, info->var.xres,=
 info->var.yres) ||
>> +           font->height > FBCON_SWAP(info->var.rotate, info->var.yres,=
 info->var.xres))
>
> Note that we already have local vars w and h, albeit with the wrong
> signedness.

I don't like the "h" and "w" variables. Maybe something like "fh" for "fon=
t-heigth"
would have been better explaining which kind of "h" is meant.
I assume that's why the patch below didn't used it either.

That said, I'd like to keep it as is (at least for now).

Helge


>> +               return -EINVAL;
>> +
>>         /* Make sure drawing engine can handle the font */
>>         if (!(info->pixmap.blit_x & (1 << (font->width - 1))) ||
>>             !(info->pixmap.blit_y & (1 << (font->height - 1))))
>
> There were already more opportunities for using w and h before...
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

