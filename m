Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC7AC433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 May 2022 00:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiE0A1b (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 26 May 2022 20:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiE0A1a (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 26 May 2022 20:27:30 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF91C6A04E
        for <linux-fbdev@vger.kernel.org>; Thu, 26 May 2022 17:27:29 -0700 (PDT)
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 24R0J1tq032490;
        Thu, 26 May 2022 19:19:02 -0500
Message-ID: <261e84b34ebbf5002ff47c31f8dc8c0e2f2a05f7.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] drm/tiny: Add ofdrm for Open Firmware framebuffers
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Helge Deller <deller@gmx.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Paul Mackerras <paulus@samba.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sam Ravnborg <sam@ravnborg.org>
Date:   Fri, 27 May 2022 10:19:01 +1000
In-Reply-To: <a077bc25-03b3-f8bd-0138-a175a2864943@suse.de>
References: <20220518183006.14548-1-tzimmermann@suse.de>
         <20220518183006.14548-3-tzimmermann@suse.de>
         <20220518185156.GJ163591@kunlun.suse.cz>
         <CAMuHMdUws2eJ4pHng4GD0PjuvMj5Hef_y_YyM4fUJV9xdUVuEQ@mail.gmail.com>
         <29a8201d-3c0c-eeed-81af-92b351880702@suse.de>
         <615c93392bee43e92f0400cfa51957cd955091d3.camel@kernel.crashing.org>
         <a077bc25-03b3-f8bd-0138-a175a2864943@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 2022-05-25 at 18:45 +0200, Thomas Zimmermann wrote:
> I don't mind adding DRM support for BootX displays, but getting the 
> necessary test HW with a suitable Linux seems to be laborious. Would
> a  G4 Powerbook work?

Probably not unfortunately... it's going to be tricky. I might sitll
have some old BootX-based machines somewhere in storage I could try to
dig out, but it might not be worth bothering too much...

Cheers,
Ben.

