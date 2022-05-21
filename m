Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFF8C433F5
	for <linux-fbdev@archiver.kernel.org>; Sat, 21 May 2022 02:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242358AbiEUC7W (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 20 May 2022 22:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239452AbiEUC7S (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 20 May 2022 22:59:18 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59272195936
        for <linux-fbdev@vger.kernel.org>; Fri, 20 May 2022 19:59:17 -0700 (PDT)
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 24L2nY8j004405;
        Fri, 20 May 2022 21:49:35 -0500
Message-ID: <615c93392bee43e92f0400cfa51957cd955091d3.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] drm/tiny: Add ofdrm for Open Firmware framebuffers
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Sat, 21 May 2022 12:49:34 +1000
In-Reply-To: <29a8201d-3c0c-eeed-81af-92b351880702@suse.de>
References: <20220518183006.14548-1-tzimmermann@suse.de>
         <20220518183006.14548-3-tzimmermann@suse.de>
         <20220518185156.GJ163591@kunlun.suse.cz>
         <CAMuHMdUws2eJ4pHng4GD0PjuvMj5Hef_y_YyM4fUJV9xdUVuEQ@mail.gmail.com>
         <29a8201d-3c0c-eeed-81af-92b351880702@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, 2022-05-19 at 09:27 +0200, Thomas Zimmermann wrote:

> to build without PCI to see what happens.

If you bring any of the "heuristic" and palette support code in, you
need PCI. I don't see any reason to take it out.

> Those old Macs use BootX, right? BootX is not supported ATM, as I don't 
> have the HW to test. Is there an emulator for it?

It isn't ? When did it break ? :-)

> If anyone what's to make patches for BootX, I'd be happy to add them. 
> The offb driver also supports a number of special cases for palette 
> handling. That might be necessary for ofdrm as well.

The palette handling is useful when using a real Open Firmware
implementation which tends to boot in 8-bit mode, so without palette
things will look ... bad.

It's not necessary when using 16/32 bpp framebuffers which is typically
... what BootX provides :-)

Cheers,
Ben.

> Best regards
> Thomas
> 
> > Gr{oetje,eeting}s,
> > 
> >                          Geert
> > 
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> > 
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                  -- Linus Torvalds
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Ivo Totev

