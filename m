Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFCE1624C9;
	Fri,  4 Apr 2025 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743747753; cv=none; b=DmF1o66gofwpLy+IHJ+01Qa3LHyhTLs3F4cgt2V209sci9GooBxlP2zF7Zw7bBtasu1XGDoJ8nY1H+vgPYIq9LrR0huaQFHtPv8itH5kDB04cZ030daPOlQWcpOPoftpg+einbDLKPE1VEsETmAxCcri6Tvq9aHaXmL1/WvKV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743747753; c=relaxed/simple;
	bh=icNkHaDylAUYaUhRUL2b2w83tKNGx6vEQPdvQkocNnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMDGR4aZMCuv+oM/NQAF4ceNA/+D3XpM/2EEqN+5qnLdkftP+7Kr3wO4w5g/gPPQsN6Bzx3iXecpLmTHS+mXb2oHDTa9NQnFyBwqGSC39819SwBMCKUS97C62qpxf5wB/SiWsOiVY2x4Oz+d9SQ2ZOx2envuzf1nzPvxRM8qb7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lRCZbrXu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lRCZbrXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0324C4CEDD;
	Fri,  4 Apr 2025 06:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743747753;
	bh=icNkHaDylAUYaUhRUL2b2w83tKNGx6vEQPdvQkocNnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRCZbrXuGH5l4gVQu4WC795SftaDLJUdZJuE2hE7TkzXDuwpLNFuxwMV+/JERUB9b
	 dS8P9dfFuGC2nUyQJjxaW4IIA0uP6GzgO3mIwslBXp8vSeaoM+BEuuUxOZ4HuGocgi
	 85/V6gKQnokKT5BCowpySiqyjgPfr4keuMAr9vwE=
Date: Fri, 4 Apr 2025 07:21:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Akintola <princerichard17a@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, julia.lawall@inria.fr
Subject: Re: [PATCH] staging: sm750fb: modify function name to kernel code
 style
Message-ID: <2025040443-serrated-flying-c329@gregkh>
References: <67ea5813.5d0a0220.293276.775e@mx.google.com>
 <2025040301-tightness-giveaway-a568@gregkh>
 <CAMyr_bL3sh3HyL0=Qb1h21_-5dqJy0M0Ewo0JMFPNr=x28oNgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMyr_bL3sh3HyL0=Qb1h21_-5dqJy0M0Ewo0JMFPNr=x28oNgw@mail.gmail.com>


A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?


http://daringfireball.net/2007/07/on_top

On Thu, Apr 03, 2025 at 11:37:48PM +0100, Richard Akintola wrote:
> Hi,
> 
> Yes I did send two different patches (part of the reason I used
> different subject lines),
> they did similar things (change camelCase to snake_case,  I wanted to
> get all done in the file,
> but I learnt it is best done one at a time.
> 
> So should I have it all done in the file (there are more than 2
> camelCase CHECKs), or send it
> one after the other? (but you could take the first).

Please send it as a patch series.

thanks,

greg k-h
