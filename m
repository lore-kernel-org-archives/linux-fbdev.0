Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4A6C433ED
	for <linux-fbdev@archiver.kernel.org>; Sat, 15 May 2021 00:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE0A61264
	for <linux-fbdev@archiver.kernel.org>; Sat, 15 May 2021 00:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhEOArJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 14 May 2021 20:47:09 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50295 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhEOArJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 14 May 2021 20:47:09 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 14F0jFEm090525;
        Sat, 15 May 2021 09:45:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp);
 Sat, 15 May 2021 09:45:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 14F0jFti090520
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 15 May 2021 09:45:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] video: fbdev: vga16fb: fix OOB write in
 vga16fb_imageblit()
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
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
References: <0000000000006bbd0c05c14f1b09@google.com>
 <6e21483c-06f6-404b-4018-e00ee85c456c@i-love.sakura.ne.jp>
 <87d928e4-b2b9-ad30-f3f0-1dfb8e4e03ed@i-love.sakura.ne.jp>
 <05acdda8-dc1c-5119-4326-96eed24bea0c@i-love.sakura.ne.jp>
 <CAHk-=wguwhFpjhyMtDaH2hhjoV62gDgByC=aPyTrW9CkM5hqvA@mail.gmail.com>
 <alpine.DEB.2.21.2105142150460.3032@angie.orcam.me.uk>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <543ead9f-08d2-cc9d-e569-78a479378e62@i-love.sakura.ne.jp>
Date:   Sat, 15 May 2021 09:45:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2105142150460.3032@angie.orcam.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2021/05/15 5:25, Maciej W. Rozycki wrote:
>  NB for fbcon the usual ioctl to resize the console is FBIOPUT_VSCREENINFO 
> rather than VT_RESIZEX; fbset(8) uses it, and I actually experimented with 
> it and a TGA-like (SFB+) framebuffer when at my lab last time, as Linux is 
> kind enough to know how to fiddle with its clockchip.  It works just fine.

fbcon_update_vcs() from FBIOPUT_VSCREENINFO is no-op if vc->vc_mode != KD_TEXT
(which is equivalent to "if vc->vc_mode == KD_GRAPHICS" because KD_TEXT0/KD_TEXT1
are treated as KD_TEXT). Then, maybe it is OK to let resize_screen() return -EINVAL
in order to make vc_do_resize() request fail if vc->vc_mode == KD_GRAPHICS.

>  Overall I think it does make sense to resize the text console at any 
> time, even if the visible console (VT) chosen is in the graphics mode, as 
> my understanding (and experience at least with vgacon) is that resizing 
> the console applies globally across all the VTs.  So the intent of the 
> original change appears valid to me, and the choice not to reprogram the 
> visible console and only store the settings for a future use if it's in 
> the graphics mode correct.
>
>  Which means any bug triggered here needs to be fixed elsewhere rather 
> than by making the request fail.

Since syzbot does not trigger this problem with Linus's patch, I think we can
try Linus's patch with

  pr_info_once("Resizing text console while in graphical mode is ignored. Please report if you need this.\n");

added in order to see if somebody wants "only store the settings for a future use".

