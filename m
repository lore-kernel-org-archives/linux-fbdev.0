Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4CFC433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 10 Feb 2022 21:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344471AbiBJVAh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 10 Feb 2022 16:00:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344465AbiBJVAh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 10 Feb 2022 16:00:37 -0500
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com [91.221.196.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FCE10DE
        for <linux-fbdev@vger.kernel.org>; Thu, 10 Feb 2022 13:00:36 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx1.smtp.larsendata.com (Halon) with ESMTPS
        id 85c0f381-8ab4-11ec-baa1-0050568c148b;
        Thu, 10 Feb 2022 21:00:48 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id B9438194B34;
        Thu, 10 Feb 2022 22:00:32 +0100 (CET)
Date:   Thu, 10 Feb 2022 22:00:29 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, javierm@redhat.com, noralf@tronnes.org,
        andriy.shevchenko@linux.intel.com, deller@gmx.de,
        bernie@plugable.com, jayalk@intworks.biz,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] fbdev/defio: Early-out if page is already enlisted
Message-ID: <YgV87ejpzGkSMNop@ravnborg.org>
References: <20220210141111.5231-1-tzimmermann@suse.de>
 <20220210141111.5231-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210141111.5231-2-tzimmermann@suse.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On Thu, Feb 10, 2022 at 03:11:11PM +0100, Thomas Zimmermann wrote:
> Return early if a page is already in the list of dirty pages for
> deferred I/O. This can be detected if the page's list head is not
> empty. Keep the list head initialized while the page is not enlisted
> to make this work reliably.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/fbdev/core/fb_defio.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
> index a591d291b231..3727b1ca87b1 100644
> --- a/drivers/video/fbdev/core/fb_defio.c
> +++ b/drivers/video/fbdev/core/fb_defio.c
> @@ -59,6 +59,7 @@ static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
>  		printk(KERN_ERR "no mapping available\n");
>  
>  	BUG_ON(!page->mapping);
> +	INIT_LIST_HEAD(&page->lru);
>  	page->index = vmf->pgoff;
>  
>  	vmf->page = page;
> @@ -122,17 +123,19 @@ static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
>  	 */
>  	lock_page(page);
>  
> +	/*
> +	 * This check is to catch the case where a new process could start
> +	 * writing to the same page through a new pte. this new access
> +	 * can cause the mkwrite even when the original ps's pte is marked
> +	 * writable.
> +	 */
When moving this comment it would be prudent to also fix the wording a
bit.
- Capital in start of sentence and after a period
- Spell out process and do not shorten ps


> +	if (!list_empty(&page->lru))
> +		goto page_already_added;
> +

This check says that if the page already has something in the parge->lru
then this is added by defio and thus is already added.
This matches your commit description - OK.

Maybe add something like:
* Pages added will have their lru set, and it is clered again in the
* deferred work handler.



>  	/* we loop through the pagelist before adding in order
>  	to keep the pagelist sorted */
>  	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
> -		/* this check is to catch the case where a new
> -		process could start writing to the same page
> -		through a new pte. this new access can cause the
> -		mkwrite even when the original ps's pte is marked
> -		writable */
> -		if (unlikely(cur == page))
> -			goto page_already_added;
> -		else if (cur->index > page->index)
> +		if (cur->index > page->index)
>  			break;
>  	}
>  
> @@ -194,7 +197,7 @@ static void fb_deferred_io_work(struct work_struct *work)
>  
>  	/* clear the list */
>  	list_for_each_safe(node, next, &fbdefio->pagelist) {
> -		list_del(node);
> +		list_del_init(node);
>  	}
>  	mutex_unlock(&fbdefio->lock);
>  }

With the comment adjusted as you see fit
Acked-by: Sam Ravnborg <sam@ravnborg.org>
