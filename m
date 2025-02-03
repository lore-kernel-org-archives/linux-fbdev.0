Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07066209681
	for <linux-fbdev@vger.kernel.org>; Mon,  3 Feb 2025 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738597780; cv=none; b=BUsgcWBGWkRfzIbDtF9cvzqTuLxkKOvfMfzs2zBeraTBNIPv81PSmyiKthA4uk4AiiON9rLw9Fh6Sou0lIKT0Tz0M6zM7Zian579TC9NccglTYEKU+/0mlVvQwvMAC1bLGhOp5X2fxmzluxzeh17xdxmMVH3WGZISXPRxpJTPQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738597780; c=relaxed/simple;
	bh=q8S8Cv3RfiWwhqYt/3mCU7c12YPN48uNx+lQK9KsaSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hni4ejN7XzMVw32LxZsBd3kCQBTuwpMlf1GRPuF5/9slfTrPF55rcm5iBqd83aNQwyvfZKjnCdikIh1RHxbTVxdIBwLFXN69bkqTqcJRzSKAaj7sUPpIhjz5KbnRWXiLF7tinE5z2I8mpuHjhtmj6816ZJwplKojjL4mNaVi72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=hkFbmuSB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hkFbmuSB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so46074615e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 03 Feb 2025 07:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1738597777; x=1739202577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4swfrN/KXwv8DqI9T5BPiJD4bprbjtxNuz9fAJpEo2I=;
        b=hkFbmuSBbwedUNlHtIqANnWfQEOk1RH6TFweQrfO0aSfkylQAHzgpmmxMlz27EvOqP
         aKr3BvQpWWeHw846CYIUQq4r8SX/Abb5xNi5XTrhJ2OTOLQGb6XQViPiLLumqbP/bp8k
         QNfu6DD6r5WR3Miq5OfoqETmCzDiBFAUsPK7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738597777; x=1739202577;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4swfrN/KXwv8DqI9T5BPiJD4bprbjtxNuz9fAJpEo2I=;
        b=NCjfTe/GXgkwdSR6Q/hNrngbRGGmtbuvHAkGRIELavpcZqyH6e8A/2Sq4KEzx8OBmr
         o+RhXcot/LioCrkRlOHg1XgtSsI2vd24ZlWGIKUwYbbwztJMmCZ/7SmfeIquekUnJZ7f
         +zXvBED+TmcDRvZwpGie3Ws8ix5HsWODzr//a5chA2jbJioKQCZyjcIKx+QxcmW23pMn
         3NPjFYWEzlXg1So6oSe2Qmbe/G6F5aw9ycUTbNPWZHF7GWUcDPrRfS+Jl2bk0q9OKyMN
         bo4y87Ae6nmsUL5cDmrmFTrCXBJ25xzgYWt6ImgXc/cNnDeTCD2RChUtDrPQhhriK/u8
         1c2g==
X-Forwarded-Encrypted: i=1; AJvYcCWNLg1t+J4xbJAV1pO8hFwcAX1aNKYmLVgiJdW+to1ljoreCT++aLpd7ar+T7h4x0+e/flXFFiMl4BFRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhv0tvRzZQADgnm8NVjTrB0iuXPsiearCXeP42chMxXhBqp2Im
	2G/BV4t7Wtio6RRp7eRA0wKEFtQWzbCfUFu/zsv9RYpVCQmo2sSyjXO+Z6K7UZ8=
X-Gm-Gg: ASbGncvjl15YlOFuhpCqwRhXQLddXXiw7Vkj9Yd+vrt+9e0oZwjm937q+w4Xh5v6RpY
	Shdum24jQ+5CtrBeyQthikG3GBt1H4tps46khj4gVy+8Irp/7SSydt4eGjL0h7t+4mNbf0b/2hL
	99mocHOHKGNLrd6QMongDr3JJ+ppjQg5UBW/SMZBmM706q2/oCFSvKVA0evM7tYXVJowOj2ffKG
	LjadJMMrhg1XdTKFPyB4pMYu+31+pMY+rMeg17GNFqtZi9WH6FCEmvbj6sL+KsLFSh9wwHFMHa7
	+aUHGc7VB7Ni0VeSS3gFsuMn/Yo=
X-Google-Smtp-Source: AGHT+IFXuD8mylE+ZEqDPpJQ67LpqiN8TrZVlx/UkTqzZgwWZoSori+xM5ZHZR97fwIfxFA4qqZSOg==
X-Received: by 2002:a05:600c:4511:b0:438:a1f5:3e38 with SMTP id 5b1f17b1804b1-438dc430931mr203886735e9.30.1738597777065;
        Mon, 03 Feb 2025 07:49:37 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1d1d03sm13321752f8f.99.2025.02.03.07.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 07:49:36 -0800 (PST)
Date: Mon, 3 Feb 2025 16:49:34 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jaya Kumar <jayakumar.lkml@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Kajtar Zsolt <soci@c64.rulez.org>, Maira Canal <mcanal@igalia.com>
Subject: Re: [PATCH 2/3] mm: provide mapping_wrprotect_page() function
Message-ID: <Z6DljlvHpjdFof42@phenom.ffwll.local>
Mail-Followup-To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jaya Kumar <jayakumar.lkml@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Kajtar Zsolt <soci@c64.rulez.org>, Maira Canal <mcanal@igalia.com>
References: <cover.1738347308.git.lorenzo.stoakes@oracle.com>
 <c802c17cdba59e3455f3d7db07659d5da0ed6dc1.1738347308.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c802c17cdba59e3455f3d7db07659d5da0ed6dc1.1738347308.git.lorenzo.stoakes@oracle.com>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Fri, Jan 31, 2025 at 06:28:57PM +0000, Lorenzo Stoakes wrote:
