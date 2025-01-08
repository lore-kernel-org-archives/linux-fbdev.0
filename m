Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381431ACEDC;
	Wed,  8 Jan 2025 20:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736369691; cv=none; b=PMY+uatbsVR2JAMVaq9cqfFsoYZml8VjVaiUd629Ju3+BdOi72phZV/kev+S6b53rJXJCUfo0gp8EB8kBasTHqB7iYPEhYsHqU0LO4oqBrZ7bcOacOSSIrXfmNBzcz3G0kI30bRpJQjhycmnsWmuh1yzvVpjY513llnTB2pz+RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736369691; c=relaxed/simple;
	bh=gUw1BjVrWGwt6IWYCYnlqQ1CU6/mi17XnQ/+kNDR9Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWfGnxLyfnXR7aCGxQFMtrU0RtG7EEQoYU3Cr2vHYp9N527eCMK9pBegDhVzjx6v7aLrY6PhY6h6NClPWLY0FrWvMnRb05OfciXwdepx1kbwzcVhs15atyClzqoLTMM95qDkD2Y+hZHUCPXHjjyZYSXrjjo7oXiDIRvh8ArGgVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=id8ODoj9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="id8ODoj9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9sXMdrAsf83UYmPz7o8NHqLs8S9FkLI60oZYrNlbEpE=; b=id8ODoj9gU0Cdk3fyxjE3BdOdg
	uzdKMRy41bzNmrLscB4FzoMPJ5q7FYTtHLhNy8cYciYJrrqZfj1WblHHR20IRMFctT3j96n96gsKO
	aU0GsNK46nQFgEImmHiUJT11tcTDzlYSNewtMaYYpNHzmJS6WPMmNoPXpAy1HcrQcHBWWNgfc0ZTO
	BkaC1qZ/9eJAaE7h9DEcPguHWkzM5QJtDKQhFYgCdOb+p/YvzJwdQA2YsAl1G6bp7zfbGmAyLhc5g
	36GBWqjje5gB8aEEiFb905VC+d8oT67HKipiG6yC/KiUtQPcqHS90GWjL3Bi7Cix5Ul0hITNqkgTn
	jo44I6PA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVd4d-00000002p0c-1TjA;
	Wed, 08 Jan 2025 20:54:43 +0000
Date: Wed, 8 Jan 2025 20:54:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 3/3] fb_defio: do not use deprecated page->mapping,
 index fields
Message-ID: <Z37mE7NdQu-ZgBES@casper.infradead.org>
References: <cover.1736352361.git.lorenzo.stoakes@oracle.com>
 <1e452b5b65f15a9a5d0c2ed3f5f812fdd1367603.1736352361.git.lorenzo.stoakes@oracle.com>
 <Z362xoQMxQRxYUlJ@casper.infradead.org>
 <b7465ad8-50ec-490b-a62a-e535e0a4691c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7465ad8-50ec-490b-a62a-e535e0a4691c@redhat.com>

On Wed, Jan 08, 2025 at 09:14:53PM +0100, David Hildenbrand wrote:
> On 08.01.25 18:32, Matthew Wilcox wrote:
> > On Wed, Jan 08, 2025 at 04:18:42PM +0000, Lorenzo Stoakes wrote:
> > > @@ -280,7 +269,10 @@ static void fb_deferred_io_work(struct work_struct *work)
> > >   		struct folio *folio = page_folio(pageref->page);
> > >   		folio_lock(folio);
> > > -		folio_mkclean(folio);
> > > +		rmap_wrprotect_file_page(fbdefio->mapping,
> > > +					 pageref->offset >> PAGE_SHIFT,
> > > +					 compound_nr(pageref->page),
> > > +					 page_to_pfn(pageref->page));
> > >   		folio_unlock(folio);
> > 
> > Why do we need to lock the folio?  (since this isn't necessarily a
> > folio)
> 
> Can you clarify the "since this isn't necessarily a folio" part ? Do you
> mean in the future, when we split "struct page" and "struct folio"?

Right.  I need to finish the email that explains where I think we're
going in 2025 ...

> Doing an rmap walk on something that won't be a folio is ... sounds odd
> (->wrong :) )

Not necessarily!  We already do that (since 2022) for DAX (see
6a8e0596f004).  rmap lets you find every place that a given range
of a file is mapped into user address spaces; but that file might be a
device file, and so it's not just pagecache but also (in this case)
fb memory, and whatever else device drivers decide to mmap.
