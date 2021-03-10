Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713FCC433DB
	for <linux-fbdev@archiver.kernel.org>; Wed, 10 Mar 2021 16:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4009D64FC7
	for <linux-fbdev@archiver.kernel.org>; Wed, 10 Mar 2021 16:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhCJQyy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 10 Mar 2021 11:54:54 -0500
Received: from verein.lst.de ([213.95.11.211]:37292 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233214AbhCJQyu (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 10 Mar 2021 11:54:50 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4452668B05; Wed, 10 Mar 2021 17:54:47 +0100 (CET)
Date:   Wed, 10 Mar 2021 17:54:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ian Campbell <ijc@hellion.org.uk>,
        Jaya Kumar <jayakumar.lkml@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fb_defio: Remove custom address_space_operations
Message-ID: <20210310165447.GA18299@lst.de>
References: <20210310135128.846868-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310135128.846868-1-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Mar 10, 2021 at 01:51:28PM +0000, Matthew Wilcox (Oracle) wrote:
> There's no need to give the page an address_space.  Leaving the
> page->mapping as NULL will cause the VM to handle set_page_dirty()
> the same way that it's set now, and that was the only reason to
> set the address_space in the first place.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>


Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
