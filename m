Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03CD314B77
	for <linux-fbdev@vger.kernel.org>; Sat, 14 Feb 2026 22:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771107953; cv=none; b=eCzvjziuG7JgCX2lv9tIptEQ5qj9D1xFc2g7mDl1t861LHwpPsFoUPPbRuTn9rKPY1rG3MpyL1PIteXKbxHyGdResi5xVRWKPipkWoYQ6Naia71QCvGeClRpt5Bp9VOL6Ud8b/xiOUY3WakxKfHsR1aD2mHXZRkQtBl2jurbezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771107953; c=relaxed/simple;
	bh=gPB8/WX4QlbC0B2UxTWMVblFHmuSf4ny8gF3oefmnWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=c1vJdDXANDemHoIpOBDCO1+G1tductJpiMLUlxZossnNRnledsOuWNmsfLXe0wCbFdxdIHLT4PF8ZjCEoCe3sL0G+I7HEhxmgFBnctZvWhxQD5J3V6tvsOuBJYRgmlIErnXrjUZrPkox9tA241rSsrV24k6be1Tt2BGW6u2HbVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=fail (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OMj4Dl5F reason="signature verification failed"; arc=none smtp.client-ip=10.30.226.201; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OMj4Dl5F"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48371119eacso18904425e9.2
        for <linux-fbdev@vger.kernel.org>; Sat, 14 Feb 2026 14:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771107950; x=1771712750;
        h=content-transfer-encoding:content-disposition:mime-version
         :list-unsubscribe:list-subscribe:list-id:precedence:dkim-signature
         :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwU1h6E+8PFMX0KJbuF6T0udAVN+SodXJVv8cPdeK5Y=;
        b=Ex8YT9XI0un2ZceBUiytFL/fwtivn3Z91+tFVjBM3KSjXtwSnrngB8rM37PlFImF73
         TemF4Hp7f9bMAZjgm4zMNaDvnZmVp7naMPPLFNZzBp8rtsTBCL7szJdKR0s1FJKBtLh9
         3ukqpAKXnq6Mp9eIy/VLAyv3oOEHJ2mGO6bRK/zmG6KIpFimPCh2AdtCODfPMRNUfLEX
         hjGIBSvYeDLgZPrYURrPBMyODOr0bqvdqY7nMYS4TJYdNE17BDXKpgAYzi4hdz+RqHdb
         xBArvi5ZkELysEBLlNqrk97TcXGZJPNWXrf9yFpQHEL3cL80c2fej0dcIPZpLYbYNCPm
         CVig==
X-Forwarded-Encrypted: i=1; AJvYcCU1t79PyrtWV26reOIV6tZT7T3n+WFzZsToJ8XjKWR1wzfU6U/U7VtZmqmE9y8p6R/SSq2RokIPgfO6xA==@vger.kernel.org
X-Gm-Message-State: AOJu0YztsvhsGvqN8TTTbD8kz0N50D340/f3Hdw3AJ60YPTkVNcLfxW/
	v6DhHTq4PyfEWF6dPqMizfh+b/NprAiS02qQ5zVHbm4QGq7xLyUHfrt+
X-Gm-Gg: AZuq6aK5BeJUKXhnDz/Nbe3OdunFSv5v/OMGNn5tiJEtsOVinuJ6YTJa8iAWYHPmMZG
	SbJ8zljsMsH97+xGY4ncI9NA+/jK77SNiMwQTr13GthToCCupj6p7NCsSNE8SkEJDY8UOreNK1b
	OtK3s/D/t23ZICF+K2Xn0u4K71rl1g9y+LQouktkKM8a/xx9rLt7CjZle2qPvOpkwfb7u2HwIPb
	fjnUAD/ZWX2nyvkn78PGSQkhz6Rfzov6QV3SonZ1HXoSN5YwBDJzxVptrcePSW9Gp8UibB/m9G5
	sUfiUyoLJLYisfH0K99btNsNu6pE2/MHlmig5OD/5Equ53bmQjVKFkP/UGs32pwyjN7wpW64jl4
	Tn5N8pzMP206TU80ZMNsHRhZJOSijaTDzYVn1Z9BD+VVkds5qt0laI64WXjUelbReO3gg9gtIQb
	Dh+CKOUgwyZtuXpyeF7EGlUn9T/n8=
X-Received: by 2002:a05:600c:5246:b0:483:71f7:2782 with SMTP id 5b1f17b1804b1-48373a14406mr108884505e9.12.1771107950050;
        Sat, 14 Feb 2026 14:25:50 -0800 (PST)
Received: from Ubuntu.. ([213.137.70.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8d46sm17135301f8f.32.2026.02.14.14.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 14:25:49 -0800 (PST)
From: Sarah Schwartz <sarah.schwartz025@gmail.com>
To: a0583214067@gmail.com,
	Sarah Schwartz <sarah.schwartz025@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix CamelCase warning for dBase
Date: Sat, 14 Feb 2026 22:25:39 +0000
Message-ID: <2026020450-shindig-starry-32fc@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204153856.23277-1-sarah.schwartz025@gmail.com>
References: <20260204153856.23277-1-sarah.schwartz025@gmail.com>
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201]) (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D94421A16; Wed,  4 Feb 2026 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371C8C19423; Wed,  4 Feb 2026 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org; s=korg; t=1770220460; bh=RSORJ03ne4P+AXQgsb8E2FO6orKfDo+ustVJgXpZ7+I=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From; b=OMj4Dl5FLduGGkbiXRA0GeeiD5moSjai0zPSDfAcAyMaTXsmx5vaPBi11IBLr+HX6 TmTIvOT+QsmKqRekKAaCDdNmsKNw7QDD4J6guvsgHlFKAizmt3NtMLTjmydziubYrQ 7kyuHEKwUUZ8B16HFP9LSfolLsHM9AT0I8XcqaK8=
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Message-ID: <20260214222539.5faayXRlmLXepHBqztNQJucf_WV55Z6iUTN76fuVa_k@z>

From: Greg KH <gregkh@linuxfoundation.org>

On Wed, Feb 04, 2026 at 03:38:56PM +0000, Sarah Schwartz wrote:
> Rename variable dBase to d_base to fix a CamelCase warning reported by checkpath.pl
> This aligns the code with the Linux kernel coding style.
> 
> Signed-off-by: Sarah Schwartz <sarah.schwartz025@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750_accel.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index 046b9282b..c77b0fe3b 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -136,7 +136,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
>   * @sPitch: Pitch value of source surface in BYTE
>   * @sx: Starting x coordinate of source surface
>   * @sy: Starting y coordinate of source surface
> - * @dBase: Address of destination: offset in frame buffer
> + * @d_base: Address of destination: offset in frame buffer

what does the "d_" stand for here?

Should that be dest_base instead?

>   * @dPitch: Pitch value of destination surface in BYTE

Why ignore all of these other variables as well?

thanks,

greg k-h

