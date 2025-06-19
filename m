Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C121FF25;
	Thu, 19 Jun 2025 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347018; cv=none; b=Z8ioZc8Fk43V34TsCX3+QRMkT+YrDphCS5CdWlfK5Z3FKsIj/N9rphzOWVitnv1uVTBVq3MM5oZWuHNc6kN5DeLrBXga5PKSXcu4vcoj8YwE0UUI1UYgxJUic4TjEgxQlbh3NmMJBM3NWfS5Glkx2nTgfxY1OePQz8OQ7GP9j9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347018; c=relaxed/simple;
	bh=zRoIT/6nK4xLwX17zgEegbn2IQiNh1JQ18P+Kdl11yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5DRdL232ueYwX3WWEIocahnpe5wLY2DmMn+PfZUqN2ujGmzViEC3x6DU9/mMGSd/WOFyCktrIh6R3NidFTQ/tgDkFgXMzt6ZilvmQfTFmfx3ZRtSgsyWw+WvByEJLmBHWKWb+EnTM8MTrltj8QYIHEeno91UQK7IC+wpG5kL9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DJ7Jr3eg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DJ7Jr3eg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207EAC4CEEA;
	Thu, 19 Jun 2025 15:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750347016;
	bh=zRoIT/6nK4xLwX17zgEegbn2IQiNh1JQ18P+Kdl11yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJ7Jr3ego+L3rVVigRC1Xpd6JRdEFKnstpksFWR7lph8M174ob9bb69Wi/eDIB3Ei
	 xjlPl1uVK1Y2RiOLf3GSNYugdKbw7XVjgGMIpujrG//5ASuYBM7PWcPSuj3GE0MeQD
	 RdszHntc3szF8iwhR5hDFx1fRdgRqiyz526OTnGI=
Date: Thu, 19 Jun 2025 17:30:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Florin <ericflorin@google.com>
Cc: teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] staging: sm750fb: rename `Bpp` parameter
Message-ID: <2025061949-estrogen-progeny-5553@gregkh>
References: <cover.1748365488.git.ericflorin@google.com>
 <5f9c28d0dc0f48151837f11d5f6e7b82f84978ef.1748365488.git.ericflorin@google.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f9c28d0dc0f48151837f11d5f6e7b82f84978ef.1748365488.git.ericflorin@google.com>

On Tue, May 27, 2025 at 10:11:27AM -0700, Eric Florin wrote:
> Rename `Bpp` to `bpp` in `sm750_hw_copyarea` to conform with kernel
> style guidelines.
> 
> Signed-off-by: Eric Florin <ericflorin@google.com>
> ---
>  drivers/staging/sm750fb/sm750_accel.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index ea64e10d4814..a34d8f6a033d 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -138,7 +138,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
>   * @sy: Starting y coordinate of source surface
>   * @d_base: Address of destination: offset in frame buffer
>   * @d_pitch: Pitch value of destination surface in BYTE
> - * @Bpp: Color depth of destination surface
> + * @bpp: Color depth of destination surface

What does "bpp" mean here?  How about "dest_depth"?

