Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FC63ACF17;
	Mon,  9 Mar 2026 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074380; cv=none; b=ZtD4nWqLHhsIozJHCRkDPyDKOkNDk4S0Hw0coy82p3eQCYo7SgrmNNMUgntrfCH0L+k/MKazK+4ptiHTi2VGqPn77VEj//sNRrmKGMsx8fD+WB4TtsIrg/ia/VPxaMiMlCOxQLPaZlzy9C4D673r54CY/t7h6oi9aV2Q3LM5bUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074380; c=relaxed/simple;
	bh=1xfjIqDEkQZEleSzaHtcg9LZ76mWLmVjfAaua14bNR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkDQkj48KDKxgT/5HmCeMHIojtFqrJf+CKU+rGYfq2gx8vh9DhHoqpaSFZ9DuFlD3qnEDjAlyI2758wjdVjIaNs0+BxekgaFZDnyxgGGCnRnu4rkVWNeTB7C5YTZuLgSUO0UvyUc4DDksBALCSaw6IDI7P4PGvqELC5igmzgEMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sLCry9I9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sLCry9I9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4306C2BCB3;
	Mon,  9 Mar 2026 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773074380;
	bh=1xfjIqDEkQZEleSzaHtcg9LZ76mWLmVjfAaua14bNR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sLCry9I9DiU/qS6eoG/Ma7qXRqvOQx2VI3WRSmGHWZ5xfxlO9VxJCMUGC5+jY/8bR
	 ECIyB0S6sVqAsRvq5+IwVA4gcAolah+sCqwSv1ZlX7J9KpaF7Jrw+Z3IXSiCIdNyFP
	 lHfIcCcdE5T3aSYCQL1odNBuXITqu8LkiU4zeAkQ=
Date: Mon, 9 Mar 2026 17:39:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gabriel Windlin <gawindlin@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] staging: sm750fb: remove unused GPIO_MUX bit field
 definitions
Message-ID: <2026030913-deliverer-scorpion-d940@gregkh>
References: <20260303232434.1850583-1-gawindlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303232434.1850583-1-gawindlin@gmail.com>

On Wed, Mar 04, 2026 at 12:24:22AM +0100, Gabriel Windlin wrote:
> The GPIO_MUX_0 through GPIO_MUX_31 bit field macros defined in
> ddk750_reg.h are not referenced anywhere in the driver. The register
> address GPIO_MUX itself is still used by ddk750_swi2c.c. Remove the
> unused bit definitions to reduce dead code as noted in the TODO file.

As Dan says, it's good to keep hardware documentation like this around,
as it's not taking any runtime space.

thanks,

greg k-h
