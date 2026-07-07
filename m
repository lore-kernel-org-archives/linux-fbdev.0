Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE793955F5;
	Tue,  7 Jul 2026 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416182; cv=none; b=ELScWI0ArKCQ1PzP4Mx04DFSqmQQqQ5UA6vD3QkxhA57CHR/d3v18mK85NmEyTo6EOSmWcjRtPaHubuiPMHESLJA1kh85gJXGdT2Le8FUOhs2JUQDhjoEMyGzXpYsqYwaNEy9rUP/4ZAgXMIFcfxsVN26QZkidndYg7e0KebH3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416182; c=relaxed/simple;
	bh=zt22E1LX9kmkVm98NsMh/8f8xBREn/n7nY8DsZn/VB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMXj8lqyD/iBlKTzM9eyA6AKzK58MqWXCf2yCkrvY9C2pYFqa06KDFP5exKfLGDIpoOc8EyOGV7V7xKj/C6eo7OUOEoAJSzPjedunS0/d/isQVe7e+lj+q3xlHmrr+Gt9bNhmAOJMPzjS+7jVq+Ye8+BfIMNerRPVNFY5xL/qTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZQ80bHMs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZQ80bHMs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BBE1F000E9;
	Tue,  7 Jul 2026 09:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783416180;
	bh=UaQwlQnyCdvbuPHBNAIA3OiyxH9sx25jbkvaRh2ZHk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZQ80bHMsCyg2muDZI/f5f3lWDTOQarmhBBYNYcWNWGkgQpA2MnsDVscSOO+/VxBNI
	 Kq35GnqvQI3fMN837+PxAKRnvaJefGuicPbN/ZRmDe8SNb6PwAcyRPw7Ynd1AuP8fl
	 ZL1CWcZkNR7ETjaE9sU5PROwnjXnL+SiKtuMaw+U=
Date: Tue, 7 Jul 2026 11:22:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Keefe Reeves <reeveskeefe@gmail.com>
Cc: andy@kernel.org, abdun.nihaal@gmail.com, error27@gmail.com,
	chintanlike@gmail.com, namcao@linutronix.de,
	niejianglei2021@163.com, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fbtft: use %pe for backlight errors
Message-ID: <2026070747-skype-exit-5962@gregkh>
References: <20260614201551.20542-1-reeveskeefe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614201551.20542-1-reeveskeefe@gmail.com>

On Sun, Jun 14, 2026 at 05:15:51PM -0300, Keefe Reeves wrote:
> Coccinelle found two places where backlight registration errors are
> printed by passing PTR_ERR() to dev_err().
> 
> Use %pe instead so the error pointer can be printed directly. This keeps
> the behavior the same and just makes the error printing cleaner.
> 
> Signed-off-by: Keefe Reeves <reeveskeefe@gmail.com>
> ---
> Changes in v2:
> - Use reachable Gmail address for author and Signed-off-by.

Does not apply to my tree :(
