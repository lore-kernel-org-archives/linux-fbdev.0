Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381B9C3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sun, 29 Nov 2020 16:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DBEC206F4
	for <linux-fbdev@archiver.kernel.org>; Sun, 29 Nov 2020 16:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZsXSw1Wn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgK2QQC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 29 Nov 2020 11:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2QQB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 29 Nov 2020 11:16:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74033C0613CF
        for <linux-fbdev@vger.kernel.org>; Sun, 29 Nov 2020 08:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=K/3XCS09PtgAMlsxXhCLZ8FMnd8vje/idDmjW6xJGbc=; b=ZsXSw1WnAYWmbL/jPtiLwenAb6
        FhGtAWQWB9FYC4J3Th+7447OeVOXPqCixc4rUHhBQaQA6rANkxiWxFJC7ddetQGXSIRFOMbPcAdRt
        1O+cZzW6WPSEjPMQRl4t5j5MdOB//fKNnp60G2XoAkJduc+W4lGEDD9Js95T6RyLRBA+RtzljL6YY
        /QIvZrAvkw4CP8tZ9CJrjhIiPvTVwcMzGwWUO61QHjbIC7vgA494GD8CbEXX5gTvsSI090zv+errG
        /FFrLKluwmRXEm/VS9hkPHObw9J2VpL9TSsO7ZNIOFhQxIqo6uIgInQoIDJL2iw/2gOOoai78ArjC
        FtMWB12g==;
Received: from [2601:1c0:6280:3f0::cc1f]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjPHY-0001br-7L; Sun, 29 Nov 2020 16:10:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 16/28] video: fbdev: hgafb: Fix kernel-doc warnings
To:     Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Lee Jones <lee.jones@linaro.org>
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Evgeny Novikov <novikov@ispras.ru>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimemrmann <tzimmermann@suse.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
        linux-nvidia@lists.surfsouth.com
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-17-sam@ravnborg.org>
Message-ID: <9be40b75-698f-a46f-ba66-2ec3d0443ad2@infradead.org>
Date:   Sun, 29 Nov 2020 08:10:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201128224114.1033617-17-sam@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Sam-

On 11/28/20 2:41 PM, Sam Ravnborg wrote:
> Fix kernel-doc comments.
> 
> v2:
>   - Updated subject (Lee)
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Ferenc Bakonyi <fero@drama.obuda.kando.hu>
> Cc: linux-nvidia@lists.surfsouth.com
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/video/fbdev/hgafb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
> index a45fcff1461f..69af72937844 100644
> --- a/drivers/video/fbdev/hgafb.c
> +++ b/drivers/video/fbdev/hgafb.c
> @@ -358,7 +358,7 @@ static int hga_card_detect(void)
>  /**
>   *	hgafb_open - open the framebuffer device
>   *	@info:pointer to fb_info object containing info for current hga board
> - *	@int:open by console system or userland.
> + *	@init:open by console system or userland.

Please add a space after the ':' in 2 lines above.

>   */
>  
>  static int hgafb_open(struct fb_info *info, int init)
> @@ -372,7 +372,7 @@ static int hgafb_open(struct fb_info *info, int init)
>  /**
>   *	hgafb_open - open the framebuffer device
>   *	@info:pointer to fb_info object containing info for current hga board
> - *	@int:open by console system or userland.
> + *	@init:open by console system or userland.

Same here (2 lines).

>   */
>  
>  static int hgafb_release(struct fb_info *info, int init)
> 

thanks.
-- 
~Randy

