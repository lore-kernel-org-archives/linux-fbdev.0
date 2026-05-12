Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA8C379C28;
	Tue, 12 May 2026 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571404; cv=none; b=keJLgiCblTOMO3lMK21cECz2x2c/h7U6uVmMalsDzCWCVuNduC2ZHiMKochj1mNaytv+qUR8v1PhuVt13J+37pqLOqOfGRkUgw4rWTwvoXNMaMMfgxtQDouBU65Yzfq754oUUZUSns1itGgTNtWWfnIR8SV1LSnmHFQCSJDHwvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571404; c=relaxed/simple;
	bh=WOHHUJNSb2WnE7C9dFgWjj4jGg0IoQ3Fk/F1s97/06Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QReE0HdTPL9WJE3HINeBWP0+6pO3KRIrXqGSFqSONEETsgi+s0z6Y8ZdWO8guqyJT7ZeN6gemrC6VxBXyef7FLXB0HqRlJ54rY1F2FWy/sIk/TdWgob0iPTP8EJBBfkVmwkJzpATh+iJS/rJJSolKoOPb9lqfsOEV+5wK9YneAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uRnubecS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uRnubecS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741B0C2BCB0;
	Tue, 12 May 2026 07:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778571403;
	bh=WOHHUJNSb2WnE7C9dFgWjj4jGg0IoQ3Fk/F1s97/06Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uRnubecS+v3il9rGVV6NV7Ffe2T/zk1sHoUrUXWDa9aztXkhtJaNTxkK+ZXrg69Br
	 QyQnBsHhfr5Vqf/hZwvPd+YkbNWUNd/ls8bbLwQn4UnZFrs5LrJ1TUV+p4ZSxAFyMx
	 Bexq5KZWZUFICgjE0FhwLIpHaH4aOlPrfvmqf/Mg=
Date: Tue, 12 May 2026 09:36:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chhabilal Dangal <yogeshdangal66@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] staging: sm750fb: remove unused <asm/mtrr.h>
 include
Message-ID: <2026051227-mayday-factual-c81b@gregkh>
References: <20260512063457.80882-1-yogeshdangal66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512063457.80882-1-yogeshdangal66@gmail.com>

On Tue, May 12, 2026 at 12:19:55PM +0545, Chhabilal Dangal wrote:
> sm750_hw.c includes <asm/mtrr.h> under CONFIG_MTRR, but no
> mtrr_add/mtrr_del calls exist in the file; the driver uses
> arch_phys_wc_add/arch_phys_wc_del in sm750.c instead.
> 
> Remove the dead include.
> 
> Signed-off-by: Chhabilal Dangal <yogeshdangal66@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750_hw.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
> index a2798d428663..f491d3aca468 100644
> --- a/drivers/staging/sm750fb/sm750_hw.c
> +++ b/drivers/staging/sm750fb/sm750_hw.c
> @@ -13,10 +13,6 @@
>  #include <linux/vmalloc.h>
>  #include <linux/pagemap.h>
>  #include <linux/console.h>
> -#ifdef CONFIG_MTRR
> -#include <asm/mtrr.h>
> -#endif
> -#include <linux/platform_device.h>
>  #include <linux/sizes.h>
>  
>  #include "sm750.h"
> -- 
> 2.54.0
> 
> 

Please slow down.  Wait at least a full day between patch submissions.
There is no rush or deadline here.  As pointed out, your patches don't
even apply :(

Take a few days off, redo these.  Send them to yourself and see if you
can apply them from the message you send, and then, if all works, send
them out AFTER reading all of the review comments (again this series was
not sent properly, there is no version information...)

thanks,

greg k-h
