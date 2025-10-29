Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098972E9ED8;
	Wed, 29 Oct 2025 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732999; cv=none; b=HQ69itpQppiBc/djIp/kUumeh1CT1kxaOPCjoHn8U6j0yZ1wx3Yjf0eY5Fz4Zk8dqhT1N45ZVUE5Q6YsVCxuUTlbLbpq86eBfnPFEoQ53z6j9/cvIU6ZRvjUXsjqZeSCB9pE7bcexMtoIQYFQI2xfryldFLU4xZbb197jpV8m+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732999; c=relaxed/simple;
	bh=PqWMb0OTtldGprN90pxvWtXUmUfGOi4866Reg1Uxjzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJlRWknnE4RiFKxjhALM6Fn7ax4pg8Ov64UIAU8KIi6zbZKu3gMykgYdTrwq3f4XALAXUKdVx3IfI5eaBfQC32B+od3Lcd8acQguxOY19EYxflQU+5GgJAVOEqn26bkCnmWX5K1GWelHfNh6IXzNQ9m2OEe9zTirsRXk10F3ycg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Da+TSplu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Da+TSplu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF482C4CEF7;
	Wed, 29 Oct 2025 10:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761732997;
	bh=PqWMb0OTtldGprN90pxvWtXUmUfGOi4866Reg1Uxjzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Da+TSpluoosJta1j32p74f6RANfZSjjNy0/y6ka3tbRW2dpYG5/2kiG3+asxhoW+t
	 lKL6957DZqBHsFO1sKdzLhkpgFP3IcDnDG/hC+2VnUCsaSiEpT4lm+C0wPyibxd8f9
	 DA41FJX+mVA41JSEy8Qc2Y6qZ3xs54Wb+f3OBF+0=
Date: Wed, 29 Oct 2025 11:16:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
Cc: sudip.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] staging: sm750fb: style fixes: align call and split
 chained assignment
Message-ID: <2025102946-thickness-audacious-5c22@gregkh>
References: <20251029021449.5420-1-cristiandelgobbo87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029021449.5420-1-cristiandelgobbo87@gmail.com>

On Wed, Oct 29, 2025 at 03:14:49AM +0100, Cristian Del Gobbo wrote:
> - Drop previous change that made g_fbmode[] elements const (broke build).
> - Align the continued arguments of sm750_hw_cursor_set_size() with the
>   opening parenthesis.
> - Replace a chained assignment of red/green/blue with a temporary
>   variable to satisfy checkpatch and improve readability.
> 
> No functional change intended.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Signed-off-by: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

On top of what Dan said, I see 4 different copies of this patch in my
inbox, which one is the correct one?  Please make it easy for
maintainers to know what patch to review, we get 1000+ emails a day to
deal with and have no short term memory :)

thanks,

greg k-h
