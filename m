Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E89736E476;
	Mon, 30 Mar 2026 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774886112; cv=none; b=qOy7Bq7+0b0u1b5tu5BoR+s+NyYPJWj8CA8e8F8s31QBhmepcyOs9NxjHlWytrV9B/IN79n8lKMMOuKgmlWuFazLTdT/kXkRv9/kX4WNNhvXkq3P2KMgf6LOhhZAJdzzAbQktSkN2/4EzS4rqirPteAiMkHsL/YXGhNgSzXHrdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774886112; c=relaxed/simple;
	bh=Tti4blvCj2le0+UVCkhRw+Ts1zPGEyT54Cef9EtYjrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bE/DPR+8ZUIc521wUoWFgJq5ywIdcRPf4eZjo9LZlg2VX62l03zqrJy3Amjjsgi4XKL8I4NV7fUO9Hti9vwR7WKK9LdAE12gfiPyMo95bQEs0QYwVJOy9I5fAvWETonIC0JdrjBz9otD9dO7FVMNN3pPH4ylyh1Zmd4zgKRnfrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RAZFofRD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RAZFofRD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E3FC19423;
	Mon, 30 Mar 2026 15:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774886111;
	bh=Tti4blvCj2le0+UVCkhRw+Ts1zPGEyT54Cef9EtYjrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAZFofRD1Sh82knVqII5bXjWAwv/z8QLNS+ZnAWC2rR78mlMm68S0cuzO/w0Vs4hr
	 SwB3MU93dH49mEt+saAzXki9FYJI0Th8lAxm2lrFeXBJbS5qiXRrRwUO/9p2PlkekG
	 iWbu/aQ6w9/++2Nex/po/XCaFb93j+hMytix/zrI=
Date: Mon, 30 Mar 2026 17:55:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shubham Chakraborty <chakrabortyshubham66@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] staging: sm750fb: Rename enum sm750_pnltype
 values to snake_case
Message-ID: <2026033049-race-washhouse-86d1@gregkh>
References: <20260318173440.9457-1-chakrabortyshubham66@gmail.com>
 <20260318173440.9457-2-chakrabortyshubham66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318173440.9457-2-chakrabortyshubham66@gmail.com>

On Wed, Mar 18, 2026 at 11:04:38PM +0530, Shubham Chakraborty wrote:
> This patch renames the CamelCase enum values in sm750_pnltype to
> follow the Linux kernel coding style.

Your subject says something different from what you actually did in this
commit :(

