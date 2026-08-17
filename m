Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDEB4399CD;
	Mon, 17 Aug 2026 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985887; cv=none; b=Pcp+vrLQzL361XgvBIegRuG6q1AoDTq9vOzn+lZofq86JQSNWEjkQAgtSNS4cU18ln1hOlKVo/X36gK6CJtC7nsEfMJWpvCW2nqAQzcmz+nlMsBx4pcA4eXMFega6NixIhsMw9fLXC8jvVRKjaRSifbeHPgbe976tbmZsqqvtp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985887; c=relaxed/simple;
	bh=E7XkthcgdOWlCGNCIYt2jsx5n0Bn7gtOQoYVBubqvUw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gvIUsddcaLCEqzIyIHmEvfodcPQqD5vZbeq1syjGoKTuv2PWkl9zm1bq+CvQ77neLF4xwkK0cfabFGxgSub9/q7YTQXq81vxNYWmThubKv4jjvC/LGh48ITyn0zUQ+MEA5dDQ+22uf7XTHYQ9GCr+QG3PCTdxqIO4BVIsgYpi5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id D31629200C0; Mon, 17 Aug 2026 18:58:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id CF8309200BB;
	Mon, 17 Aug 2026 17:58:03 +0100 (BST)
Date: Mon, 17 Aug 2026 17:58:03 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Randy Dunlap <rdunlap@infradead.org>
cc: linux-kernel@vger.kernel.org, sashiko-bot@kernel.org, 
    Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
    dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 04/04] fbdev: maxine: fix maxinefb_init() return value
In-Reply-To: <20260814025640.2782161-1-rdunlap@infradead.org>
Message-ID: <alpine.DEB.2.21.2608171757500.14132@angie.orcam.me.uk>
References: <20260814025640.2782161-1-rdunlap@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 13 Aug 2026, Randy Dunlap wrote:

> A driver should return a negative error code on failure of its
> module_init() function so that the system recognizes the failure.
> Change the "return 1" to "return -ENODEV".

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej
