Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8F636BCCA;
	Thu, 15 Jan 2026 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476770; cv=none; b=B6knajhZ3KndlSLKxqpDc2DNnEeKrjTNwxp5DeOhYvQSw1M41lptDbMJZNHRSzQ4Intnx0DZSxpqZT9emdYqnjIl7fiol9paoJQ360fOUy5KuVZPkHtPft/pD4B+K9VTib8dAEECAf1+y2LmoyEhtWSbgIkmvYUaSjndwvg6kRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476770; c=relaxed/simple;
	bh=jwG8SuTF3yyDL5ZuCv2MQi+rxhqSLRuJEsIh6jEObsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DY3iuLdNWlQRN445RmBOnSpCp0VwggPK6pPvLxmhprOHiZd7MPgqvW7fk4rJb3y1bnHYO0nb/bHCVTDwGEzMkZkfgAyjtrbJSgF1FJ59FhbJ0zmdpT2c6RbnIgj0mjsSZ7ipuPD2kuq7ocURPvk0pmEDq6ZQzeaNjpuxJ0pMLwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jzYp+h/l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jzYp+h/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C98C116D0;
	Thu, 15 Jan 2026 11:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768476770;
	bh=jwG8SuTF3yyDL5ZuCv2MQi+rxhqSLRuJEsIh6jEObsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzYp+h/lKOyqeg4GtSAub0LqVHHmLF4iHX98oCL1R2oF26c7PoNV3toEP02iMgL2f
	 dsts2S9glbqs+rb+JqsZJJkKX6hxezwFR9mTxh9uV4AdrQNy+ZQZcvPc6fdq7JuBKr
	 otFJvZcuaRXoGJe/qz2/Y3y+7nD8Q5mjz0eU25p4=
Date: Thu, 15 Jan 2026 12:32:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Karthikey Kadati <karthikey3608@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: sm750fb: Convert sw_i2c_read_sda to return
 bool
Message-ID: <2026011521-regally-lunchroom-5602@gregkh>
References: <20260114171748.34767-1-karthikey3608@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114171748.34767-1-karthikey3608@gmail.com>

On Wed, Jan 14, 2026 at 10:47:48PM +0530, Karthikey Kadati wrote:
> The sw_i2c_read_sda() function currently returns unsigned char (1 or 0).
> Standardize it to return bool (true or false) to match kernel standards.
> 
> Signed-off-by: Karthikey Kadati <karthikey3608@gmail.com>
> ---
> v3:
>   - Add version history (Reported by kernel test robot).
> v2:
>   - Fix invalid "Unix Antigravity" Signed-off-by.
>   - Submit as standalone patch (detached from unrelated series).
> 
>  drivers/staging/sm750fb/ddk750_swi2c.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
> index 0ef8d4ff2..9d48673d3 100644
> --- a/drivers/staging/sm750fb/ddk750_swi2c.c
> +++ b/drivers/staging/sm750fb/ddk750_swi2c.c
> @@ -180,7 +180,7 @@ static void sw_i2c_sda(unsigned char value)
>   *  Return Value:
>   *      The SDA data bit sent by the Slave
>   */
> -static unsigned char sw_i2c_read_sda(void)
> +static bool sw_i2c_read_sda(void)

So how does this call:
	data |= (sw_i2c_read_sda() << i);
work with a boolean?

confused,

greg k-h
