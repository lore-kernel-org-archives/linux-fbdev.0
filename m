Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88ED1A76C4;
	Wed, 31 Jul 2024 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411893; cv=none; b=ZQbuyUhK7QCYUeU+Iw6U22pzVkOSG/oiVrX49KU5GJD+dOhRehTMx4/Y5GZ4Lx2miVJG8Z104QYAnJGWkCeFq6yU3CI65R9L/rI9O8v5tryfh1jTP82aJ4brmOwcyRtXS9PajT5oFbjuPyC0WXVfnazGboPsMIvXb8k6ewQUFhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411893; c=relaxed/simple;
	bh=ShY7Nj4mnNJABphfGU7nTPsI5y6WvrjXgfhgmdlfdAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSBOr245YA98y//EHk/7RleZrs1x7ugRBHNzEyXzXYiaQFc3yl+16tdV4q930D8Lrp4ikMzMu0hF/CGEIR/oqCdHSKd50ZvS882ayROjTCXXI3t4EQfNBgh+dp0xP3JP2WxEqmLjQyI2z9PRRuSzHiJjjWvgxxIOsbnEqOyOmdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ksMDSoIy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ksMDSoIy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF11C116B1;
	Wed, 31 Jul 2024 07:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722411893;
	bh=ShY7Nj4mnNJABphfGU7nTPsI5y6WvrjXgfhgmdlfdAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ksMDSoIyA4US0w9TtUvGC3IjWc/1rNmQLUy97N8VumsV426KvF8GWKIJHoK10IO64
	 7bCUSrcUG8nPIBc6f7/49R22jKPniW29jtTa1jPPU39W9PH7wU4Pz/ACyMhYtrzD9U
	 /pcA4J2X0X3LpEL0NzIInLYZSON9GgpN4isLVtE4=
Date: Wed, 31 Jul 2024 09:44:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vme_user: vme_bridge.h: Fix mutex without
 comment warning
Message-ID: <2024073127-babbling-antiquely-22a2@gregkh>
References: <20240731073605.9857-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731073605.9857-1-riyandhiman14@gmail.com>

On Wed, Jul 31, 2024 at 01:06:05PM +0530, Riyan Dhiman wrote:
> Adhere to Linux kernel coding style
> 
> Reported by checkpatch:
> 
> CHECK: mutex definition without comment
> 
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
> ---
>  drivers/staging/vme_user/vme_bridge.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/vme_user/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
> index 9bdc41bb6602..0b1f05944f0d 100644
> --- a/drivers/staging/vme_user/vme_bridge.h
> +++ b/drivers/staging/vme_user/vme_bridge.h
> @@ -28,6 +28,7 @@ struct vme_master_resource {
>  struct vme_slave_resource {
>  	struct list_head list;
>  	struct vme_bridge *parent;
> +	/* Locking for VME slave resources */

Are you sure about all of these?  Please document them individually and
put the proof of that in the changelog text.

thanks,

greg k-h
