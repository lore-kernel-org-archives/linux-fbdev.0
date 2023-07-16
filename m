Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF97EB64DD
	for <linux-fbdev@archiver.kernel.org>; Sun, 16 Jul 2023 21:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGPVW6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 16 Jul 2023 17:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPVW4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 16 Jul 2023 17:22:56 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A601B5
        for <linux-fbdev@vger.kernel.org>; Sun, 16 Jul 2023 14:22:55 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-57045429f76so37378647b3.0
        for <linux-fbdev@vger.kernel.org>; Sun, 16 Jul 2023 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689542575; x=1692134575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehHFd2i1D4cdxDgZXxDtxev4s/OtFUIBV9R8JH1GczI=;
        b=TUANb1xdwg4ApfDT153qsO6QCznb5nxHBKEhNirqqCNXAE2sRkK2qbvW49vqxIsAj2
         o2d0ZFedzmRDzUrDHmn0LcAsYOg6z8ZPD+RX6Vqg3LesLA6K8FweiqJ6RiNjb507yS7J
         mdzOgTJygiJIrBrFtehvMOuu6AhkSN0LytONWTRC2sSOQeK9jfjBPxGgmtKU3x5wVAuk
         pGIeeLly8iAwYCG5ts7WPiV6nwFJ9jkDCjgu5w3cFHMpcmzUjp6oCkVNsHui7JD8NlYY
         /naJzYS/oBC+CDcx7XIUGGVbOkDCjT84b8RociW+eusq3Wx7Uvgx9u/SPNpIoF3bfmLH
         gjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689542575; x=1692134575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehHFd2i1D4cdxDgZXxDtxev4s/OtFUIBV9R8JH1GczI=;
        b=TWS0MBZ56JC0x8oybi+GY8viwS0p5rFuOEyd/Wv5pAiX3egYXnrOFUxXkdoJ4CCyoF
         8Db9K14Nm3dYQ8epwybuBXpuOOIaYfPwfp00nQAsuqMgfYS+wIQNYEjADwVcQnUB+H/q
         ow8/g+cgvHSfEN+NhNmvX1M5CZ7lkiU2XrgW4K0sEUG4/4GdKtViMwZEog1IRXuJ790C
         1abvIdVyklJSSFwH5s/4Q/GnJW4zm0wG/9SCK3XQ8vuFwJtcvWrgM9Lajys9gE/pNsYI
         eZRC1VsRVnUUKG464Q+OjeU7HXb2bX9lgHzMm5kW42L0XJ0OcTodsfuEom5OG+QBK80D
         1aaw==
X-Gm-Message-State: ABy/qLYu5qLCJRrkuvEnriLl5vfx4RNJ6utOQNNbFNFkeoxA5UgufsGj
        +w5HUp8HbdLLIela+aH0uy29dww1z9QWdEJmQ7KZuw==
X-Google-Smtp-Source: APBJJlErNg8Oc3PPMT7Mk+Lfx5QAC/OC92g4sKDGGNguhpK28xKdYtC3K+IjcJQWqeu8+LMrged+MnE1lM++5T7GyW0=
X-Received: by 2002:a0d:eec3:0:b0:577:3fb4:f245 with SMTP id
 x186-20020a0deec3000000b005773fb4f245mr12710224ywe.19.1689542574879; Sun, 16
 Jul 2023 14:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230707095415.1449376-1-arnd@kernel.org> <20230707095415.1449376-3-arnd@kernel.org>
 <CACRpkdbiDUomH8HLkk_jyJZYc+mEmRaFL8-JasDmd=ooSB62Qw@mail.gmail.com> <1c0119cc-7787-4f95-870e-da1c5894625d@app.fastmail.com>
In-Reply-To: <1c0119cc-7787-4f95-870e-da1c5894625d@app.fastmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jul 2023 23:22:43 +0200
Message-ID: <CACRpkdYVQa-p_tA5reK1Biniz6xf9gWm3K8JKCbjr4fO3=GHZQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] dummycon: limit Arm console size hack to footbridge
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jul 7, 2023 at 4:28=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:

> Since you have already spent the time to build and test a kernel with
> this patch, can you do one more test here and check the text size
> reported in the atags on this machine and the actual text sizes you
> get from both vgacon and cyber2000fb?

Heh I tested this then walked out of the office for vacation.

But I can put a note in my calendar to test it when I return to
my equipment!

Yours,
Linus Walleij
