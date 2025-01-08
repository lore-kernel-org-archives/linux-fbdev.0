Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A95200BBE;
	Wed,  8 Jan 2025 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357108; cv=none; b=T2l/qXF3Fpm/cA2N5Hmxkcrt7Cpofk4XVZ+TFoKrDsOawyEE6MndlYr4/FNO5aK/J5vUkMhzYbXxbI6VohGUWf4zZhVMPz0ueAwdWWT+tGhcHDgBJb4r4AgQRxD4MrzF8dj3eUPmFplXO6V6hPt4XPLx2X/rsIeQ2PQjfl3BxLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357108; c=relaxed/simple;
	bh=DldbNAtePHmlsvAWzdjWhtXQOJmvH7c/HTBmqfBM9S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaxYmirHwZcI+Wvit5GMz8YTOn7Aia39EzIrxOR2K1dIM8cLWGMySLg6UyKd9GWecEEgwEuPtLQCCDQXC4JSHDAQbO5zmEtU/EGmf+1WLQrRcCDrEFeKmPAADXdRlGYHQWHCo4k4CtcJUkvXAEizyWhWdZpUXcEA8eRwqPgSems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DPeZlbq2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DPeZlbq2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f+VrhCVA0I2IukdomGe2XOJrgKQEjDIDWoIRbh28hMQ=; b=DPeZlbq2fcSMzeFGGMmizeZU+5
	CH9miax6p7gZPvrEvaZ5/y+rkTfOZObHy6a3N6jX0UeqWQhG8SB0ucrnXAikteceS2Vb09Ob44pDD
	/0y1qQkx0vnBcRu/iJocMGvdMa6toIcdz+pkbxCM393o2Rbe3T+v/nKGyCrvBKgQbAlp5Nd1qyV4D
	R3iiJDlkpOc1KRDj+K3Hs5XZOgzGxhzwNp6HaC0Wf5tcUJ6bl91aLfOjvQuHDZzdnOyV8q2Do+nbH
	z5KaHsddfG1YGZLC724DamnGEHPjJrSTWXxdKRFrT3xTOzU+1AEPie2u9z3pX4/DWly18nmpkolgU
	XC7+EAHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVZnh-00000002DWW-3y85;
	Wed, 08 Jan 2025 17:25:02 +0000
Date: Wed, 8 Jan 2025 17:25:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH 2/3] mm: provide rmap_wrprotect_file_page() function
Message-ID: <Z3607T2A-pukkuQj@casper.infradead.org>
References: <cover.1736352361.git.lorenzo.stoakes@oracle.com>
 <701a67692d5bf9c8424cdbda103c988bbb278e38.1736352361.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <701a67692d5bf9c8424cdbda103c988bbb278e38.1736352361.git.lorenzo.stoakes@oracle.com>

On Wed, Jan 08, 2025 at 04:18:41PM +0000, Lorenzo Stoakes wrote:
> +++ b/include/linux/rmap.h
> @@ -754,6 +754,26 @@ unsigned long page_address_in_vma(const struct folio *folio,
>   */
>  int folio_mkclean(struct folio *);
>  
> +/**

The kerneldoc comment should be with the implementation, not the
prototype.

> + * rmap_wrprotect_file_page() - Traverses the reverse mapping, finding all VMAs
> + * which contain a shared mapping of the single page at PFN @pfn in @mapping at
> + * offset @pgoff and write-protecting the mappings.

After the '-' should come a _short_ description ... maybe "Write protect
all mappings of this page".

> + * The PFN mapped does not have to be a folio, but rather can be a kernel
> + * allocation that is mapped into userland. We therefore do not require that the
> + * PFN maps to a folio with a valid mapping or index field, rather these are
> + * specified in @mapping and @pgoff.
> + *
> + * @mapping:	The mapping whose reverse mapping should be traversed.
> + * @pgoff:	The page offset at which @pfn is mapped within @mapping.
> + * @nr_pages:	The number of physically contiguous base pages spanned.
> + * @pfn:	The PFN of the memory mapped in @mapping at @pgoff.

The description of the params comes between the short and full
description of the function.

> + * Return the number of write-protected PTEs, or an error.

colon after Return: so it becomes a section.

> +int rmap_wrprotect_file_page(struct address_space *mapping, pgoff_t pgoff,
> +		unsigned long nr_pages, unsigned long pfn)
> +{
> +	struct wrprotect_file_state state = {
> +		.cleaned = 0,
> +		.pgoff = pgoff,
> +		.pfn = pfn,
> +		.nr_pages = nr_pages,
> +	};
> +	struct rmap_walk_control rwc = {
> +		.arg = (void *)&state,
> +		.rmap_one = rmap_wrprotect_file_one,
> +		.invalid_vma = invalid_mkclean_vma,
> +	};
> +
> +	if (!mapping)
> +		return 0;

Should it be valid to pass in NULL?

