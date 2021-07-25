Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBB0C4338F
	for <linux-fbdev@archiver.kernel.org>; Sun, 25 Jul 2021 14:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA3560F23
	for <linux-fbdev@archiver.kernel.org>; Sun, 25 Jul 2021 14:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhGYNVx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 25 Jul 2021 09:21:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:44023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhGYNVx (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 25 Jul 2021 09:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627221727;
        bh=340oxUqB+pwxiqxWW/cd7DjFI0xOrzq59FIfoXP3S1I=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gbvFuDGOyKNCqw5KidhNLWnATQrXYGbCL60RErsLk8WUUv80FI6ipKOydrqL1w6XY
         2xDmvC5Yf/EsHCQVvDue/mNxqwP4idWefRTY5NBrBfoWVmGXt+gNLgTfG3o5JFM0Bf
         kpi/gLgRJ19i3fu6szYRigGoq2qdxdNQZCfzCEuI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([83.52.228.41]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N63VY-1l1VBu38Wm-016S1K; Sun, 25
 Jul 2021 16:02:06 +0200
Date:   Sun, 25 Jul 2021 16:02:04 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] staging/fbtft: Fix braces coding style
Message-ID: <20210725140204.GB1953@titan>
References: <20210724151411.9531-1-len.baker@gmx.com>
 <20210724151411.9531-4-len.baker@gmx.com>
 <CAMuHMdX6PUr0irndogg=Aa+AFDdiDJMeMWM74mLBkuLrW+zWng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX6PUr0irndogg=Aa+AFDdiDJMeMWM74mLBkuLrW+zWng@mail.gmail.com>
X-Provags-ID: V03:K1:3Eg3v7AELPHXFdoJHGTE5b05uHbis/dRr8ApGFt/g1+gkHNbSSg
 KSHc03AunknsizsegEZKOcG0miDl6Ne1a/radEDdbQ3VP4TJhjoU5qW5U8qCJTxKuJ9qiva
 u91KUIi8wpJOrhsSZLaBz9LJvnmmQNbtRhlk32j3azogf4uNS4mIs7R/t7MeP1II6juDyTl
 K7VvjSL0a7vD9NSEJW5tQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2xiUjm9aORg=:xoqOPOdWGflIJ4WGEGkMFX
 bOCy2BhOi925zBfTtkX8yYLF6T0iQXo9hgeFgB7zzS57DL2EK8UXbCD5MVSiwZwmpT8KTOQBA
 Aj9KHT9jfQ/5a03etCykDe7InMaDfoE0e+rVV7EA+FAa5RrCkfycn7vKCTtzM8YG1qsSy/v47
 KuV1CzL/dLjXr4qKwIbP6MCICTkDCsqWtz1H7C2zCAsbQqWYsXc94T7k4gEMVPoMmRC+QbTxz
 vgtNrbOlVnCWIj5cdXXmlQRvGoWhaTs2G1+xo7egfgnIZmIi36FKVHP9RYdqbTwokJXR66gyl
 aZ2XMylFK2Xt30NYSv+Fzo2ookmxTz089a2UJCs2yuiyYRoA+wNdquQ+ocIhv4xWt+pGBh/Fd
 AtYzoJIplwayVMRtJWx5ZAS0MwGc4tUhKTyHrEPOtEmi4fcf/SXij4pgInsyPaOXYxNL9tBPq
 CBIyZffZ0PA5UaL5e4YQ1nAjVuJRB9V8bhcdHKcuWgBmS51Q8MM862KLT5a0Ey5RSA/sYh0X0
 o+87gwdZSFKmPPRxQhIfjhqhq67xRI8Cx/bDdkJ5brFj0wusgnhD36MsxEyG+O9RlZMVM+q0O
 nFLTcLfjLIMT8Qu8qjEhdxBemT1GibOHaL6HJXztsP2dZoDDv5WjUkyTn8zD6Yaxg3ARt5lCz
 McCFp0E33C+bfLtkUrD2KEf1nsHyL9EUshkWLDI/6zXR67tP8FYQbRvUXGTSZZUNi9sHLylOE
 8b4YFP4SpcCLCroz/O0eQjtN3/MnThINO7+amlF9yEidr8kSRRLSDaRqTXEK0CWOeafkxMLDf
 YodzEnnsa4gMtiSHFU35RYzg48rqs/KTPE4AxCSg0Zc3KD4+v36A5qwFpgIjsqkSdveL2vBi6
 GO3cYaaUy8R65Efn935qlAYLej8IkvF1AMKMEpSxo7scDuTlRUlzS5x+CNfEAX/o4P/KOztin
 UVi3vlWtKghw2Ox0F8zStg+7ujU6rcYNOPgWHQVUzlYf6EWwmHQN++7GpgHYuDtQeeGbsgZ+F
 0jPEjxGjvP3CHbOF/tu1EgbtJITWkLEZuJ7l7X1lMI+/AF5CqHv+fZtbtVJ0FQR2z7T9JCJuj
 6dQnNQI8bD4bJ13eAPboqYD+k5iqbjPtrQI
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

On Sat, Jul 24, 2021 at 08:01:53PM +0200, Geert Uytterhoeven wrote:
> Hi Len,
>
> On Sat, Jul 24, 2021 at 7:44 PM Len Baker <len.baker@gmx.com> wrote:
> > Add braces to the "for" loop and remove braces from the "if" statement=
.
> > This way the kernel coding style is followed.
> >
> > Signed-off-by: Len Baker <len.baker@gmx.com>
>
> Thanks for your patch!
>
> > --- a/drivers/staging/fbtft/fbtft-core.c
> > +++ b/drivers/staging/fbtft/fbtft-core.c
>
> > @@ -1016,10 +1018,9 @@ int fbtft_init_display(struct fbtft_par *par)
> >
> >         i =3D 0;
> >         while (i < FBTFT_MAX_INIT_SEQUENCE) {
> > -               if (par->init_sequence[i] =3D=3D -3) {
> > -                       /* done */
> > -                       return 0;
> > -               }
>
> These braces should not be removed, due to the presence of
> the comment.

Ok, I leave it as is.

Thanks,
Len
