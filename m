Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912D0C433B4
	for <linux-fbdev@archiver.kernel.org>; Sat, 15 May 2021 16:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D6AE60724
	for <linux-fbdev@archiver.kernel.org>; Sat, 15 May 2021 16:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhEOQWx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 15 May 2021 12:22:53 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:33330 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhEOQWx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 15 May 2021 12:22:53 -0400
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 May 2021 12:22:52 EDT
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id AA83692009C; Sat, 15 May 2021 18:21:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 9B60392009B;
        Sat, 15 May 2021 18:21:37 +0200 (CEST)
Date:   Sat, 15 May 2021 18:21:37 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        syzbot <syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH v2] tty: vt: always invoke vc->vc_sw->con_resize
 callback
In-Reply-To: <97f1d292-c3a8-f4d6-0651-b4f5571ecb72@i-love.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.2105151815040.3032@angie.orcam.me.uk>
References: <0000000000006bbd0c05c14f1b09@google.com> <6e21483c-06f6-404b-4018-e00ee85c456c@i-love.sakura.ne.jp> <87d928e4-b2b9-ad30-f3f0-1dfb8e4e03ed@i-love.sakura.ne.jp> <05acdda8-dc1c-5119-4326-96eed24bea0c@i-love.sakura.ne.jp>
 <CAHk-=wguwhFpjhyMtDaH2hhjoV62gDgByC=aPyTrW9CkM5hqvA@mail.gmail.com> <alpine.DEB.2.21.2105142150460.3032@angie.orcam.me.uk> <CAHk-=wioOHwKNj8AmvXWV-oL60ae0jKswAHy9e6wCYYeA5EQXg@mail.gmail.com> <CAHk-=wjkVAjfWrmmJnJe1_MriK9gezWCew_MU=MbQNzHbGopsQ@mail.gmail.com>
 <97f1d292-c3a8-f4d6-0651-b4f5571ecb72@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, 15 May 2021, Tetsuo Handa wrote:

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 3406067985b1..22bb3892f6bd 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2019,7 +2019,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
>  			return -EINVAL;
>  
>  		pr_debug("resize now %ix%i\n", var.xres, var.yres);
> -		if (con_is_visible(vc)) {
> +		if (con_is_visible(vc) && vc->vc_mode == KD_TEXT) {
>  			var.activate = FB_ACTIVATE_NOW |
>  				FB_ACTIVATE_FORCE;
>  			fb_set_var(info, &var);

 LGTM, although I'll yet try to verify it with hardware.  But it'll have 
to wait another week or so as I'm currently away from my lab and this 
requires physical presence.

Reviewed-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej
