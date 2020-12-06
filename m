Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBE2C4361B
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA57722E03
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgLFTiJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 14:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbgLFTiJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 14:38:09 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8DDC0613D0
        for <linux-fbdev@vger.kernel.org>; Sun,  6 Dec 2020 11:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=uaJjx5MBG5/1n7wKwNZRjc2vRPxVE5bY074S204GE54=; b=vhUZ83k2KpTRvt5r5yBKPDHD5N
        7ERZf9DIWzHsx3KNdK5sOYxnEgLqoPnmAkEZNidZhhMYkBgYIv+LssD9GNoD1JJAuhWMz6rvH/nIA
        J5z8kjJYPt9T2Ykaj8a8wy6ZZz0fvZKBVkuRyt3RtUmuynadwZDuakc9+ybJMyINayAftLrf0fzIw
        ehYyGfLwZP3Bs893E2SgrTFvU8GM+VGeh2jcPOl7NNnOjkEzUFz+SebdEVKwaGq2OzZcoaCU8QEsC
        hwFrcj90NkVEsRoFhnsCy4RVtQms8NRTYxWRHSvxHxAScVa0SVt/1jEPfoBB+c14FPKz3nAtqMRHd
        JKXs482g==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1klzng-0000jY-CU; Sun, 06 Dec 2020 19:34:28 +0000
Subject: Re: [PATCH v3 01/13] video: fbdev: hgafb: Fix kernel-doc warnings
To:     Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
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
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Prisk <linux@prisktech.co.nz>,
        Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
        linux-nvidia@lists.surfsouth.com
References: <20201206190247.1861316-1-sam@ravnborg.org>
 <20201206190247.1861316-2-sam@ravnborg.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c0c465e0-035a-956a-f8d6-18976bfb813b@infradead.org>
Date:   Sun, 6 Dec 2020 11:34:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201206190247.1861316-2-sam@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12/6/20 11:02 AM, Sam Ravnborg wrote:
> Fix kernel-doc comments.
> 
> v2:
>   - Updated subject (Lee)
> 
> v3:
>   - Add space after ':' (Randy)
>   - Fix name of function in comment
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Ferenc Bakonyi <fero@drama.obuda.kando.hu>
> Cc: linux-nvidia@lists.surfsouth.com
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/video/fbdev/hgafb.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
> index a45fcff1461f..8bbac7182ad3 100644
> --- a/drivers/video/fbdev/hgafb.c
> +++ b/drivers/video/fbdev/hgafb.c
> @@ -357,8 +357,8 @@ static int hga_card_detect(void)
>  
>  /**
>   *	hgafb_open - open the framebuffer device
> - *	@info:pointer to fb_info object containing info for current hga board
> - *	@int:open by console system or userland.
> + *	@info: pointer to fb_info object containing info for current hga board
> + *	@init: open by console system or userland.
>   */
>  
>  static int hgafb_open(struct fb_info *info, int init)
> @@ -370,9 +370,9 @@ static int hgafb_open(struct fb_info *info, int init)
>  }
>  
>  /**
> - *	hgafb_open - open the framebuffer device
> - *	@info:pointer to fb_info object containing info for current hga board
> - *	@int:open by console system or userland.
> + *	hgafb_release - open the framebuffer device
> + *	@info: pointer to fb_info object containing info for current hga board
> + *	@init: open by console system or userland.
>   */
>  
>  static int hgafb_release(struct fb_info *info, int init)
> 

LGTM. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
