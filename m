Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347A2C7EE26
	for <linux-fbdev@archiver.kernel.org>; Mon,  8 May 2023 21:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjEHVbW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 8 May 2023 17:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjEHVbU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 8 May 2023 17:31:20 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CD5868B
        for <linux-fbdev@vger.kernel.org>; Mon,  8 May 2023 14:31:18 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so27425106276.0
        for <linux-fbdev@vger.kernel.org>; Mon, 08 May 2023 14:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683581477; x=1686173477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOJR/20LVKyz48EAyeHc1+jVArD8eFRaiPVz2llKJYw=;
        b=xnPwIs1cwDo2FfYER/sCJ/da+7w70ojR2vcIjoTIwWXCv32mMF1zm1BD4+lfb2YBZM
         a2JVJMgplb8WbXqgCdHgK8Kp72gs89jO2wf+8i72UAlWKsMEO+QAvE2kzbL6W+zsK4XX
         5Z8iTG2eG+u2fgFxWPNmnpwDmCvRMpfx0fMcptbYfNamY9350JY8Gd4qdqq2mPQh9kC0
         +x56ZfIKBMwAlE8P63WHOLZVXUP3U77r1pEjelQEPWycVNYaZZsW7RV6EqwWY1pIciet
         mUJNXjEV6P9b/N9Sms+auwR08F+s4xsHpxn7JhrpRdBY15Z66VnYReC0HO7LXkTpsCWj
         0ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683581477; x=1686173477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOJR/20LVKyz48EAyeHc1+jVArD8eFRaiPVz2llKJYw=;
        b=W+PoCvksPdRmcsYPPpWi0B0QCPrFoxF8aprEM0GOV0sJC1R4XixefJZ7VPQE0SCgOC
         qXxCOJ5qNjlUVJvfkcHHspVCHZ++qHXmJZaE0QjYcX1KSSlGSoeYCCrEvBVjym3sNK1c
         sjLSl+0NEWOJWbuhpYvrzuwpmrXsvu1MUDxy6rtmf+L2ZW6IuuLMLoxcxiYJer3SqluA
         mv35QzO4wcoB5Vm1OyHYDtDZD20plSBgsdaY7Pdlxm4sx26D1gWNOyHjII5JCkmAieqv
         mCUTBACZ0mBQKSVxSAQAQh+QVBY9vc6wMGkJ7PYKtIh2vhWFS8LK6cxdPwOKx23FlA0F
         evGA==
X-Gm-Message-State: AC+VfDwQK/IX2aoyv2Udo9QG+i8w6dALz+QR51hqEZUelMfBiQlOrznx
        pFcmVgXREEio3o8n9cu1a1rKp5+vED6RCa8fqC8cgQ==
X-Google-Smtp-Source: ACHHUZ58fReQQ4pRCBtoCz9Lw0P3GVuCrDW/FKsG0+nk/YgPWCXp8EO7CBeqYU//QyxCun6JDuY2iPWmdeq6/W2Qfd0=
X-Received: by 2002:a81:4c4c:0:b0:54f:54c5:70d with SMTP id
 z73-20020a814c4c000000b0054f54c5070dmr13840092ywa.20.1683581477497; Mon, 08
 May 2023 14:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230430-nokia770-regression-v3-0-a6d0a89ffa8b@linaro.org>
 <20230430-nokia770-regression-v3-1-a6d0a89ffa8b@linaro.org>
 <ZFVGMiuRT+e2eVXw@google.com> <CACRpkdZUXOTOK9CObdXuHQx4PMD3ykMKco8X5ijchkZ8cEmQvA@mail.gmail.com>
 <ZFlpYff6I5V6JiH1@google.com>
In-Reply-To: <ZFlpYff6I5V6JiH1@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 May 2023 23:31:06 +0200
Message-ID: <CACRpkdae4+0vsJS71G6dR5PEpMw13JGJAJr9Jyf2T+Z8gOgoxQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] Input: ads7846 - Convert to use software nodes
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Helge Deller <deller@gmx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, May 8, 2023 at 11:28=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, May 08, 2023 at 11:23:44PM +0200, Linus Walleij wrote:

> > > This needs to be
> > >
> > >         return !gpiod_get_value_raw(ts->gpio_pendown);
> >
> > There is no such function. The gpio descriptor runpath simply assumes t=
hat
> > device trees can be trusted.
>
> Sorry, this was supposed to be gpiod_get_raw_value():
>
> https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L28=
54

I missed it, I should have very well understood you meant that one...
I just read the file too sloppily.

> Yeah, we we can land the DT fixes ahead of the driver change that would
> be great. Otherwise we need a temporary application of
> gpiod_get_raw_value().

If the patch is fine I will send it to the SoC tree and ask for it to be
applied as a fix.

Yours,
Linus Walleij
