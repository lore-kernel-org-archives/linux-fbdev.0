Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5277C29AAF0;
	Tue,  4 Mar 2025 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105399; cv=none; b=a02iHM+6ypD1dynK0IBgZKYGFrGYZbdufLCkHZDlkdopB5vDtg585mq4/KX+tphyoLr8kB0NXKIrZcr0PKl6pjHfSG0UaFGhC9q8usQ/YeB3UCk8z9QmiJpTF8igBNf8H9RjTj35YKU2ffpg1b8M5r+K7q5z73w3k8LcwoOkotQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105399; c=relaxed/simple;
	bh=MPawbIJcENnfcWBzE8ARs/VX8aAD+0rWnhUzTNkxxl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiPJhP5ho33N+rYelbQgfdpuDUDDqnqpvqbmoear8V5TwwQ2tSIiNj5rzT+LyCeaCaTZaPaan9WwqYJxYmy44QO1jKh10/UWUp0Nuh5u40HXuXuYQQwXTNScYmzKvgI7T743W8V93JNEzMpBD+2TDn4rrIb6KQamg4vRH0qa9p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f9RGc3Rf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f9RGc3Rf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FZJncvRlAU5SBAYX1vQ2enRjbM6jVubiJ0n/QmKhBmU=; b=f9RGc3RfzGcoGsmGMUeGU2eI3G
	c2CPso4DPlhpl7VJr8pPYIsP8e0l5qeN+Dn1QF56cI94dW8iSkjwjWIRLDpVr/BiQJhEYvBQ3iLCj
	0+DsrLMVlelE+p1jh3ymjl2VtUokUHqyibB0Tazu6iFBDzG9CkB6YysYnQG9OVQAcjXc2InLaJQ0K
	fkbG2jbYjJIDJtIPDk7Y8/4WC4JrKOO4QlJllbfRd6aHWCEvasWTuwUe9rtZ2Wlkcj2DTWDgQVh6F
	kfFj6nvXDGKVxxE6/G8K11/BK8j4lDYumcScqLN+7zskCdywym1giLoVEeJbBDG3i4FJzyPDxtqEE
	1hvVQchw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpV1O-00000001rNs-35pX;
	Tue, 04 Mar 2025 16:22:21 +0000
Date: Tue, 4 Mar 2025 16:21:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] fbtft: Remove access to page->index
Message-ID: <Z8coiv3rn8loOltq@casper.infradead.org>
References: <20250221173131.3470667-1-willy@infradead.org>
 <27cc53b9-0db7-451c-9136-5fdcf42145f7@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27cc53b9-0db7-451c-9136-5fdcf42145f7@lucifer.local>

On Fri, Feb 21, 2025 at 05:53:16PM +0000, Lorenzo Stoakes wrote:
> On Fri, Feb 21, 2025 at 05:31:29PM +0000, Matthew Wilcox (Oracle) wrote:
> > There is no need to print out page->index as part of the debug message.
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> LGTM from my side,
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

This patch is not yet in linux-next; can I expect it to go in soon?
