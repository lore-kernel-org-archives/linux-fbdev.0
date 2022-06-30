Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EA9C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 30 Jun 2022 19:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiF3TSy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 30 Jun 2022 15:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiF3TSx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 30 Jun 2022 15:18:53 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099E4338A7
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:18:53 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id i17so603608qvo.13
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7pML6UMsrO1AGKh9xvcZgROuleHW3uaJmPAn03Yhfg=;
        b=y7QJvOtsGXXv4ltWDVmmt6i6C9VfVwUGZkC8IyWpTcP8aH92gY9rV/NKiIczrdGmh4
         0M7/qET07Juf9DbIaeNVqh3Ci0tZsyKAYD9OUXx3BJEmzS3pN2u90sLfelPICzYyJQQY
         lDJ/Wdxg0fj2JtMqbug54jVdxZiHEI9bw4LN5BPs0OothCSMnKbSTs6JE19xpH7b8Z4M
         BDcoEpj8ZGotXwmg4fQXkmxckl6w0UzBKGmGNgzLBl3ESh+p2e1cn+fay7ndrNsLQ2P8
         bxpZUfyte3tpEWra43tzFa62btUMQ9MiGcpRAbW3lWGIyvr5zPzCK+8vlZCHGblTSLb4
         LnuA==
X-Gm-Message-State: AJIora9eLuvLCctO/FqKt2CpzfJPSbD0bGMANu4mq2J1f3HVq2Y2b757
        Oh+cHEz96PE+v5KgNnie09GnI+AfYZf3Uw==
X-Google-Smtp-Source: AGRyM1sbVGD/90WaQ5muoB0KDlsAN2fwqqjUcWe14PhCACVTM/n4MbRN697i1uVMGe80GyDxHtqbYQ==
X-Received: by 2002:a05:6214:2506:b0:470:2c9c:65fa with SMTP id gf6-20020a056214250600b004702c9c65famr13995814qvb.117.1656616732030;
        Thu, 30 Jun 2022 12:18:52 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id bs36-20020a05620a472400b006a6ab8f761csm16905316qkb.62.2022.06.30.12.18.51
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 12:18:51 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id v38so150864ybi.3
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:18:51 -0700 (PDT)
X-Received: by 2002:a25:2b48:0:b0:668:3b7d:326c with SMTP id
 r69-20020a252b48000000b006683b7d326cmr10859442ybr.380.1656616731229; Thu, 30
 Jun 2022 12:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220629200024.187187-1-deller@gmx.de> <20220629200024.187187-4-deller@gmx.de>
 <CAMuHMdWVe3TPCpEiNks2p1AAc-7KXx8fnEa8J=Qsvc0d+WTL+w@mail.gmail.com>
In-Reply-To: <CAMuHMdWVe3TPCpEiNks2p1AAc-7KXx8fnEa8J=Qsvc0d+WTL+w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Jun 2022 21:18:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU2pFR9NGjSBsyZn7KbV1yeGaS4v-Q8QnckHfFO18K=rg@mail.gmail.com>
Message-ID: <CAMuHMdU2pFR9NGjSBsyZn7KbV1yeGaS4v-Q8QnckHfFO18K=rg@mail.gmail.com>
Subject: Re: [PATCH 3/5] fbcon: Prevent that screen size is smaller than font size
To:     Helge Deller <deller@gmx.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Helge,

On Thu, Jun 30, 2022 at 9:09 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Jun 29, 2022 at 10:00 PM Helge Deller <deller@gmx.de> wrote:
> > We need to prevent that users configure a screen size which is smaller than the
> > currently selected font size. Otherwise rendering chars on the screen will
> > access memory outside the graphics memory region.
> > This patch adds a new function fbcon_modechange_possible() which
> > implements this check and which later may be extended with other checks
> > if necessary.  The new function is called from the FBIOPUT_VSCREENINFO
> > ioctl handler in fbmem.c, which will return -EINVAL if userspace asked
> > for a too small screen size.
> >
> > Signed-off-by: Helge Deller <deller@gmx.de>
> > Cc: stable@vger.kernel.org # v5.4+
>
> Thanks for your patch!
>
> > --- a/drivers/video/fbdev/core/fbcon.c
> > +++ b/drivers/video/fbdev/core/fbcon.c
> > @@ -2736,6 +2736,34 @@ void fbcon_update_vcs(struct fb_info *info, bool all)
> >  }
> >  EXPORT_SYMBOL(fbcon_update_vcs);
> >
> > +/* let fbcon check if it supports a new screen resolution */
> > +int fbcon_modechange_possible(struct fb_info *info, struct fb_var_screeninfo *var)
> > +{
> > +       struct fbcon_ops *ops = info->fbcon_par;
> > +       struct vc_data *vc;
> > +       int i;
> > +
> > +       WARN_CONSOLE_UNLOCKED();
> > +
> > +       if (!ops || ops->currcon < 0)
> > +               return -EINVAL;
>
> So if the virtual console is _not_ used as a text console, we refuse
> mode changes?
>
> > +
> > +       /* prevent setting a screen size which is smaller than font size */
> > +       for (i = first_fb_vc; i <= last_fb_vc; i++) {
> > +               vc = vc_cons[i].d;
> > +               if (!vc || vc->vc_mode != KD_TEXT ||
> > +                          registered_fb[con2fb_map[i]] != info)

Looks like registered_fb[] is wrong since commit cad564ca557f8d3b
("fbcon: Fix boundary checks for fbcon=vc:n1-n2 parameters")?

> > +                       continue;
> > +
> > +               if (vc->vc_font.width  > FBCON_SWAP(var->rotate, var->xres, var->yres) ||
> > +                   vc->vc_font.height > FBCON_SWAP(var->rotate, var->yres, var->xres))
> > +                       return -EINVAL;
> > +       }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
