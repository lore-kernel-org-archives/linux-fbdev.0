Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DBB221F29;
	Fri, 18 Apr 2025 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744972742; cv=none; b=g6fpINAHPp2rU2DSo8haZx/qWnX4T1AJ721NeQsS/LALIO1osrDGHW5EoUI+UMBoyokDRo5/4ldN9jIxx8zsWS2wYUr6YmyA8iWhtVsvGw3vFc/aIepvrV3w0wQkityTctt+gSXXEz5yJzD7BIXPyBGHrr5xP2a72DJzCnvaBZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744972742; c=relaxed/simple;
	bh=aOQRhOeOnmBbII4RBa6Tmt1BXk6NhnAMlsO85/OnSFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f96JiTHvASaht9vHVVKvbWLFBENtzS3UQezbcyV2bKsDMnywQvuVsHSfFEeWhYBXxFDEsFHn1iS1itSqSMR2UDygqBFDXOdVjOek7Xy8pVKESKploeGFc0EahBmxjX68OY8RTB//eRF1EywVfFoIEkIt/FjpkPnqHpwPa7HFtrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YVKjUYwf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YVKjUYwf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B17CC4CEE2;
	Fri, 18 Apr 2025 10:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744972742;
	bh=aOQRhOeOnmBbII4RBa6Tmt1BXk6NhnAMlsO85/OnSFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YVKjUYwfy2+yKRho8fwn0xIifvlLqd1IU3tHIFLwPJ/B9/XRcUJMTC4gSTihoDlLc
	 1K+P8HW/SyiDfl6jqSyhCwatI5C9PsR7R9TgfT9I5GmhHfQvQK0UgZEdp7ZiGi9JUs
	 nMf9h++GOIbuE9r22prwXy/mlzClNsCBY9XD50Z4=
Date: Fri, 18 Apr 2025 12:38:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ruben Wauters <rubenru09@aol.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] staging: sm750fb: rename hotPlugValue to
 hot_plug_value
Message-ID: <2025041831-tricky-gag-de34@gregkh>
References: <20250417190302.13811-1-rubenru09@aol.com>
 <20250417190302.13811-9-rubenru09@aol.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417190302.13811-9-rubenru09@aol.com>

On Thu, Apr 17, 2025 at 08:02:56PM +0100, Ruben Wauters wrote:
> Renames hotPlugValue to hot_plug_value
> 
> fixes checkpatch.pl's camel case check.
> 
> Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> ---
>  drivers/staging/sm750fb/ddk750_sii164.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
> index 769cbe768c49..86490c87156a 100644
> --- a/drivers/staging/sm750fb/ddk750_sii164.c
> +++ b/drivers/staging/sm750fb/ddk750_sii164.c
> @@ -344,11 +344,11 @@ void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug)
>   */
>  unsigned char sii164_is_connected(void)

This should be returning a boolean, right?  Not your fault, just noticed
it for further potential cleanups if you want to do that.

thanks,

greg k-h
