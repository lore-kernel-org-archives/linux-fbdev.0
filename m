Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C3FC433E0
	for <linux-fbdev@archiver.kernel.org>; Fri, 12 Mar 2021 14:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D2D65007
	for <linux-fbdev@archiver.kernel.org>; Fri, 12 Mar 2021 14:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhCLOM7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 12 Mar 2021 09:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhCLOMc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 12 Mar 2021 09:12:32 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E8CC061574
        for <linux-fbdev@vger.kernel.org>; Fri, 12 Mar 2021 06:12:31 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id d191so3876153wmd.2
        for <linux-fbdev@vger.kernel.org>; Fri, 12 Mar 2021 06:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=FS8E3QfSbLNuEUx0oGFG0GGmNvYIycOcmcrDH3zq20s=;
        b=EpXn29ELHwyLOmSmA0dpAkvkzt6uQd+2W1sVUIUHPfGbws8JaoUARChu8bwZ+ySzEi
         nCr0fmdzZQeLZKtpf+sy93qveuEeBtDIH1nlt0EaWvvaxRUMiX+UBQeY9QSHzzh7fC1w
         qkTT5+yV7aj5TuQgL7jb9WbbOMqqtVTntSsrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=FS8E3QfSbLNuEUx0oGFG0GGmNvYIycOcmcrDH3zq20s=;
        b=s7Gjo8AtsPlrX/dfhZhH/oyIMbreuRuXVL9TSkK8B80CkaUUzsux5qWeL7a1J4hoNG
         fUs9Axyn6/uVyPoDG02xxZdpr2eTOKTrmRoaq6N84c5VRQK2mSdtWUukMGuWiIMgmFT1
         RvwoZ6mX4HWVHCxM1AEIasOOqGkpHWdaH1cm2Uy0+vUn/rNTyGTTzGqyJS1CVGTz1Asy
         7IgAmBO0HkR0aolPB458trJIC3WhQ7tPQigvHy2W7dDNWy00eFpAjk+oUNOi+2XDm4Dp
         LrrqzQLRJrCFcr0rRVhUSiDctqJU1wlD0enEospINBkam87PnmVHdOdXc7bYR5Qz0mcM
         TjmA==
X-Gm-Message-State: AOAM531/DZidt7iWv6eHZvOAweFdHRl6A11HoVoGt7ATQp+0g1zmklTk
        f2j2ZKLExgIHzLuXk/BPhg87QA==
X-Google-Smtp-Source: ABdhPJx9JKGvYeYalS8uchoaPC4Epklh6gjPywXF2S3wgfsIQjVglkf/531Kk5D6ZMHgJxr/FEKZgg==
X-Received: by 2002:a1c:1bc7:: with SMTP id b190mr13478032wmb.115.1615558350171;
        Fri, 12 Mar 2021 06:12:30 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k4sm10360878wrd.9.2021.03.12.06.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 06:12:29 -0800 (PST)
Date:   Fri, 12 Mar 2021 15:12:27 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ian Campbell <ijc@hellion.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Jaya Kumar <jayakumar.lkml@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] fb_defio: Remove custom address_space_operations
Message-ID: <YEt2y4QqnanHHviZ@phenom.ffwll.local>
Mail-Followup-To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ian Campbell <ijc@hellion.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Jaya Kumar <jayakumar.lkml@gmail.com>,
        Christoph Hellwig <hch@lst.de>
References: <20210310185530.1053320-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310185530.1053320-1-willy@infradead.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Mar 10, 2021 at 06:55:30PM +0000, Matthew Wilcox (Oracle) wrote:
> There's no need to give the page an address_space.  Leaving the
> page->mapping as NULL will cause the VM to handle set_page_dirty()
> the same way that it's handled now, and that was the only reason to
> set the address_space in the first place.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Thanks for your patch, merged to drm-misc-next for 5.13.

While I have an expert here, does this mean that for a VM_PFNMAP we could
pull of the same trick without any struct page backing, assuming we pulle
the per-page dirty state into some tracking of our own?

