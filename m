Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9CDC433ED
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Apr 2021 09:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D4E36108B
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Apr 2021 09:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhDSJzw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 19 Apr 2021 05:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbhDSJzv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 19 Apr 2021 05:55:51 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C0FC06174A;
        Mon, 19 Apr 2021 02:55:19 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id r22so27934525ljc.5;
        Mon, 19 Apr 2021 02:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ac+/RDFDZwqxQM1YZG+NKhRwGNKn1wPe8k84YxH283M=;
        b=HKurBa83oYzINv/oZfV8hZ44LSh6xV6T5WewOSna3dYwU6kEDtcHOpYaTFb0LobUpW
         7fdEQ8hb47KZteiK7MjxXBaBun9KGzzieF5X1DEbp6VvMuGlC5Aoty4wyj4CxDhjfh8m
         T9ecaygHZGQFOHHRTl21E7LKNCrjCcQb8tzyF1yVOYT7AnsM4spz/yZGg9ejlC/fVpdH
         VJHyykmZUuZZb5U1GCL03hCV/T27G22vi0vzKmNxO7OIVdG7Ys/LASEYo2db7O73mHMf
         owXhcQk/sA4dE86jDMiDcwXHJzynp9NkB+sP7Yyk8SK1RuZN88MmwDOl2TbAZ/bwp9Cy
         WYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ac+/RDFDZwqxQM1YZG+NKhRwGNKn1wPe8k84YxH283M=;
        b=uEMR+5tXqJsKx5XI9UgHnzJf4ZDoavS+Qz414JFS38fvW3xzw2ygEJgwet2qntqpbJ
         CeGBdnTW4JJAkirBNX6jiUh4gFgDYE/6TIRaqhazuihnZ7yUsXkoB97DIymb11irBgAr
         EWVQwp+bySXXqPaWp8sskGhKtSabvgr8Xav43KxK//JL/FloU/wwBos+zg6qoLb1tszA
         wIyFOXFTiE27FwBeXqSmc0YsaEdkBiQ7h68YwupDZuSm3RxUrZGxZ54/QoyH9y/Rtjok
         auUYVRa1anZzP8jOG94iwRgNaCCIbZxwg3tWKGzNWkBM0AH5frsd5fipbaWtrFuizCC7
         isBA==
X-Gm-Message-State: AOAM532Um6LwjeDtNIlkRta7+m+exs5DIez338nJubBQjvsRabN08dOL
        YXQ2kKcUF2i/Up1x23QSvgW0mx0fnv4hEpjnAzs=
X-Google-Smtp-Source: ABdhPJzjbowagID+0Tq/eUdoUjEEqSw6LDCkb3PwLhpzB3fsLwZpjsdyJweOlmDzPmNZviyxLZpu8VQVfiWbl6dgh2Y=
X-Received: by 2002:a05:651c:1249:: with SMTP id h9mr10822745ljh.141.1618826117706;
 Mon, 19 Apr 2021 02:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <1616945059-8718-1-git-send-email-u0084500@gmail.com>
 <CADiBU3-d3_L8RTeYCirnfjJdG=ea6UVenAi8O8GO_LvOaB7OdA@mail.gmail.com>
 <20210419072229.GA4869@dell> <20210419072317.GB4869@dell> <20210419072403.GC4869@dell>
In-Reply-To: <20210419072403.GC4869@dell>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 19 Apr 2021 17:55:06 +0800
Message-ID: <CADiBU38bMuH00Bcx5hJas2=yAon00ffcGokT4u89vX-LJYuxNA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] mfd: rt4831: Adds support for Richtek RT4831
To:     Lee Jones <lee.jones@linaro.org>
Cc:     lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2021=E5=B9=B44=E6=9C=8819=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:24=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 19 Apr 2021, Lee Jones wrote:
>
> > On Mon, 19 Apr 2021, Lee Jones wrote:
> >
> > > On Mon, 19 Apr 2021, ChiYuan Huang wrote:
> > >
> > > > Hi, Linux mfd reviewers:
> > > >    It's been three weeks not to get any response from you.
> > > > Is there something wrong about this mfd patch?
> > > > If yes, please feel free to let me know.
> > >
> > > Couple of things:
> > >
> > > First, if you think a patch had fallen through the gaps, which does
> > > happen sometimes, it is generally considered acceptable to submit a
> > > [RESEND] ~2 weeks after the initial submission.  FYI: This was such a
> > > patch.  It was not on, or had fallen off of my radar for some reason.
> > >
> > > Secondly, we are really late in the release cycle.  -rc8 has just bee=
n
> > > released.  Quite a few maintainers slow down at ~-rc6.  Particularly
> > > for new drivers.
> > >
> > > No need to resubmit this driver this time.  It is now on my to-review
> > > list and I will tend to it shortly.
> > >
> > > Thanks for your patience.
> >
> > Also you are missing a DT review on patch 4.
>
> ... looks like you forgot to Cc them!
>
Yap, really. I''ll resend patch 4 and cc them. Thx.
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
