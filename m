Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025BC204C26;
	Fri, 18 Apr 2025 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744972496; cv=none; b=JWZszvUmh3uBZZN1J5Bm+SZl0rOKuZArdQQtZY67c0+qSeFadqr7GhYP4auYCa6nLGyDxLlg2tIpR8prFqlrlSRr+66+aLi1M20242762UjILoF4uDk2grHGvys07mJZVjei7152ZIGjy/qQDx3bwLcEaB91RIogkLpUxbJ7oYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744972496; c=relaxed/simple;
	bh=6c0cSTTMGONN/Sf9a5aqLjjJNGiqVqC0uKrf9/rS9VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnLS5Resc4U7K5l3OobohpyEd96P1PNpO2c4yamHwBOxLrkphLb3ADYIEBCZFBZGGUOSP8ZOhKxB0Ls8aZnpPx5qcCYYKM+8LSGjTUByxznoYu55M+SIvpSHHU9C9I0+yON5FiZQHEil+WJ0e1//uYkEAyK8vSOLb/T8VbPS7b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pcsRXTc1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pcsRXTc1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A71C4CEE2;
	Fri, 18 Apr 2025 10:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744972495;
	bh=6c0cSTTMGONN/Sf9a5aqLjjJNGiqVqC0uKrf9/rS9VQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pcsRXTc136y3th6Dmo4mZhSvoIbHd0WVdBDb012opF30X9pJtKGi8jRXUOXZwPikk
	 22+zQJXL2Mvu45hlkVsNwqMzF5WdlsM3zSbB96sdhvy5+D5abytSuvIne3FXju3s2h
	 FggkKzNjaCq58LzdzS+nT87Jh3QDF8fj2MzHxLuY=
Date: Fri, 18 Apr 2025 12:34:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ruben Wauters <rubenru09@aol.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] staging: sm750fb: rename sii164_set_power's param
Message-ID: <2025041825-ranting-dancing-0c86@gregkh>
References: <20250417190302.13811-1-rubenru09@aol.com>
 <20250417190302.13811-6-rubenru09@aol.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417190302.13811-6-rubenru09@aol.com>

On Thu, Apr 17, 2025 at 08:02:53PM +0100, Ruben Wauters wrote:
> Renames sii164_set_power's param from powerUp to power
> 
> This fixes checkpatch.pl's camel case check
> 
> Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> ---
>  drivers/staging/sm750fb/ddk750_sii164.c | 6 +++---
>  drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
> index 9f660a9be5d6..e2da110fab81 100644
> --- a/drivers/staging/sm750fb/ddk750_sii164.c
> +++ b/drivers/staging/sm750fb/ddk750_sii164.c
> @@ -262,14 +262,14 @@ char *sii164_get_chip_string(void)
>   *      This function sets the power configuration of the DVI Controller Chip.
>   *
>   *  Input:
> - *      powerUp - Flag to set the power down or up
> + *      power - Flag to set the power down or up

But now we don't know if it's "up" or "down", right?  Why not pick
"power_up"?

And shouldn't this be a boolean, and not an unsigned char?

thanks,

greg k-h
