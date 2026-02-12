Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848242E7BD3
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Feb 2026 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770891229; cv=none; b=pPibIoyhYEUIUereF+AjrOponjHL8WeZWID9TzEXv7yNSXy8OlIVbbCFJblQLEEdMwHk9R6pHA0PT7pbFUK2sJQTPx6LLW3DfKXKbUKf2Pp2abYmGIDk/df8dwO8AO07E9Wki2B/Bv9WpTqD53m4hZfJPcZ4DjuD989rXMAilxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770891229; c=relaxed/simple;
	bh=3MSidW44q464Z8alG+qVBm1Ulap/yrSMRoMM5gJaXNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2P92EN+NbtM9QOaqoJH+caT9aDdKlypv5GSo/FafiVcvA0M28KhNSuJq/886F6Y/yaztfbyfr1TjWisuH6WbHgPlhQzc3C/WP7otoHR5uPhXJAC+AsMcM6pWukkW+SXE0M9NP0XjJjp9kxB5JnY2FZC/1jvH3NjsMqBnmZ22Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=biaQC1gL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="biaQC1gL"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-480142406b3so61652955e9.1
        for <linux-fbdev@vger.kernel.org>; Thu, 12 Feb 2026 02:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770891227; x=1771496027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yYNO6gMuouM67BRrJSaKOZMx38WmQmF67AYgzDtgK0I=;
        b=biaQC1gL2sfR5Iph8FzOar64G5DiOufxH+FOprqpKHPhaXLuls4Xzl6i+E2MzDdtHl
         /bPfYqq5QxnDsJRThXK0ceZ1O+1ygWgm7W+eTU4ojWCSaSrUakJIQMo05UR3lVIP/5wp
         nHuWM9BcLGPWc0lUxKZxc96Ub7UuQ9qs2UDQY4YLkGflQr8aOj4An/G1+oDBgdlx4BXY
         QRfMUKY+ecVuRJN3uAW5Udl3ZVcRMkIalLYI3s2tro5wPGr+u9kwmAF8qrAz4Chf/1N5
         cT4i8Rl4qUoB61qTWM9MDY3UtFXdCbchatUIGyLMH2T+gKnvnK11fdhBg32f7zFGQbIZ
         oAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770891227; x=1771496027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYNO6gMuouM67BRrJSaKOZMx38WmQmF67AYgzDtgK0I=;
        b=PJv8sws8Tl2F4kxCqkg4DKEon86t0cSmfFR7vA3C+X2+e5BS5osb0JD6rr0MlraLOF
         IN13PGQ2cr9eAhP+KmlUD1YGTF8gqu/6cf9TReWW6E+pCMc6GQXB1FlGcTCxuYl4IbYq
         MTyrBu0I/UDJqnenzEmgsNVuNrpj5NDsh3YtiI3qBAXaZAoAc//gtC1RqeN8Y87W7tNt
         HXmrf0iD9Wrnayafo/9QcmtB1PHCq87E/cvHsip+JijxEYOyNCDdiQKXR3quLROuED8R
         nNaSp/VvBaLlgGn39XK3/yCdl+7lj7MrvxOlpkrtILN1aVHcNz7w+k2Rg0Y2m7V4bsXi
         SSQw==
X-Forwarded-Encrypted: i=1; AJvYcCUJvQAiWBh4JuS2RE+UTSq0EbJ4pmRAyV73O/0uRv5vAa+2+zZkrNjsiKgiryuwg5XPg5lDeWxebwGk5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVoWwLb3y0ygrRXg6dEVtfTnBxUNLnflTU1E605FaJu/vc74aW
	rbMha2qlfH1sBixr+GptFcAKbDShIn5pAYxQOIhWfjCtYGjw9UP+IQ1XMG4MRv4a4vE=
X-Gm-Gg: AZuq6aJDmQJN5B8ui7mVG1hWG1a2NrbBXyIto9KP02tN7qVYcRDCdN4RzybDxIqXEiZ
	MpOiONIUXnnlEa9KzJJaRvHe6WwXkLYa68WbjtXGKbprrgbvgvkJeVDIu/D88v8L4ZDXdYC6kwl
	8pkBlqAXjE92ctE/uInrGVhWULJEOa0pvFLstt78NgOIOzgwx+sOthuDLiBKZf0cljhFTqxoUiW
	fDFiIG24m6Z6qKmTMw747ik/SNvXMwEXfLnmrmpjN3vqfwyHWFwOyAZWqNmTfb5Bo44vYS22+iC
	42YsoBl+ipe+JNN7bfUQWH0rLtwQjEWGVAoBAC1iG7zk966YwP+NQqOMbxF7J8zXvSxJe60D+J5
	fbmKywXJZqHofpIEAWgT4RwWE5UopoAJTjQJIOQ8RCNbMZWoaaj62uJOCll9knkL8bgQF8akcaV
	eIsi4aaPe3tkeW7/ZXR0lsgNzZxJRc
X-Received: by 2002:a05:600c:c494:b0:480:25ae:9993 with SMTP id 5b1f17b1804b1-4836570df9bmr24783715e9.20.1770891226720;
        Thu, 12 Feb 2026 02:13:46 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d46f9csm10677577f8f.10.2026.02.12.02.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 02:13:46 -0800 (PST)
Date: Thu, 12 Feb 2026 13:13:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: RachelOvrani <rachel.ovrani@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: Rename nDirection to new_direction
Message-ID: <aY2n12yxgH_wnMFM@stanley.mountain>
References: <20260212095715.2844-1-rachel.ovrani@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212095715.2844-1-rachel.ovrani@gmail.com>

On Thu, Feb 12, 2026 at 11:57:15AM +0200, RachelOvrani wrote:
> Convert the variable 'nDirection' to 'new_direction'
> in drivers/staging/sm750fb/sm750_accel.c to comply
> with Linux kernel coding style guidelines.
> 
> The variable holds a newly calculated direction value,
> so 'new_direction' makes the intent clearer than 'n_direction'.
> 
> Checked with checkpatch.pl --strict: no warnings, no errors

Don't include this sort of thing in the patch description.

> 
> Signed-off-by: RachelOvrani <rachel.ovrani@gmail.com>
> ---

This patch assumes we applied that previous patch but we won't.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter

