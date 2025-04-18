Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B325FEEB3;
	Fri, 18 Apr 2025 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744972784; cv=none; b=Jnz/86IOUOzg+uHahVET10RH2rsfVEbDcArnnufMxazyJvGhTwCPRdTP9S7Oo/gF6621kJDmT3MshmQU1Ot6ziBuDDJwMT9EyhIkI+9KoQflmyvUJl9lpzThLhPvBqPGe0c2o51dqmWj9PJwGCHSJhQ68GH75qYLBIjEyTNvMUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744972784; c=relaxed/simple;
	bh=Es2kj5rWfsRwuqdJ3HO6rHVetddtnH4dUWYDSUnEDKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbzKO8NLf0eaizcbidxFa9z28J7cH8qcXsPd8TZUd/O1cSgUZD6K6d5fkZHmUGw/UUe4CzXRsc4teuIx8URNSbFceXRhSKKh5P7sJ8i3TCzr/UdcaaYBbxZfH0U/ZxOISiJBkyf8rovn1PLuvMNaOZ6zwSlllStwdk50ScqZ1RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MuTS1vVJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MuTS1vVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F8BC4CEEA;
	Fri, 18 Apr 2025 10:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744972784;
	bh=Es2kj5rWfsRwuqdJ3HO6rHVetddtnH4dUWYDSUnEDKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MuTS1vVJOrWO1tgoRVvQyutsbHBkU4EJvq499/WdEML7nqdDHlXi891tVZFpb7T/3
	 uB72O76sDIL2/YkFw01OEADsmG1trwUuiG7wA1LE0i52TTXoZc/GtaF+SAhw+v2bmn
	 ik4ZuYcUO8nfOpbabrq6cu+zCHb/apDgjrm/TDDg=
Date: Fri, 18 Apr 2025 12:39:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Florin <ericflorin.kernel@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: clean-up `else`-blocks
Message-ID: <2025041805-ammonium-scouting-dad6@gregkh>
References: <20250418035023.27067-1-ericflorin.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418035023.27067-1-ericflorin.kernel@gmail.com>

On Thu, Apr 17, 2025 at 08:50:23PM -0700, Eric Florin wrote:
> Clean-up `else`-blocks in `hw_sm750_map` that occur after `if`-blocks that
> terminate function execution.
> 
> Signed-off-by: Eric Florin <ericflorin.kernel@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750_hw.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
> index 4bc89218c11c..64b199061d14 100644
> --- a/drivers/staging/sm750fb/sm750_hw.c
> +++ b/drivers/staging/sm750fb/sm750_hw.c
> @@ -55,9 +55,8 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
>  		pr_err("mmio failed\n");
>  		ret = -EFAULT;
>  		goto exit;
> -	} else {
> -		pr_info("mmio virtual addr = %p\n", sm750_dev->pvReg);
>  	}
> +	pr_info("mmio virtual addr = %p\n", sm750_dev->pvReg);

When drivers work properly, they are "quiet".  This driver is not quiet
at all.  So this really should be a call to dev_dbg(), right?

>  
>  	sm750_dev->accel.dprBase = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
>  	sm750_dev->accel.dpPortBase = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
> @@ -84,9 +83,8 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
>  		pr_err("Map video memory failed\n");
>  		ret = -EFAULT;
>  		goto exit;
> -	} else {
> -		pr_info("video memory vaddr = %p\n", sm750_dev->pvMem);
>  	}
> +	pr_info("video memory vaddr = %p\n", sm750_dev->pvMem);

Same here.

thanks,

greg k-h
