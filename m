Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB6D1E5206
	for <linux-fbdev@vger.kernel.org>; Tue, 18 Feb 2025 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905694; cv=none; b=Bl+0WKc472i2gB1QFfZqtCNiFd3eksVLCO+H8xJ6/ng2slsXNcuwZkzU0wGkTLUHwfswmhu1sjnuMmyh8d8uFDLRMb0uXqKPjL/gZbPru1lPgY3diMZJoqK5abHa4au1QIt4tFomVhnL2n1HZhjl1ThAXSXsi0eMSUDvkkJE2bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905694; c=relaxed/simple;
	bh=qYAZTiqzP1po9iMBaj0lHNXjlSX1F1TWryWziMbjTVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4o3zcYmNwNDR0YWjPtDU+nq2c5S1dtKN3n1Lj0LD20PPpwlrb62pMONSBqW0TLHp3EUYL0kngihRZEgFn6tvblxrBvKHpbdKD5eq1cummdjBrMLsY/XCCloEoRebudhade3QSQOyR/9gpKgGGGtvJzC0Q1KHzwzHA5PggjifQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g7tRfZmX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7tRfZmX"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb94e3b49bso446105866b.3
        for <linux-fbdev@vger.kernel.org>; Tue, 18 Feb 2025 11:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739905690; x=1740510490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rNsBxEX1Tk64WX5P1Q2cqgd6NAXQLvCCopiRfOs8H1Q=;
        b=g7tRfZmXQU2D748U1SumVD+ZYfFUS7ND4alUtIn0tttFxBQWv/V19rgYggvLEi59q2
         DLpUKTXOgLyqy7HQ8g3azS2xdRBjijJgp5euwZQqdq/uHvgZ4wLCMaV4y7z0aWoinny6
         6muwik33Js2WiPjA2wrRdgFy3GzqSkCVoLcVd3mZyQ1t2kLWE3dS2ALGrql/i2xVPxTS
         g328WK9r3Ejd6qzIiIF+KhwWUDr5ly6LEGgGxU0OSsfKMH1p1cOp8D8VwOn+rjwYSzzG
         mKayVRuxSGq0POnDrwft3mjIDpZmA/HBHR/0anM7a2Egdn98AmUQ75oWAutoIPqYTyud
         aLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739905690; x=1740510490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNsBxEX1Tk64WX5P1Q2cqgd6NAXQLvCCopiRfOs8H1Q=;
        b=nL7y/66phRyP+NlhUM8oaDylLoo5nXHX+GmqC3pj7kThGsHRRqWhtRWPZVH0Z/CRLk
         xt2o7UZUYQrTJ1OKwTALgMFCvJInB8rqPLNDbxL7K3dMoGZg0YL7/p6il746jGDt9daq
         DTmUwkFkic0nf8aX7PWBF2jXiNzaZLHh8JJoHeLasvmCeoHpMiaF/TAJ+dFJNQMo3dT1
         H00B29nM3w0XL94ZXzcS4xbXivQesvQ8uOz2hjDCYOpvrOKVyOJ4ngegvQL6nnd0dbyU
         O4Q6KTCDEsWuJZwdwKtHFp/MU1qMV7fBHQh1vBvMQi218yCAQj+22FUG7SPB/1Jz18vA
         Hknw==
X-Forwarded-Encrypted: i=1; AJvYcCXMJhjtgk381wsBXkMi05jhkjQ/N14NmM1Zg4/JJCSL7ql+jL9gGJ3Sz9w4l0mxi604ir5r8Kk3aK413Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHfOwRk2bcUAC+xG4/lzw9abs+zqMZz0dWPUlTkQPge0yg/fJu
	B72cvCj/+RdDmhdcVqd101VOAhZkVyHkVgXNCSFs6KrIWzlpp3n9bW5CjGz9pcs=
X-Gm-Gg: ASbGncv62uKBhGU5MAZxZHv1c61R20/geZBiYahcKmTDlPbHPtUxmlAlxEUPMcMnM+n
	xZmM5O7eJRSs7jKzbAiwuLUuO4PKQqx9si5MJlATta/Z/RK6fZqFLHs3/XWVT0ljcE9ZU62Cku/
	OWh3h+v7tNPl5k4krFkJDdj9jDS4cerEs247jtT+AYjcN5TmBVgxSYZVjj6GJUkhENcjFsdwAjm
	1ksiQiJO126Sm97DuIrcf3pOdpo8VSeJ6jE1Uue9S9W6got+fB78ei5GWhDLPP524ym4m+zt4K5
	T0scovA9nsHjNh1S3Oe8
X-Google-Smtp-Source: AGHT+IFlziriHnAKD1HuHccq2KQBzmgCVFxrmvHg/JF2Df2oa6sJkUNmECTIl18g14D0PF+iOjDlAQ==
X-Received: by 2002:a17:906:26d3:b0:abb:b1a4:b0fe with SMTP id a640c23a62f3a-abbb1a529b3mr486697566b.1.1739905690148;
        Tue, 18 Feb 2025 11:08:10 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abbb0fb63ecsm244309466b.115.2025.02.18.11.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:08:09 -0800 (PST)
Date: Tue, 18 Feb 2025 22:08:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Fix CamelCase issues across multiple
 files
Message-ID: <6259457a-3a44-4b02-bc83-19eb1fc05e49@stanley.mountain>
References: <20250218184343.20585-1-madhurkumar004@gmail.com>
 <20250218184343.20585-2-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218184343.20585-2-madhurkumar004@gmail.com>

On Wed, Feb 19, 2025 at 12:13:43AM +0530, Madhur Kumar wrote:
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---

Quite a few issues...  Take your time.  There is no rush.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter

