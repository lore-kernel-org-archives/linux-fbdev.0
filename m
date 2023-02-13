Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B1FC64ED6
	for <linux-fbdev@archiver.kernel.org>; Mon, 13 Feb 2023 16:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjBMQb4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 13 Feb 2023 11:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjBMQbx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 13 Feb 2023 11:31:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6532C1E1FB
        for <linux-fbdev@vger.kernel.org>; Mon, 13 Feb 2023 08:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=bGNxZYPN8DFGD+DAyTWS3zPGWV5ykBQ5tFyV385U9oc=; b=R4iTn6xH8zDJTusokMQXuA5WPJ
        Oh+/9/zhQ1iGYv06sWa4L39n+21g1lSA8X0KLvTooiD4limw8fjBX+LzN6N2N9QBMDeVc67SFGS7j
        X/JXtkCSz3XcM8VXpeiEYXUFxm8F9U+pdp046JlHjG+uSepuEYVupTGDjAJ3AZ8kc587hFnyehufg
        m9k4/xBxDK8i2PX/3jJJKGMucsVX/12Dxx4EnBmOlvTqyFh8Ov+oNT3Ijyj29u7MUkaGdaxRl6Lfd
        aUzKLC6n14UuTVnhsiPJuObd+hsAyu+ZQcmxlqIvc3dSzpXeRrhhYfz6HpjQuLF5pKFF0B++FOLRC
        VUF4+4wg==;
Received: from 108-90-42-56.lightspeed.sntcca.sbcglobal.net ([108.90.42.56] helo=[192.168.1.80])
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRbjk-005vGY-H6; Mon, 13 Feb 2023 16:31:29 +0000
Message-ID: <f8b1ef96-3d33-fa35-d99f-af00bf8c2e40@infradead.org>
Date:   Mon, 13 Feb 2023 08:31:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 04/11] drivers/ps3: Read video= option with
 fb_get_option()
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de, javierm@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20230209135509.7786-1-tzimmermann@suse.de>
 <20230209135509.7786-5-tzimmermann@suse.de>
 <06917dd0-c4f1-c80a-16a7-f2baac47027d@infradead.org>
 <fedc746f-1685-a5a1-b847-7031b66c1fd2@suse.de>
Content-Language: en-US
From:   Geoff Levand <geoff@infradead.org>
In-Reply-To: <fedc746f-1685-a5a1-b847-7031b66c1fd2@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

On 2/13/23 03:29, Thomas Zimmermann wrote:
> Am 12.02.23 um 17:53 schrieb Geoff Levand:
>> On 2/9/23 05:55, Thomas Zimmermann wrote:
>>> Get the kernel's global video= parameter with fb_get_option(). Done
>>> to unexport the internal fbdev state fb_mode_config. No functional
>>> changes.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> ---
>>>   drivers/ps3/ps3av.c | 11 +++++++++--
>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> I wanted to test these changes on the PS3, but got this
>> error when trying to apply this patch set to Linux-6.2-rc7:
>>
>>    Applying: fbdev: Handle video= parameter in video/cmdline.c
>>    error: patch failed: drivers/gpu/drm/Kconfig:10
>>    error: drivers/gpu/drm/Kconfig: patch does not apply
>>
>> Is there a Linux kernel revision that these will apply to,
>> or is there a git repository I can pull them from?
> 
> Thanks for testing.  My base version is a recent DRM development tree. The repo is at https://cgit.freedesktop.org/drm/drm-tip/, the branch is drm-tip.

I tested the drm-tip branch at c54b5fcf3e68 on PS3 and it
seemed to work OK.

Tested-by: Geoff Levand <geoff@infradead.org>

