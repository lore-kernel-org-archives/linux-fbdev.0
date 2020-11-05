Return-Path: <SRS0=iaJD=EL=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C675C4741F
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 Nov 2020 19:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 872532087D
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 Nov 2020 19:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dO5hEZcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgKETRv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 Nov 2020 14:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731983AbgKETRv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 Nov 2020 14:17:51 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C807AC0613CF
        for <linux-fbdev@vger.kernel.org>; Thu,  5 Nov 2020 11:17:50 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so3049889wrc.11
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Nov 2020 11:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j+IQhvhw435u8nsN2WVFpAWIcN2hwG2s/J5+3AR6JLc=;
        b=dO5hEZcM51v6mQ3PmBzyEbxtmZxlwbEDZZXHYYythrbeVAQ3pRx9dWvRn84UhXi2Em
         ml/Q+jOVtk0eafTV+uu6z5YtDw2je+0ICuFu6hxIOvwENdZpe2TT3d0M9/gMxuHLSBsf
         EUsh9D6ANi8inHlFA1zxxMAs0K/AN0s09AUMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j+IQhvhw435u8nsN2WVFpAWIcN2hwG2s/J5+3AR6JLc=;
        b=BUDqSP4D72jMVkUCiWy4UjsMyM7i7B7u5MJQEMO9YOJH2tTDc4l+SASSkcRlc/SSx5
         uT7LGYixLnKVKshCq1PErIaMIelYKXqIOOS2R9w5gH1cLYUQoZynZvrz07lbpFzPQkqm
         In5d+GfR05REJU3aOAaz9YzPJf7xFuJ95nlptpbTBBKfcq42AbsyE2PlWOQT+7AfOtBm
         4oOSaDYMGK7KK30z/eimI/ZQ5y2anGa+I23bpMAtpljEwJ+lEKB0Snt2Ogi8p7Urh7s4
         KTHotJaEBw/tKxF3LNKBCKaNyrrQpEjhbLUe5LjCxS/S2V3zB7raLy41JlnFQTB8C3iu
         So0g==
X-Gm-Message-State: AOAM532DdSToyUX92MzhUyVZyYp7nE5XoM4rRRRDBymfJYVlCjBDys06
        u9MzCfJQH7xtA34xpnvWCFZ4uQ==
X-Google-Smtp-Source: ABdhPJw3DaNV5PFRS17QOGMcfKkxrIGmNbzqbv20Aa+JsHn+j7B2uPUnnJigwpP3joAKyTGDhLSqZA==
X-Received: by 2002:adf:e412:: with SMTP id g18mr4702345wrm.211.1604603869511;
        Thu, 05 Nov 2020 11:17:49 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b14sm2102468wrq.47.2020.11.05.11.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 11:17:48 -0800 (PST)
Date:   Thu, 5 Nov 2020 20:17:46 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] drm: remove pgprot_decrypted() before calls to
 io_remap_pfn_range()
Message-ID: <20201105191746.GC401619@phenom.ffwll.local>
References: <0-v1-2e6a0db57868+166-drm_sme_clean_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-2e6a0db57868+166-drm_sme_clean_jgg@nvidia.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Nov 05, 2020 at 01:00:19PM -0400, Jason Gunthorpe wrote:
> commit f8f6ae5d077a ("mm: always have io_remap_pfn_range() set
> pgprot_decrypted()") moves the pgprot_decrypted() into
> io_remap_pfn_range(). Delete any, now confusing, open coded calls that
> directly precede io_remap_pfn_range():
> 
> - drm_io_prot() is only in drm_mmap_locked() to call io_remap_pfn_range()
> 
> - fb_mmap() immediately calls vm_iomap_memory() which is a convenience
>   wrapper for io_remap_pfn_range()
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/gpu/drm/drm_vm.c         | 3 ---
>  drivers/video/fbdev/core/fbmem.c | 5 -----
>  2 files changed, 8 deletions(-)
> 
> rc3 will have the dependent patch, this should not be merged to DRM until it
> has the rc3 commits.
> 
> There are three other pgprot_decrypted() calls in DRM, I could not figure out
> what was what there, but other than very special cases I would expect code to
> use io_remap_pfn_range() instead.

There's 4 now, I think linux-next added one. It's another io_remap_pfn

Of the three you mentioned we have:
- ttm and i915 use vm_insert_pfn (and ttm also can do also do pud_mkhuge
  entries)
- drm_gem is for all other drivers, some also use vm_insert_pfn, the
  others I think use dma_mmap_* and friends, which I think underneath
  boild down to io_remap_pfn. Or at least should be taking care of this
  already.

I'll try and remember to merge this after -rc3. Yell if it's not in by
-rc4 please.
-Daniel

> 
> diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
> index 1a636963378947..6d5a03b3223800 100644
> --- a/drivers/gpu/drm/drm_vm.c
> +++ b/drivers/gpu/drm/drm_vm.c
> @@ -70,9 +70,6 @@ static pgprot_t drm_io_prot(struct drm_local_map *map,
>  {
>  	pgprot_t tmp = vm_get_page_prot(vma->vm_flags);
>  
> -	/* We don't want graphics memory to be mapped encrypted */
> -	tmp = pgprot_decrypted(tmp);
> -
>  #if defined(__i386__) || defined(__x86_64__) || defined(__powerpc__) || \
>      defined(__mips__)
>  	if (map->type == _DRM_REGISTERS && !(map->flags & _DRM_WRITE_COMBINING))
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 8268bbee8cae11..63a27a67a05cfa 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1386,11 +1386,6 @@ fb_mmap(struct file *file, struct vm_area_struct * vma)
>  	mutex_unlock(&info->mm_lock);
>  
>  	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
> -	/*
> -	 * The framebuffer needs to be accessed decrypted, be sure
> -	 * SME protection is removed
> -	 */
> -	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
>  	fb_pgprotect(file, vma, start);
>  
>  	return vm_iomap_memory(vma, start, len);
> -- 
> 2.29.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