I'm asking since for DRM drivers we currently have a fairly awkward
situation with a bounce buffer in system memory going on that we copy out
of, because we can't directly use the gpu buffers. If we can track
directly in the gpu buffers, maybe even as some kind of overlay over the
vma, we could avoid that copy.

Otoh no one cares about fbcon performance, so *shrug*.

Cheers, Daniel

> ---
> v2: Delete local variable definitions
>  drivers/video/fbdev/core/fb_defio.c | 35 -----------------------------
>  drivers/video/fbdev/core/fbmem.c    |  4 ----
>  include/linux/fb.h                  |  3 ---
>  3 files changed, 42 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
> index a591d291b231..b292887a2481 100644
> --- a/drivers/video/fbdev/core/fb_defio.c
> +++ b/drivers/video/fbdev/core/fb_defio.c
> @@ -52,13 +52,6 @@ static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
>  		return VM_FAULT_SIGBUS;
>  
>  	get_page(page);
> -
> -	if (vmf->vma->vm_file)
> -		page->mapping = vmf->vma->vm_file->f_mapping;
> -	else
> -		printk(KERN_ERR "no mapping available\n");
> -
> -	BUG_ON(!page->mapping);
>  	page->index = vmf->pgoff;
>  
>  	vmf->page = page;
> @@ -151,17 +144,6 @@ static const struct vm_operations_struct fb_deferred_io_vm_ops = {
>  	.page_mkwrite	= fb_deferred_io_mkwrite,
>  };
>  
> -static int fb_deferred_io_set_page_dirty(struct page *page)
> -{
> -	if (!PageDirty(page))
> -		SetPageDirty(page);
> -	return 0;
> -}
> -
> -static const struct address_space_operations fb_deferred_io_aops = {
> -	.set_page_dirty = fb_deferred_io_set_page_dirty,
> -};
> -
>  int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma)
>  {
>  	vma->vm_ops = &fb_deferred_io_vm_ops;
> @@ -212,29 +194,12 @@ void fb_deferred_io_init(struct fb_info *info)
>  }
>  EXPORT_SYMBOL_GPL(fb_deferred_io_init);
>  
> -void fb_deferred_io_open(struct fb_info *info,
> -			 struct inode *inode,
> -			 struct file *file)
> -{
> -	file->f_mapping->a_ops = &fb_deferred_io_aops;
> -}
> -EXPORT_SYMBOL_GPL(fb_deferred_io_open);
> -
>  void fb_deferred_io_cleanup(struct fb_info *info)
>  {
>  	struct fb_deferred_io *fbdefio = info->fbdefio;
> -	struct page *page;
> -	int i;
>  
>  	BUG_ON(!fbdefio);
>  	cancel_delayed_work_sync(&info->deferred_work);
> -
> -	/* clear out the mapping that we setup */
> -	for (i = 0 ; i < info->fix.smem_len; i += PAGE_SIZE) {
> -		page = fb_deferred_io_page(info, i);
> -		page->mapping = NULL;
> -	}
> -
>  	mutex_destroy(&fbdefio->lock);
>  }
>  EXPORT_SYMBOL_GPL(fb_deferred_io_cleanup);
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 06f5805de2de..372b52a2befa 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1415,10 +1415,6 @@ __releases(&info->lock)
>  		if (res)
>  			module_put(info->fbops->owner);
>  	}
> -#ifdef CONFIG_FB_DEFERRED_IO
> -	if (info->fbdefio)
> -		fb_deferred_io_open(info, inode, file);
> -#endif
>  out:
>  	unlock_fb_info(info);
>  	if (res)
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index ecfbcc0553a5..a8dccd23c249 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -659,9 +659,6 @@ static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch,
>  /* drivers/video/fb_defio.c */
>  int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma);
>  extern void fb_deferred_io_init(struct fb_info *info);
> -extern void fb_deferred_io_open(struct fb_info *info,
> -				struct inode *inode,
> -				struct file *file);
>  extern void fb_deferred_io_cleanup(struct fb_info *info);
>  extern int fb_deferred_io_fsync(struct file *file, loff_t start,
>  				loff_t end, int datasync);
> -- 
> 2.30.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
