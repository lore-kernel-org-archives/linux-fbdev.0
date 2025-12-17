Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6534C127;
	Wed, 17 Dec 2025 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976530; cv=none; b=TQxsyaYm9PSvRma++mzZOnL4JWtPgGzpNwosaV+C6dv51QEbU5nVWaADik95/umAYzGzQeB0cihhnpDMdVEtlnQQhABWd9Lw2LY1ZAjuRohuWKC9Y2PC07/VbZs2l7/WilAzXshXdZZrLpcplaXNpR/jIGTfYGiWKAQBHnTCl1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976530; c=relaxed/simple;
	bh=hyLYNW8vxTGXY7LoQe+aYQQuDjchyCEv3663+h9XpXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDrnTpu+JOK6nEKHe+tskyb6YFD7VsasnE7pLqeEgRB6puaoEsdoDbwjxczBbOQ74AIcedAjNnzorA9w9Sw0WHZu9c8lr5Sxl3F71TucsspVFAHFReRpDPvdsJ8uf4tVhLaoihHdF0fhETa1W0FEB0UhJi4GFYy35ss6Cqbq3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YK2FrcmF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YK2FrcmF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AACC4CEF5;
	Wed, 17 Dec 2025 13:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765976530;
	bh=hyLYNW8vxTGXY7LoQe+aYQQuDjchyCEv3663+h9XpXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YK2FrcmFM+Q8yCEh1+6AD+JI45hh9f0jbvGqu5b5xcTVbC1JK4pNEHvdYmq2DZEe2
	 pr3iQ5M7iVeKqDn9bXIeAH+Tb7TA0fiJGtIyA3nryU6aXw0mWxzwJ560C2w87IsZjw
	 Zbsevj0ESOnPJt1Y/a5imV1PO0+OLWdZmUE8w/rg=
Date: Wed, 17 Dec 2025 14:02:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Karthikeya <garagakarthikeya2007@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Fix alignment in
 sm750_hw_cursor_set_size call
Message-ID: <2025121756-unfreeze-overbid-dafa@gregkh>
References: <20251204150127.10844-1-garagakarthikeya2007@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204150127.10844-1-garagakarthikeya2007@gmail.com>

On Thu, Dec 04, 2025 at 08:31:26PM +0530, Karthikeya wrote:
> Align the arguments of the sm750_hw_cursor_set_size function call
> with the opening parenthesis.
> 
> This fixes a checkpatch.pl CHECK warning:
> 'Alignment should match open parenthesis'
> 
> Signed-off-by: Karthikeya <garagakarthikeya2007@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 3659af7e5..9740f2705 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -121,8 +121,8 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
>  	sm750_hw_cursor_disable(cursor);
>  	if (fbcursor->set & FB_CUR_SETSIZE)
>  		sm750_hw_cursor_set_size(cursor,
> -					fbcursor->image.width,
> -					fbcursor->image.height);
> +					 fbcursor->image.width,
> +					 fbcursor->image.height);
>  
>  	if (fbcursor->set & FB_CUR_SETPOS)
>  		sm750_hw_cursor_set_pos(cursor,
> -- 
> 2.52.0
> 

Does not apply at all to the latest kernel tree :(
