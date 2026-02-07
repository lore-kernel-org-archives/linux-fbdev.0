Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7341F0991;
	Sat,  7 Feb 2026 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770471261; cv=none; b=bTkp5DNvemBNcLeSxmQLRyVR+9eHpV0ha4d+JlnuI4Qo8p+hDJbkAjW/cMH10W9n/u6CFNg97mEZchNlZkn+UuHcKx9uhMpP8iCczcNdfM5EtVBxR+3I0ucRcBIdClaPbF8Z5THcIKithD8gjoN5s2nw4FLVfTb4EkOqNePbjCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770471261; c=relaxed/simple;
	bh=zI8stNPZ2Gz7lJTh9kOcFHpyQzat1antrXW4Yj9SIl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6i618izAIRTgF9yEDJlQEyZkRE4ylyAW3Sp7lpcGAnSKZO6a0K0pIVu2jIB/+HsP7xIlBLID7lTmSQrsqVJLQpZVdpkMv4PQd9GLigzQH2WdP3hYiPGLfbph673iiUQiNqaa32btFs9Bi4ixApKYKI8P/q1XU8ejs1IEaDTBW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oMCBJ+Av; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oMCBJ+Av"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF39C116D0;
	Sat,  7 Feb 2026 13:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770471261;
	bh=zI8stNPZ2Gz7lJTh9kOcFHpyQzat1antrXW4Yj9SIl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oMCBJ+AvtEx0T+ZdrRZ5btw6uWFe1X06sRKOMGIBSUETf54dRYlLb2ELWFK/vGsxR
	 r+sgEUBvBiSD5IkIP1QptxQao4HvC50L9mxKeJ+kRSADWisswzE0f+7tow9DiHhANE
	 fXh+zk1NjB05UhFTYSLhFW5KJZJIq/sxCuWC6Hyc=
Date: Sat, 7 Feb 2026 14:34:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: rename CamelCase variables in
 sm750_accel.c
Message-ID: <2026020754-jolliness-film-b35f@gregkh>
References: <20260205234808.2232-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205234808.2232-1-iprintercanon@gmail.com>

On Thu, Feb 05, 2026 at 11:48:08PM +0000, Artem Lytkin wrote:
> Rename CamelCase function parameters and local variables to
> snake_case to comply with kernel coding style:
> 
>   sBase       -> src_base       dBase        -> dst_base
>   sPitch      -> src_pitch      dPitch       -> dst_pitch
>   Bpp         -> bpp            nDirection   -> direction
>   pSrcbuf     -> src_buf        srcDelta     -> src_delta
>   startBit    -> start_bit      bytePerPixel -> bytes_per_pixel
>   fColor      -> fg_color       bColor       -> bg_color
>   ulBytesPerScan  -> bytes_per_scan
>   ul4BytesPerScan -> bytes_per_scan_aligned
>   ulBytesRemain   -> bytes_remain
>   ajRemain        -> remain_buf
>   write_dpPort    -> write_dp_port
> 
> Update the corresponding kernel-doc comments and function
> declarations in sm750_accel.h.
> 
> Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750_accel.c | 134 +++++++++++++-------------
>  drivers/staging/sm750fb/sm750_accel.h |  46 ++++-----
>  2 files changed, 90 insertions(+), 90 deletions(-)

Does not apply to my tree due to others doing the same sort of changes
right at the same time as you were, but their changes came in first,
sorry.

greg k-h
