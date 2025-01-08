Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC6E19B586;
	Wed,  8 Jan 2025 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357579; cv=none; b=EHqB5H221lI0j8CYbrLYTLvBUg+qOjNOb4kIGfRH2+kmztuV4vKKoKOdMqF1Twd9uR0D273nDv4NUUDBaNT9Krwa4InVX50g4ZSOZgOYWur6KomUA4/rGRxLOwXDFl15HPUfcYNc+XKvjrw/RCJOLYXweTtKsk95IBrP16Ocwsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357579; c=relaxed/simple;
	bh=fomzoRettkr7aMGo/poqz1mTyYKh4eTk3JZhGo2LkEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m70E84XjOGqiWRA+A1NvH1Mz72L03xMKdUjERv7+DODaQ9aiL1vXVEqv2hub/VzQpVomHMAZoQlH1RsRK9IcOmVmr24y8ZPLi+fycWty0UDQl2KQHqdu9HzmOivire2DqJpk+VrrhN2PPpvIWE9gqr3oDuzYkQ9h4egFu5EUL2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pANWxhKc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pANWxhKc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=efjfjhNy/ciPUjqdeZUPjdUi9qYemP+O/s6sz7yjRHE=; b=pANWxhKcc5wYNurkiGzQddiIqL
	w7FpUk/gg2lJv6MnbCeORlEgD9UrFNs//jhfIECLEtqRFCAv9y23s8T9g+biYYGyzU23Cjj5RQRzw
	+5FZck6XehMK7OSNvk8LNAReH3dmWzwsLeb1pqmxVDhp0x73Kct0k8oeL+bsrhDyCtganEVeG+Ghf
	6R3I1t5hzKiYTOlpPwn/Yymgh5pjRJe/J8vxZ2cMggjbgWHpdfpB1TsMy8m8u1QFkUizqc/Mjplm1
	klqEBhaNR0HRTpWaFEpms2iwL0Qt9vIBuQvU+zpmLBHN75pk2843p+7s4Ix2acbOOL0rFFJdubgZH
	nlqQdF5w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVZvK-00000002GR2-2UD8;
	Wed, 08 Jan 2025 17:32:54 +0000
Date: Wed, 8 Jan 2025 17:32:54 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH 3/3] fb_defio: do not use deprecated page->mapping,
 index fields
Message-ID: <Z362xoQMxQRxYUlJ@casper.infradead.org>
References: <cover.1736352361.git.lorenzo.stoakes@oracle.com>
 <1e452b5b65f15a9a5d0c2ed3f5f812fdd1367603.1736352361.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e452b5b65f15a9a5d0c2ed3f5f812fdd1367603.1736352361.git.lorenzo.stoakes@oracle.com>

On Wed, Jan 08, 2025 at 04:18:42PM +0000, Lorenzo Stoakes wrote:
> @@ -280,7 +269,10 @@ static void fb_deferred_io_work(struct work_struct *work)
>  		struct folio *folio = page_folio(pageref->page);
>  
>  		folio_lock(folio);
> -		folio_mkclean(folio);
> +		rmap_wrprotect_file_page(fbdefio->mapping,
> +					 pageref->offset >> PAGE_SHIFT,
> +					 compound_nr(pageref->page),
> +					 page_to_pfn(pageref->page));
>  		folio_unlock(folio);

Why do we need to lock the folio?  (since this isn't necessarily a
folio)  Also, do we need compound_nr() here?  I _think_ for defio,
the number of pages allocated per object are fixed, so this should be
an fbdefio->nr_pages field?

(something that's always troubled me about compound_nr() is that it
returns 1 for tail pages and the number you actually expect for head
pages)

