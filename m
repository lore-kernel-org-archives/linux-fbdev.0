Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9703C6FA82
	for <linux-fbdev@archiver.kernel.org>; Wed, 21 Sep 2022 16:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiIUQ5q (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 21 Sep 2022 12:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIUQ5V (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 21 Sep 2022 12:57:21 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80348329
        for <linux-fbdev@vger.kernel.org>; Wed, 21 Sep 2022 09:57:18 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1280590722dso10003411fac.1
        for <linux-fbdev@vger.kernel.org>; Wed, 21 Sep 2022 09:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3qFaGkY9CCS42x3fMr78U/0joSy0gdPgTA8V50h7rRU=;
        b=CeJQkdEzjtCxNG+rOaYL8BfFRBSeNKLgGsRwxW8pMKv0lYpIip/Hqr9N2ulqjklXbd
         ER6kmWXpra5jlL2OXLwskoiD1EruSdi9QSuO644A22XJP94HfpeA/nwW8293j9fcIHe9
         mn4Y8qEhXwpogUdNimZMQzXdPLHu38zP6mXdRl6eiBKMAquybrn4PLgOkwD6P81TE1e4
         1rr7BYrCQy97UP+NjIbSZ3AhVjgYMA/jNgLv2PjbUYG/BRaEfFmcLOOIOppJckFKUuib
         HCGzW5i4BHki8g+JPleBTp32OKxhSKGNhIqfB0Zng+RVH8gh3qQizMGbMe0eY3T4Clst
         WrwQ==
X-Gm-Message-State: ACrzQf2sOsZZZ4sRsuF2xLYrlBZvZeV5eJOOvN7VIqpSnPX/pUQsvFAj
        bVngLyML9yxd+P2XO9pIcZMFQpZUA8CExA==
X-Google-Smtp-Source: AMsMyM6hp842D2HTEQRFLGUxozcJdoC5me1YQdoN+Zcc0UwBqcfcP/e3Defbctu+FEM7RaIIQuzQPg==
X-Received: by 2002:a05:6870:428c:b0:127:9e5c:3605 with SMTP id y12-20020a056870428c00b001279e5c3605mr5823524oah.170.1663779437603;
        Wed, 21 Sep 2022 09:57:17 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id cg11-20020a056830630b00b0063715f7eef8sm1555924otb.38.2022.09.21.09.57.17
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 09:57:17 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so4351254otu.7
        for <linux-fbdev@vger.kernel.org>; Wed, 21 Sep 2022 09:57:17 -0700 (PDT)
X-Received: by 2002:a5b:506:0:b0:6af:ffac:4459 with SMTP id
 o6-20020a5b0506000000b006afffac4459mr23009053ybp.365.1663778938618; Wed, 21
 Sep 2022 09:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220720142732.32041-1-tzimmermann@suse.de> <20220720142732.32041-11-tzimmermann@suse.de>
 <4715518d0a6ec60349c76414815ae3f6e4ed977e.camel@kernel.crashing.org> <350bdc4b-7fb3-f04f-06ba-0a3a266041a0@suse.de>
In-Reply-To: <350bdc4b-7fb3-f04f-06ba-0a3a266041a0@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 21 Sep 2022 18:48:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVE0X=8tXQAUPR8zUe9vSY1YKiavCxQQ0i7h5Dr1v4HZw@mail.gmail.com>
Message-ID: <CAMuHMdVE0X=8tXQAUPR8zUe9vSY1YKiavCxQQ0i7h5Dr1v4HZw@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] drm/ofdrm: Support color management
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        javierm@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        deller@gmx.de, maxime@cerno.tech, sam@ravnborg.org,
        msuchanek@suse.de, mpe@ellerman.id.au, paulus@samba.org,
        mark.cave-ayland@ilande.co.uk, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On Wed, Sep 21, 2022 at 2:55 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 05.08.22 um 02:19 schrieb Benjamin Herrenschmidt:
> > On Wed, 2022-07-20 at 16:27 +0200, Thomas Zimmermann wrote:
> >> +#if !defined(CONFIG_PPC)
> >> +static inline void out_8(void __iomem *addr, int val)
> >> +{ }
> >> +static inline void out_le32(void __iomem *addr, int val)
> >> +{ }
> >> +static inline unsigned int in_le32(const void __iomem *addr)
> >> +{
> >> +       return 0;
> >> +}
> >> +#endif
> >
> > These guys could just be replaced with readb/writel/readl respectively
> > (beware of the argument swap).
>
> I only added them for COMPILE_TEST. There appears to be no portable
> interface that implements out_le32() and in_le32()?

iowrite32() and ioread32()?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
