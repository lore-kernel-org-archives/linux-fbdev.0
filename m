Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723E921ADC7;
	Wed, 18 Mar 2026 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847471; cv=none; b=mfisyfsuL4BU/DDUjoIYQHIdnZL9+loiIo4r1C/EYxnVVoh7KwhukPpIbIA/5cc+Jpv8IVfwfJuLEDExDP/eJXZYIOjXJicoVUqM8kigc8t0jO4uUV4GRhzEE9tWtrmDm5B2YTQoxvPyNzJhcK9DSVLY249KX+ouJKSFIY4/bdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847471; c=relaxed/simple;
	bh=z+ZlhfTmw1aEPMmQkN577hP2jlg4YMc3Fyxz2oubyLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMEZ8+9vVWj5hH2HDMJoIkboru8HiAV2nnIoBGN6I8MQ5WlvXepJya5m0traS3Fo+yLqCljbxCW25ztS/bA42tG0fMSZfI3v02F3TUdlCNhl69qUpDAhflKus1jZCWlrScrjUAZfWRCXtWHIfuwvd6nbb+Rk/2zpO8XC/xuXFY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l27fqDNQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l27fqDNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9538FC2BC87;
	Wed, 18 Mar 2026 15:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773847471;
	bh=z+ZlhfTmw1aEPMmQkN577hP2jlg4YMc3Fyxz2oubyLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l27fqDNQgkCT4uSJjCKGSYUbgmIE7ipBm+uSo9vr2763Vg66BF8f6j38xP8fKuJxv
	 CUn6GlZY34KLo5VkJAZ5UrwVKwo9X1KqGnKKjd+tmRhRS6XFemvw6TNNRtVoivFtDI
	 uFst7BgPbMPzeXN80485fia6ST67lxeCxXp0YutA=
Date: Wed, 18 Mar 2026 16:24:26 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: sm750fb: Rename enum sm750_pnltype values
 to snake_case
Message-ID: <2026031815-unicorn-despair-4c63@gregkh>
References: <20260314080934.135457-1-chakrabortyshubham66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314080934.135457-1-chakrabortyshubham66@gmail.com>

On Sat, Mar 14, 2026 at 01:39:30PM +0530, Shubham Chakraborty wrote:
> This patch renames the CamelCase enum values in sm750_pnltype to follow the Linux kernel coding style.

Please wrap your changelogs at 72 columns.

thanks,

greg k-h
