Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFCD325730
	for <linux-fbdev@vger.kernel.org>; Thu, 19 Feb 2026 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771484145; cv=none; b=KeoZMabziT+AxqWmCIwIGcY/4n3heFzd3T4IwTDl1osZrhtOdV9802PBy64onPY1n9zQPBhC/2/17B15kp9Yksvss3I3Qx9Rx2T5hffaaq8lcXSxSEat0cO4ZkhMCQsmjqYf6FmD266DUTs/yBSsQXVGM120y//dYD5Wiv5Hceo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771484145; c=relaxed/simple;
	bh=h6C6Rl/C14U6XEKXE7Zacworo+izARx/EsAioocuE54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWxbKWxw57Gm31dxqFGEP18ueB8uw6843qrws6LHG8/+oD39LCxZDtxbV2mWtwX9+hr/UPTyCT/LNLGuZ5trvUmOX/x2MLztxKBsVpSLpmoR1GSm6Gm7BOvg8K2w10tjHq2mF87+QyRBYKCt1WbLYHM2aWnt/D1XlwB80A/K6kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D8qyjeNd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D8qyjeNd"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48371119eacso5598985e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Feb 2026 22:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771484141; x=1772088941; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E/z8DUBlvRShOEs/ZLMAJkKG+Ia036OEocxXbY1rOKc=;
        b=D8qyjeNdI7cNaTyd6323OcMKMYAKtLZm0fEXfCLFgF3tUbSsGo4W+WqaL175wv1yi0
         zJsz1UsaeXL7017+cYkhusaXIpUh4wOs5AbA4AuJ9B83BhqXsm4hrq7/6oXK63h+uWjE
         OmQoWMqA2RQc2s7fg5Hoi5q5r/F5SZgtv2sgJO/TUccnURK/3T0r1/yIWUHlrUNXBzIq
         IBAKZFT3JyDC5IxZSNZEMDoKHSK9QzbP2mqPNKqmyGVa9lsInt7EwRukDqpEAn5ZFq3B
         NLY67UYQsQGuJW6hlFl0dfhvAkZRMgBibVLXIe31EHIABgWs3RYap6qoA8o45qy49TqT
         8Hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771484141; x=1772088941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/z8DUBlvRShOEs/ZLMAJkKG+Ia036OEocxXbY1rOKc=;
        b=ldJ+zdvdI6lkfy8kIENT8Uwp+qS/Ey9wjkfadaTZVnKPDJ1kVdgTllDbEM8eEm5NXB
         zFym4uSGX86KRaR03/q2hmjm9XG9dHHQHgZKHJlxJteFLqyQnt6mofDxGai1XlPKsw4X
         w5Sqwql9WPWrZcCjAmIhz+34UL3rl+hzsSvzy/b7n8EsXYdSgla5W2O1EEnQKhfhVGoo
         2+JI2kqTZotCHuE9UNXmyJB8GE9do7Jp1hAdN6e4c0B+3Hdc1pNwQtdFPA9FUm8EHVxS
         XffzwpMFEkcOKqvBYyCIz2Pj5gY8LRxOwngOYaUK2HO6YzCIcXkc1IEh0JJvJs4aa3l3
         BUNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV39aQSEifVo+PoSJLytGDvdYyuPGd0rusDR8RR84IX1P+uSQ/wI2iadSuqfXf/3bn7pR3+lM8EJdww1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIdbdmyJRi4gwm/7F5tawafTES+Q3usNprLNdUjAYKPRIk7XEK
	2qJlJynZnHFuhFNOKckItSGhT9aHAzJbHWrvMRVEUray3Vwlidk8JzRzqrVuS3I8aoQ=
X-Gm-Gg: AZuq6aIZ7n8t+tHlAL6wdehQmamc/tBZd2AvHSzTonCRFTnABB5ApfwifHnpjeiAfEj
	jQOUWEXDJqu7K3/41PXY+DwmAcq2DXuC5c50DyoqWwbuCHj0byglPbpHUdNHqOQM1yavsZxPHml
	SV67giZe9jvtZPtRihIBeYXbCaaIHJsFjeRkBTRFDbdRe8huPIRIlTa6MkOmHbGwIRu1TjM7eM5
	5YOXCUtsYi2QNpVW/8m9MkHjF72NNBb+mi+4yeoSPrkvlYeGG7dPp7iBBnaBx/3VRmA993s6yDy
	zCRWd6XFNYQQb9sCoT3hfpEcGVTuWJ4j1Fm5oXm+bjDtaz1anOn5W9HfsehPco2eJZL94wq1YBd
	2fE92Qfy70wGsJ1qQtaBY5q0nLBOmanYxluHIYEfVWTMDdX+/tDYAdU6agF1zC+Lq6yyicASJ5f
	271wwGVbdoQqZzqHO66kNaPYTnhwg4
X-Received: by 2002:a05:600c:474c:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-48398b78ea8mr60187755e9.30.1771484141289;
        Wed, 18 Feb 2026 22:55:41 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836ff00332sm408299005e9.2.2026.02.18.22.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 22:55:40 -0800 (PST)
Date: Thu, 19 Feb 2026 09:55:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?utf-8?Q?Ey=C3=BCp_Kerem_Ba=C5=9F?= <baseyupkerem@gmail.com>
Cc: Ethan Tidmore <ethantidmore06@gmail.com>, sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: add missing const to g_fbmode array
Message-ID: <aZaz6ZyNqyyXuy3I@stanley.mountain>
References: <20260216003939.206758-1-baseyupkerem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260216003939.206758-1-baseyupkerem@gmail.com>

On Mon, Feb 16, 2026 at 03:39:39AM +0300, Eyüp Kerem Baş wrote:
> Checkpatch reported a warning that the static const char * array should
> probably be static const char * const. This patch adds the missing const
> keyword to g_fbmode array, moving it to read-only memory.
> 
> Signed-off-by: Eyüp Kerem Baş <baseyupkerem@gmail.com>
> ---

This beaks the build.

regards,
dan carpenter

