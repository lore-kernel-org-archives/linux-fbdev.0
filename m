Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868AFC388F7
	for <linux-fbdev@archiver.kernel.org>; Tue, 10 Nov 2020 12:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA522065E
	for <linux-fbdev@archiver.kernel.org>; Tue, 10 Nov 2020 12:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="E4HkumvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbgKJMy6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 10 Nov 2020 07:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJMy6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 10 Nov 2020 07:54:58 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFF1C0613CF
        for <linux-fbdev@vger.kernel.org>; Tue, 10 Nov 2020 04:54:56 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id b6so1212125wrt.4
        for <linux-fbdev@vger.kernel.org>; Tue, 10 Nov 2020 04:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=21NUxsor7hHh3PxftuxZky4lFBsZ7ois+WrBZ+IPnLY=;
        b=E4HkumvRbwuhozffvJJYhcXQ+VtG4Q5s+Lzoafw7cM2EbsdrTNVYk1kPivb8pbY7c+
         I3kjvimorLUFRT9npgGtOPRUW7SmX6WyqftC9yyMCGkX+bhVlGtQOJkJpmTW1UQKJfWV
         ARuzsuE6jBqPKwT7KHW/FpzfKGO1l7WHVK6XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=21NUxsor7hHh3PxftuxZky4lFBsZ7ois+WrBZ+IPnLY=;
        b=hGwNqlfdQXofClrAru8FdFsGdWFfJQqZyU1FnJwWIINeDkKFjUPbdgb6sULCtD5Ahy
         gz8CXEkmdu25hJMczNkNaLdbpLMEszSs08x7oFhwU43LU1skB4G9uH9ayCNKrT7Zgd2+
         tIxp+wT2HAZHjmfn9ToKfpcB+si3qZeZp17P+bNF7M3wiAHJaGgbE135yD+FQbKTH403
         s6XUMo0jBdXBDZT0X2CS4dAaZ4AGLiNvnUsFEkb5VhTbVwZM7LNyQCKtJb5WCQHp2pva
         LIyuqa9p0/WWUP4femdkdyPnzGBetPLMht97i51WP8H5ltq5odcs4ORetphktEbkjG8C
         qc3g==
X-Gm-Message-State: AOAM533y0Yq/6iNT2KPzXQhcUOb/TreUkJimEHrDCQNCsFWQ2bQVO6gB
        918EZyBjm+Zt/c3zcjMvil3BjQ==
X-Google-Smtp-Source: ABdhPJzT5dC6ywnGl2kTD3cDLIqcnE5q/gaqRflUh5l8yTN1U1ZZN6jf0KEM1LgGEsdInku+ZwePhw==
X-Received: by 2002:adf:f546:: with SMTP id j6mr10751487wrp.219.1605012895642;
        Tue, 10 Nov 2020 04:54:55 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 71sm17578577wrm.20.2020.11.10.04.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 04:54:54 -0800 (PST)
Date:   Tue, 10 Nov 2020 13:54:52 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] drm: remove pgprot_decrypted() before calls to
 io_remap_pfn_range()
Message-ID: <20201110125452.GG401619@phenom.ffwll.local>
References: <0-v1-2e6a0db57868+166-drm_sme_clean_jgg@nvidia.com>
 <20201105191746.GC401619@phenom.ffwll.local>
 <20201105193554.GP2620339@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105193554.GP2620339@nvidia.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Nov 05, 2020 at 03:35:54PM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 05, 2020 at 08:17:46PM +0100, Daniel Vetter wrote:
> > On Thu, Nov 05, 2020 at 01:00:19PM -0400, Jason Gunthorpe wrote:
> > > commit f8f6ae5d077a ("mm: always have io_remap_pfn_range() set
> > > pgprot_decrypted()") moves the pgprot_decrypted() into
> > > io_remap_pfn_range(). Delete any, now confusing, open coded calls that
> > > directly precede io_remap_pfn_range():
> > > 
> > > - drm_io_prot() is only in drm_mmap_locked() to call io_remap_pfn_range()
> > > 
> > > - fb_mmap() immediately calls vm_iomap_memory() which is a convenience
> > >   wrapper for io_remap_pfn_range()
> > > 
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > >  drivers/gpu/drm/drm_vm.c         | 3 ---
> > >  drivers/video/fbdev/core/fbmem.c | 5 -----
> > >  2 files changed, 8 deletions(-)
> > > 
> > > rc3 will have the dependent patch, this should not be merged to DRM until it
> > > has the rc3 commits.
> > > 
> > > There are three other pgprot_decrypted() calls in DRM, I could not figure out
> > > what was what there, but other than very special cases I would expect code to
> > > use io_remap_pfn_range() instead.
> > 
> > There's 4 now, I think linux-next added one. It's another io_remap_pfn
> > 
> > Of the three you mentioned we have:
> > - ttm and i915 use vm_insert_pfn (and ttm also can do also do pud_mkhuge
> >   entries)
> 
> You can't insert IO memory with vmf_insert_pfn_pmd_prot() (it
> doesn't set the special flag) so why does it need decrypted?

Well, see the other thread, we do ... :-/
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
