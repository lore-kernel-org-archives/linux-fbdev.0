Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0624315F;
	Wed,  8 Jul 2026 05:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487011; cv=none; b=UFTgDdTkn+2DSJ0P8QDMA7t1+sQm55bD6f9moyTtYd3Esd1OgfBZFhOBkhblT1gClEb21A7k7PKqI/ZMvmSbhbjX1oqdXphgq9k3egei/yXk+x+UfM18zcximFw1MK3pZ+67joHqZ0dtUpevYAcWrm5SZMNXx7raXBE9BP6k8xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487011; c=relaxed/simple;
	bh=e7CNPpAQxniVzU3iR3ohCJiNprSDXauK5T7+8lfSY8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQy2ee8LXK+sW9xB0hb6koZoVt/oe8oFzO4ia1Ce3jHr3N5P9nKtiTQ9loouplqlXFk3mQwAlYwH3YDKIGjgZStQMYpJhcTDvJqysJ5NTPgAeTgHO0QgLjVSlAXJRiALokEL9pGKOkt89d1NWPDcmWXDicNAlw7Ye+qboPTohYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mov4GCPZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mov4GCPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AEB1F00A3A;
	Wed,  8 Jul 2026 05:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783487010;
	bh=bYUVqDMTWF7x6NhvYJ8jXQ7FbhBQKf3Dhd934oNBMso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mov4GCPZ+gjImU0gVJivYsPPdcrwMbnNkFPMPuhlxdXgE+eLHWpFncmExtCwi2opB
	 hZ3i7vbkKg3CP6iJaKyW92gw6IVg3GscHWVp4ez+RmFoHnN3MSvjOnPwP7baUtvptg
	 Y66Np3jHU9Mu5rPiZIg0RoVFaQ1aCtUy/rqcxhJQ=
Date: Wed, 8 Jul 2026 07:03:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Andr=E9?= Moreira <andrem.33333@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] staging: sm750fb: rename variables to comply with
 kernel style
Message-ID: <2026070804-everyday-almighty-9aac@gregkh>
References: <2026070710-exact-unveiling-e321@gregkh>
 <20260707201541.12459-1-andrem.33333@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707201541.12459-1-andrem.33333@gmail.com>

On Tue, Jul 07, 2026 at 05:15:41PM -0300, André Moreira wrote:
> Rename 'setAllEngOff' to 'set_all_eng_off' within the 'init_status'
> struct to avoid CamelCase and comply with the Linux kernel coding style.
> Also update its usage within sm750.c to prevent compilation errors.
> 
> Signed-off-by: André Moreira <andrem.33333@gmail.com>
> ---
> v5:
>   - Fix broken diff from v4 that was accidentally recreating the entire struct.
>   - Update the variable usage inside drivers/staging/sm750fb/sm750.c to
>     prevent compilation errors.
> 
> v4:
>   - Drop register renames 'pvReg' to 'regs' as they were merged via another upstream patch.
>   - Keep only the 'init_status' CamelCase cleanup.
> 
> v3:
>   - Added changelog history to satisfy the bot.
> 
> v2:
>   - Renamed 'pv_reg' to 'regs' to completely remove Hungarian notation, based on Greg KH's feedback.
> 
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  drivers/staging/sm750fb/sm750.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 89c811e0806c4..00c293430a7d5 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -848,7 +848,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
>  	sm750_dev->init_parm.mem_clk = 0;
>  	sm750_dev->init_parm.master_clk = 0;
>  	sm750_dev->init_parm.power_mode = 0;
> -	sm750_dev->init_parm.setAllEngOff = 0;
> +	sm750_dev->init_parm.set_all_eng_off = 0;
>  	sm750_dev->init_parm.reset_memory = 1;
>  
>  	/* defaultly turn g_hwcursor on for both view */
> diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
> index d2c522e67f26a..589ae51444f81 100644
> --- a/drivers/staging/sm750fb/sm750.h
> +++ b/drivers/staging/sm750fb/sm750.h
> @@ -44,7 +44,7 @@ struct init_status {
>  	ushort chip_clk;
>  	ushort mem_clk;
>  	ushort master_clk;
> -	ushort setAllEngOff;
> +	ushort set_all_eng_off;
>  	ushort reset_memory;
>  };
>  

If this variable is only set, and never read, why is it here at all?
Why not just remove it entirely?

thanks,

greg k-h
