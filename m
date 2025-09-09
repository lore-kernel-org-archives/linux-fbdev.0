Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E68020D4FC
	for <linux-fbdev@vger.kernel.org>; Tue,  9 Sep 2025 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404500; cv=none; b=ZILlUfVb65nDcwHKZvAKlScp7TU3tu7m1hIR4whR+d5+ttQ1R9pfyto+fmjD9aE0zySWd/EIez2DDwgM4EQ9c4tSSPcDYVhzH4b8aYs1WLmDFc50mUjvqfayfnTLCYnVrKJRBkq2xWUR/0tsFVl13cKXmzRaJHLr1GA00Uzvx2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404500; c=relaxed/simple;
	bh=bPYYoqftfSKsz0hlk498WcRINtzXQZnNUseNh+Begto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8lVg5EZq5U5Q7WlH1jseaNZyNh4u20TezXvMOnrKjlWvqjLSL+Ma1UiWL/ytnfVs5G8qa9Pb4cxEQV2PtOCvatdf2zgUGSrc8YBfMNzzvUUb4VNldpbTB/gEMzNLKfwJ7Qe236KM/u0GrFXAIwXcO7jD0PJ2CEEETCjqKGjsWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vqLahdfO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vqLahdfO"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e2fdddd01dso873705f8f.2
        for <linux-fbdev@vger.kernel.org>; Tue, 09 Sep 2025 00:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757404497; x=1758009297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t5sZUHke1cOrNWY6qZMJoyROLt4T1nD+uxD+OwzRsAo=;
        b=vqLahdfOvDoy3e8ZlV9Fw79WizA6wTAmyOsJarmprpE3i7Ue3xfaKUt9+ed67Y5qRU
         K2zJLRygdjzAxwcYXNciBakdt8Z+XH2JJ+ahny2CJCIV0uRhrJrCd4QvI4AA5LEdEdPG
         cww+VJuZdTNPN0R2hRtzhKKljhBjLdY3lgFA0a001/1RK+P+/Q5eBaZvB/73h3cPWFVG
         U0RJcuBKcuQqI7HKPOlO6VPBDLOIF/Kgjnz0Ad1syHArO1aDxWE9elmgJUdmk8mvP0Cb
         qVHBK+u9mMtU3lU5jAu0zHHEDhvFhOVCx6r1pOycHA7fWpucNeOdQ/ZvbjvOnc+Ie0dl
         Cz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757404497; x=1758009297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5sZUHke1cOrNWY6qZMJoyROLt4T1nD+uxD+OwzRsAo=;
        b=cD2uiYdeQhW2/Rbo0Cz3RB+1cBe3yqa+AIRrluvdpEOyb6HFDnE2Z6RljplhCBcD3C
         o3+akEZd4ermiAT1GpoTqZZ9gC+0Q6joO+dMsU80iWkqHqziYyGGZvIW/8uJ6Q3+YIHb
         CjCUFs7xpMQnGxjiAvunSQ6r1/r/yiP94odVLKrjcaOyQc9esp6QniUSCAoyuLo+1oHp
         rZj1pFT6vc3WEttVKs4/sY4LHVg8Xh06tDFI2gNrPcUwX6XLiI6ivkMWYW7UUNCSU3qK
         892uzoCv/LYg7F/GjQBMh9NSdOu79/G6wWKLtOgmccMmpdWyVjHx/NysvLZTJOgsTqo4
         Jpag==
X-Forwarded-Encrypted: i=1; AJvYcCVjV+8cUrXPwJ4wLV3wjllgUPYXVl5y6u92JkhOJdcpEH5/qwNNNJHoYcO+qWGklfrf1S2ilkrpfEnNFw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ccKEa2NUeF6WcY8jRu33p7pv9Q+2p+WFCtadEajyH/wwf8gn
	bt5+qEhl985TWJKs5Eu634azEqR6BQ+DBjCzrvYnKt4Aie6Q2huqe6zF8qg10rYwOZ4=
X-Gm-Gg: ASbGnctfQBx8daKadQbDJ765/fSN/CNomzjpn25kW7sVWMFwXeYonNdH5h8+5ReQiFm
	Vv2qidK5QjQS+MVTRxbRj83eHmyDLObeLhTefUKIJ9hAvl6UnAdO8gEZzkSr2wReue4plwm5h0q
	VRLFc5j6133sz5Bk7BVmRGCqGLEOrwuePk+cdl9a0OeuXwliWeN6IYgFJFFl+aRQzLOOtkv5xZE
	xA2Gow6wfIt8787yhhldg8nQPo0hifyQlOkBo2ebUQoOTj9IEnLFdsEi7aZWEyiVVL8kTChaiaO
	isRTcuJxuNLdScxLsUyZK27ETXp1I21uhLhA65bPwfLk5s6stn2y+6/cE0VC7kHRCKzsbQfeAgs
	EnDcRs7ih/3t22GEe9ePlCB5Urbv5MuhJUROpwg==
X-Google-Smtp-Source: AGHT+IFMrL+qpqVZLHtIpk0NAIPagB6TkPEvQUOKqRDE9Ox6P//HG3+ZZPicp7UNZIR5zh9FPOH4xQ==
X-Received: by 2002:a05:6000:144a:b0:3d1:61f0:d253 with SMTP id ffacd0b85a97d-3e64cc61000mr8735700f8f.60.1757404497452;
        Tue, 09 Sep 2025 00:54:57 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45deff68b43sm5564215e9.2.2025.09.09.00.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:54:57 -0700 (PDT)
Date: Tue, 9 Sep 2025 10:54:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yiming Qian <qianym1996@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com
Subject: Re: [PATCH v2 0/2] fix coding style issues in sm750.h
Message-ID: <aL_dTVlN13Q2nYX0@stanley.mountain>
References: <aL5tjv_2YkvHPs5C@stanley.mountain>
 <20250909060130.12919-1-qianym1996@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909060130.12919-1-qianym1996@gmail.com>

On Tue, Sep 09, 2025 at 02:01:28PM +0800, Yiming Qian wrote:
> Fix volatile and camelCase issues in coding style:
> 
> changes in v2:
> - Split single patch into two separate patches as suggested
> 

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter
