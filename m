Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF281AAA38;
	Tue, 10 Dec 2024 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840719; cv=none; b=d5/ZmfVVBgIqT74sCLs64y8PVm7h4PSd8Yq0DYw52OxWGSmjdY2LXFOydRFNoZis6YlNDrLN2x83889K4DUHQHzylY17L07cpZqw2juDnvOwfSC/g4zJJmDSXZK9kg9+KB+kjJaaG8RQBPwc88tpwRW9Am67fOHWHvoTLuy125E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840719; c=relaxed/simple;
	bh=XvACE+bdqQyWiqXaX0FQMqrV41fU2XwxHSNf6quzRNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGYBVB7uuJ1OIfs+VS4Ef8uaN9EVVsp113nuiF7PG+/nqO0JhzU5Pr2eSbQO1eEt8EkDlRd5KRhATVnSPbiHSDGNUOs844BafJsQI8lFmrr93veZoscomoBdRrczaXt7ZRQjS7XSB8wfTJak53gq9i/DI10RXGEEHz5aBIP5tFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ohxgPAk5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ohxgPAk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70476C4CEDE;
	Tue, 10 Dec 2024 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733840718;
	bh=XvACE+bdqQyWiqXaX0FQMqrV41fU2XwxHSNf6quzRNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ohxgPAk5I/GLaIskYIwE6w1VuTM7PUnEFC3rvpKTg05SBwffEWgZhZsu9Z2n6QWOS
	 lVcW1CavMeGNdG/X6t0wJiL02K7xz6BJjuEwicsEUZUzfPoIDVG7RKnusXs5vE2T+S
	 1ZplfdjGTrRrjvPebjVdW4SNdDp/onKaRwh1gAR4=
Date: Tue, 10 Dec 2024 15:24:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Antonio Riccio <linux@ariccio.me>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Remove unnecessary parentheses
Message-ID: <2024121021-blurred-dotted-c78d@gregkh>
References: <Z1hNxNkVSt11ncXs@stream-circuit>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1hNxNkVSt11ncXs@stream-circuit>

On Tue, Dec 10, 2024 at 02:18:48PM +0000, Antonio Riccio wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> CHECK: Unnecessary parentheses around 'devcode != 0x0000'
> CHECK: Unnecessary parentheses around 'devcode != 0x9320'
> 
> Signed-off-by: Antonio Riccio <linux@ariccio.me>
> ---
>  drivers/staging/fbtft/fb_ili9320.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Checkpatch is wrong here, sorry.  Please see the archives for the
details as to why I don't take changes like this.

sorry,

greg k-h
