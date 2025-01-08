Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC501A08CA;
	Wed,  8 Jan 2025 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736373320; cv=none; b=divJg5fJHHZpAfnq7ut3dFePZtnj5uUZ24z3uTrfo2y/VMHYotUdA8Sv9JEsirw3uhMd+n6lp7ocOBtSXilwshLpnNjTx5zGrMlE/AfRReQf4alrOvMUFaLe1+ZWMyr0WAd95b/qpf0FWf/jf7fdDggYwIfUNo2DqyqmcZBrr1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736373320; c=relaxed/simple;
	bh=1P5pa29rTWsZd4zCnpSv0aA5c+H/ePKH5N9VRIqM960=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rogVoRx91JFQOJnue7RL/CS6eOdIYvJsPG1dboEETZsL+rVSuSpy2dKIAwBjsdGhi37QYTvJSKQMUFkGauhuGPCaOYa4FmoHgoKoCv/7w3iQqKFJLq25ovl7auWmUNEC7VlgsxMsJutmUs5geH3DA5WMYgkaIM1q3HD9/g1u4u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tKtR3JeM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tKtR3JeM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GZFfG+Oey+YrRCmnuLUDH49MTGtZAOROTvCOTJdkge4=; b=tKtR3JeM6A1gmAWNtq4cuOMcjM
	Ymux5zQa7scoEka+qRFfaW9TtNncXNfaGb0/Dur+AnmApwhDpMulmiupz69vy885FpWVvr+kf12Mv
	QV/Y0jB8EFEU2D7DCawSyRYGvekSg24VJrNJRHJgv+w3rX6QJgYtWqnVlFJd+RZszj4XK67Pb4szY
	hDRHyLmHH59eOk/GiBit7gph6L0jZUOKh+8mYxOesouUB6VUeVFEGCowNisc7TcDQ0VJ//RZMrd59
	8kniig18CBsDcV/cctYTRE2YKf1R8ZWHFHaqHPlJRVSveYFAMKJgyitdKWPg3F2Sf5cMXBXznmozy
	pm+98I7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVe1B-00000002xlB-08gm;
	Wed, 08 Jan 2025 21:55:13 +0000
Date: Wed, 8 Jan 2025 21:55:12 +0000
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
Message-ID: <Z370QO_Qq8-g4DZ6@casper.infradead.org>
References: <cover.1736352361.git.lorenzo.stoakes@oracle.com>
 <1e452b5b65f15a9a5d0c2ed3f5f812fdd1367603.1736352361.git.lorenzo.stoakes@oracle.com>
 <Z362xoQMxQRxYUlJ@casper.infradead.org>
 <b7465ad8-50ec-490b-a62a-e535e0a4691c@redhat.com>
 <Z37mE7NdQu-ZgBES@casper.infradead.org>
 <34ad8349-c4c3-4370-a662-324fa91b32b1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34ad8349-c4c3-4370-a662-324fa91b32b1@redhat.com>

On Wed, Jan 08, 2025 at 10:12:36PM +0100, David Hildenbrand wrote:
> On 08.01.25 21:54, Matthew Wilcox wrote:
> > Not necessarily!  We already do that (since 2022) for DAX (see
> > 6a8e0596f004).  rmap lets you find every place that a given range
> > of a file is mapped into user address spaces; but that file might be a
> > device file, and so it's not just pagecache but also (in this case)
> > fb memory, and whatever else device drivers decide to mmap.
> 
> Yes, that part I remember.
> 
> I thought we would be passing in a page into rmap_wrprotect_file_page(), and
> was wondering what we would do to "struct page" that won't be a folio in
> there.
> 
> Probably, because the "_page" in rmap_wrprotect_file_page() is misleading :)
> 
> ... should it be "file_range" ? (but we also pass the pfn ... )

I don't think it's unprecedented for us to identify a page by its pfn.
After all, the acronym stands for "page frame number".  That said, for
the one caller of this, it has the struct page and passes in the result
from page_to_pfn().  So no harm in passing in the struct page directly.

I would not like to see this function called "rmap_wrprotect_file_pfn".
Files don't have pfns, so that's a bad name.
