Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE51489FD9;
	Tue, 22 Sep 2026 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055690; cv=none; b=uWutebZjHjuln8pmkxOHnrk2Uf2b+3Ue9H+AzGZjJ8OEB5lTJm5D3Fv7pn8Qsvx/GKf9mec2NrYI2bAASghWqtQR2cbUNzYe/aSupSAOiYTDBFl/B/OjvdKLPzgD0r7XEQ2TGnTynUYVFiEJLwV7wu4daWLSsKQDeFs4JR64Muc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055690; c=relaxed/simple;
	bh=XUfOpKItUivTQzfJZZPeBV73mNXXnF63BoKe2YealYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZXvHE/62ABMLiJflP4Q56bEmfYcfwtXO+NNPRJ/hF1VsIZgScapsZDqUyhi96z+okbipeVGV/XB3HTDmq+x2q32Qw4VEu+OAqkVzdHqRMmWRgNhrpnn+fnmxgR7VUEzMweT9Ab5t2BLwfob5amyTMX7G+Fvk567sUqkTQHzzbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=khMrIrLY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="khMrIrLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A3E1F00893;
	Tue, 22 Sep 2026 05:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790055689;
	bh=DrlcUzTgdGShWSLTZcCX91aNyoT35IwgtT0JL3SZWw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=khMrIrLYkiP5lFsB8RZ4XapvAWHtMWwjNUpW+tUp8rSlP8DMxyWjyFq2HZf0dRZVX
	 laWWywRn/GKAsjnQq44PboP5IZLMcgicMXbBftxi8LGzt+sJyqHToAI4+nPrX3mNWj
	 X1Sewp07+M3G9vrHItDIoryOVZOhqRI/1Q1BkAB4=
Date: Tue, 22 Sep 2026 07:41:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lucas Costa <2000.costalucas@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: free cmap on framebuffer release
Message-ID: <2026092214-corset-unaligned-2cb2@gregkh>
References: <20260922035302.167378-1-2000.costalucas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922035302.167378-1-2000.costalucas@gmail.com>

On Tue, Sep 22, 2026 at 12:53:02AM -0300, Lucas Costa wrote:
> The driver never calls fb_dealloc_cmap() after it has been allocated,
> so when the buffer is torn down we leak.
> 
> This happens on every unbind, and when an error is detected in
> sm750fb_framebuffer_alloc().
> 
> fb_dealloc_cmap() gets called before framebuffer_release() in both places.
> 
> Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
> 
> Signed-off-by: Lucas Costa <2000.costalucas@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 8b93bfeb217b..92412534239c 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -910,6 +910,7 @@ static void sm750fb_framebuffer_release(struct sm750_dev *sm750_dev)
>  	while (sm750_dev->fb_count) {
>  		fb_info = sm750_dev->fbinfo[sm750_dev->fb_count - 1];
>  		unregister_framebuffer(fb_info);
> +		fb_dealloc_cmap(&fb_info->cmap);
>  		framebuffer_release(fb_info);
>  		sm750_dev->fb_count--;
>  	}
> @@ -943,6 +944,7 @@ static int sm750fb_framebuffer_alloc(struct sm750_dev *sm750_dev, int fbidx)
>  	return 0;
>  
>  release_fb:
> +	fb_dealloc_cmap(&fb_info->cmap);
>  	framebuffer_release(fb_info);
>  	return err;
>  }
> -- 
> 2.43.0
> 
> 

Nice, how was this found and tested?

thanks,

greg k-h
