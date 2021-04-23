Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4709EC433B4
	for <linux-fbdev@archiver.kernel.org>; Fri, 23 Apr 2021 00:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED0D613A9
	for <linux-fbdev@archiver.kernel.org>; Fri, 23 Apr 2021 00:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhDWA7f (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 22 Apr 2021 20:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhDWA7d (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 22 Apr 2021 20:59:33 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5DDC061574;
        Thu, 22 Apr 2021 17:58:57 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id m7so43166569ljp.10;
        Thu, 22 Apr 2021 17:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N+jXaR0SB+8fxvvMVeDeNfESYRDFwrHiFdNeachsM6Q=;
        b=pYJyKgcMm7jhXAw5yMF2RJTsBTmNftz7BoC6GSRljtvEGlST/ngMHac1C3rDYDmlU2
         DOC8RM6zDBLQwuzOBjqErj+9DEPsf4WjQnthj3xjdeE2LgoZ6uiWfi0dSrLpJiY5yq+6
         OZCXUB0opoMUtqo9Hw/fJpnPzILw6j+tw7d/T3ePlrmZQnZPwEWjl85/+1xGDt3aELtB
         FTC5D0oJWbtd7K0owLKKNYNb1cfwvX2Nofg/NtgZXoutgyj6Vny3WX3tcCQlo2b/5zhu
         UNMjR8Bk892Y2v1da3uIgugWZUhrK4mZw0cIjxNmLYObVXvRON5ix87Avp8shyVzu8zf
         DDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N+jXaR0SB+8fxvvMVeDeNfESYRDFwrHiFdNeachsM6Q=;
        b=c0+cHymFLm1GqDFJLkoxwLUY2tcUVnLsqETEDy/MeNreDgiVnIi3HMQFxXxAxqUF1a
         FVicFZajJ/6x4QhWtB5nS/6FLGmp5a27Ef1OrTvBByQ2PvOfPCE4pkjzcAv+f+80EiJf
         02Xw3Lmqi0TCdAXBbtJV64dRM9UAGLII0O3P5j12WK6nTUcaTazHKIMdaE9T74yCPKB1
         YOTXi7rNEdptdQussoUHcyTCgTiT2ER8SjuDzCNpVGg4m3tJ5abd6KNwXIKgFyBiTA82
         n/87NhS3ADwHoJjX+F3W5FAzBC8QATbKrRqYw9uKp1io6omYeAM0KuZepTUjEpShpuDp
         q9mQ==
X-Gm-Message-State: AOAM532m8zxiPyNQaXcdfP8aigWbMDxmUq/7LSYQDEaxeIcmzOVtXMKz
        SJM+frvVrU6p9pehbhIpwrJTcB9FQVbSx0hIUWjeOif1
X-Google-Smtp-Source: ABdhPJz5Sq2Kl8285SJaqMSuRC+6FB8sKME1fMLn2LVa8SctzGoFZqjKCE5hJjtd4qYhXcU1sB5mCy0wwuI/TPqkV2E=
X-Received: by 2002:a05:651c:10f:: with SMTP id a15mr1038547ljb.153.1619139529165;
 Thu, 22 Apr 2021 17:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <1616945059-8718-1-git-send-email-u0084500@gmail.com>
 <CADiBU3-d3_L8RTeYCirnfjJdG=ea6UVenAi8O8GO_LvOaB7OdA@mail.gmail.com>
 <20210419072229.GA4869@dell> <20210419072317.GB4869@dell> <20210419072403.GC4869@dell>
 <CADiBU38bMuH00Bcx5hJas2=yAon00ffcGokT4u89vX-LJYuxNA@mail.gmail.com>
In-Reply-To: <CADiBU38bMuH00Bcx5hJas2=yAon00ffcGokT4u89vX-LJYuxNA@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 23 Apr 2021 08:58:37 +0800
Message-ID: <CADiBU39F4nHC5U+G+fJJemAJgeYxDimi0cXYkm25+YC8qO5yDA@mail.gmail.com>
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

Hi, Lee:

ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B44=E6=9C=8819=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:55=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Lee Jones <lee.jones@linaro.org> =E6=96=BC 2021=E5=B9=B44=E6=9C=8819=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:24=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Mon, 19 Apr 2021, Lee Jones wrote:
> >
> > > On Mon, 19 Apr 2021, Lee Jones wrote:
> > >
> > > > On Mon, 19 Apr 2021, ChiYuan Huang wrote:
> > > >
> > > > > Hi, Linux mfd reviewers:
> > > > >    It's been three weeks not to get any response from you.
> > > > > Is there something wrong about this mfd patch?
> > > > > If yes, please feel free to let me know.
> > > >
> > > > Couple of things:
> > > >
> > > > First, if you think a patch had fallen through the gaps, which does
> > > > happen sometimes, it is generally considered acceptable to submit a
> > > > [RESEND] ~2 weeks after the initial submission.  FYI: This was such=
 a
> > > > patch.  It was not on, or had fallen off of my radar for some reaso=
n.
> > > >
> > > > Secondly, we are really late in the release cycle.  -rc8 has just b=
een
> > > > released.  Quite a few maintainers slow down at ~-rc6.  Particularl=
y
> > > > for new drivers.
> > > >
> > > > No need to resubmit this driver this time.  It is now on my to-revi=
ew
> > > > list and I will tend to it shortly.
> > > >
> > > > Thanks for your patience.
> > >
> > > Also you are missing a DT review on patch 4.
> >
> > ... looks like you forgot to Cc them!
> >
> Yap, really. I''ll resend patch 4 and cc them. Thx.

Should I resend the patch and loop DT reviewers?
> > --
> > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> > Senior Technical Lead - Developer Services
> > Linaro.org =E2=94=82 Open source software for Arm SoCs
> > Follow Linaro: Facebook | Twitter | Blog
