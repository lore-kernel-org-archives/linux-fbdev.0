Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51201C433DB
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 10:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF16164DA1
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 10:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhA1J76 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 28 Jan 2021 04:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhA1J7x (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 28 Jan 2021 04:59:53 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C9BC061574;
        Thu, 28 Jan 2021 01:59:12 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id f19so5586671ljn.5;
        Thu, 28 Jan 2021 01:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7pfzxki9lheHgOLLzQUHgmk1QHH49lwL5Xi6bGveKqI=;
        b=C5iQTW3T8+J3IZWK6A5QNut7MFv+TbeI1f0Zb7Qjo0SxH2FThG4KpFizCyByRiNb7s
         viTeDmowChDcQ8aNRy0KxaHpOKiDumWRod4N7OszB2XwnahAhLDBiP1p4Eh34nW9ck4X
         c6iMTE2SUHtlRzSq+GVvJrsQ8z4Nq40YZxt+Kp2UpvrTqwnXiR166LxKfl+FW9AUTrt+
         JInyKlot+NlBlvaaK5w6QO1+VeOP2O9MDEz8rYLSbCf8hQH4g+z4p9ZJxPMG0wj+EB+V
         AeR5Qn+WmIUDJ0NS/fYzIauFxJ0PXLlubrIEPMNzFhJiJlCugY/kiim2oHuYgpnnxZAv
         V2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7pfzxki9lheHgOLLzQUHgmk1QHH49lwL5Xi6bGveKqI=;
        b=bs3Kns7SfDsWOQJpo2cpCJZqnXzPv0a1ZmYS55MIDvLXA5siP+M6Upvk3JeQ0+uOwr
         r1tsP1Aojk2AvD3KRCvd6Am7t/86fV2ADj/7AXdonDfEXoQ6nTKcdWCZtgXVhQ6Y4+o2
         39zw4MT0yvhm3mQK9b+ra1LI24k6+jhoxxGsDV7fbGweSPjLHACGl/fI3kg3APaqv0XY
         lku5C7Fr17uGP8JVTl6aSw7x52WSUb6XIk4TUBUOpuFExPvpmfxip/hlFCAjONeudAyq
         iCh3A9aVevJB90hKY5wQEmnCGIpuoG0UPQbhHXgLP7P2XcYk+RilrT6faPxPOjBw1bZy
         6u1g==
X-Gm-Message-State: AOAM533vrgSABH+GwxYEDZPf4WoTu3cS2OtuZTTzjWB83iAIgpUrU5DZ
        D0i9h+moFMGqHX6KNLDZalw=
X-Google-Smtp-Source: ABdhPJyQahjeVdQ9RR/Pj8A7PCSfRelscgLOEjJP1Tv1tX+t766D1pvJb3mrXoIpOblsSeRBhdN7Rg==
X-Received: by 2002:a2e:b8c7:: with SMTP id s7mr7574137ljp.397.1611827951312;
        Thu, 28 Jan 2021 01:59:11 -0800 (PST)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id k20sm1814663ljb.73.2021.01.28.01.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 01:59:10 -0800 (PST)
Date:   Thu, 28 Jan 2021 11:59:08 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     carlis <zhangxuezhi3@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Colin King <colin.king@canonical.com>,
        oliver.graute@kococonnector.com, zhangxuezhi1@yulong.com,
        mh12gx2825@gmail.com, Stefano Brivio <sbrivio@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10] staging: fbtft: add tearing signal detect
Message-ID: <20210128095908.nm5kh4yspza2v27q@kari-VirtualBox>
References: <1611754972-151016-1-git-send-email-zhangxuezhi3@gmail.com>
 <20210127223222.3lavtl3roc4cabso@kari-VirtualBox>
 <20210128094258.000012c3@gmail.com>
 <20210128065233.ji4b7ea54ihyu2l5@kari-VirtualBox>
 <CAMuHMdWK0wbMVJNwSW=pafsyjDVg14h2AX=haJeAkyivehP=JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWK0wbMVJNwSW=pafsyjDVg14h2AX=haJeAkyivehP=JQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Jan 28, 2021 at 10:42:54AM +0100, Geert Uytterhoeven wrote:
> Hi Kari,
> 
> On Thu, Jan 28, 2021 at 7:53 AM Kari Argillander
> <kari.argillander@gmail.com> wrote:
> > On Thu, Jan 28, 2021 at 09:42:58AM +0800, carlis wrote:
> > > On Thu, 28 Jan 2021 00:32:22 +0200
> > > Kari Argillander <kari.argillander@gmail.com> wrote:
> > > > > @@ -82,6 +111,33 @@ enum st7789v_command {
> > > > >   */
> > > > >  static int init_display(struct fbtft_par *par)
> > > > >  {
> > > > > + int rc;
> > > > > + struct device *dev = par->info->device;
> > > > > +
> > > > > + par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0,
> > > > > GPIOD_IN);
> > > > > + if (IS_ERR(par->gpio.te)) {
> > > > > +         rc = PTR_ERR(par->gpio.te);
> > > > > +         dev_err(par->info->device, "Failed to request te
> > > > > gpio: %d\n", rc);
> > > > > +         return rc;
> > > > > + }
> > > >
> > > > You request with optinal and you still want to error out? We could
> > > > just continue and not care about that error. User will be happier if
> > > > device still works somehow.
> 
> devm_gpiod_get_index_optional() returns NULL, not an error, if the
> GPIO is not found.  So if IS_ERR() is the right check.
> 
> And checks for -EPROBE_DEFER can be handled automatically
> by using dev_err_probe() instead of dev_err().

Yeah. Thanks for pointing that clearly.

> > > You mean i just delete this dev_err print ?!
> > > like this:
> > >       par->gpio.te = devm_gpiod_get_index_optional(dev, "te",
> > > 0,GPIOD_IN);
> > >         if (IS_ERR(par->gpio.te))
> > >               return PTR_ERR(par->gpio.te);
> >
> > Not exactly. I'm suggesting something like this.
> >
> > if (IS_ERR(par->gpio.te) == -EPROBE_DEFER) {
> >         return -EPROBE_DEFER;
> >
> > if (IS_ERR(par->gpio.te))
> >         par-gpio.te = NULL;
> >
> > This like beginning of your patch series but the difference is that if
> > EPROBE_DEFER then we will try again later. Any other error and we will
> > just ignore TE gpio. But this is up to you what you want to do. To me
> > this just seems place where this kind of logic can work.

