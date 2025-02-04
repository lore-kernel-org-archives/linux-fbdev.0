Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D0B8632C;
	Tue,  4 Feb 2025 05:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738647408; cv=none; b=RbOKDjqpX8MCkqJaPXIian8gYPdAhlxf/v/Fa87h/1OBkao6IC2w7E0GAzgvhlkH2rI7OFGlVXhaC5/2epjNvm0mhAKI8Y+t6mhfMg+OFdD3bu9BVpmfgrQATKXbDq3g16aj/Tp6gufvYQuUlACiIfL3FTGAbM7qYtT/rY9rO54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738647408; c=relaxed/simple;
	bh=lsO9hrR/gFtCjhrxYLTAwuHqmreL/QpwD9+YEc97dAs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCRkmxfa7NMClWVeB9UwKX8Dt2DfnSqrJOaxKTSAeZCV3ueBniHNNVqOcyVjY2tag/SZieRAiDUsfxEGp8vPssFOQMC0RHilt9rRRJH8NgOHIiwKloSf+O1phxiz0qBQuK41gtFMbUl0xUkQ7LdAsIUyiBCgeKkXxDTRYw3QPk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AQUCW5op; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AQUCW5op"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cTohvSTvwj+ZiQenntSx8kX9G9dSHidT+DOg/qXt65k=; b=AQUCW5opXz0A3Kwr5+UxwcoShn
	+se4y7BgGVNMd5vk3a+LJjeglSR+HU6tqMfWBQM6G+0j/Ol7NzbDBguQhzHCqBrz+DujUhGY9jJwC
	S2+Ky1IGkbsle1xPtswC823NAtxDxsQwAZfqYJUlPXo8gm+N5E+qDLG79Je6VvfjyA0bKTjCAmP/k
	XqemcU+TeAuRZNGehwNon9n315HM0Mvvhm6l7jtVWwbSwMhkoQQOpsUM5l/mq9fJJEojYlLCzgy7+
	sBBjeG+D6LDPUehEiBJxsM6SdKZay9N20kCXh+WlIQWvrxaUju1vEnBmmWbzQzuCZjFlvr/kttbOH
	RwUhjWnQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfBc2-0000000HIAy-0zIU;
	Tue, 04 Feb 2025 05:36:42 +0000
Date: Mon, 3 Feb 2025 21:36:42 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jaya Kumar <jayakumar.lkml@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Kajtar Zsolt <soci@c64.rulez.org>, Maira Canal <mcanal@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/3] mm: provide mapping_wrprotect_page() function
Message-ID: <Z6Gnat93skcoFZqn@infradead.org>
References: <cover.1738347308.git.lorenzo.stoakes@oracle.com>
 <c802c17cdba59e3455f3d7db07659d5da0ed6dc1.1738347308.git.lorenzo.stoakes@oracle.com>
 <Z6DljlvHpjdFof42@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6DljlvHpjdFof42@phenom.ffwll.local>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Simona,


On Mon, Feb 03, 2025 at 04:49:34PM +0100, Simona Vetter wrote:
> 
> Could we go one step further and entirely drop the struct page? Similar to
> unmap_mapping_range for VM_SPECIAL mappings, except it only updates the
> write protection. The reason is that ideally we'd like fbdev defio to
> entirely get rid of any struct page usage, because with some dma_alloc()
> memory regions there's simply no struct page for them (it's a carveout).

Umm, for dma_alloc* where * is not _pages you never can get a page or
PFN form them.  They are block boxes and drivers must not attempt to
translated them into either a page or PFN or things will go wrong.
Only the kernel virtual address and dma_address may be used.

> See e.g.  Sa498d4d06d6 ("drm/fbdev-dma: Only install deferred I/O if
> necessary") for some of the pain this has caused.

The commit hash is corrupted, I guess this is 5a498d4d06d6 as the
subject line matches.  And that commit (just like the code it is trying
to fix) is completely broken as it violates the above.

