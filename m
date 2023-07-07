Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4162C0015E
	for <linux-fbdev@archiver.kernel.org>; Fri,  7 Jul 2023 11:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjGGLdj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 7 Jul 2023 07:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjGGLdi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 7 Jul 2023 07:33:38 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC34B9E
        for <linux-fbdev@vger.kernel.org>; Fri,  7 Jul 2023 04:33:37 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-c4cb4919bb9so1950344276.3
        for <linux-fbdev@vger.kernel.org>; Fri, 07 Jul 2023 04:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688729617; x=1691321617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMDmR1AyUqqSLlrR4dAl1mTPWPJqJms7W4GVYjDPIGA=;
        b=xiiQaYZq3bDHw91HWI3fRO9UDkLX7hyAFNYDmTVBWHFjkvIZjxGpJ9Ucr1pqYcfkCy
         mZ8qVZI4gHIQAjBqmvS/E0Lu5McUUZMuarBruPYB3Z5vRsXtxYrhontrBigkgUOWMcTh
         AcX/Q+4iYvqSQQhP4CqYV5lOm749u86MZwzKYr+PWH5I2o2upjOC8iQKoaLsHS4ZmX9i
         wduX5j7NLHNyM6waY5iUjI7MOSAgIh63hRMWL+VCYtcrsbS3S8OPN70xEFgGPBQFGdi1
         qUGifkUwapGATJFhAkRv9er8DG50uEop5Wi7WKN1Ync5B+2EBdQZ+fNxjctFco+oSLIX
         sYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688729617; x=1691321617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMDmR1AyUqqSLlrR4dAl1mTPWPJqJms7W4GVYjDPIGA=;
        b=KLj2ZYttOp9yPNcERKGu8u9sSt4DXyHgxSAr+jw/BIb4Mv+ri5JmELhGgI4hcKqdPy
         iVKAmYiiT2xFYSowO6K7IvGy35g28S5LB0/DvvAmtIxLWxnaIQ+l/WuuuMbWUwaaP+F8
         R700t5YcuUhtHpCHWJWKTg4ouEYukg917pa1FLDF452yEduA//3rfHAQwlwX8zIXvTAO
         UzL/EZaaGa+26/2N6Z6MRm3O6JjjKCDZcSiF1jzp/1GAdp2YYbALCY5Rq27+CbuYXiqg
         URVPGJ5oE0amPIK5vbGAm1HiVtdIXi1E72eJ/6n9K/pDMbQEP818VyOaQ9PcXh7cSQdQ
         Mofw==
X-Gm-Message-State: ABy/qLYP/9vht1Rj2zqfsbOqEFnwkCyTHgo/O8f1gUxs00I/DaF3UyNA
        Q0uHpD/0CicDIiv8l5RWyOi83ECUN26jLUM+8EN9zBBo6XBUfDxp
X-Google-Smtp-Source: APBJJlEQSj9eXj+7lnzyovN+ytLh/4DHueGCx30NZ+9pdKgvYoJ0FyPX7RpPM7SVjIqI/EaQCzqVM+GieMin6C25zn0=
X-Received: by 2002:a25:604:0:b0:c5f:d493:c91f with SMTP id
 4-20020a250604000000b00c5fd493c91fmr3740950ybg.61.1688729616893; Fri, 07 Jul
 2023 04:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230707095415.1449376-1-arnd@kernel.org> <20230707095415.1449376-3-arnd@kernel.org>
In-Reply-To: <20230707095415.1449376-3-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Jul 2023 13:33:24 +0200
Message-ID: <CACRpkdbiDUomH8HLkk_jyJZYc+mEmRaFL8-JasDmd=ooSB62Qw@mail.gmail.com>
Subject: Re: [PATCH 3/4] dummycon: limit Arm console size hack to footbridge
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jul 7, 2023 at 11:56=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The dummycon default console size used to be determined by architecture,
> but now this is a Kconfig setting on everything except ARM. Tracing this
> back in the historic git trees, this was used to match the size of VGA
> console or VGA framebuffer on early machines, but nowadays that code is
> no longer used, except probably on the old footbridge/netwinder since
> that is the only one that supports vgacon.
>
> On machines with a framebuffer, booting with DT so far results in always
> using the hardcoded 80x30 size in dummycon, while on ATAGS the setting
> can come from a bootloader specific override. Both seem to be worse
> choices than the Kconfig setting, since the actual text size for fbcon
> also depends on the selected font.
>
> Make this work the same way as everywhere else and use the normal
> Kconfig setting, except for the footbridge with vgacon, which keeps
> using the traditional code. If vgacon is disabled, footbridge can
> also ignore the setting. This means the screen_info only has to be
> provided when either vgacon or EFI are enabled now.
>
> To limit the amount of surprises on Arm, change the Kconfig default
> to the previously used 80x30 setting instead of the usual 80x25.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested this before and after patch and it looks the same on the NetWinder.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

The legacy in the cyber2000 FB driver supports pseudocolor which
makes it a bit hard to rewrite into a simple DRM driver, which is something
I could otherwise look into, it's not a very big or complex driver
after all.

Yours,
Linus Walleij
