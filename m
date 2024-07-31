Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B959F18B480;
	Wed, 31 Jul 2024 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415102; cv=none; b=D6b6dGXkpouai6Jf7vEbBgJhkujcm2UbRp2p/XnuoTgaFPalBXWTAAh//TxaigSZEmBI6AW65GwJL/o4evbelXfr3ANgrc6hKtvcQMXTkAKPhVyAT00Hq4iICrHILRp+VqjQZGxsWww6NQMehFrPGrJ1QkJNyeKaNTUofIOS09s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415102; c=relaxed/simple;
	bh=PJHNRap1ONRw06JzQHZ+bOu/QyvhIVKClDqpdRjag/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imrQsZ49FSWoCW37WvwPck/h/9PsAvBwprBBQBp0CTHEj0MgHyMXvPYLb+/+KnNT8TmTF1sSTQ/IR5JXfsWbPXPysBp6iCNsxl3h/5ztKzlSMLLcL0m4SV6bQqAcdo2GZojDlgTOSkrMQnfkbAaxIemnIL6rTXpYoOAB2Yl37e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zJokyidU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zJokyidU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B281C116B1;
	Wed, 31 Jul 2024 08:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722415102;
	bh=PJHNRap1ONRw06JzQHZ+bOu/QyvhIVKClDqpdRjag/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zJokyidUtVT1Ip+sjNrv8uHyUI4ihMnAx4Xt0h33GjiFtU2P9X4WQdK6nzNvq+Zo3
	 RVn1ZswiuRm2j8KTcJEedLepgaQZsXajV7nYMB2tkg8pxY9UQjgyC2GQQEbra2AEKq
	 JK3eTWHVuWvXSsMSbl6zulnwADtR8sF9LPLUvAxU=
Date: Wed, 31 Jul 2024 10:38:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vme_user: vme_bridge.h: Fix mutex without
 comment warning
Message-ID: <2024073122-abnormal-carefully-f53e@gregkh>
References: <20240731073605.9857-1-riyandhiman14@gmail.com>
 <2024073127-babbling-antiquely-22a2@gregkh>
 <CAAjz0Qahd96tQEpbWPXiGQ7Frku3sXpKQ6BfTWzqxcf4ApSYEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAjz0Qahd96tQEpbWPXiGQ7Frku3sXpKQ6BfTWzqxcf4ApSYEA@mail.gmail.com>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Jul 31, 2024 at 01:34:56PM +0530, Riyan Dhiman wrote:
> Hello,
> 
> Thank you for reviewing my patch. I received your feedback:
> > Are you sure about all of these?  Please document them individually and
> > put the proof of that in the changelog text.
> 
> I'd like to clarify a few points to ensure I address your concerns
> correctly:
> 
> 1. By "document them individually", do you mean I should submit
> separate patches for each mutex documentation change?

Yes.

> 2. Regarding the "proof" for the changelog text, could you please elaborate
> on what kind of proof you 're looking for? Should I include:
>  - References to the code where these mutexes are used?
>  - Explanations of the race conditions these mutexes prevent?
>  - Citations from the driver's design documentation (if available)?

Whatever you feel would be needed to convince everyone that the comment
is now correct.

> 3. Is there a preferred format or level of detail you'd like to see in the
> changelog for each documentation change?

What would you want to see if you had to review this type of change to
be comfortable accepting it?

thanks,

greg k-h
