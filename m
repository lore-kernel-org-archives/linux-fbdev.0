Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9806C433FE
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Dec 2020 16:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B87E23884
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Dec 2020 16:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgLGQoz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 7 Dec 2020 11:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgLGQoz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 7 Dec 2020 11:44:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3EBC061749
        for <linux-fbdev@vger.kernel.org>; Mon,  7 Dec 2020 08:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=hWgEFWxtA5vHvY/cTLZIg3kHkIKYysgYUsDBGEkeogk=; b=vs6tHrh4pKe3hJSYy5Xe3Ww+0a
        HSwtec2B3U9FmlLXWwJocucnGcLp9KhCe0sXThZ2CWB+W2FoPPL4jgPZ2mZKkPUlS6UPZoU9YHHUV
        Lxo1HVMefaxyzIxFMqts04Z90zwT6dVEuN+VrgXWyHz8+nZQS/9H1n8bosuAlYXFHIqmE/EQuKvCc
        uUgihOZi7rGoTtkXqjxaSfH6i0mITrt6pOIquJmISGSTv4e1y0nRLz5wGDKJPnUEJ7u7xk97DzV+w
        c0Yg1nBfBk2tk51ET0AK0RMkRMFDFsu/Zu56iVo7PFeTH2bYydYYq7qf2wqSUiFmyz0imHE2RQ+kC
        u65ItD1g==;
Received: from [2601:1c0:6280:3f0::1494]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmJbj-00031f-GG; Mon, 07 Dec 2020 16:43:28 +0000
Subject: Re: [PATCH v3 02/13] video: fbdev: core: Fix kernel-doc warnings in
 fbmon + fb_notify
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Lee Jones <lee.jones@linaro.org>
Cc:     Alexander Klimov <grandmaster@al2klimov.de>,
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
        Tony Prisk <linux@prisktech.co.nz>
References: <20201206190247.1861316-1-sam@ravnborg.org>
 <20201206190247.1861316-3-sam@ravnborg.org>
 <0fb6ff8b-bea3-c5bc-0d37-8a5fdab41abc@infradead.org>
 <dd81dd0e-9701-8332-63eb-2f159c535d02@suse.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d144fe12-8f05-464e-3c1f-272999b39311@infradead.org>
Date:   Mon, 7 Dec 2020 08:43:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <dd81dd0e-9701-8332-63eb-2f159c535d02@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12/7/20 12:16 AM, Thomas Zimmermann wrote:
> Hi
> 
> Am 06.12.20 um 20:37 schrieb Randy Dunlap:
>> On 12/6/20 11:02 AM, Sam Ravnborg wrote:
>>> Fix kernel-doc warnings reported when using W=1
>>>
>>> v2:
>>>    - Improve subject (Lee)
>>>
>>> v3:
>>>    - Add RETURNS documentation (Thomas)
>>
>> Hi Sam,
>>
>> Yes, RETURNS: will work. It just looks like any kernel-doc section name,
>> such as Context: or Note:.
>> However, the documented format for return info is "Return:".
>> (see Documentation/doc-guide/kernel-doc.rst)
> 
> Thanks for the note. I asked for RETURNS: because the rest of the file appears to be using it. Returns: is certainly the better alternative. I didn't know there was a difference.
> 
> Best regards
> Thomas
> 

I'm not insisting on using Return:
It can stay the same as the rest of the file IMO.

>>
>>
>>> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>>> Cc: Lee Jones <lee.jones@linaro.org>
>>> Cc: Sam Ravnborg <sam@ravnborg.org>
>>> Cc: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>>> Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
>>> ---
>>>   drivers/video/fbdev/core/fb_notify.c | 10 ++++++++++
>>>   drivers/video/fbdev/core/fbmon.c     |  2 +-
>>>   2 files changed, 11 insertions(+), 1 deletion(-)


-- 
~Randy

