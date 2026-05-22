Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401305FDA7;
	Fri, 22 May 2026 04:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779424991; cv=none; b=ma6F7pB/DVDCGLhlotZSJR2Q2oBYZOA/eDOns9qCJEfO6Iis7XF+0eDRslVMSYDSySCJ7gqgeLSc//1HG9Fr/euoNRil+KX9/bNNjTPr67WTtLAKiynptB2RKWspxgrQAxTrn9ZeDZxYIaZG96ZPTEu+GYna5cWa5ZHJEwOSoJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779424991; c=relaxed/simple;
	bh=YfFh5yk0v1xTpsGNMqRc30/ft6bjAwbrqGEt+rDGzVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpauPUC1+etLj/RQyGOKiLgUf+B6BlLPyx+0MTgzIryxiX31GnThOWsrFYoc4xXa63TXMjc3wro9Mv4D22rXg3WemuxElJHoKS2sg27JxtCsHinGyvmsAvSqNASZYmgVO79a6ni0o8Gg25Ba5RF431DsMsKNU19XiHTmUYLs4fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a8iGxB2K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a8iGxB2K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417941F00A3E;
	Fri, 22 May 2026 04:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779424989;
	bh=YfFh5yk0v1xTpsGNMqRc30/ft6bjAwbrqGEt+rDGzVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a8iGxB2KckWBC2HIOeH5LWglZ3LDomGLNTJEfSptLbrey5066HwO//Yc1o/eaaUeZ
	 f+HHBi++a1CNpDPN+LmRQglOJqnFSgzFv27cnKqMQ40UJr+gLjGr826vxBJKuznVu+
	 4WMUtxx4xo+Au01VYKjvCrxCWbftbbsgfPc5pLeo=
Date: Fri, 22 May 2026 06:43:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Michail Tatas <michail.tatas@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: sm750fb: Change camelCase to snake_case
Message-ID: <2026052249-gargle-dimly-9e4c@gregkh>
References: <ag-XlRifxjqXF-Zx@michalis-linux>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag-XlRifxjqXF-Zx@michalis-linux>

On Fri, May 22, 2026 at 02:39:01AM +0300, Michail Tatas wrote:
> Change variable names from camelCase to snake_case
> as per the Linux Kernel standards.

Please do one-change-per-variable, as some of these are fine, but others
are obviously not.

thanks,

greg k-h
