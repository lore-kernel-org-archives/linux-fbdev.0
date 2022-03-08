Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799EDC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Mar 2022 14:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiCHOnq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbiCHOnp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Mar 2022 09:43:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CF752B1AE
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Mar 2022 06:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646750566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tATbOgHJcJ/4hUpKdLQsepBRnBgdhbYd9x5YyJps/7o=;
        b=hS5rXwykWhb1j9uio9P63VIMU85kRt2VQ6ob528lKNYo3OTVMMUbIMgdJklO5dI8UB63ch
        1uQX1TYI2/IhDLHAFsrX2zAnGIQobhWed/7wr1BxBXBSQRSNtOvbM5tffSUWQoXGHyx+hN
        sGbKAI7JemVKpvLpyhPl+jEdF0e1BQM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-t9wPLld8MySv_zrqESXY8g-1; Tue, 08 Mar 2022 09:42:45 -0500
X-MC-Unique: t9wPLld8MySv_zrqESXY8g-1
Received: by mail-wr1-f69.google.com with SMTP id m18-20020a5d4a12000000b00203731460e6so354965wrq.3
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Mar 2022 06:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tATbOgHJcJ/4hUpKdLQsepBRnBgdhbYd9x5YyJps/7o=;
        b=nWNxKX4s0zPend6u9WPuXkC7Etm/n5vJeEyM+mIyF6KgrhNIzgA5AymeL1FgmfSTAc
         yMd8Ttl2T1tvpOOH6SN1WDuHZB0dOWc/w6+T8y3SsqrV+k6DMJaDFf1fBo9E/h6Ji08b
         dXmzyHuFpjmzu7J9QDeQ15aRB25t37yKyeZDcuVTMJ9zCo2AuZvimp7aOkR3cOG5b7OA
         AV/TVRG5IAXoSSf25W8I/ZvRyitxn95VM2jzyMugfFls7gNOi0SO3An1s6CEgtdWe9Gt
         amqoN36hqE9Ws62iC0BO8s/7HzqktFfgZqWpQJS2UCcrkcpcSEYiYIHLmp0Vpy3raR7L
         3g+Q==
X-Gm-Message-State: AOAM530+ciw/xd/YPaBpvhledkuFzcUZjHaQpOiBo4podZ9oQ19p2jA1
        zF+eaEJPSAI5u+vnm33SvIQGnsB/dQ++JUUG/dPEDf4SDl2y875PfYq93K70O/l1KPUzcTqsSBm
        HIAli9hbDSwhqdxlqOLlvS04=
X-Received: by 2002:adf:b1da:0:b0:1f0:1205:89c1 with SMTP id r26-20020adfb1da000000b001f0120589c1mr12369657wra.27.1646750563991;
        Tue, 08 Mar 2022 06:42:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOZcVU+hFCO17d0FKfNV//pcbVvoZdXclr9zQPpsTXnY/L9Y2Kt6jpCy1GSMTv1uSfM8TgFQ==
X-Received: by 2002:adf:b1da:0:b0:1f0:1205:89c1 with SMTP id r26-20020adfb1da000000b001f0120589c1mr12369647wra.27.1646750563746;
        Tue, 08 Mar 2022 06:42:43 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e2-20020adfe7c2000000b001f04d622e7fsm14003199wrn.39.2022.03.08.06.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 06:42:43 -0800 (PST)
Message-ID: <291426e8-32ed-ba0b-4d23-38218d450c93@redhat.com>
Date:   Tue, 8 Mar 2022 15:42:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/9] fbdev: Track deferred-I/O pages in pageref struct
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220303205839.28484-1-tzimmermann@suse.de>
 <20220303205839.28484-4-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220303205839.28484-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 3/3/22 21:58, Thomas Zimmermann wrote:
> Store the per-page state for fbdev's deferred I/O in struct
> fb_deferred_io_pageref. Maintain a list of pagerefs for the pages
> that have to be flushed out to video memory. Update all affected
> drivers.
> 
> Like with pages before, fbdev acquires a pageref when an mmaped page
> of the framebuffer is being written to. It holds the pageref in a
> list of all currently written pagerefs until it flushes the written
> pages to video memory. Writeback occurs periodically. After writeback
> fbdev releases all pagerefs and builds up a new dirty list until the
> next writeback occurs.
> 
> Using pagerefs has a number of benefits.
> 
> For pages of the framebuffer, the deferred I/O code used struct
> page.lru as an entry into the list of dirty pages. The lru field is
> owned by the page cache, which makes deferred I/O incompatible with
> some memory pages (e.g., most notably DRM's GEM SHMEM allocator).
> struct fb_deferred_io_pageref now provides an entry into a list of
> dirty framebuffer pages, free'ing lru for use with the page cache.
> 
> Drivers also assumed that struct page.index is the page offset into
> the framebuffer. This is not true for DRM buffers, which are located
> at various offset within a mapped area. struct fb_deferred_io_pageref
> explicitly stores an offset into the framebuffer. struct page.index
> is now only the page offset into the mapped area.
> 
> These changes will allow DRM to use fbdev deferred I/O without an
> intermediate shadow buffer.
> 

As mentioned, this is a very nice cleanup.

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

[snip]

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
> index 33f355907fbb..a35f695727c9 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
> @@ -322,12 +322,13 @@ static void vmw_deferred_io(struct fb_info *info,
>  	struct vmw_fb_par *par = info->par;
>  	unsigned long start, end, min, max;
>  	unsigned long flags;
> -	struct page *page;
> +	struct fb_deferred_io_pageref *pageref;
>  	int y1, y2;
>  
>  	min = ULONG_MAX;
>  	max = 0;
> -	list_for_each_entry(page, pagelist, lru) {
> +	list_for_each_entry(pageref, pagelist, list) {
> +		struct page *page = pageref->page;
>  		start = page->index << PAGE_SHIFT;

Do you think that may be worth it to also decouple the struct page.index and 
store the index as a struct fb_deferred_io_pageref.index field ? 

It's unlikely that this would change but it feels as if the layers are more
separated that way, since no driver will access struct page fields directly.

The mapping would be 1:1 anyways just like it's the case for the page offset.

In fact, that could allow to even avoid declaring a struct page *page here.

[snip]

> @@ -340,7 +340,8 @@ static void fbtft_deferred_io(struct fb_info *info, struct list_head *pagelist)
>  	spin_unlock(&par->dirty_lock);
>  
>  	/* Mark display lines as dirty */
> -	list_for_each_entry(page, pagelist, lru) {
> +	list_for_each_entry(pageref, pagelist, list) {
> +		struct page *page = pageref->page;

Same here and the other drivers. You only need the page for the index AFAICT.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

