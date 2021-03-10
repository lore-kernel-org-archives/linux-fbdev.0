Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F88C433DB
	for <linux-fbdev@archiver.kernel.org>; Wed, 10 Mar 2021 18:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF3964F78
	for <linux-fbdev@archiver.kernel.org>; Wed, 10 Mar 2021 18:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhCJStu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 10 Mar 2021 13:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbhCJStR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 10 Mar 2021 13:49:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44223C061760;
        Wed, 10 Mar 2021 10:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4HgOUtZioTDMKUvW4dyz8tRE+AffCXG+nsSseXdbPJk=; b=P1Bdb0fRml2tffwzopV3LbuQkD
        XiK+O7Tn0dk24d5j4uLS37+YCyyHyF+OzWpE2WQ4j21wKUZ3s1bWAoGqsSm+u1yBzszeCgZ6Ne+3t
        L2Z6/sUTX4fqGXjHSwHwgQTiz8zodMisx9vQj9oOS9jjijt1TuElXLy+NYrybZaR4m2GpepX84laF
        OOtPDEjY3QNJpRE04Os1zOb/8/dLOqIY4hEQ0EPZkBLdyi7nfVXQajaWWEplm25vUVt5Oqm4Npoxr
        JAR3BcPz0JxaHZYrxaw9zt6NkR+HjFDjkHE8/yvTlOLpjdyLqW6m7PQwWfmacwqh/smZmoyS4VNQQ
        QlTzrJIA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lK3tI-004PX6-LW; Wed, 10 Mar 2021 18:49:07 +0000
Date:   Wed, 10 Mar 2021 18:49:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ian Campbell <ijc@hellion.org.uk>,
        Jaya Kumar <jayakumar.lkml@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fb_defio: Remove custom address_space_operations
Message-ID: <20210310184904.GS3479805@casper.infradead.org>
References: <20210310135128.846868-1-willy@infradead.org>
 <B2F0192D-2C63-4BD0-8B5C-461361C7F0DD@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B2F0192D-2C63-4BD0-8B5C-461361C7F0DD@oracle.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Mar 10, 2021 at 06:38:07PM +0000, William Kucharski wrote:
> Looks good, just one super minor nit inline.
> > @@ -228,13 +202,6 @@ void fb_deferred_io_cleanup(struct fb_info *info)
> > 
> > 	BUG_ON(!fbdefio);
> > 	cancel_delayed_work_sync(&info->deferred_work);
> > -
> > -	/* clear out the mapping that we setup */
> > -	for (i = 0 ; i < info->fix.smem_len; i += PAGE_SIZE) {
> > -		page = fb_deferred_io_page(info, i);
> > -		page->mapping = NULL;
> > -	}
> > -
> > 	mutex_destroy(&fbdefio->lock);
> > }
> 
> We no longer need the definition of "int i" right before the BUG_ON().

Huh.  Usually gcc warns about that.  let me figure that out and post a v2.

