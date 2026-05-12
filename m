Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB4E388E52;
	Tue, 12 May 2026 05:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564168; cv=none; b=NBa/2RjMKwLd9C+GOYqRoIdrBiBu21AeNIJcfQ2dcOaVMCWPxkZk4EN8TJAztq5yY6pvuNUlie/7omCuzXdHb7UXXEogy0XVxDCL69VuoGS+GbNryqBPnAOWVBHnmZplxOVliuc/IQNcnD+8x495S56+AHZR++BgOtrDz6bEan0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564168; c=relaxed/simple;
	bh=DZH5yH5vZbTuff6CKFBxrdPNRi5PhD/0sETkrpzSgX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YG+1H3CpNp0QryQsMh+CMFkrGfzwYbUd57rXKb3VSkW1YUsRxzyGamN6MXFKTF0oLe4yyGDuZjEhBdbaI3p/3hQ+VhI2FsYrSnrLyoBUY3vwpElPKEx/fNIx5VeQ/+zrfTLmjttSfBmwM++JunxUGstRwfffzGEFwfaAEvQ783Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aVi+rA53; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aVi+rA53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E2BC4AF18;
	Tue, 12 May 2026 05:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778564167;
	bh=DZH5yH5vZbTuff6CKFBxrdPNRi5PhD/0sETkrpzSgX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aVi+rA53fQYulcZb7kAiPI+b7sf1jNogk8gH/VcsbOTpHfMvoYZY0zw6Rze+4U1ES
	 +Q9lvuc51/kBGUJ2lNvwSgrQJMK1Ar6eFZ8sXF6Bn+JHVnuGmtt8srjdinObYopT45
	 OdWW8cmifoFPclQQvP1NQOcBfUw208V2GAncKAaI=
Date: Tue, 12 May 2026 07:35:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alone <yogeshdangal66@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: sm750fb: Keep g_fbmode array non-const
Message-ID: <2026051255-ditto-stainless-e4ba@gregkh>
References: <20260511170245.53556-1-yogeshdangal66@gmail.com>
 <2026051150-yearbook-detention-49d8@gregkh>
 <CAF9nfaDfdBKUnC6sVN8w84ruH5NkSxm8cqXN8JCWH0RESff4Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF9nfaDfdBKUnC6sVN8w84ruH5NkSxm8cqXN8JCWH0RESff4Rg@mail.gmail.com>

On Tue, May 12, 2026 at 12:48:05AM +0545, Alone wrote:
> Thanks for the clarification and guidance.
> 
> I want to learn the correct workflow. As a student contributor, what checks
> and testing steps should I always perform before sending a patch?

Please start with not top-posting and sending html email :)

After that, go through the kernelnewbies.org first-patch tutorial, as
well as the free Linux Foundation kernel development online class.
Between those two, you should have a good basis for working on this
correctly.

Also read all of the documentation we have about submitting a patch.
People wrote that for a reason, don't ignore it :)

thanks,

greg k-h
