Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2053905EC;
	Tue,  7 Jul 2026 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415385; cv=none; b=fR0abTBfjfzZtBDJZeq0W6taqjw7PORDDB8ixUCx1wFyBifl80pBzpi1GJUdVg9ZMaAmb+TXQ2tZL46AeahHYYrKdxGT03uUbfwtfH0TSbBb7wLkjUWhR7l1rnaU7ryzBPcGelq36oo3uIpG1QXy0Kpo/YPMN1w7jz6axtEPljA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415385; c=relaxed/simple;
	bh=vPOuVeW5epXD7yeUkWK5wSMWExGXYaQMD3jBKVjlZfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCm8Ca4xiDgGtTE3yPZOOvuXFhCAHq7zqY0Thn3fAr2f+eznkvSgpJKvOXOAGFNhsxYiqi2ZFZgRza53vTd/rGDuD1RvmIwRhEyEusILX7oG9VC0cDlslOn+t42+56txvxArg+yy1f1DXsOonvazt9q1BLRmZOQpgxCWUvEFGpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BPldcR3h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BPldcR3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAA51F00A3D;
	Tue,  7 Jul 2026 09:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783415384;
	bh=j8dyS+0xYby0cnr1vLiqDQ3mkMwebfrFYbyZIetKD5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BPldcR3hjVN3fjJLSI5DoUjD61Sy2bGeq25i7hDN/YqzVmwB3xpHnPqdM0i/b6lGn
	 Nq8zDb5LUVfuBcg4oWKKfaB2lDVFhpqeisDl3qZhv/X29lq1Je2RjFGbAMj7C/82ID
	 2lXjDH4npx6V69X/BnBSJPGCehyOX04zUPmXTuSc=
Date: Tue, 7 Jul 2026 11:09:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ahmet Sezgin Duran <ahmet@sezginduran.net>
Cc: error27@gmail.com, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] staging: sm750fb: deduplicate fbinfo loop in
 suspend/resume
Message-ID: <2026070721-trimming-justifier-ec8d@gregkh>
References: <20260525085808.171974-1-ahmet@sezginduran.net>
 <20260525085808.171974-5-ahmet@sezginduran.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525085808.171974-5-ahmet@sezginduran.net>

On Mon, May 25, 2026 at 08:58:08AM +0000, Ahmet Sezgin Duran wrote:
> lynxfb_suspend() and lynxfb_resume() both walk sm750_dev->fbinfo[]
> via duplicated per-index blocks for fbinfo[0] and fbinfo[1].
> 
> Replace each pair of blocks with a for-loop bounded by
> sm750_dev->fb_count, the number of successfully registered
> framebuffers.
> 
> No functional changes intended.

Do you have the hardware to test changes like this?


thanks,

greg k-h
