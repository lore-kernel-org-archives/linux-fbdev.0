Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFFDC0015E
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Jul 2023 12:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjGYMkW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Jul 2023 08:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjGYMkV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Jul 2023 08:40:21 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C0D1992
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Jul 2023 05:40:18 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 36PCeGQT060305;
        Tue, 25 Jul 2023 21:40:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Tue, 25 Jul 2023 21:40:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 36PCeFMV060302
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Jul 2023 21:40:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <41b72295-8eb2-8609-7494-cb8f57c4443a@I-love.SAKURA.ne.jp>
Date:   Tue, 25 Jul 2023 21:40:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Revert "fbcon: Use kzalloc() in fbcon_prepare_logo()"
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Helge Deller <deller@gmx.de>
References: <98b79fbdde69a4a203096eb9c8801045c5a055fb.1690218016.git.geert+renesas@glider.be>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <98b79fbdde69a4a203096eb9c8801045c5a055fb.1690218016.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2023/07/25 2:03, Geert Uytterhoeven wrote:
> The syzbot report turned out to be a false possitive, caused by a KMSAN
> problem.  Indeed, after allocating the buffer, it is fully initialized
> using scr_memsetw().  Hence there is no point in allocating zeroed
> memory, while this does incur some overhead.

I suggest using below description, for this problem was reported by me
using a kernel built with syzbot's config file (i.e. syzbot is irrelevant).

Commit a6a00d7e8ffd ("fbcon: Use kzalloc() in fbcon_prepare_logo()") is
redundant, for the root cause that resulted in a false positive was fixed
by commit 27f644dc5a77 ("x86: kmsan: use C versions of memset16/memset32/
memset64").

