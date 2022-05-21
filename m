Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1937C433F5
	for <linux-fbdev@archiver.kernel.org>; Sat, 21 May 2022 01:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348769AbiEUBpW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 20 May 2022 21:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiEUBpU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 20 May 2022 21:45:20 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FEF81912E9
        for <linux-fbdev@vger.kernel.org>; Fri, 20 May 2022 18:45:18 -0700 (PDT)
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 24L1ZFqO002400;
        Fri, 20 May 2022 20:35:16 -0500
Message-ID: <ea7ef1e652f5664a41f2befc3cb97bd089f27e69.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] drm/tiny: Add ofdrm for Open Firmware framebuffers
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Sat, 21 May 2022 11:35:14 +1000
In-Reply-To: <CAMuHMdUws2eJ4pHng4GD0PjuvMj5Hef_y_YyM4fUJV9xdUVuEQ@mail.gmail.com>
References: <20220518183006.14548-1-tzimmermann@suse.de>
         <20220518183006.14548-3-tzimmermann@suse.de>
         <20220518185156.GJ163591@kunlun.suse.cz>
         <CAMuHMdUws2eJ4pHng4GD0PjuvMj5Hef_y_YyM4fUJV9xdUVuEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, 2022-05-19 at 09:11 +0200, Geert Uytterhoeven wrote:
> Hi Michal,
> 
> 
> 
> On Wed, May 18, 2022 at 8:54 PM Michal Suchánek <msuchanek@suse.de>
> wrote:
> 
> > On Wed, May 18, 2022 at 08:30:06PM +0200, Thomas Zimmermann wrote:
> > > --- a/drivers/gpu/drm/tiny/Kconfig
> > > +++ b/drivers/gpu/drm/tiny/Kconfig
> > > @@ -51,6 +51,18 @@ config DRM_GM12U320
> > >         This is a KMS driver for projectors which use the
> > > GM12U320 chipset
> > >         for video transfer over USB2/3, such as the Acer C120
> > > mini projector.
> > > +config DRM_OFDRM
> > > +     tristate "Open Firmware display driver"
> > > +     depends on DRM && MMU && PPC
> > Does this build with !PCI?
> > The driver uses some PCI functions, so it might possibly break with
> > randconfig. I don't think there are practical !PCI PPC
> > configurations.
> 
> 
> IIRC, the first PowerMacs didn't have PCI.

They also don't have OF and we never supported them upstream :-)

Cheers,
Ben.

