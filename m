Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BD230ACF4;
	Sun, 11 Jan 2026 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768135877; cv=none; b=RwarIC8kJ0/dbuAMhDggE+EOhCaHZTOy3sKZ5614EwaTs9xlbmjbV+yIeAzIUvwF9a2+bpJKK2cxFKGPVEeRl2lgCpoq1KJiUyzyACSKhdm5peyWPv/n04bc/cGTR4g72i0z3omTJl9pQVox6PyTXzw0Bj+wCEu2wOPYUWLaM34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768135877; c=relaxed/simple;
	bh=UvSiY6WMb1tSspIQCY5ZZLenHzVbLj6V0DmuUk97Sas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYc2ik4X1ojjwqITIdMhag/89y78hyllQ/3Q+lbR9iPHJlfWEA4IPh86+Dmv/SbcocVD7/Z4FfdLPslIa5xn/PpwXO2750KowRe3mjDNzDveHv1xus1UsyEfhR7Hfj/3yotHm7WOerSXlY3x2XKlLLhSR7seI8Z2l7AT4dHQdZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ztaoQtAm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ztaoQtAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E075BC4CEF7;
	Sun, 11 Jan 2026 12:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768135877;
	bh=UvSiY6WMb1tSspIQCY5ZZLenHzVbLj6V0DmuUk97Sas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ztaoQtAmqJkW+LY2RrE87IgBewVwyPQ8sE9aV9ELmpXvHe2MXnBbN2nMYIdIZ3nwI
	 2mkLoJ+fi9CFuVgyoQxUslzUcrV4TED1+iLld3Pk8GYOv+pSF/5gWFFbI105XvNIqe
	 p4iQrPFrei5pyfAw9ccSYIJ/0u+utgAE3r8cps6Q=
Date: Sun, 11 Jan 2026 13:51:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tejas Chaudhari <tejaschaudhari038@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: improve clarity in TODO file
Message-ID: <2026011156-alphabet-statute-27fb@gregkh>
References: <20251223185950.12328-1-tejaschaudhari038@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223185950.12328-1-tejaschaudhari038@gmail.com>

On Wed, Dec 24, 2025 at 12:29:50AM +0530, Tejas Chaudhari wrote:
> Improve wording and consistency in the sm750fb TODO file
> by clarifying references to checkpatch.pl and improving
> sentence readability.
> 
> No functional changes.
> 
> Signed-off-by: Tejas Chaudhari <tejaschaudhari038@gmail.com>
> ---
>  drivers/staging/sm750fb/TODO | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/TODO b/drivers/staging/sm750fb/TODO
> index 7ce632d04..56ffd9b36 100644
> --- a/drivers/staging/sm750fb/TODO
> +++ b/drivers/staging/sm750fb/TODO
> @@ -1,8 +1,8 @@
>  TODO:
> -- lots of checkpatch cleanup
> +- lots of checkpatch.pl cleanup
>  - use kernel coding style
>  - refine the code and remove unused code
> -- Implement hardware acceleration for imageblit if image->depth > 1
> +- Implement hardware acceleration for imageblit when image->depth > 1
>  - must be ported to the atomic kms framework in the drm subsystem (which will
>    give you a basic fbdev driver for free)
>  
> -- 
> 2.39.5 (Apple Git-154)
> 
> 

Does not apply to the tree anymore due to other changes in this file,
sorry.  Please rebase on the staging-testing branch and try again.

greg k-h
