Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262F1C4361B
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAEF222E03
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgLFTi2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 14:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbgLFTi2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 14:38:28 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7C2C0613D1
        for <linux-fbdev@vger.kernel.org>; Sun,  6 Dec 2020 11:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=vIK6m1ctc35l8MtZw4GhuOmmWW9BpzOaMtrZWwhnKPA=; b=cEumralgnwh+jRe12UCsStYlTC
        GVxHJFKjqSEPPiRoIZalVZDp5IvOP6d5ujKsPQdr3iiaisXeEadwX4RNu5XA4y1zvThpKzDs8u2pL
        diPMigE0nSE//QolSNHuO2p1Nrk15gXfEYa9N2ryj5kjac+pU+84jc4lNA4+2vO91IGmrNh9OlwnJ
        6I7TVYIX3Fa6MJKVnh983my10M+Jlu+gvqalhNaunl2+MKsaqO9Z+o7pLfFJ7Xb4cLvncuZ25e6eB
        tcQAmghEQHh+uP7fNPpd0wJ9b99xH5xfAgZeg3name4XYCa3Fp3pJDqaAvFvqPKFHKfv/n8VVYbuY
        jYn86gvw==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1klzqZ-0000sq-1R; Sun, 06 Dec 2020 19:37:27 +0000
Subject: Re: [PATCH v3 02/13] video: fbdev: core: Fix kernel-doc warnings in
 fbmon + fb_notify
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
        Tony Prisk <linux@prisktech.co.nz>
References: <20201206190247.1861316-1-sam@ravnborg.org>
 <20201206190247.1861316-3-sam@ravnborg.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0fb6ff8b-bea3-c5bc-0d37-8a5fdab41abc@infradead.org>
Date:   Sun, 6 Dec 2020 11:37:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201206190247.1861316-3-sam@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12/6/20 11:02 AM, Sam Ravnborg wrote:
> Fix kernel-doc warnings reported when using W=1
> 
> v2:
>   - Improve subject (Lee)
> 
> v3:
>   - Add RETURNS documentation (Thomas)

Hi Sam,

Yes, RETURNS: will work. It just looks like any kernel-doc section name,
such as Context: or Note:.
However, the documented format for return info is "Return:".
(see Documentation/doc-guide/kernel-doc.rst)


> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
> ---
>  drivers/video/fbdev/core/fb_notify.c | 10 ++++++++++
>  drivers/video/fbdev/core/fbmon.c     |  2 +-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/fb_notify.c b/drivers/video/fbdev/core/fb_notify.c
> index 74c2da528884..4e39c61fae1f 100644
> --- a/drivers/video/fbdev/core/fb_notify.c
> +++ b/drivers/video/fbdev/core/fb_notify.c
> @@ -19,6 +19,9 @@ static BLOCKING_NOTIFIER_HEAD(fb_notifier_list);
>  /**
>   *	fb_register_client - register a client notifier
>   *	@nb: notifier block to callback on events
> + *
> + *	RETURNS:
> + *	0 on success, negative error code on failure.
>   */
>  int fb_register_client(struct notifier_block *nb)
>  {
> @@ -29,6 +32,9 @@ EXPORT_SYMBOL(fb_register_client);
>  /**
>   *	fb_unregister_client - unregister a client notifier
>   *	@nb: notifier block to callback on events
> + *
> + *	RETURNS:
> + *	0 on success, negative error code on failure.
>   */
>  int fb_unregister_client(struct notifier_block *nb)
>  {
> @@ -38,7 +44,11 @@ EXPORT_SYMBOL(fb_unregister_client);
>  
>  /**
>   * fb_notifier_call_chain - notify clients of fb_events
> + * @val: value passed to callback
> + * @v: pointer passed to callback
>   *
> + * RETURNS:
> + * The return value of the last notifier function
>   */
>  int fb_notifier_call_chain(unsigned long val, void *v)
>  {
> diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
> index 1bf82dbc9e3c..b0e690f41025 100644
> --- a/drivers/video/fbdev/core/fbmon.c
> +++ b/drivers/video/fbdev/core/fbmon.c
> @@ -605,6 +605,7 @@ static void get_detailed_timing(unsigned char *block,
>   * fb_create_modedb - create video mode database
>   * @edid: EDID data
>   * @dbsize: database size
> + * @specs: monitor specifications, may be NULL
>   *
>   * RETURNS: struct fb_videomode, @dbsize contains length of database
>   *


-- 
~Randy

