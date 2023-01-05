Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADA1C3DA7D
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 Jan 2023 13:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjAENdM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 Jan 2023 08:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjAENdK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 Jan 2023 08:33:10 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AE530552
        for <linux-fbdev@vger.kernel.org>; Thu,  5 Jan 2023 05:33:09 -0800 (PST)
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 305DX8wW057642;
        Thu, 5 Jan 2023 22:33:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Thu, 05 Jan 2023 22:33:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.20] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 305DX784057638
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 5 Jan 2023 22:33:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3e818daa-448c-9e36-7059-df26f6ce0075@I-love.SAKURA.ne.jp>
Date:   Thu, 5 Jan 2023 22:33:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] fbcon: Use kzalloc() in fbcon_prepare_logo()
Content-Language: en-US
To:     Alexander Potapenko <glider@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Helge Deller <deller@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <cad03d25-0ea0-32c4-8173-fd1895314bce@I-love.SAKURA.ne.jp>
 <CAMuHMdUH4CU9EfoirSxjivg08FDimtstn7hizemzyQzYeq6b6g@mail.gmail.com>
 <86bdfea2-7125-2e54-c2c0-920f28ff80ce@I-love.SAKURA.ne.jp>
 <CAG_fn=VJrJDNSea6DksLt5uBe_sDu0+8Ofg+ifscOyDdMKj3XQ@mail.gmail.com>
 <Y7a6XkCNTkxxGMNC@phenom.ffwll.local>
 <032386fc-fffb-1f17-8cfd-94b35b6947ee@I-love.SAKURA.ne.jp>
 <Y7bPJzyVpqTK+DMd@phenom.ffwll.local>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Y7bPJzyVpqTK+DMd@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2023/01/05 22:22, Daniel Vetter wrote:
> Oh I was more asking about the fbdev patch. This here sounds a lot more
> something that needs to be discussed with kmsan people, that's definitely
> not my area.
> -Daniel

Commit a6a00d7e8ffd ("fbcon: Use kzalloc() in fbcon_prepare_logo()") was
redundant but not reverting that commit is harmless. You don't need to
worry about this problem. This is a problem for KMSAN people.

