Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6BB247291
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634339; cv=none; b=KwDCfT7OCNpzKK94CULpS1wUW9t6aDSwn9LJh+CvYg7du8luHGXFpxCJktGHLg8xfOIPrlf+WByLiptt1oQ0wnAZ/FI6zkcoiOwabY1lFiSdOuMoUV6V/KJJMxeh7u+VP3tf39tWpFY8NanK6ta+4lVQFkuMeuyKYdw0zsK94RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634339; c=relaxed/simple;
	bh=6V2qYjxCYdKujrfKdfTH9jaCaXDQM6SLHUezFjdUNIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0PfvK7xtNiOoiA4dI4LrwVGCDNMXiqyXDsXJ9NSBkkhSNAaVdDwgoPXMDLq9qaqDubezr5GE5e3k1cf+P9EVHHmH589zIiojYjbhl9r39G8kQjU7Gy4LuwyteggJTAcmsEoQcLNvOaxyJIJW4qzuGslVo6BDWG+gFQ8KCMjRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PHUQ9t6o; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PHUQ9t6o"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48370174e18so40465055e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 06:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772634336; x=1773239136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6V2qYjxCYdKujrfKdfTH9jaCaXDQM6SLHUezFjdUNIE=;
        b=PHUQ9t6o5+WK4xOyyJOtrtYuUeAIu1VGS2chGoAVUAKQdStExr7OcD8+m2lmcKITF2
         NA75ffWwQjbI7aABP6oAiDdM3GghiA3OXX0d8T8XXl57FSlwckZqnzfBbMjIDloQxggL
         4cu4aIZeIT3QOLFPjHwIz5OXftV2uKA9Qp9F1zrzOnIdu2V1PBe2LHOpsKp70EvHSjke
         +FlceUS5N9fRKGWekO7Ahm42DnUrAPKyD+qIdp7CL+IS9UYTwZ9YZU/6W0tQN6Qjm8RB
         AKcAgz9kSnT43hmRs3N+SzHGQJnYaqjtoSKn3r9z79jjvlCiHHABAzfvIl0NPlob5ndc
         DBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772634336; x=1773239136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6V2qYjxCYdKujrfKdfTH9jaCaXDQM6SLHUezFjdUNIE=;
        b=QOyxRxAJbGGvLfAtxAqWjPSCE5+Vb7AwWXgZGCkaRXCCLiLPuAcPqh6MCs67PvEFtS
         1jjj+TWwt5vBjq/KWSqToN1AdMh5e+pD2jmU+XjWZ3YVLN7ttVvYIF2zYaol7EOGzorg
         Jxxz0LUC6aH0Oo1bqwpEHW5nzNHY6b1H383LbFYaLm01XJ3GutBlNXAsLSEz186Vy+pn
         epcK9aHCqLQ+VR/qgkxBylJFNTsK38IrvbNrlj/x7VFblyDmYw8IHyoN6MQ8G5+yI8dg
         JfX2Ww63xoQqCu2RbK06yTKs4lWLoPr28ixaplD+i2yRJ99t27tLKp9fYd2OSYA2Ions
         9SCg==
X-Forwarded-Encrypted: i=1; AJvYcCVfvrVAK2wb0qpVMLxxMHHMMj5zQvSsWHCQTEuABi3274Lkuwmc5dvKQG3NKLy+KhhTym+Rt4iT3+37bA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLgwOvce83uM8B8tBE/PPkQJGA8XjMXoxGJDr0LNGVlcY99/nh
	t+sXnF2PMH5JmQs1Wv7vMEt+L0jqv88z0ZmkHkpUu/usJJw1wuLfisPfJR+dkTK2zNc=
X-Gm-Gg: ATEYQzwCA2Nz+2aS+ML7943U6UA8LcWbt8iI1qu0U4JfKoBfhZ87of7GbovEByAdfpP
	vPuoqNh0Z4XO6pjcPE7dY5u08dIqTX5pNypBdmnPR7zmzWk2z/yCbyy9T8nZzKn4I6LYgDuMgnB
	femX2Mo4E/xRSci0Y0GxV42Lhvb82al7v5R72xJ2L1TFwyKMqovmU4hglx6Gz1nDlu3IFKB5uQP
	o2g0gNFcZ3OptO89qqD7qtFh7CkwJJOUmvfaby2gyv7rc6G/3UqasDty59NTXgUi142w8qMdExs
	iS+obP1nG8GYYYtr9bEekfZIeRp4Ma9Bcf+dAMk7Dil5gYhGVLbAW0rBTbYOdC8RjgdrC128aiO
	LIodH7j8X5a9B2lcD9ngYKLCyUd0fU9/ck0MKFCvsaZwPrwREOhjmx928iu/XVG1KMEXUXbUBn1
	W2HeOP55WvsIV8wnMVLyqiQSJkYl+x
X-Received: by 2002:a05:600c:444e:b0:483:702f:4641 with SMTP id 5b1f17b1804b1-485198270efmr30791045e9.3.1772634336224;
        Wed, 04 Mar 2026 06:25:36 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851acf9cabsm10615715e9.14.2026.03.04.06.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:25:35 -0800 (PST)
Date: Wed, 4 Mar 2026 17:25:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Soham Kute <officialsohamkute@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] staging: sm750fb: sm750_hw_imageblit: propagate
 de_wait() error
Message-ID: <aahA3J_yiTNwUrth@stanley.mountain>
References: <aaVT1mSeKrSSlrha@stanley.mountain>
 <20260304084545.156170-1-officialsohamkute@gmail.com>
 <20260304084545.156170-5-officialsohamkute@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304084545.156170-5-officialsohamkute@gmail.com>

On Wed, Mar 04, 2026 at 02:15:43PM +0530, Soham Kute wrote:
> Propagate the error from accel->de_wait() instead of returning -1.
> The caller treats all non-zero return values as failure.

The caller ignores errors.

regards,
dan carpenter

