Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE27C433B4
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 May 2021 12:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95564611AE
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 May 2021 12:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbhESMUI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 19 May 2021 08:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbhESMUI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 19 May 2021 08:20:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F8DC06175F;
        Wed, 19 May 2021 05:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DZ+/uBpSMB9Hquk+mtUG9wzPieYFcOsJhcqFJZdyx3M=; b=wC1Hw7IltZ2bJsVU22RHxTz5M8
        xkbXKtu0lwXY7OTusOONIL+UHgZLuSwS3T3WihKwwG54+95K5ZgO4CebMTmwhoEnMZdx5TBfaywBS
        ueIMBJjfnfJsKrSabHI9+Zwu3x6mqqnXsRSoCIu96jlK9CA8Yv3prjeycjBM3QV0vD0YrThon7ohC
        3W+0noURDVuH/pnQ2sFH71tgRirGgDaFxaU8b5491qkpUgucjndd86FVtyuSyndyYcIZjVx7MVtjO
        UHhAkhPw8ZFRNAFbZ1WG4yoTGD5/Jw+i6jOeV5ionTWqdTsqFsCVr2FEEAkvCLPoCr89KVEeSZFtN
        jMqOlzeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljL8A-00EvWt-Ia; Wed, 19 May 2021 12:17:19 +0000
Date:   Wed, 19 May 2021 13:16:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     songqiang <songqiang@uniontech.com>
Cc:     sam@ravnborg.org, b.zolnierkie@samsung.com,
        penguin-kernel@i-love.sakura.ne.jp, george.kennedy@oracle.com,
        arnd@arndb.de, tzimmermann@suse.de, jgg@ziepe.ca,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/video/fbdev/core/fbmem.c: add pointer judgment
Message-ID: <YKUBtiOTE7zJHAjI@casper.infradead.org>
References: <20210519120028.7350-1-songqiang@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519120028.7350-1-songqiang@uniontech.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, May 19, 2021 at 08:00:28PM +0800, songqiang wrote:
> Signed-off-by: songqiang <songqiang@uniontech.com>
> ---

You need to explain:

 - Why you think this patch is needed
   - Did you observe a problem at runtime?
   - Is this the output from some checking tool?
 - Why this is the right way to address the problem

