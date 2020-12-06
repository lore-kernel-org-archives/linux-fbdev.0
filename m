Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECF5C433FE
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 21:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB6522CF6
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 21:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgLFV25 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 16:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbgLFV25 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 16:28:57 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306F1C0613D0
        for <linux-fbdev@vger.kernel.org>; Sun,  6 Dec 2020 13:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=jqZowNSxZx03e2+zHSXuNqp8jokTpKVo8DZ3QyeqECU=; b=SH0G9oTMFItgli83OxaB5dHaGg
        wZGuHDUT7CWXOWN9+0zBUwilZPwg60ASMlG8GBl+p/cyCnrzC8zd3kEVMS4hfjh+j/FvNQ6gDydTS
        7uOJGHEtcHFWNb82cuyFT5RrINZ2AKXrFOKrUIhF2Iz1BeliOtOBbq0tWTloQuC5DY5Lt7N6LcVZZ
        w/xS4uGFzgRnV7z6o3Iwf/MOnJYKkC0+WsQWm1yx3S1Lx3kT/LjnQUNpevAoqzwZ/Lm0hQL2dT5Bh
        0nJKGmLx+YXAsNg7dvgyBoWbgHRi5tZAnuNWj1dlKRvMCgxs1N666ddQnBq+7KcRxlDrrU1dHgkJo
        TPCh9bdA==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1km1ZJ-0006Na-8B; Sun, 06 Dec 2020 21:27:45 +0000
Subject: Re: [PATCH v3 02/13] video: fbdev: core: Fix kernel-doc warnings in
 fbmon + fb_notify
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Gustavo A R Silva <gustavoars@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Rich Felker <dalias@libc.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20201206190247.1861316-1-sam@ravnborg.org>
 <20201206190247.1861316-3-sam@ravnborg.org>
 <0fb6ff8b-bea3-c5bc-0d37-8a5fdab41abc@infradead.org>
 <20201206205132.GA1869030@ravnborg.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <22e4482a-11f7-170f-0981-cf9f4069f00f@infradead.org>
Date:   Sun, 6 Dec 2020 13:27:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201206205132.GA1869030@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12/6/20 12:52 PM, Sam Ravnborg wrote:
> Hi Randy.
> 
> On Sun, Dec 06, 2020 at 11:37:17AM -0800, Randy Dunlap wrote:
>> On 12/6/20 11:02 AM, Sam Ravnborg wrote:
>>> Fix kernel-doc warnings reported when using W=1
>>>
>>> v2:
>>>   - Improve subject (Lee)
>>>
>>> v3:
>>>   - Add RETURNS documentation (Thomas)
>>
>> Hi Sam,
>>
>> Yes, RETURNS: will work. It just looks like any kernel-doc section name,
>> such as Context: or Note:.
>> However, the documented format for return info is "Return:".
>> (see Documentation/doc-guide/kernel-doc.rst)
> OK, like this?

Yes. LGTM.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> I did not fix any existing uses of RETURNS, thats for another patch.
> 
> 	Sam
> 
> commit 03b7c3ecf7cb51b5429ca0ef58a32bb4dc486610
> Author: Sam Ravnborg <sam@ravnborg.org>
> Date:   Sat Nov 28 23:40:49 2020 +0100
> 
>     video: fbdev: core: Fix kernel-doc warnings in fbmon + fb_notify
>     
>     Fix kernel-doc warnings reported when using W=1
>     
>     v2:
>       - Improve subject (Lee)
>     
>     v3:
>       - Add RETURNS documentation (Thomas)
>     
>     v4:
>       - Use Return: not RETURNS (Randy)
>     
>     Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>     Cc: Lee Jones <lee.jones@linaro.org>
>     Cc: Sam Ravnborg <sam@ravnborg.org>
>     Cc: Randy Dunlap <rdunlap@infradead.org>
>     Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>     Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>     Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>


-- 
~Randy
