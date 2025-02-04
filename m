Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AC820A5DC
	for <linux-fbdev@vger.kernel.org>; Tue,  4 Feb 2025 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738664382; cv=none; b=ud66Y68VPn+znnbpI942+fJYHghdzKzb77s+7T7NtFm3vfxfxxLqPFDwbmDxhx6EKpeOQYge1akZF+aK5CStRHRWM84coYa7l8AgLjtvd5xhZKUSX8JqthDP0i+dB/LRu2SLncloCKeK6hTfiDj79H7xaSokC3CFrHihTdPFyOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738664382; c=relaxed/simple;
	bh=kLCeiml1fltmVi2Q5hzDLvANaBNKxpl2f1e67rzIRYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCaP7oxHKmmii9Ey94UZgO2Nm09rXbr7wCqMo1S30gokhC5JMTGkcqjBnQ3xMdeYu8CDheXvbRD/BrMVhA6ZuNko4h0r6EfMlnzDhlMnTM3eU+LU/pVm97um345obyfX66C33dwRkJcKucJC9hMwysRqU2mfHrKI6enKB+uT5qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=a9sDV4ue; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="a9sDV4ue"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so36998405e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Feb 2025 02:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1738664379; x=1739269179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ls4rUpX9KWpzDW4b2Z40ClskRs4xRfQGCjUvTHygnvU=;
        b=a9sDV4uenDevwHp/knk+W17qZdzdgH/4GpOBKxPuG5gp8AMzkFLPVXfeCPlW7QuBhk
         /QYGLEA3iYTxEYzgBskBJbEeyYAm5M50hB2ZRa9LQN1IlrK476z1TlIRasJYZ84u4KwH
         CWgYG+hYcYHgVFELiqhFIx/FG2dPm0IRNxAkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738664379; x=1739269179;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ls4rUpX9KWpzDW4b2Z40ClskRs4xRfQGCjUvTHygnvU=;
        b=ts+Rnmdb+byzTEqYFnt1O8+7BYll4YNxHh5rDqOHtARbpPf+3ryjiuLPosmsI62npV
         KZLjBgXwpyiXwh62ERFL/rLiD9zjKHx49EFTWaME6+kdlm+t5iOZ7AzpmAfVbvqc/wVm
         39OaCySpIIvoR6Yxt0KGrDjAEVRojGcg/JrJmg/VsP56ow93dHl1aBVCl5pLz03FdzSe
         8+v00XLPBXWynko8Msn4rScVvGi9Hf7s5xxrrRp/ZiiUm8WN0gdVIdsyOCx/bt3ORjF8
         nkAqG9ma3iTFhkO9A8hDICufcvamgsxSJ9+C2m9Vxn4mG5rSsKzHPcN+VmN+P5tGsQVi
         Bk5g==
X-Forwarded-Encrypted: i=1; AJvYcCU3culNp7/5Uy/0UoPCboXPYtPvBYLFOfkI56XSL19BB+9ud/7qW5p7k4WWut/HcCOwXg7uMTaeie8Quw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZkRHsFxjrcv75IUgWOMpeX/gr0G0/mxPQ1e7E0laScqvnwFxO
	4o87omMhI5YnDuc9D5pdUqhjY8Mc9Utzo4O8c7s6WoT7XFDKido0aX5cpRi0yOo=
X-Gm-Gg: ASbGncvYabpMQ5NKhf/uaCAxAe8H4ho5bp6DtkSoSpRRWbW6uKbXrDwjXUJfNeMkOxi
	IVZPK+Z8ezlQ2QAbfSMqWWsix8AeeTuoOrdLzkC/HGdVa98TsLzLAzModmA1kTiN2Y814lQ1a+s
	zDqLuvWIpmIzLCBscqeUmywmEDwoxE4VAVUHRw1uPeB0y9tBpfLZbfEaPrIoTcknZcPEO90jgG5
	irg19k48typWyvNQe0EIfWdyELt13fAXf5UvVSRcr7trY0T/AOFYguG2vSBj7xMv2ZGAPhsjJve
	v9IJujJn85+/W0JnoSn8ELUKdEY=
X-Google-Smtp-Source: AGHT+IGfnTZuu7x6vWbYmuRmysx88ve6RVrYfx4SVhj9Cnq16Qs0v8RQpAhNnfDl/p101BKPt5R/Qw==
X-Received: by 2002:a05:600c:6d5a:b0:436:e8b4:3cde with SMTP id 5b1f17b1804b1-438e01febf7mr214271695e9.14.1738664378625;
        Tue, 04 Feb 2025 02:19:38 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e245f492sm183438775e9.38.2025.02.04.02.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 02:19:38 -0800 (PST)
