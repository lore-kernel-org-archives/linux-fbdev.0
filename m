Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D7638F258;
	Tue, 13 Jan 2026 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768326844; cv=none; b=rmos+ZUA6zJoUlpyC7+yNTg4KRoHDbV8u2lCCscpnzghn7uO9v5zSgZRpWjveth3hwMc0CnsY3j0E+O7SClfd16B/VLObBoOQMn2ftkj+V1xMLWdsIp4UCNAoKtQS5SiEMBvOJjDbMg7XBXJQ14T4iUFvyRgQ1Q2tQ/4R7FJRdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768326844; c=relaxed/simple;
	bh=8+DdW0k7dct5OT1SiW+7H7DV9JoJjHMxpojYpZLJ070=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fY1a4ohXoHuQ3icPPJMFH5dkTxI8e4GIQvZdfX1Izy79k0/dSWwNeGrgoEAhsN4REzv3/KSysqmnfWvyGY8mV6MzdhjB6DTy6utSafk18IjDiZTBs7dvYnmd6J+LS9KnC/cmrBueCVMiNZCGgZ6KfSdNJpIui8OVp2Mc6mhHjRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=te/C0d+e; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="te/C0d+e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N+rDfW9wwKb/n3da7GixyOkPRd4YZkwdcbQcqnUfsmo=; b=te/C0d+egA2gtgGbiHaaotEcQr
	dxHIcF8WhPTxhGpmHjMgqByrRC6l/C1CxNuvILXO20t36GPbzEtSdHwF9cCX20tb5O2Goicx5yW8C
	5D0pxSTpu0mRpSlf+jpGk1j+nMkzeCP/sxF0Qd2i+r8EB0jY60KUvcGDVbp90JIRsAZLKKCjZEtUW
	tDBkC/CVXMVpOJ/aeQ8LDtWf1WpGTpx2gL+bLKZBWQQ/6zhhjHeWlzQpZnBBrtcBHnJpsYmotxQb7
	k1Mi4zPKBx5PlpDpjv1tleDpBXrLN1PuKGSpojQU6qE0k3YIaW5pw6I2GAZfTnImuXm13LgNVy2Ip
	KPrIgQuA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfiaW-000000053AQ-3VRD;
	Tue, 13 Jan 2026 17:53:52 +0000
Date: Tue, 13 Jan 2026 17:53:52 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Gideon Adjei <gideonadjei.dev@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jianglei Nie <niejianglei2021@163.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Change udelay() to usleep_range()
Message-ID: <aWaGsGhS-nNrDjDA@casper.infradead.org>
References: <20260113172756.14744-1-gideonadjei.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113172756.14744-1-gideonadjei.dev@gmail.com>

On Tue, Jan 13, 2026 at 09:27:56AM -0800, Gideon Adjei wrote:
> Replace udelay() calls >= 100us with usleep_range() to avoid busy-waiting.
> This allows the scheduler to run other tasks while waiting.

Your commit message omits how you know it's safe to sleep in these
situations.  Are we holding a spinlock or being called in interrupt
context, for example?
