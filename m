Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6DB2BD5BF;
	Tue, 30 Dec 2025 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767080533; cv=none; b=f8fy5GEmWR72OneueoGsA8nBnTiJm/rkSNDKy+afL5qWYvbEgtTKZrNzsOSY4CCg8Av7O5ffui/TpjfQOGYGQTSqwk1HuXi1BcHmHuSlwiBc5eLpbzObdt+/Ur6AiTeattFyYAQmNK8vgSp1Ggyh4LREH+ewU5sz4nKDD1FWCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767080533; c=relaxed/simple;
	bh=EK7xRaZTeENFTZbLetkczIs6qxysFgja/Qink8l/jt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDXOobE1e7jeSUA2TIASpBi+5kgNF18qcLGzBK73kN/fiREySj1f70XaiU0LWgsFZMh6nPx0dw92CxWj3iI+C4OqkyiT/s5yfCe9dZG1olHPFeO0P/TpS2yIwWvDKUYS10wCQGOvhgXQCHkSdpeZvJGDIMUcl1IkeiCdKi3/tVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MhwTzcoh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MhwTzcoh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44671C4CEFB;
	Tue, 30 Dec 2025 07:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767080532;
	bh=EK7xRaZTeENFTZbLetkczIs6qxysFgja/Qink8l/jt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MhwTzcohTSocPm75jgLItw43vuH3dzgTlCHz7suPZbMBazLu1BNDEwgKyiIdbE4Sb
	 CW+nsjiTBs0srsco+0dUuImyZHhY+47oiQjeD/3qsvBVTVVC/cf/F8h+WOxQ4gCPx9
	 92DErX35cAj64jVJQIB+d1L8azFPjpz6+NA0Vglg=
Date: Tue, 30 Dec 2025 08:42:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: MottiKumar <mottikumarbabu@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix const array warning
Message-ID: <2025123055-procurer-prodigal-27b6@gregkh>
References: <20251226120417.2599020-1-mottikumarbabu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226120417.2599020-1-mottikumarbabu@gmail.com>

On Fri, Dec 26, 2025 at 05:34:17PM +0530, MottiKumar wrote:
> Add a missing const to g_fbmode to fix a checkpatch warning:
> "static const char * array should probably be static const char * const"
> 
> Signed-off-by: MottiKumar <mottikumarbabu@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index d100b9e1d3d5..7afb58561a0c 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -33,7 +33,7 @@
>  static int g_hwcursor = 1;
>  static int g_noaccel;
>  static int g_nomtrr;
> -static const char *g_fbmode[] = {NULL, NULL};
> +static const char * const g_fbmode[] = {NULL, NULL};
>  static const char *g_def_fbmode = "1024x768-32@60";
>  static char *g_settings;
>  static int g_dualview;
> -- 
> 2.43.0
> 
> 

Did you test build this change?  If not, please do so.

thanks,

greg k-h