Date: Tue, 4 Feb 2025 11:19:35 +0100
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
Message-ID: <Z6Hptwe_Ugo9Qwl8@phenom.ffwll.local>
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
 <Z6DljlvHpjdFof42@phenom.ffwll.local>
 <655f318b-d883-4ddd-9301-53a05ab06bc0@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <655f318b-d883-4ddd-9301-53a05ab06bc0@lucifer.local>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Mon, Feb 03, 2025 at 04:30:04PM +0000, Lorenzo Stoakes wrote:
> On Mon, Feb 03, 2025 at 04:49:34PM +0100, Simona Vetter wrote:
> > On Fri, Jan 31, 2025 at 06:28:57PM +0000, Lorenzo Stoakes wrote:
> > > in the fb_defio video driver, page dirty state is used to determine when
> > > frame buffer pages have been changed, allowing for batched, deferred I/O to
> > > be performed for efficiency.
> > >
> > > This implementation had only one means of doing so effectively - the use of
> > > the folio_mkclean() function.
> > >
> > > However, this use of the function is inappropriate, as the fb_defio
> > > implementation allocates kernel memory to back the framebuffer, and then is
> > > forced to specified page->index, mapping fields in order to permit the
> > > folio_mkclean() rmap traversal to proceed correctly.
> > >
> > > It is not correct to specify these fields on kernel-allocated memory, and
> > > moreover since these are not folios, page->index, mapping are deprecated
> > > fields, soon to be removed.
> > >
> > > We therefore need to provide a means by which we can correctly traverse the
> > > reverse mapping and write-protect mappings for a page backing an
> > > address_space page cache object at a given offset.
> > >
> > > This patch provides this - mapping_wrprotect_page() allows for this
> > > operation to be performed for a specified address_space, offset and page,
> > > without requiring a folio nor, of course, an inappropriate use of
> > > page->index, mapping.
> > >
> > > With this provided, we can subequently adjust the fb_defio implementation
> > > to make use of this function and avoid incorrect invocation of
> > > folio_mkclean() and more importantly, incorrect manipulation of
> > > page->index, mapping fields.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  include/linux/rmap.h |  3 ++
> > >  mm/rmap.c            | 73 ++++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 76 insertions(+)
> > >
> > > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > > index 683a04088f3f..0bf5f64884df 100644
> > > --- a/include/linux/rmap.h
> > > +++ b/include/linux/rmap.h
> > > @@ -739,6 +739,9 @@ unsigned long page_address_in_vma(const struct folio *folio,
> > >   */
> > >  int folio_mkclean(struct folio *);
> > >
> > > +int mapping_wrprotect_page(struct address_space *mapping, pgoff_t pgoff,
> > > +		unsigned long nr_pages, struct page *page);
> > > +
> > >  int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
> > >  		      struct vm_area_struct *vma);
> > >
> > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > index a2ff20c2eccd..bb5a42d95c48 100644
> > > --- a/mm/rmap.c
> > > +++ b/mm/rmap.c
> > > @@ -1127,6 +1127,79 @@ int folio_mkclean(struct folio *folio)
> > >  }
> > >  EXPORT_SYMBOL_GPL(folio_mkclean);
> > >
> > > +struct wrprotect_file_state {
> > > +	int cleaned;
> > > +	pgoff_t pgoff;
> > > +	unsigned long pfn;
> > > +	unsigned long nr_pages;
> > > +};
> > > +
> > > +static bool mapping_wrprotect_page_one(struct folio *folio,
> > > +		struct vm_area_struct *vma, unsigned long address, void *arg)
> > > +{
> > > +	struct wrprotect_file_state *state = (struct wrprotect_file_state *)arg;
> > > +	struct page_vma_mapped_walk pvmw = {
> > > +		.pfn		= state->pfn,
> > > +		.nr_pages	= state->nr_pages,
> > > +		.pgoff		= state->pgoff,
> > > +		.vma		= vma,
> > > +		.address	= address,
> > > +		.flags		= PVMW_SYNC,
> > > +	};
> > > +
> > > +	state->cleaned += page_vma_mkclean_one(&pvmw);
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +static void __rmap_walk_file(struct folio *folio, struct address_space *mapping,
> > > +			     pgoff_t pgoff_start, unsigned long nr_pages,
> > > +			     struct rmap_walk_control *rwc, bool locked);
> > > +
> > > +/**
> > > + * mapping_wrprotect_page() - Write protect all mappings of this page.
> > > + *
> > > + * @mapping:	The mapping whose reverse mapping should be traversed.
> > > + * @pgoff:	The page offset at which @page is mapped within @mapping.
> > > + * @nr_pages:	The number of physically contiguous base pages spanned.
> > > + * @page:	The page mapped in @mapping at @pgoff.
> > > + *
> > > + * Traverses the reverse mapping, finding all VMAs which contain a shared
> > > + * mapping of the single @page in @mapping at offset @pgoff and write-protecting
> > > + * the mappings.
> > > + *
> > > + * The page does not have to be a folio, but rather can be a kernel allocation
> > > + * that is mapped into userland. We therefore do not require that the page maps
> > > + * to a folio with a valid mapping or index field, rather these are specified in
> > > + * @mapping and @pgoff.
> > > + *
> > > + * Return: the number of write-protected PTEs, or an error.
> > > + */
> > > +int mapping_wrprotect_page(struct address_space *mapping, pgoff_t pgoff,
> > > +		unsigned long nr_pages, struct page *page)
> > > +{
> > > +	struct wrprotect_file_state state = {
> > > +		.cleaned = 0,
> > > +		.pgoff = pgoff,
> > > +		.pfn = page_to_pfn(page),
> >
> > Could we go one step further and entirely drop the struct page? Similar to
> > unmap_mapping_range for VM_SPECIAL mappings, except it only updates the
> > write protection. The reason is that ideally we'd like fbdev defio to
> > entirely get rid of any struct page usage, because with some dma_alloc()
> > memory regions there's simply no struct page for them (it's a carveout).
> > See e.g.  Sa498d4d06d6 ("drm/fbdev-dma: Only install deferred I/O if
> > necessary") for some of the pain this has caused.
> >
> > So entirely struct page less way to write protect a pfn would be best. And
> > it doesn't look like you need the page here at all?
> 
> In the original version [1] we did indeed take a PFN, so this shouldn't be
> a problem to change.
> 
> Since we make it possible here to explicitly reference the address_space
> object mapping the range, and from that can find all the VMAs that map the
> page range [pgoff, pgoff + nr_pages), I don't think we do need to think
> about a struct page here at all.
> 
> The defio code does seem to have some questionable assumptions in place, or
> at least ones I couldn't explain away re: attempting to folio-lock (the
> non-folios...), so there'd need to be changes on that side, which I suggest
> would probably be best for a follow-up series given this one's urgency.

Yeah there's a bunch more things we need to do to get there. It was the
lack of a pfn-based core mm function that stopped us from doing that thus
far, plus also fbdev defio being very low priority. But it would
definitely avoid a bunch of corner cases and duplication in fbdev
emulation code in drivers/gpu/drm.

> But I'm more than happy to make this interface work with that by doing
> another revision where we export PFN only, I think something like:
> 
> int mapping_wrprotect_range(struct address_space *mapping, pgoff_t pgoff,
> 		unsigned long pfn, unsigned long nr_pages);
> 
> Should work?
> 
> [1]:https://lore.kernel.org/all/cover.1736352361.git.lorenzo.stoakes@oracle.com/


Yup that looks like the thing we'll need to wean defio of all that
questionable folio/page wrangling. But like you say, should be easy to
add/update when we get there.

Thanks, Sima

> 
> >
> > Cheers, Sima
> 
> Thanks!
> 
> >
> >
> > > +		.nr_pages = nr_pages,
> > > +	};
> > > +	struct rmap_walk_control rwc = {
> > > +		.arg = (void *)&state,
> > > +		.rmap_one = mapping_wrprotect_page_one,
> > > +		.invalid_vma = invalid_mkclean_vma,
> > > +	};
> > > +
> > > +	if (!mapping)
> > > +		return 0;
> > > +
> > > +	__rmap_walk_file(/* folio = */NULL, mapping, pgoff, nr_pages, &rwc,
> > > +			 /* locked = */false);
> > > +
> > > +	return state.cleaned;
> > > +}
> > > +EXPORT_SYMBOL_GPL(mapping_wrprotect_page);
> > > +
> > >  /**
> > >   * pfn_mkclean_range - Cleans the PTEs (including PMDs) mapped with range of
> > >   *                     [@pfn, @pfn + @nr_pages) at the specific offset (@pgoff)
> > > --
> > > 2.48.1
> > >
> >
> > --
> > Simona Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
