Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B47DC433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 19 May 2022 07:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiESHLx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 19 May 2022 03:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiESHLn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 19 May 2022 03:11:43 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE90EBA
        for <linux-fbdev@vger.kernel.org>; Thu, 19 May 2022 00:11:41 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id j6so4144949qkp.9
        for <linux-fbdev@vger.kernel.org>; Thu, 19 May 2022 00:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=REdU6yQ0LkgcyYqOaju3zdpW9ygW1nqPdZvdg9KIbtw=;
        b=us05idt/kWCNIG1gprD2ele4YBPRJ38jyEZVdvEpWq1qVW5X0VtL2oUo8SBHwi9LxL
         HsX/z1MZoYCcbgbrZ/HSzn28ElHMCfsM8l4iRn4w5fs0DQTmRIyWnC4NLa1kcNQFPS+T
         5VsSoo56QULpurH156MIQgEQfBCuKkvrydDiaLXiVfO31c6C9IvYan5QYlkOt3A0fDbE
         TXCumV+DuRMW0zCDpnZDpQxEnPGlYsgFoi5f67FFWO7X2AnnAPifExRAXkWkcJ55ZrRE
         Hxcqj0437qxGoOSJwy42VwGJ8UtuyIE3pU1GIw+mfwqr+OjQiwh48n8yo8Rv1k2Q1xPT
         1jKA==
X-Gm-Message-State: AOAM533xNTxyX8hS2rlvXlr7wTNsP2JfWkdSyZ8Dl+lfeleKG2/3uzOu
        WrNEqmsEWQr/TRoj4SNambKPajPXKhlnwA==
X-Google-Smtp-Source: ABdhPJw0ernwRkDVNSLPrJsycy/O5LKjZ6V9E05UOoJXdFQuHLdimzLeIdIYPo3hNeN7A2C1y0B0Mw==
X-Received: by 2002:a37:4549:0:b0:69f:556c:4e38 with SMTP id s70-20020a374549000000b0069f556c4e38mr2114082qka.202.1652944300154;
        Thu, 19 May 2022 00:11:40 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id t65-20020ae9df44000000b0069fc13ce232sm865036qkf.99.2022.05.19.00.11.36
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 00:11:38 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2fedd26615cso47570507b3.7
        for <linux-fbdev@vger.kernel.org>; Thu, 19 May 2022 00:11:36 -0700 (PDT)
X-Received: by 2002:a81:9b0c:0:b0:2f4:c522:7d3c with SMTP id
 s12-20020a819b0c000000b002f4c5227d3cmr3231864ywg.316.1652944295889; Thu, 19
 May 2022 00:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220518183006.14548-1-tzimmermann@suse.de> <20220518183006.14548-3-tzimmermann@suse.de>
 <20220518185156.GJ163591@kunlun.suse.cz>
In-Reply-To: <20220518185156.GJ163591@kunlun.suse.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 May 2022 09:11:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUws2eJ4pHng4GD0PjuvMj5Hef_y_YyM4fUJV9xdUVuEQ@mail.gmail.com>
Message-ID: <CAMuHMdUws2eJ4pHng4GD0PjuvMj5Hef_y_YyM4fUJV9xdUVuEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/tiny: Add ofdrm for Open Firmware framebuffers
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Michal,

On Wed, May 18, 2022 at 8:54 PM Michal Suchánek <msuchanek@suse.de> wrote:
> On Wed, May 18, 2022 at 08:30:06PM +0200, Thomas Zimmermann wrote:
> > --- a/drivers/gpu/drm/tiny/Kconfig
> > +++ b/drivers/gpu/drm/tiny/Kconfig
> > @@ -51,6 +51,18 @@ config DRM_GM12U320
> >        This is a KMS driver for projectors which use the GM12U320 chipset
> >        for video transfer over USB2/3, such as the Acer C120 mini projector.
> >
> > +config DRM_OFDRM
> > +     tristate "Open Firmware display driver"
> > +     depends on DRM && MMU && PPC
>
> Does this build with !PCI?
>
> The driver uses some PCI functions, so it might possibly break with
> randconfig. I don't think there are practical !PCI PPC configurations.

IIRC, the first PowerMacs didn't have PCI.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
