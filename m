Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471EEC433FE
	for <linux-fbdev@archiver.kernel.org>; Mon, 15 Nov 2021 23:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD9261A09
	for <linux-fbdev@archiver.kernel.org>; Mon, 15 Nov 2021 23:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhKOXau (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:30:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243484AbhKOX2u (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 15 Nov 2021 18:28:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BAAB61882;
        Mon, 15 Nov 2021 23:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637018754;
        bh=rGYlQyxDaD3rF9edRUkWserAGW/waRNxxYO5X77TR0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rHNtf20mOE69yBjq72LUkrANiH0nkEAgcXR7+XtZn5SkPFrx8uLyyYouV+vaWhJdb
         evf224lm2E+vdylYG396rGdoKa0fYKULmw71l3rWcdMVh1MIPBP8qRCkbiGBDB1lNE
         NPvVTe6XjPhS3ShdrbAM/oYdLu4LA+DcQq6MeFE/2SiXN1AkiOZqUt0ISNdc9EDxM2
         3D3IxCQ8sjPwOXZng7CRhMsNaVyQk9u7d858/12Rh0W/5oIeLxWWx9v3q8Pan4AknW
         TksRUI9MN8a7f6x7p8wjWqwAyEu5TU0KzutxtdEOGAPKuf+8XRf6PUsVMkhvSufNbx
         gEFhF/ecEICoQ==
Date:   Mon, 15 Nov 2021 17:30:58 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>,
        Manuel Lauss <mano@roarinelk.homelinux.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fbdev: sh7760fb: document fallthrough cases
Message-ID: <20211115233058.GA116241@embeddedor>
References: <20211115063257.14369-1-rdunlap@infradead.org>
 <CAMuHMdWerZGYz_i8oBK4-ZC+AHZm8c0VW7CXDRX=2PxboWFZ-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWerZGYz_i8oBK4-ZC+AHZm8c0VW7CXDRX=2PxboWFZ-w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Nov 15, 2021 at 09:35:09AM +0100, Geert Uytterhoeven wrote:
> On Mon, Nov 15, 2021 at 7:33 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > Fix fallthrough warnings in sh776fb.c:
> >
> > ../drivers/video/fbdev/sh7760fb.c: In function 'sh7760fb_get_color_info':
> > ../drivers/video/fbdev/sh7760fb.c:138:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >   138 |                 lgray = 1;
> > ../drivers/video/fbdev/sh7760fb.c:143:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >   143 |                 lgray = 1;
> >
> > Just document the current state of code execution/flow.
> >
> > Fixes: 4a25e41831ee ("video: sh7760fb: SH7760/SH7763 LCDC framebuffer driver")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Section 30.4.4 ("Data Format") of the SH7760 Group Hardware
> Manual confirms fall-through is appropriate here (especially for
> the odd 6 bpp mode).
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I'm taking this in my -next tree[1].

Thanks
--
Gustavo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp-misc-fixes
