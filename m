Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4A2386C12;
	Mon, 27 Apr 2026 03:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261837; cv=none; b=h2QyA9FI8qT1RsYdNQWt3Lxl8Qmcs/CmJ5k/dVwUVR3dux7bxVCHM+R5SwyVnOv8jJeVcJa3aiS4HepGrLH8aAgnbjuCWiEEBUvOwceo3qxCxF0TEkBStgc3fdcWnEZzMtzs4EEiLVtFW4ZgUqa/MqHP5KEf6uX/opj+9WNBu1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261837; c=relaxed/simple;
	bh=OsTqdrCpvuRt+s8mRGNxqscUnV+Sj8U770iBk/KIUY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dp8rgdPdbJbK/HKFkKIIZuq+nmUNS4PpMbuVn9r3MXL6Ft8ZWSUekAJyUi+Hyg/Wu8l6TshnT9ko5bICTVO23/RIU/kjYmqBzGrDsBDjYPwk2Ij2mcIXju3tMqW48v109u8m7bIhCiTLfqBpMZV+Tl3y8d6Z7LPj+TWuJqBxbCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c3d6Pbue; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c3d6Pbue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106E0C19425;
	Mon, 27 Apr 2026 03:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777261835;
	bh=OsTqdrCpvuRt+s8mRGNxqscUnV+Sj8U770iBk/KIUY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c3d6Pbuevqje1jWXOD8d5lmhKF4IEv2/3QGbrB/3mqgDZU1IyFyw9WBuJmKXsXmYh
	 JDWd++NiwvAomyC5gX65Sllmh7WhuOpYx4dLH3Y1pR7i1P3GWZQPigaKQWqaoUA7iD
	 P2Ttv/gDMcE4n1AVy7LlBbtg7ygwlygx6KVl5nYg=
Date: Sun, 26 Apr 2026 21:08:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: sm750fb: return -ETIMEDOUT on timeout in
 de_wait functions
Message-ID: <2026042644-deafening-unwelcome-ca90@gregkh>
References: <20260409155821.23375-1-dennylin0707@gmail.com>
 <20260409155821.23375-2-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409155821.23375-2-dennylin0707@gmail.com>

On Thu, Apr 09, 2026 at 03:58:20PM +0000, Hungyu Lin wrote:
> The hw_sm750le_de_wait() and hw_sm750_de_wait() functions return -1
> when a timeout occurs. Replace these with -ETIMEDOUT to use a proper
> errno value and better describe the error condition.
> 
> All callers check the return value as non-zero, so this change does
> not alter existing behavior.
> 
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750_hw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
> index a2798d428663..3809401baa3a 100644
> --- a/drivers/staging/sm750fb/sm750_hw.c
> +++ b/drivers/staging/sm750fb/sm750_hw.c
> @@ -502,7 +502,7 @@ int hw_sm750le_de_wait(void)
>  			return 0;
>  	}
>  	/* timeout error */
> -	return -1;
> +	return -ETIMEDOUT;
>  }
>  
>  int hw_sm750_de_wait(void)
> @@ -520,7 +520,7 @@ int hw_sm750_de_wait(void)
>  			return 0;
>  	}
>  	/* timeout error */
> -	return -1;
> +	return -ETIMEDOUT;

The comment should be removed at the same time, now that the code itself
documents it properly, right?

thanks,

greg k-h
