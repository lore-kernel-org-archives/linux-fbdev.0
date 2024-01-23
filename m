Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D847FBBD
	for <linux-fbdev@vger.kernel.org>; Tue, 23 Jan 2024 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030459; cv=none; b=DdCCxaU2vnGxYceNQKbyCbTDI4sSrNFdgwjJrkj7tQ1Kuh4I4ru09eIAZpAw1CkbZUlYESD4d+q+mr+eor1aHy/8FfJtUuhuavHQCnjMS26xqtHq32pi07BAZoY2OSGQH57n+VHTOhcaJJ2qxeuV8VGuECQE/qmw8TiHsahWsJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030459; c=relaxed/simple;
	bh=YCZelNhhbIWQTdvj6nFXsE2thA4PMZIvZ3H2/uASigg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uu+LLvCDlZK+Vy9LZnrtPDQhrbgqYr9z3xhCZcAnJr8pOMUQrt4TP1qsmxBVk7dMAeYeiXL+ghi4Co56Gj5OTnsH0TSv3YxnmbvJc1l/c/XzDUI1mqSH1b9a8HeqatlHLPDlnhNmQzH28CsYtrhSO6q7okqh1TAe87bVYWex6aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HtFk/wxX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HtFk/wxX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=zTQsORFLC6fYhfsfPEKgNKuKiXnrjQDCNN/vaGQwoOc=; b=HtFk/wxXzP3j+1B+UYOoNdpJVC
	lKb66WmeXCRmhmb61slllPnGtUpZbEqXvKc+PhLaySfvnQjOKBdYgIAUDsWr/cgw64g2fL80FEZGc
	tPKgJ+2nUN7lU+BkYthbINdNEPNHqdFXeX2P3nOV5ryObtY1reTQ7Jci8zqbmEEXjq7ghNt65n13y
	SbHatvktIyzyeOh2Nkezoj6cciPDhkjybwL9OPkf4lz/62b2mmchurI+bmrNvo7TkRJ/ZbRiruNIg
	WT5aSIfZRl7W6B1SuggIdsrNnoAeYZqFAbCBknLpv+Zu5rrygJD1os/Vei31TbKtcSusBVD8Y7aJo
	OY9HZJfg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSKSF-00000003oVe-1WZ9;
	Tue, 23 Jan 2024 17:20:55 +0000
Date: Tue, 23 Jan 2024 17:20:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
	Jaya Kumar <jayalk@intworks.biz>, Daniel Vetter <daniel@ffwll.ch>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org
Subject: fb_defio and page->mapping
Message-ID: <Za_1d4MVxKeQOP9B@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We're currently trying to remove page->mapping from the entire kernel.
This has me interested in fb_defio and since I made such a mess of it
with commits ccf953d8f3d6 / 0b78f8bcf495, I'd like to discuss what to
do before diving in.

Folios continue to have a mapping.  So we can effectively do
page_folio(page)->mapping (today that's calling compound_head() to get
to the head page; eventually it's a separate allocation).

But now I look at commit 56c134f7f1b5, I'm a little scared.
Apparently pages are being allocated from shmem and being mapped by
fb_deferred_io_fault()?  This line:

                page->mapping = vmf->vma->vm_file->f_mapping;

initially appears harmless for shmem files (because that's presumably
a noop), but it's only a noop for head pages.  If shmem allocates a
compound page (ie a 2MB THP today), you'll overlay some information
stored in the second and third pages; looks like _entire_mapcount
and _deferred_list.prev (but we do shift those fields around without
regard to what the fb_defio driver is doing).  Even if you've disabled
THP today, setting page->mapping to NULL in fb_deferred_io_lastclose()
for a shmem page is a really bad idea.

I'd like to avoid fb_defio playing with page->mapping at all.
As I understand it, the only reason to set page->mapping is so that
page_mkclean() works.  But there are all kinds of assumptions in
page_mkclean() (now essentially folio_mkclean()) that we're dealing with
file-backed or anonymous memory.  I wonder if we might be better off
calling pfn_mkclean_range() for each VMA which maps these allocations?
You'd have to keep track of each VMA yourself (I think?)  but it would
avoid messing with page->mapping.

Anyway, I don't know enough about DRM.  There might be something
unutterably obvious we could do to fix this.
