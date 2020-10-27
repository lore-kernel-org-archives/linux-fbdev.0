Return-Path: <SRS0=EV96=EC=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D10C4363A
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 06:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A6822264
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 06:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgJ0GyY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 27 Oct 2020 02:54:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:36746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410058AbgJ0GyY (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 27 Oct 2020 02:54:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24F2CAEFE;
        Tue, 27 Oct 2020 06:54:22 +0000 (UTC)
Subject: Re: [PATCH] matroxfb: avoid -Warray-bounds warning
To:     Arnd Bergmann <arnd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20201026194010.3817166-1-arnd@kernel.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <745539ce-52ff-f56f-0f02-41894f366503@suse.de>
Date:   Tue, 27 Oct 2020 07:54:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201026194010.3817166-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi

Am 26.10.20 um 20:39 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The open-coded list_for_each_entry() causes a harmless warning:
> 
> drivers/video/fbdev/matrox/matroxfb_base.c: In function 'matroxfb_register_driver':
> include/linux/kernel.h:856:3: warning: array subscript -98 is outside array bounds of 'struct list_head[1]' [-Warray-bounds]
> 
> Use the normal list_for_each_entry instead.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

I'll add the patch to drm-misc-next. Thanks!

Best regards
Thomas

> ---
>  drivers/video/fbdev/matrox/matroxfb_base.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
> index 570439b32655..a3853421b263 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_base.c
> +++ b/drivers/video/fbdev/matrox/matroxfb_base.c
> @@ -1970,9 +1970,7 @@ int matroxfb_register_driver(struct matroxfb_driver* drv) {
>  	struct matrox_fb_info* minfo;
>  
>  	list_add(&drv->node, &matroxfb_driver_list);
> -	for (minfo = matroxfb_l(matroxfb_list.next);
> -	     minfo != matroxfb_l(&matroxfb_list);
> -	     minfo = matroxfb_l(minfo->next_fb.next)) {
> +	list_for_each_entry(minfo, &matroxfb_list, next_fb) {
>  		void* p;
>  
>  		if (minfo->drivers_count == MATROXFB_MAX_FB_DRIVERS)
> @@ -1990,9 +1988,7 @@ void matroxfb_unregister_driver(struct matroxfb_driver* drv) {
>  	struct matrox_fb_info* minfo;
>  
>  	list_del(&drv->node);
> -	for (minfo = matroxfb_l(matroxfb_list.next);
> -	     minfo != matroxfb_l(&matroxfb_list);
> -	     minfo = matroxfb_l(minfo->next_fb.next)) {
> +	list_for_each_entry(minfo, &matroxfb_list, next_fb) {
>  		int i;
>  
>  		for (i = 0; i < minfo->drivers_count; ) {
> 

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
