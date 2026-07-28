Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA33C3F58;
	Tue, 28 Jul 2026 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223481; cv=none; b=eXafoFJR4SeBprMf9++QcwPBaHkplc3FgLY0Hl0B1faa4GkRQeYwPCG9xh7vdsd6SyrkUCgy2pJXcVO0k7RQfZ9/P0nlFkZSM1OBZfJjWrBtQIG54DQIP1Jbd0ZC1QCzgiBClyKN3nLTJupc03HcpM1n0WNDZAsGWCGKrh3y2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223481; c=relaxed/simple;
	bh=WTdD65h7AAMaOf0i8jE0MhwhWRsGcA8sEH8gi+yN36E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JemPTl80F609hf+VQZ0ZodmMWbfOQcgC4mHY+JzOV0mkWGurBJ0EzXj+M2Hbky5T/MGVjnDvU2zUPYCFDQK2Mc2OXxky7XSeMVDEDRQ/XELVbiBsztuw4636Vl6INUFBUpIGTk3SX2VdEEVWg04zqehYWz1J+1YIcBMejLf9UqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GXBtsWGK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GXBtsWGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45881F00A3A;
	Tue, 28 Jul 2026 07:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785223480;
	bh=cs4qnu4ZSJwlXm9q5eOss4nO07ier2ZZTVxbKCyPENw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GXBtsWGK9Rt9erkduGhGG4WZtAA5kdgNcHF9eZeOV62YWeqV8HsTtqc/MbVDbtleI
	 Rnez1dZdQPuvMEtrRTwt13Qjo7MVhm1+OBYVHP7hOYT6dLyJ4YeXcwf43at7slYzcZ
	 agz5/gxrQy5b7gRmd3Iakjo1l3+XH5JgpHkMt0OQ=
Date: Tue, 28 Jul 2026 09:24:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mohit Mishra <mishraloopmohit@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Align prototype parameter names to
 implementation
Message-ID: <2026072814-napkin-legume-4b5e@gregkh>
References: <20260720142605.63454-1-mishraloopmohit@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720142605.63454-1-mishraloopmohit@gmail.com>

On Mon, Jul 20, 2026 at 07:56:05PM +0530, Mohit Mishra wrote:
> The declarations for sm750_hw_copyarea and sm750_hw_imageblit in sm750_accel.h
> use legacy CamelCase parameters, which do not match the snake_case names
> in the actual implementation in sm750_accel.c. The de_copyarea and
> de_imageblit function pointers in struct lynx_accel (sm750.h) also use
> outdated parameter names.
> 
> Rename these prototype parameters to match their implementation names.
> 
> Signed-off-by: Mohit Mishra <mishraloopmohit@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.h       | 10 +++++-----
>  drivers/staging/sm750fb/sm750_accel.h | 12 ++++++------
>  2 files changed, 11 insertions(+), 11 deletions(-)

Does not apply to the staging-testing branch :(
