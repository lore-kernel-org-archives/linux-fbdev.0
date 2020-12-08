Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CC1C433FE
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Dec 2020 18:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4707823B51
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Dec 2020 18:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbgLHSDQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Dec 2020 13:03:16 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:51516 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgLHSDQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Dec 2020 13:03:16 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 4EDE380670;
        Tue,  8 Dec 2020 19:02:30 +0100 (CET)
Date:   Tue, 8 Dec 2020 19:02:28 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>
Cc:     Rich Felker <dalias@libc.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gustavo A R Silva <gustavoars@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Peter Jones <pjones@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        linux-arm-kernel@lists.infradead.org,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v3 0/13] drivers/video: W=1 warning fixes
Message-ID: <20201208180123.GA76613@ravnborg.org>
References: <20201206190247.1861316-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206190247.1861316-1-sam@ravnborg.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=bexM8UI-dkrNMHotJ4MA:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Dec 06, 2020 at 08:02:34PM +0100, Sam Ravnborg wrote:
> Following the great work of Lee Jones in other subsystems
> here is a set of patches that address all remaining W=1
> warnings in drivers/video/.
> Lee Jones already fixed all warnings in video/backlight/ so
> this is mostly fbdev related fixes.
> 
> The general approach used were:
> - Fix kernel-doc, this is often very trivial
> - Drop unused local variables
> 
> Build tested on a set of architectures with various configs.
> 
> The patches do not depend on each other and fixes for one driver
> are kept in a single patch.
> 
> v2:
>   - Updated subject of the patches to tell what was fixed (Lee)
>   - Fixed build error in one patch (kernel test robot)
>   - A few editorials updates to the changelog messages
> 
> v3:
>   - Applied patches that was acked - thanks Thomas!
>   - Updated patches after feedback from Randy and Thomas
>   - Added several new patches to cover warnings that triggers
>     with other architectures than the one I used for v1 + v2
>   - Included one sh specific fix that handle a corner-case,
>     let's see what the sh people say to that
>   - One fix to previous set of patches to fix an issue
>     reported by Coverity (By Colin)
> 
> 	Sam
> 
> Sam Ravnborg (13):
>       video: fbdev: hgafb: Fix kernel-doc warnings
>       video: fbdev: core: Fix kernel-doc warnings in fbmon + fb_notify
>       video: fbdev: omapfb: Fix set but not used warnings in hdmi*_core
>       video: fbdev: uvesafb: Fix set but not used warning
>       sh: Fix set but not used warnings with !CONFIG_MMU
>       video: fbdev: sparc drivers: fix kernel-doc warnings for blank_mode
>       video: fbdev: mmp: Fix kernel-doc warning for lcd_spi_write
>       video: fbdev: wmt_ge_rops: Fix function not declared warnings
>       video: fbdev: goldfishfb: Fix defined but not used warning
>       video: fbdev: gbefb: Fix set but not used warning
>       video: fbdev: efifb: Fix set but not used warning for screen_pitch
>       video: fbdev: controlfb: Fix set but not used warnings
>       video: fbdev: sis: Drop useless call to SiS_GetResInfo()

Thanks for the feedback!
All applied to drm-misc-next except the sh patch.

The sh patch will be resend to the sh people as it should go in via the
sh tree.

	Sam
