Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31603C43214
	for <linux-fbdev@archiver.kernel.org>; Sat, 24 Jul 2021 11:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A0EF60BD3
	for <linux-fbdev@archiver.kernel.org>; Sat, 24 Jul 2021 11:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhGXKf1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 24 Jul 2021 06:35:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:59349 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232258AbhGXKfU (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 24 Jul 2021 06:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627125335;
        bh=EbwSnGgErGioLtZ9SjG8svALcdfgzH3xpEgvBjbS5U4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NW4WWrySmiU9reoo2b5sQCrdB5nwVs3zpBCe/qsUaK3AWxAJz1rAxYurXRIC3X10J
         n2w0USAXFhr3W6/yl8vHNJmEOBksUKyIUu2v4OgB//w4YOWveyhw9PTU9dJKiKid1M
         sxW5dG6Pklh2dI5LQKRwH1YMCO5h7PklHsRgAas0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([83.52.228.41]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MqJqD-1lJq7g0veV-00nQM3; Sat, 24
 Jul 2021 13:15:35 +0200
Date:   Sat, 24 Jul 2021 13:15:32 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Len Baker <len.baker@gmx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phil Reid <preid@electromag.com.au>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging/fbtft: Remove all strcpy() uses
Message-ID: <20210724111532.GB4709@titan>
References: <20210718133920.15825-1-len.baker@gmx.com>
 <CAHp75VeEA0=KFsfdjCnBm-b9+F+NnFWJ38nkh+qtb85XdXVWog@mail.gmail.com>
 <CAMuHMdXnhzumSrr=MAkv5nwY2o8xCa4s5zKa9meJTuo0r9yABw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXnhzumSrr=MAkv5nwY2o8xCa4s5zKa9meJTuo0r9yABw@mail.gmail.com>
X-Provags-ID: V03:K1:LGbsxKMon4WHzLQ8n04LauX8j5z6/6dVSMiYxp1Prrj9P7mNSD7
 VvrTqTmzuJO+Bby1BsSsXEiUkIiMS2ODmTipcQb5SvDMgZ1WEiYZz0DkkSyHhLcmwNwd+S9
 ybp/bPhfpueGHvuTB+ab67+ucPZk6a8YBLrFJNWZUWrkn9ewhRyJzmU5+RGxR+Vm3VOVrZA
 Ofe1z9Jp8Frluwpu+X2XQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lXghBVD0FTw=:li5TEGASHZpBFfCNCMHSlm
 O3+bHd/z8R7A6x0kYE9MaMtMv/Hmtv5MgJyGngjyRFspkJJ9i8rzNyGHyq+yap2PMAjEqxL+N
 RnqCtQKzCr5GPXUDG3/edXtjPhokkxUgMgjvATOpmTdKS2urDAmbJN2etpP4C5mcwuDE/aCzi
 SNwWpPFkYugT/FAUrNpU06D7yazycNeYXLQDWijjLcHJ5YtLuyAigrCRk7knv6bpJ2+DhqjJq
 B+vkqDhpCgngmvsNM55n+9PNo3DfDZZ/Rwkwhh6BS/9Tmu38IKvh7A1biRFVZ/IQjMCEcyTfJ
 ecBzpFdXIyuUIDhIRdriXpmbYkHF2gsVh2g++hEzWcvzFVpMgn+FDJkAYC88TN9RpwD19XHtS
 pdE/BinX2+yte69evqy871zw+p3zrDxMpJbs6jWipxlGzRLjkDXDeM2GkAy7nhy5UnnfsBzJp
 dFd569WF3g8sTQaoyQkyp5BkZxu8RCvKhhfFll5cwnSt4ku2YwZ+xG0qDE1dMybiG1hhVC6gq
 9kxmoVPEHY3tlr0MRQ7A6+aPCOzlndZFkjnHyoz1zTUnjVzWE8NwlVJfqyq6EU9tQNf1e5ZxQ
 aiDJVN3QUy09m2Wexd4b/s3pu6Otb3bymZ6nEWMvUAoqJretRhxFFmBp6D9EBdKxPPyvEc/eA
 vxbEjKo9e10EzFPlOQyddkFfJRUZDA08JtGos3UbFkSPYj/zIKV4dyTYCkwYEstt8wbL54Tpp
 VEn23pWF0xyYnfR6rlUSdRibPCw3KEFaLueKVYFQ0LsjOO92lVXHB66IGyFJRh8yH5fTw3HgQ
 oQI2qnCe2V1ho+23xChR5UL7T3bGxJxU2Pkrmm44x2iyoM1H3hlxzPfEbNJZAjhYJfY7oMXOf
 1f8RYE27l5IYbUBlSVjHPXACVY1V2Egq2ZuHMfjEVMG+t9TLzmGKqcuMu6WOXzEeOzndhlmPv
 uKpTokgohCMEviVcbP75bnPHlu4Cu4BmP6ld0h5dKSWNPcAfmZ1KRMOkqm+L5WvyjSzf1ZU1p
 W5Gh5AsAOhwZY/8S6XNvap77VLaS2OkTtSKvk+abRN5Ev2X0sre0Cm+DGwSLGOD8srRFN5JVt
 KGCSqVwTh+ghso4Q+7F9fxlNabiB4laV7nj
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jul 19, 2021 at 09:53:29AM +0200, Geert Uytterhoeven wrote:
> On Sun, Jul 18, 2021 at 9:43 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sun, Jul 18, 2021 at 4:43 PM Len Baker <len.baker@gmx.com> wrote:
> > > strcpy() performs no bounds checking on the destination buffer. This
> > > could result in linear overflows beyond the end of the buffer, leadi=
ng
> > > to all kinds of misbehaviors. The safe replacement is strscpy() but =
in
> > > this case it is simpler to add NULL to the first position since we w=
ant
>
> "NULL" is a pointer value, "NUL" is the character with value zero.

Ok, understood. Thanks.

>
> > > to empty the string.
> >
> > > This is a previous step in the path to remove the strcpy() function.
> >
> > Any document behind this (something to read on the site(s) more or
> > less affiliated with what is going to happen in the kernel) to read
> > background?
> >
> > ...
> >
> > >                 case -1:
> > >                         i++;
> > >                         /* make debug message */
> > > -                       strcpy(msg, "");
>
> While this strcpy() is provably safe at compile-time, and will probably
> be replaced by an assignment to zero by the compiler...
>
> > > +                       msg[0] =3D 0;
> >
> > Strictly speaking it should be '\0'.
> >
> > >                         j =3D i + 1;
> > >                         while (par->init_sequence[j] >=3D 0) {
> > >                                 sprintf(str, "0x%02X ", par->init_se=
quence[j]);
>
> ... the real danger is the
>
>         strcat(msg, str);
>
> on the next line.
> Fortunately this whole debug printing block (including the strcpy)
> can (and should) be rewritten to just use "%*ph".

Ok, I will work on it and I will send a v2 for review. Thanks for the
feedback.

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

Regards,
Len
