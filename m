Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A253333CE;
	Fri, 22 Mar 2024 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101124; cv=none; b=dINS52gsE56V0Fjhb1TRRt1e7K+lZwelFoB414+30htJTSi3zVQYsey7/tEHwdVmhVlO2pE5r5ziGT3xIVcRsEd+SE0MgF3W3c4PHLDqFrwBWNRQ2PMAmNjLS8J8D2/tbhHEMeh3G3BH9PFM+yy3ZYz+trJ6V/j+/B4wn5GrcsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101124; c=relaxed/simple;
	bh=Y9duQDmYbIfZAdL99bbYJgOQArOsdocc2mHzGrxTJr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGRo1fHXvGZowGXmxkMxvexgVvuRY3yy0YwFQhjwPv2t7Nsdl0OpYgi95SHvG8gRPCHaoywSMBXDTYa9kVDjgN0WSGtXhiLLQ/5FY3YjepHduR5g9/URimB2yU+2RG1qsXiPQaLrHobzavafNUZEj5HtH0RoBYNuy4bKb4rAGmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E22C433F1;
	Fri, 22 Mar 2024 09:52:03 +0000 (UTC)
Date: Fri, 22 Mar 2024 10:52:01 +0100
From: Greg KH <greg@kroah.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	deller@gmx.de, andy@kernel.org, geert@linux-m68k.org,
	dan.carpenter@linaro.org, sam@ravnborg.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 5/6] staging: fbtft: Remove reference to fb_blank
Message-ID: <2024032255-parole-stubbly-37ad@gregkh>
References: <20240319093915.31778-1-tzimmermann@suse.de>
 <20240319093915.31778-6-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319093915.31778-6-tzimmermann@suse.de>

On Tue, Mar 19, 2024 at 10:37:24AM +0100, Thomas Zimmermann wrote:
> The field fb_blank in struct backlight_properties is deprecated and
> should not be used. Don't output its value in the driver's debug print.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
