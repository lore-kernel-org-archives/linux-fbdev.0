Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4825C38382
	for <linux-fbdev@vger.kernel.org>; Sun, 29 Sep 2024 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727639196; cv=none; b=tvne5WhuiIlt0bEeaai9r8y3umnWLDIg/HGS300ItEJ9gDmRJPtXcB15vc9kkYTd49emMromW1FVKGHySgBzLEfSEIhi9d8rIlyrA6Q2rgRvGgxC7dnGb5uwG5BvXN+twWRkPnfhitQeJe7hCT63IH+x7ASMsFT7JPApQ9HWoJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727639196; c=relaxed/simple;
	bh=XMST7TPn1bZV0oTzlcZpPJqPJy6iOk6kUJkThkgulBk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/KEZkjM0QKgTy4cRyPfGgZzgzU4uY5lNXfGjLMjc1hRSaGtNRRvaXgoZJjJ6z4NJ/Y+laeJtB5jNV+nQfr7z9kk3cKODMLgWK//qPXwHak2Fo+fBYlxmrgySUmIXUoLaLgZqYrTGYWIpyA+rnHEcpAmeqhC/xYe0I0FW0m10Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 5ee75b3e-7e9b-11ef-9946-005056bd6ce9;
	Sun, 29 Sep 2024 22:45:25 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 29 Sep 2024 22:45:24 +0300
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: deller@gmx.de, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbcon: break earlier in search_fb_in_map and
 search_for_mapped_con
Message-ID: <ZvmuVPwaHb1vFCmZ@surfacebook.localdomain>
References: <20240926115911.620624-1-qianqiang.liu@163.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926115911.620624-1-qianqiang.liu@163.com>

Thu, Sep 26, 2024 at 07:59:11PM +0800, Qianqiang Liu kirjoitti:
> Break the for loop immediately upon finding the target, making the
> process more efficient.

You may make it even more effecient (in terms of code readability as I believe
compiler optimizes this anyway to the same):

>  	int i, retval = 0;
>  
>  	for (i = first_fb_vc; i <= last_fb_vc; i++) {
> -		if (con2fb_map[i] == idx)
> +		if (con2fb_map[i] == idx) {
>  			retval = 1;
> +			break;
> +		}

		return 1;

>  	}
>  	return retval;

	return 0;

>  }

...

>  	int i, retval = 0;
>  
>  	for (i = first_fb_vc; i <= last_fb_vc; i++) {
> -		if (con2fb_map[i] != -1)
> +		if (con2fb_map[i] != -1) {
>  			retval = 1;
> +			break;
> +		}
>  	}
>  	return retval;

Ditto.

...

Since it's applied, you can consider a followup.

-- 
With Best Regards,
Andy Shevchenko


