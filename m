Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AF63F4824;
	Tue,  7 Jul 2026 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433855; cv=none; b=nuH0qabSszVHVkpnjT2m54ZM9TWTdpr03C9tAxLLrNpkrbBJWppzFvSeBP6YnKIU+u4OMJrGxFHRk9VXCVZjhnYLWBuk3iJuCMIJrMkY8Fs3DEJCimEz4VOC5yyyhDrRQ5BXTsEiMP/ywh+JN8hRIN9cvHLCpKEXuNprKbxY5WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433855; c=relaxed/simple;
	bh=eajTuACd/4IgS5su39Ql1WyiKQbMRkIT0R0MD1NPBh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApQSBS94IP21KSv+9Jlsega4rXMF00GvQ577QpnuSJSlnXnBXHTCeSz8iMBE8UloLOSulzncEanqhvQqNUlRxyOqYc+1mZq2E+Pv6d/tXl6Zj0c3LZt6ie/bFNtii1gaTG7gVIYNu3IVsPLOmwyHhJJPi4pKKDZbsfLzVkvaTH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MHjbv5Ph; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MHjbv5Ph"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E5D1F00A3D;
	Tue,  7 Jul 2026 14:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783433843;
	bh=Jm32KnLzXJKqXIkeeFi/CJ1wSCoIc/iBf+3ICTnzYYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MHjbv5PhULcWiA3+yqNuQL3c3LwEzOakR8EgQAj5JTpAj1nGA219NfhM5vcgr9k4Q
	 KG2vzT7K0DqifDRcgXn83s9GsNpLGiVVjnQT2XV7ZOWcfMOsc3mLQfwvH9jySdBtMK
	 z5ejGeI9PV3/nrhXmmFjjwZt7+nsqgm/0ugxvR2I=
Date: Tue, 7 Jul 2026 16:17:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Andr=E9?= Moreira <andrem.33333@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: sm750fb: rename variables to comply with
 kernel style
Message-ID: <2026070751-user-kitten-e1a6@gregkh>
References: <2026070710-exact-unveiling-e321@gregkh>
 <20260707131529.38340-1-andrem.33333@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707131529.38340-1-andrem.33333@gmail.com>

On Tue, Jul 07, 2026 at 10:15:28AM -0300, André Moreira wrote:
> Rename 'setAllEngOff' to 'set_all_eng_off' within the 'init_status'
> struct to avoid CamelCase and comply with the Linux kernel coding style.
> 
> Signed-off-by: André Moreira <andrem.33333@gmail.com>
> ---
> v4:
>   - Drop register renames 'pvReg' to 'regs' as they were merged via another upstream patch.
>   - Keep only the 'init_status' CamelCase cleanup.
> 
> drivers/staging/sm750fb/sm750.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
> index 0324778768cbc..3a1bd38ab347a 100644
> --- a/drivers/staging/sm750fb/sm750.h
> +++ b/drivers/staging/sm750fb/sm750.h
> @@ -39,6 +39,15 @@ enum sm750_path {
>  	sm750_pnc = 3,	/* panel and crt */
>  };
>  
> +struct init_status {
> +	ushort power_mode;
> +	/* below three clocks are in unit of MHZ*/
> +	ushort chip_clk;
> +	ushort mem_clk;
> +	ushort master_clk;
> +	ushort set_all_eng_off;
> +	ushort reset_memory;
> +};
>  

The description of this patch seems to have nothing to do with the diff
itself :(

Did something go wrong?

