Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0285E20A5CA;
	Fri, 18 Apr 2025 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744972575; cv=none; b=PmT5299qW+zbwkXJwPoHE567VT2yxjGxIELZhdshyRaGplbGhfV5ztSQF9LSYTE6G19CBEFtKh0raNDzyxRINMEjHRyqPIziWVWxzA/efGIZpfmE0EQNueeF6pGVigQE5MMFHItgBRGg2wHlaDPf+8MNY4xdJIsGUg4Bq82CaPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744972575; c=relaxed/simple;
	bh=2R57HIa3pKKmVn238y6fiprLjvsbLHI2IoVb8TShHi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDGgCROdX9I80wwFo3lL1Tg6WkphNob7npFRa4UcbosOr0N13PaNVYQlzhCXiHVz4jBbJ3klA8sw+dko3Vfu9GoccXJw1mF+fpO5qP73WbMY1mmstplAh9c2/xlAmBoVxoDSL0RkVlR6VPBPfgoEh/5d8TrrmDT+mDX4qiZRBJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aOiGTERv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aOiGTERv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1234DC4CEE2;
	Fri, 18 Apr 2025 10:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744972574;
	bh=2R57HIa3pKKmVn238y6fiprLjvsbLHI2IoVb8TShHi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOiGTERv/tMVpKYltUQB/s3v6XwGiNuOb0ijvF/xIuV7qsbWimLnZVfrz4/njIlkr
	 Xh82UMwhhZb0H8tjIFXdV5QswbFhS7MjunNS5OKo5QscYCMwHKDGa6nMitKi/6CMDR
	 tNL8+6k1BVlsORnEHEkMyzhL/LG/DuG7id++PoZ4=
Date: Fri, 18 Apr 2025 12:36:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ruben Wauters <rubenru09@aol.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] staging: sm750fb: rename gDviCtrlChipName
Message-ID: <2025041803-clutter-harmonica-7047@gregkh>
References: <20250417190302.13811-1-rubenru09@aol.com>
 <20250417190302.13811-3-rubenru09@aol.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417190302.13811-3-rubenru09@aol.com>

On Thu, Apr 17, 2025 at 08:02:50PM +0100, Ruben Wauters wrote:
> Renames gDviCtrlChipName to dvi_controller_chip_name
> This fixes checkpatch.pl's camel case check.
> 
> Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> 
> ---
> 
> I changed the name to dvi_controller_chip_name as I
> believe it is somewhat more descriptive than
> g_dvi_ctrl_chip_name. If the second one is wanted instead
> please let me know and I will change it
> ---
>  drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
> index dd7811b18bf6..d4309e0d807f 100644
> --- a/drivers/staging/sm750fb/ddk750_sii164.c
> +++ b/drivers/staging/sm750fb/ddk750_sii164.c
> @@ -14,7 +14,7 @@
>  
>  #ifdef SII164_FULL_FUNCTIONS

This is never defined, so instead of papering over variable names that
are crazy, why not just remove all of the code in the blocks for this
define entirely?

thanks,

greg k-h
