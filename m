Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C5C35957
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634287; cv=none; b=kiElbzlEEHzdNYOuZcscugD1+th1JKZozMFZIEojzK5u7R4U1VPKfJtelRc/XftSzdsHh0tzUc/5EvFQQPF7jWrQsHu5AaDU+dGlgyoFroho3HsaKxMoMlELYRAY8eZdLbaq1BhwlEQ8Sd9wJc65HaqRogIg5wcMsKCMmzkr4Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634287; c=relaxed/simple;
	bh=qvtp9cOPL28AfjMQQuP2kfpfH9rCoFgtAXBmC0n6E0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEuCXubGm+QkxQ5y10CfRbwok57IRYa7u9V82y400NXOBh0R3SZ/K1cK1Ot5f/dQHmKIChg++89ZyOD4DlUtAmQbm1+5E/CJM1PDHf3KEoUIv4qY2yLzLKZxYl30TWnqaFSd1j+1jNkAyJYbmVaq3CaxxLOSowrejwZADajD6kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ac6eMwzV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ac6eMwzV"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-660fb578f8eso1073917a12.0
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 06:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772634284; x=1773239084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3LfyFtLkVvYJn6xwzstyzyPG8lEHIihq8sOpWTqCBFc=;
        b=Ac6eMwzV57oQC4Sy2YL+Ja6Pz6jh4TBw2TKV72t6xh8y5ufJtVuRAiSFKEs3U0hhnm
         JUZSgAFqRcT1oHsTr4wcqTMMjgp6odRkqnAd4ghV/g+QUOxRFhD0e0BGhRMDBvq+KRfk
         X4d3G/mm16dlBm6gnRs78iIlCj8pY9aNKxzsZs8AkXoJMgZN6Mo2a3ufVVnipr1rZzMz
         5QwTDKKaNlI3KkVsWoxiTu6oQdZfr7w/P63whkrc/V/FTY/rcaQKT6oLGI5ovJnHEhZZ
         Tyk07PmyHvCoSM+srW3fLyYxwQDbMFwjLPheUUaiaFp0FgYydbcQu/VId05wsdrsU3he
         /A6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772634284; x=1773239084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LfyFtLkVvYJn6xwzstyzyPG8lEHIihq8sOpWTqCBFc=;
        b=mvSnUfuqAZvFvNb3Gcn85erXh9frk1MDh8zKq6UJvGpzh/YuUlBkxDnlh6wSfhJ78V
         KwgGfIbqjpeyTKYKv+V/XkvF2urB5BsrkGC/doTFQVdbyt+cBIe2X7n04/Q9X8JOld7o
         d5mzXnExgW1ym19qkVPCnG5Pm83nHBKPAoDLc+84RbVVpRMHzQ89LLOjdWVX4oERTHE4
         lucqCbsIFh03zL/OE6yGHTAj4euibRTTDUuHVTY0vCtePY/SCRuWhhDcirYlSF2Jj1QU
         kLuD47K3QHW+x86y1LGFYUY/gbVBt/dBFhlu9gu6dZSllCcUFTPdQ9ghL0ATVkiZhkIv
         QNmA==
X-Forwarded-Encrypted: i=1; AJvYcCWHzHXKhWrmG8Te+/+LJQU1LglV9gfnq/Bz36J3KaRwafqrkRXh+s+9CkIzHy0wgQjPwg2xo7r2Nd5Obg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJb6MqEpNWQTSbmw1Mun+aPmuNEnpb+EDTzsFMLj62QOouhIa5
	XPHcvQDuf9jTbldae/8rYstOF0kyhI6tYLaHRdZldCBoDBpJZlXKD7BXENppGvaWVx4=
X-Gm-Gg: ATEYQzzfCVP8ITDWuA8bZD7p+NSmpbCSCuMMsrST69fVXphGRD0Jran6Xna3FqHw66E
	GW0z6OUH4m85+tzlQhY3A8Q9yd4fERd2g/C8nkVujFEXNwAPp1ErW6Sr0OC9VnOo/QjmCSJby01
	Pa2oNJ0xDejPw+G/2VspREW5jTJsSFA+oscStEW9MmXj7nkTAOOfWbHmV5m/z7kwuU6IVB0cD7i
	RUDGKlikt0JGCMGK6z69squnPv49oicuVK8oUy/tM8+eyKoP0akbaX2QqPH1WxgA+yzEuzw9ERY
	3O/IPQ7F5rMeuhSsUigSXkrGdKNzUXbeAv1T+iaLpupMmTwcjg+m54Y9LWhENvLst4d/Z0DIsfn
	2XhTaat8cakmN1w0GGgQ9DyScDDmDpcdmlWh9hROwXzr+34qkaYI8zIp1Arph2nL3ZQ0NoVuRZt
	agJmqwcbco1Sch60nCk3f4MpxZMaGV
X-Received: by 2002:a50:8d89:0:b0:660:fdb5:4e2e with SMTP id 4fb4d7f45d1cf-660fdb55132mr709089a12.32.1772634284072;
        Wed, 04 Mar 2026 06:24:44 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabf6cfd9sm5644348a12.22.2026.03.04.06.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:24:43 -0800 (PST)
Date: Wed, 4 Mar 2026 17:24:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Soham Kute <officialsohamkute@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] staging: sm750fb: sm750_hw_copyarea: propagate
 de_wait() error
Message-ID: <aahAqNcuxpU--an9@stanley.mountain>
References: <aaVT1mSeKrSSlrha@stanley.mountain>
 <20260304084545.156170-1-officialsohamkute@gmail.com>
 <20260304084545.156170-4-officialsohamkute@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304084545.156170-4-officialsohamkute@gmail.com>

On Wed, Mar 04, 2026 at 02:15:42PM +0530, Soham Kute wrote:
> Propagate the error from accel->de_wait() instead of returning -1.
> The caller treats all non-zero return values as failure.
> 

The caller just ignores errors.

regards,
dan carpenter

