Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D73C2C0272
	for <linux-fbdev@vger.kernel.org>; Wed, 11 Feb 2026 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770822669; cv=none; b=r/UeZS5uuWGoRCgk7KRonrpXi0ozmRTY1EwrEEk8goo7S7i1blLjFprXIcbsHB/6Vvia5LlTz/ppaK5BLJSXVnKYrQEJPXrojQH+Dg82ngNthZBAh97VxkicaJzAMxovY37KXtmOn0akny9RhyUOqO4tq6q6QKRCFgIWEbeWzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770822669; c=relaxed/simple;
	bh=qBo1NVVfmIRUMI3y7c1Qj+U2VBN49jqloyv8Gl87fUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dagjlK5Jc4pBeglvXqCeFaUsS7f5GtkcaNlsk1LUBDKLq5MdJEKZ+ve/fgPKgY3wkKJrl31kbahUCPVaN6d5tDe8Sq/Hn6bw8glFwE0I3CfyTJ9K0Tq66+DkjsCO10vwzsqyZTaS4zIzyTEbbuOnUawfNwGHFlU03NYjnDWIybQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B0oq7i3S; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0oq7i3S"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-481188b7760so49707865e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Feb 2026 07:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770822667; x=1771427467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1ze43IOX5RFLoNmSfwTTp0YNMSx9Sbi2Os44rYWPTc=;
        b=B0oq7i3SPzElzFW/Lx4mtGG95ECBw/jw+ha12IDDlMHEUa4zcK4SQ3aN/bxBjSsNMa
         pAJPxJKOFTxfhgIhrzLmr+m1fb4225UM8KfQ01RbgcNRSXDklVGBPjQBspIiVgPPcENC
         QSrLo4ZVZ9Jilw/HwDpIj2mvgFy0kXWW8n9cHjAVdGeqBlp2B8ISyiCogUh2q+Wlf71y
         kQQU0RxJGpXCilMKtfI3K2wx6tE1YcOa8FwNxbYxX05c9c6G+6cezlGTFRgd+IXWsgxS
         72pRlB6knnkL0CYIGHPyjSYI/xuNGlJntGpk2gk+jynnRTmdnhTbV78xmIffAEr3E/9d
         VV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770822667; x=1771427467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1ze43IOX5RFLoNmSfwTTp0YNMSx9Sbi2Os44rYWPTc=;
        b=CGOmDyCG/Mlkjh5os97U4Pghr26+h6Hez8ZkKdOdoDCMe9pgoBEKOxF5ZdO+IHbabI
         a7K9AXaPgFsbVZsDUPXORFrj2NKwzw4OzjMa8DnJTIgdxPlsyWR2lY3Q3kg0efTqPzYF
         Z9ZwZhTeXA9BB3nwKCSK37/2/z9AEXsBhQXN9FeQgxkhVNb6SpwFbMKE5y0u6xf4Mrl9
         R0VYfWYB/9iVWPxJ80WaaPfa39qVxpR7/YpNv+NbtQjvgNDRajR7lwjkmMmFTl7D8nUx
         tvCRyln/IupaNiJ8FjZeNat0KDcOzOreGDwZQszPxkTSL5c6yJxL56gNGc2ydbz5Cqiw
         o0tg==
X-Forwarded-Encrypted: i=1; AJvYcCWBge0jpi//g2c3Mdrsnmf44InNMjeUZiMztpqlvrhL/9+k6P9oCceQx0bJq5k7e1gd/O+Y34ojiiQ8lQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxA36EK3iqQeEHl05WGkNuWilk2Q8/LMhqasgEQbFuC4+nng+K
	yKB8NpleSmtauxlwGVt1rkGLelXr9B1QZ/sG+xxRK3HDJEQJEKbPZuW8ZQorG/YNkKY=
X-Gm-Gg: AZuq6aJWF8ppx8D14uIFDlOwEXhDvzuvOYO/W9OGrmyiymvGflfa8/x/VLkC67U/TNA
	XUn5KYeMsPrBqSAld1h9a6iZHAjLLl2CilHrsf9xYg+LNXhC0kdbap32kmYTbh+aoy7/+mPvvGE
	OR0u5dci92J1FYoz+IdGoCi+zaXQo36nkJs9ETJsk7sZ8kC9V5BFtGc3Tim/TKdvPss9A7mP+tx
	hNBTwTOYzvOIkE4/b2Zsa+ItW74W7qAa33vAJZQ59gKHOR5RfQPL4IHfKgQXOFyFH7xSBN+TKIO
	LY3wixFNi+rIuDmwQ/USoNt4fQ7kpy5irteBEenDt75MNEuKiNDPthSwrsARgb3cX0V5GpCLJgj
	TXUG1/hEL9fDvihN01vhbAy1dZFbJBpfa+/wrMDvdQHlGRo7tMICdH6EtXdY74J+BZtpiADIPF3
	VC1odf25+oSTHX7rAp5uVrjhTQcyHw
X-Received: by 2002:a05:600c:37c3:b0:480:4ae2:def1 with SMTP id 5b1f17b1804b1-4835d4dda7bmr41751545e9.13.1770822666573;
        Wed, 11 Feb 2026 07:11:06 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835b958b6csm59016425e9.1.2026.02.11.07.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 07:11:06 -0800 (PST)
Date: Wed, 11 Feb 2026 18:11:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: RachelOvrani <rachel.ovrani@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: convert nDirection to snake_case
Message-ID: <aYycB-fAZn-uTO6r@stanley.mountain>
References: <20260211142423.4922-1-rachel.ovrani@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211142423.4922-1-rachel.ovrani@gmail.com>

On Wed, Feb 11, 2026 at 04:24:22PM +0200, RachelOvrani wrote:
> Convert the variable 'nDirection' to 'n_direction'
> in drivers/staging/sm750fb/sm750_accel.c to comply
> with Linux kernel coding style guidelines.
> 
> Checked with checkpatch.pl --strict: no warnings, no errors
> 
> Signed-off-by: RachelOvrani <rachel.ovrani@gmail.com>
> ---

What does the n_ stand for?  You can probably remove it?

regards,
dan carpenter

