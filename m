Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A06223321;
	Thu, 20 Mar 2025 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479859; cv=none; b=W9toHj7fPQ5KPR+cSwPqFMAj8P58VRog0OXA0VSOdNfOldatucLU6WpUk7UPW8cEgHje9ST7cs6uDmrUUftapLnO/b7+Ssycu609Y6rIjJESg70IsxLk7NsJbMKKntn41rEGxgoSDm6Nf4RQ1/35XA4MiKq8joYqLLLnLot74TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479859; c=relaxed/simple;
	bh=3HEJnEhZ/d669MOLql9alT4mXVOxE30ft99+n226O20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAZpf+MYHj5OLpA1GjBlNkybI7SKdHnOtHRLigqkIP/Rzu6jU4HlhuswdhrHxQxvy9IOANzYMShDeqcOveC+Hz/C+uaerwTnZe9WnISkFpfBeRJOe9wEJMTB+KLKohmkbcflteNQat5oXgDtV7neAY4DTkVNi+S2WcyJC3WyihU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hLoGDzES; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hLoGDzES"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5229C4AF0B;
	Thu, 20 Mar 2025 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742479858;
	bh=3HEJnEhZ/d669MOLql9alT4mXVOxE30ft99+n226O20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLoGDzESP3WOVoxz7nzIQITIX9J0ISZilVyTxhEO/rO0w+bR1rTys4f1iIpcJXJXT
	 RuFpwDPEjuVFG1PYJIAdUs3au1pe4Cfz5Hq0cvxN3DxW5PBs6MuHSk6m/TnUjjR6K0
	 blK1D1rs88Was9bVgiN2RYWVd5qN0fK3kV/TSUGs=
Date: Thu, 20 Mar 2025 07:09:39 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] [PATCH v2] staging: sm750fb: Make g_fbmode truly constant
Message-ID: <2025032027-babble-ominous-c704@gregkh>
References: <20250222201514.15730-1-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222201514.15730-1-madhurkumar004@gmail.com>

On Sun, Feb 23, 2025 at 01:45:14AM +0530, Madhur Kumar wrote:
> Declare g_fbmode as a pointer to constant data. This ensures that both
> array and its element are immutable.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---
> Changes in v2:
> - Added commit message
> ---
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 04c1b32a2..aa154032f 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -33,7 +33,7 @@
>  static int g_hwcursor = 1;
>  static int g_noaccel;
>  static int g_nomtrr;
> -static const char *g_fbmode[] = {NULL, NULL};
> +static const char * const g_fbmode[] = {NULL, NULL};

How did you test this?  It totally breaks the build :(
