Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ADF249E7;
	Thu, 23 Nov 2023 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kv60d1he"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7979BC433B9;
	Thu, 23 Nov 2023 12:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700743985;
	bh=js9TbuMmNU2OPFbBM6VklvWBIfOE1qJiNCZI/7EDIA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kv60d1herfconAD/4bXwQqu2+54L6nYbsMpah1vnXq2GXxm5sAQj+AW+uV0jklH7N
	 qojiCWnh3o1NPmgUTsCusOdx0zwiGMRn2/TG52qVrbrVxT3/TP+Ey8xAGIPxZUVagj
	 s5Y1UDz2UvtOVc1AQD/HggHOIMeK71lVK1zryJEY=
Date: Thu, 23 Nov 2023 12:49:16 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH 1/8] staging: sm750fb: Rename sii164GetDeviceID to
 sii164_get_device_id
Message-ID: <2023112355-upheld-prowess-9cf0@gregkh>
References: <20231113150512.1210869-1-charmitro@posteo.net>
 <20231113150512.1210869-2-charmitro@posteo.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113150512.1210869-2-charmitro@posteo.net>

On Mon, Nov 13, 2023 at 03:05:06PM +0000, Charalampos Mitrodimas wrote:
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
> ---
>  drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
>  drivers/staging/sm750fb/ddk750_sii164.c | 6 +++---
>  drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 

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


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
