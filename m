Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F264F381C1;
	Mon,  4 Dec 2023 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ed+e3vUg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C79C433C7;
	Mon,  4 Dec 2023 23:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701733832;
	bh=Mqpn8JWJrEHA3nf1/O0t1Wus8ha9IwThhk7diqcvIZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ed+e3vUgnGtB/R3YbKxwey3JkazEu6+dhewuLboQahlXm69vKI598KAUezRC2DAVK
	 lT/6WKWspSyoP+NxPdpbd5lCH5KktL/ROOYwlVFXMe583zPZC/Lvf5GQV4jsPdtER/
	 qFuv4MVnx6h4XPLGxf34tczNR3KzYeet9NIjW8C8=
Date: Tue, 5 Dec 2023 08:50:28 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: laburnumT <laburnumtec@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix coding style camelCase issue
Message-ID: <2023120550-radish-hypnotic-cc5a@gregkh>
References: <20231204233404.goxljpo2jpwlotig@flo-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204233404.goxljpo2jpwlotig@flo-XPS-13-7390>

On Tue, Dec 05, 2023 at 12:34:04AM +0100, laburnumT wrote:
> Fixed camelCase issues in ddk750_sii164.c and impacted files.
> 
> Signed-off-by: laburnumT <laburnumTec@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_dvi.c    |  16 +--
>  drivers/staging/sm750fb/ddk750_sii164.c | 130 ++++++++++++------------
>  drivers/staging/sm750fb/ddk750_sii164.h |  16 +--
>  3 files changed, 81 insertions(+), 81 deletions(-)


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

- It looks like you did not use your name for the patch on either the
  Signed-off-by: line, or the From: line (both of which have to match).
  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
