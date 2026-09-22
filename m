Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4867247CA78
	for <linux-fbdev@vger.kernel.org>; Tue, 22 Sep 2026 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061777; cv=none; b=TNx8tEyQC/k3KBG/kqRgYYRv3cHFjJOLZR3tpbxbJfCWWdGkEs8/SdAiHYe3QX2QXvZs1S+IODEAZWwndf12N/rOj48UqawNcmSGiW1p8Yq/7glfcXRDy0XIv3NEh+fkUF+SWPLT+sjG9JeBD73VB1pysnggB37pEVcYoml+bl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061777; c=relaxed/simple;
	bh=g2Xy9jDjDZ3K6DmNsnmaoN1dj1u+mGq37X7BB/6Az8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXAH5RTIt0PcEdvgrjMHOjsS0idDZB2O8l7m+xqGPOHbysO4cf2E7liEMmRaqAsVj93EuVo3vxpstPBtZmfei8GLeOHquiH/dpCK68kwDBCUVbli0NoEwCuZA+7cM6NF5QVZbazLJKsXrhjrL5Lc9UWI9Bg9HLTx63+UViOAgDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJQ8jYIp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJQ8jYIp"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4843e397f74so386521f8f.1
        for <linux-fbdev@vger.kernel.org>; Tue, 22 Sep 2026 00:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790061773; x=1790666573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zOpUj0Pnwod3tVYOQ3yCnTP6vZoRZm1tHkQP7O06AhU=;
        b=DJQ8jYIpkqCnzQzOVX8ElvdpMq4WB9zTxZW+N7+moxSrZW0gLFoG6CJLMljnRO4OEL
         eAdNQb4WyHZvTWaAdkEZhutbCMwg7y3MqYKtrxg8TazD1+QsibKE9YIk99JqUh4aHTn3
         haCoXSuZ7+KogBQeEj+pbpKEMhMWpPmqqhvu2kvt6ISF48yVUwyg2SaFjZnlAZ3akfne
         pgwSvrHdmvzT+0yr5D1uvdh6QE/9NDgV59lm39Bwjdkg4Xq37p4grHI+9r3pMe01C24c
         lJ2DkXx3Dc60SHVeX0AbiUrWxT79ZmbeUjft03/Vi3C9gu6OLTqz3iam7dMjhy1C51IA
         UYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790061773; x=1790666573;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zOpUj0Pnwod3tVYOQ3yCnTP6vZoRZm1tHkQP7O06AhU=;
        b=YvyQFwWJiYsWD+V+Rskv1w0MvFiGMkcQNUJ6OByOS36rSyBnLrr9Go5kmKSKI9gTh3
         8TACZTPfSlfk1BRLBPeF+wyky8EAntnrV3nU+7S5v1ckbfzklbP53nGLDoy1SvvUIykO
         3LqnMgiwD9fMhe3cC/4RoE5952Js6O9PhqgKld0ri1j+zu8P3kyGd47zXe/74NQCHdd1
         vp8lGptbpZL/s75k2vNPGUFYOcepWUKwmshsMoK0FZlax3/DcuUwQt7vgtzifr/rhwe/
         NaxvLAPh/SjeBVTm+tXz0swiokE5THxMFip+5z9F8KtW1V93uRNQnLvdBw0oQ5kBvhw3
         wPuQ==
X-Forwarded-Encrypted: i=1; AKwUvBzeA//ML312wmGxCaYslDqhRLpxjCtl711VC5Y5uLC/VWOGTdTWzDf2zzdVVvuu59GUT16cDU6GgbT8CQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m9d2631nKLTVTb0FWUpNDWTJvWJSsSFIL/JkPnyXr+j7SpmUbt
	sSjT82YVEf8PxiqMVek2do9hQL+bv/Lzgle+Temj/FTgz/CGw6Fo+8EI
X-Gm-Gg: AYBFou30lImUTPMT7rYfgagcBCzBQXODgj1R59zG984X93mpZ5KDXF+0/SCIdYmJRcp
	CVRe3fBnooBpwtjfzIECdz4wfb7E6rFGrBAhSXz1R9nSJzLUKP5Xeozk+rjTDWpl03VfzwaeMu/
	6UHs1otAjXL4mQFWFMYk6+kOLNZPRYSIuM3enKFbeJGkXUMqxDS7aPeEiye7X39aHG+Aj6jWszq
	aBmZxZkFHbqA2f+fqKuqZQkt/fzSvb0An2dj/ULxwaML5T1LXcYCgWXoSvK7/CDlheRwDmuZp+i
	NJOWFm2ZY6kCOIs0hnf2NGsv+zOtHX06WdgY8IjQEIc8EQsdCmycrWPkpa1MGV4tndBW1dNvew4
	uP5ganYU0wMVcyFKL/fv2Yvba1CRr4UZFcZ95sxe9QzeiN+62ZXfaJxK7twNf3Okv86q3SmI5ma
	dHGzZxiq92eqg4bkWv96PVAoBPvm9QwBvBtN9c60GKr5Nbyy5nngfINR3u1jkshzByk9rL1d3lM
	rgKJQ==
X-Received: by 2002:a05:6000:41f8:b0:485:8226:c69e with SMTP id ffacd0b85a97d-48861021808mr2450244f8f.29.1790061773363;
        Tue, 22 Sep 2026 00:22:53 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862793792sm3387192f8f.31.2026.09.22.00.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:22:52 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:22:48 +0300
From: Dan Carpenter <error27@gmail.com>
To: Lucas Costa <2000.costalucas@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: free cmap on framebuffer release
Message-ID: <arIsyPJno_UGVvSK@stanley.mountain>
References: <20260922035302.167378-1-2000.costalucas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922035302.167378-1-2000.costalucas@gmail.com>

On Tue, Sep 22, 2026 at 12:53:02AM -0300, Lucas Costa wrote:
> The driver never calls fb_dealloc_cmap() after it has been allocated,
> so when the buffer is torn down we leak.
> 
> This happens on every unbind, and when an error is detected in
> sm750fb_framebuffer_alloc().
> 
> fb_dealloc_cmap() gets called before framebuffer_release() in both places.
> 
> Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
> 
> Signed-off-by: Lucas Costa <2000.costalucas@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 8b93bfeb217b..92412534239c 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -910,6 +910,7 @@ static void sm750fb_framebuffer_release(struct sm750_dev *sm750_dev)
>  	while (sm750_dev->fb_count) {
>  		fb_info = sm750_dev->fbinfo[sm750_dev->fb_count - 1];
>  		unregister_framebuffer(fb_info);
> +		fb_dealloc_cmap(&fb_info->cmap);
>  		framebuffer_release(fb_info);
>  		sm750_dev->fb_count--;
>  	}
> @@ -943,6 +944,7 @@ static int sm750fb_framebuffer_alloc(struct sm750_dev *sm750_dev, int fbidx)
>  	return 0;
>  
>  release_fb:
> +	fb_dealloc_cmap(&fb_info->cmap);
>  	framebuffer_release(fb_info);
>  	return err;

This works, but I don't love One Err label style cleanup.  The label
name is no longer accurate.

The cmap is allocated by:

	err = lynxfb_set_fbinfo(fb_info, fbidx);

So ideally there would be a cleanup function which is called something
like:

	lynxfb_unset_fbinfo(fb_info);

Then we would only call it if lynxfb_set_fbinfo() succeeds instead of
if it succeeds or fails.

unset_fb:
	lynxfb_unset_fbinfo(fb_info);
release_fb:
	framebuffer_release(fb_info);

	return err;

See my blog for more details.
staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/

regards,
dan carpenter

