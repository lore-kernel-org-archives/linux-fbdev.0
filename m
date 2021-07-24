Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC42C4338F
	for <linux-fbdev@archiver.kernel.org>; Sat, 24 Jul 2021 11:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1966260C51
	for <linux-fbdev@archiver.kernel.org>; Sat, 24 Jul 2021 11:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhGXK32 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 24 Jul 2021 06:29:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:55457 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhGXK32 (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 24 Jul 2021 06:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627124983;
        bh=I7mxd5VcyCEIOuEVnYddEO8MCpGzXZD1UMUFjtjuZDw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=a87pv1KwZL6O1bhqDmgpBjeZFyTyfTjqXM8aRp/s4LFJoaUpQiszVWRYKWmKOPl4o
         r7FX3cQCbrgBFc/X5aFJ70sMqXKJIulLEAzVmL+vS/AznIeeiej/iCrai5y1AZN97K
         9a5Droo2pr43ImFy3Itgp9JGdYRSqGHRS8hMQ+DI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([83.52.228.41]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MpDJd-1lIkHo21S3-00qgNc; Sat, 24
 Jul 2021 13:09:43 +0200
Date:   Sat, 24 Jul 2021 13:09:31 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Len Baker <len.baker@gmx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phil Reid <preid@electromag.com.au>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging/fbtft: Remove all strcpy() uses
Message-ID: <20210724110931.GA4709@titan>
References: <20210718133920.15825-1-len.baker@gmx.com>
 <CAHp75VeEA0=KFsfdjCnBm-b9+F+NnFWJ38nkh+qtb85XdXVWog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeEA0=KFsfdjCnBm-b9+F+NnFWJ38nkh+qtb85XdXVWog@mail.gmail.com>
X-Provags-ID: V03:K1:hAZjLwuqO94d/UpjOqeAOLypbiz0VuSzukPMHWa+XYX6Y+vnhZp
 VxQvktFaDZ5Y8LK/xX7J6w8VyPP2Zdix8R3xZ28peruM6aLKmvK6Ee7+Dm9Z0AgGH/YDDD5
 yTVfM0Qbb+awntKxxa4byQJa6oNbM7omU6bzjuW5sHUT7jx/y/3DTqfk+cLj42xHR8aKxAz
 2oc6SnIzFFvckxjGCRa0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:McaxoLakj4E=:dHY9KJtjnMypOmGHVH52iL
 fFYd/jF7e3htCiKPJjevmX5qZ03k6W0JU17BrdPxVSowh/ViXn1cPV5j0fL3szxvkUGqrlv+j
 GTA8DqbQAkycOn1StzpSRKOSuwVvKv7cgcdvkFYTiJ+hkdGit6vu8c82Dk+UfOK3YuhXU5qUH
 ByY0g8NSFjfn83w8Tn6m2eq+w618z8pFtDlQRICFXRkPnW/JCvvAJiL8i9mke7LtaOBLIMBHR
 t9D250XG5APUeYor87wAUnmirqVC/lmAQzU4zPsUjXagawfNs9VT+1hA5C8RWR6r2HB3/tHto
 ZGoMOn340F1ZqqxpqKHci8UyqFd2aANCkxcsdFB9nciq6cYBNpGSI/042vZ08kO29kK33GOy8
 nGlpHwKh4TByWWBgxeeAzyBKdf5XF2M25RIuao9fKlR0GjCXKyGMUI/9KpLgXdwxiXnjs+xD4
 C2xX0w/iFohQku5aDOf+wi0tmpfkbTEceFyyzjjDXX4W5cMk4TfwTIdawKNvnoA6WvyZfVY4s
 niaOCHnfXDldeSLB1DiNQHW3mrpaEQwBfmjVYlotg7bLHAQ3cgZi9/KzAxQkrZBGWTdz9n646
 sO1JXqTqWGFixwFaG/2DocAipSYb5IdQxndnxmvLYfMFySP746V/1zyCci30SEOoouVxv3qqB
 bKFJepRUj1VdokfNdWIzxMC59dpJUMgAU8dc0GW90aKJqvfH1WWVIgoSMEJPo3zjiJDE+xDY6
 i+ew8hNZSRkX0Ce0va1Oltrat2ps43XXAaxpMr72Wy22eG3U20eN8v1sxK1zrK0l5oJ7MlObZ
 rPVMe0/Kv3Ssn9psy7fe+PH2C4XJuuD4uyZ0VALojaRZKtbeBzvI126vCb36HiV/ISAocxXA+
 isc2KAItqIYtOKLEp8iaINq9rmt8sjjOHNPlXXZ9xUNa66LVoitoAVf1c26fZiyIqT9KYXmCa
 o1ufsFC6XyD6OPl2E19syoyaDFXQco0t4UFgZ6nUM83rV0MntZU2JDNskFLRFwcygkM4Ru2Mk
 GuDrHahYVbIafQ5rhh3SbvOe4bOgyv54G7YrOenxvl/8I3dcVUE47+fpiiTiLU27Vs2EkDZva
 4HFQP7ci2vtu3jQXJchNvZ3C/YmsRs79kun
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

On Sun, Jul 18, 2021 at 10:42:42PM +0300, Andy Shevchenko wrote:
> On Sun, Jul 18, 2021 at 4:43 PM Len Baker <len.baker@gmx.com> wrote:
> >
> > strcpy() performs no bounds checking on the destination buffer. This
> > could result in linear overflows beyond the end of the buffer, leading
> > to all kinds of misbehaviors. The safe replacement is strscpy() but in
> > this case it is simpler to add NULL to the first position since we wan=
t
> > to empty the string.
>
> > This is a previous step in the path to remove the strcpy() function.
>
> Any document behind this (something to read on the site(s) more or
> less affiliated with what is going to happen in the kernel) to read
> background?

This is a task of the KSPP (kernel self protection project) [1]

[1] https://github.com/KSPP/linux/issues/88

>
> ...
>
> >                 case -1:
> >                         i++;
> >                         /* make debug message */
> > -                       strcpy(msg, "");
> > +                       msg[0] =3D 0;
>
> Strictly speaking it should be '\0'.

Ok, understood.

>
> >                         j =3D i + 1;
> >                         while (par->init_sequence[j] >=3D 0) {
> >                                 sprintf(str, "0x%02X ", par->init_sequ=
ence[j]);
>
>
> --
> With Best Regards,
> Andy Shevchenko

Thanks for the feedback,
Len
