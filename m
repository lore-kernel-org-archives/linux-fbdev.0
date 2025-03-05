Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB771C6FFE;
	Wed,  5 Mar 2025 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196996; cv=none; b=AE0qJomMClWQxG5TS1sipQcui7hEt7bbAiY4kprWPvgncZ9dN6lv7SxExL8rsHQJFdc3WFq7F50XzGXXRYxfZvvZNtD7RQvKWU2MY7ilGFdeAIGSDGEuBhS173bUDlf7BY+4SwCNnLOWvz2shxXwWvw64M6PtLovtTpXH74HGGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196996; c=relaxed/simple;
	bh=69xZ7A8/E0lWdoqkf+tuuEaLuZ2WxiW8WXs0lKR/Ju0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLmnUFSoEIK5tznpqLJjulFVQldvabHI8oXpeW7JzDOCtMM/Q21/keqzIjDlmhf/lHJUKemcaUbhymrr/Oh5INpbVBiK+FbyxA41iWp5ce3Vf7TvenUD5If8VlgZS5lkcO6sZueJqxjU9Z28vmewiEYZeNNjtc221gt8ltWT0h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kUFw1NTY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kUFw1NTY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0/5pFhUYG/qRloabUrp96KV5uy7jgbm8O+Ry5t7s1T4=; b=kUFw1NTYDgyfSoerNNJcA28H77
	grP2L7d7Wrw1ojFFqBXLiSTQztpgEGCN73eXG9Mv7FeE1/KuX91SNZ6HP+0o5PYIWmYobJoaWQHQI
	Q0x9flzcKbcM9cRbQCeDkZjGfqPZhUaHjeW5ZrW9eSV9/LxSBxHxODhYwHuiLphLY8EwyZPpWjpp8
	VVcAo/l4OnLUDaBNnNoq/VuGVeXZjFiD/otvKzg6BhnwOCSE9JH9eo8j0goYZ33fyWPiX1fPsDF08
	bDLjh7CvS1qfOTfctPjD8WYYvKC9NI/9JwlIz4ZROPAu7/Da0iX5aivcMoqkmnDLJ6P9gh7nY5Sgk
	InbAHd1w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpssM-00000005yAg-1QZ7;
	Wed, 05 Mar 2025 17:49:46 +0000
Date: Wed, 5 Mar 2025 17:49:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] fbtft: Remove access to page->index
Message-ID: <Z8iOuvGKrWa4kEz_@casper.infradead.org>
References: <20250221173131.3470667-1-willy@infradead.org>
 <27cc53b9-0db7-451c-9136-5fdcf42145f7@lucifer.local>
 <Z8coiv3rn8loOltq@casper.infradead.org>
 <Z8f_pcnaC5iJMz-Z@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8f_pcnaC5iJMz-Z@phenom.ffwll.local>

On Wed, Mar 05, 2025 at 08:39:17AM +0100, Simona Vetter wrote:
> On Tue, Mar 04, 2025 at 04:21:30PM +0000, Matthew Wilcox wrote:
> > On Fri, Feb 21, 2025 at 05:53:16PM +0000, Lorenzo Stoakes wrote:
> > > On Fri, Feb 21, 2025 at 05:31:29PM +0000, Matthew Wilcox (Oracle) wrote:
> > > > There is no need to print out page->index as part of the debug message.
> > > >
> > > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > 
> > > LGTM from my side,
> > > 
> > > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > 
> > This patch is not yet in linux-next; can I expect it to go in soon?
> 
> Being both staging and fbdev it's double orphaned, I stuffed it into
> drm-misc-next now, thanks for the ping&patch.

Thanks!