> in the fb_defio video driver, page dirty state is used to determine when
> frame buffer pages have been changed, allowing for batched, deferred I/O to
> be performed for efficiency.
> 
> This implementation had only one means of doing so effectively - the use of
> the folio_mkclean() function.
> 
> However, this use of the function is inappropriate, as the fb_defio
> implementation allocates kernel memory to back the framebuffer, and then is
> forced to specified page->index, mapping fields in order to permit the
> folio_mkclean() rmap traversal to proceed correctly.
> 
> It is not correct to specify these fields on kernel-allocated memory, and
> moreover since these are not folios, page->index, mapping are deprecated
> fields, soon to be removed.
> 
> We therefore need to provide a means by which we can correctly traverse the
> reverse mapping and write-protect mappings for a page backing an
> address_space page cache object at a given offset.
> 
> This patch provides this - mapping_wrprotect_page() allows for this
> operation to be performed for a specified address_space, offset and page,
> without requiring a folio nor, of course, an inappropriate use of
> page->index, mapping.
> 
> With this provided, we can subequently adjust the fb_defio implementation
> to make use of this function and avoid incorrect invocation of
> folio_mkclean() and more importantly, incorrect manipulation of
> page->index, mapping fields.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/rmap.h |  3 ++
>  mm/rmap.c            | 73 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 683a04088f3f..0bf5f64884df 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -739,6 +739,9 @@ unsigned long page_address_in_vma(const struct folio *folio,
>   */
>  int folio_mkclean(struct folio *);
>  
> +int mapping_wrprotect_page(struct address_space *mapping, pgoff_t pgoff,
> +		unsigned long nr_pages, struct page *page);
> +
>  int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
>  		      struct vm_area_struct *vma);
>  
> diff --git a/mm/rmap.c b/mm/rmap.c
> index a2ff20c2eccd..bb5a42d95c48 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1127,6 +1127,79 @@ int folio_mkclean(struct folio *folio)
>  }
>  EXPORT_SYMBOL_GPL(folio_mkclean);
>  
> +struct wrprotect_file_state {
> +	int cleaned;
> +	pgoff_t pgoff;
> +	unsigned long pfn;
> +	unsigned long nr_pages;
> +};
> +
> +static bool mapping_wrprotect_page_one(struct folio *folio,
> +		struct vm_area_struct *vma, unsigned long address, void *arg)
> +{
> +	struct wrprotect_file_state *state = (struct wrprotect_file_state *)arg;
> +	struct page_vma_mapped_walk pvmw = {
> +		.pfn		= state->pfn,
> +		.nr_pages	= state->nr_pages,
> +		.pgoff		= state->pgoff,
> +		.vma		= vma,
> +		.address	= address,
> +		.flags		= PVMW_SYNC,
> +	};
> +
> +	state->cleaned += page_vma_mkclean_one(&pvmw);
> +
> +	return true;
> +}
> +
> +static void __rmap_walk_file(struct folio *folio, struct address_space *mapping,
> +			     pgoff_t pgoff_start, unsigned long nr_pages,
> +			     struct rmap_walk_control *rwc, bool locked);
> +
> +/**
> + * mapping_wrprotect_page() - Write protect all mappings of this page.
> + *
> + * @mapping:	The mapping whose reverse mapping should be traversed.
> + * @pgoff:	The page offset at which @page is mapped within @mapping.
> + * @nr_pages:	The number of physically contiguous base pages spanned.
> + * @page:	The page mapped in @mapping at @pgoff.
> + *
> + * Traverses the reverse mapping, finding all VMAs which contain a shared
> + * mapping of the single @page in @mapping at offset @pgoff and write-protecting
> + * the mappings.
> + *
> + * The page does not have to be a folio, but rather can be a kernel allocation
> + * that is mapped into userland. We therefore do not require that the page maps
> + * to a folio with a valid mapping or index field, rather these are specified in
> + * @mapping and @pgoff.
> + *
> + * Return: the number of write-protected PTEs, or an error.
> + */
> +int mapping_wrprotect_page(struct address_space *mapping, pgoff_t pgoff,
> +		unsigned long nr_pages, struct page *page)
> +{
> +	struct wrprotect_file_state state = {
> +		.cleaned = 0,
> +		.pgoff = pgoff,
> +		.pfn = page_to_pfn(page),

Could we go one step further and entirely drop the struct page? Similar to
unmap_mapping_range for VM_SPECIAL mappings, except it only updates the
write protection. The reason is that ideally we'd like fbdev defio to
entirely get rid of any struct page usage, because with some dma_alloc()
memory regions there's simply no struct page for them (it's a carveout).
See e.g.  Sa498d4d06d6 ("drm/fbdev-dma: Only install deferred I/O if
necessary") for some of the pain this has caused.

So entirely struct page less way to write protect a pfn would be best. And
it doesn't look like you need the page here at all?

Cheers, Sima


> +		.nr_pages = nr_pages,
> +	};
> +	struct rmap_walk_control rwc = {
> +		.arg = (void *)&state,
> +		.rmap_one = mapping_wrprotect_page_one,
> +		.invalid_vma = invalid_mkclean_vma,
> +	};
> +
> +	if (!mapping)
> +		return 0;
> +
> +	__rmap_walk_file(/* folio = */NULL, mapping, pgoff, nr_pages, &rwc,
> +			 /* locked = */false);
> +
> +	return state.cleaned;
> +}
> +EXPORT_SYMBOL_GPL(mapping_wrprotect_page);
> +
>  /**
>   * pfn_mkclean_range - Cleans the PTEs (including PMDs) mapped with range of
>   *                     [@pfn, @pfn + @nr_pages) at the specific offset (@pgoff)
> -- 
> 2.48.1
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
