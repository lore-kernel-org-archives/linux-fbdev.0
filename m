Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCDC3D523B
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770205147; cv=none; b=I+F96UdRVqAw2NXK9bhR8F/urE83Ui+M1b3IvutNOFxotT8QTQ/I90dtFoIgVzuse3ZO3BxAxIV+LEFiP0siAhchUZasTCrwKmkyhkp2VyPG4H1l3Wb5lPUIsf9rE3gOCtiMdHNwiLOB0H6SEOssaJP83O/I72kCZKfrtaj9/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770205147; c=relaxed/simple;
	bh=3PLp7u4/e9QtU/Z9HbvZ+sWCeQ4IFeck7aj64OWbhLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k71Xkv5NtTTU8rakFMyZEjUo8D82mIF8KsB/E2mIFhyBvE1ZxF4fvBoGI+UDgMF30Wk7fuGMAUgea1A2CxPS92leNDCnFBK1q3TXYWxn5YEpZws8bP4FkEjknw2bLt4ad7gSa2s1C6MCt/5c0u/uQc/KESxuPJliKuRAlG6z/fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zggazEqE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zggazEqE"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806d23e9f1so74827565e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 03:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770205145; x=1770809945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t9tqnl4nl5DEpP04BaFMoPL0bj/Xd+YqfHCJcLoEdNs=;
        b=zggazEqE0ChKl0ha+5jPf1JDVMxk2lF8eXs/1VrDpFHwOLRMtocMTLgm3x43ZmwjWM
         Ts4wL8Rdoj1BAqq4PNDLCnxvJpiX9ZHdOcthfPmzndRbEBY+Gs5J5JOThghZXmmqaGon
         NJrvVp7YD/2408hCa/rz5hET85rt2mXaHYa5eYNWqsFOgF+FphzUSU52HIkJaMRK+8yv
         XmndBYROoSSq7pQBP3CxJ/0W0RYNO1hPjU75RflfgFebasrvNIX9AAPNXUb8SdWNL6V3
         V9czSArVbNqw6oVIO+wCCI4/wgGMAj3X3COP6HrwmMdWw/HgiqalrJm/LYr5DhWolZYq
         NGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770205145; x=1770809945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9tqnl4nl5DEpP04BaFMoPL0bj/Xd+YqfHCJcLoEdNs=;
        b=DiQxo4l04LZ7kS5XmneiYka3KOlUCbzcUwbENyaQCzcOp6XEpUgDbiH+bMI/Okcaax
         WoOIjHC6z+aA2QRQ9GDnPQd3pQ3qGokmtnMhueBB5ZzRBbvd/xcyjbu7Cct++S/55qCO
         crGuoVNJJxKa1R1aAqs0ntaKXGFWOG5hr3F3GoowAEcPK2wNnB2xV+UNFFFZq00jOg/2
         +WH5sr+xnPqPkSj2ftegcoicZgeaUUvvxiydy7pIKfxScAGitv66sAeaU+M8gchwN4kj
         rJFfcW4tawc3Cr6YGOT/pov+lE0SI1r4Avf+28PIEMnZrFXmTbGwJ/yW3zsuu827Ec+T
         Zx5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX49aXYFsk5KQDAT45WHQFNkCF2hSs9b+w7DDnfnew26P0Ny/0jTDbLIEqKqK5m/e3SJkteq1sL0z4ivA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyP4H+e89AUoJaBEUE3UHGl1mYaBpD1DaP+kj0Vs0TOEuqNsbqF
	55wo9sQEgHwAtHEwHxNKuqtvsVh6wAbNqlHM8Ugrdi+vUQdWQj3xrhnw9B3DY1uWCOo=
X-Gm-Gg: AZuq6aLfAIxdVNPIS0PPyPQzYBhWk9gnTuyDervz3hHZS1fJ3z0Kzzg50kozviRgRTv
	63X/nGdKNEQy3qcU0xuYqNXRDed7tf6jHwqvehVck+CFL8HTRbbsauJhWs6OtSDeMG/CP/1e0X6
	JylWvoci5/yIrbRxgm/O1Fkzie1IZx3sARq8Oaheg6EEhJ/QpA3Yc2lz39OvwAWQnwu482MmFwV
	pZomk/YZyIWqguLtxANocgskgi7TRIsJMXaEIbKrl8FWvuqPgpH4TyvEFBy+URYIG7xuEcojyjk
	e6eb49aNeGjz5B6MQZjm98iem4HAonFmcOJS3c6hIq5n2yP+/DTV5lTmw3hnqJ1PbUhXYzZ+Jhx
	UUPmuAlyYIdn1knZ1s3CLrQiQY6WsVp/PsNPtyqmyiqPjEFP8vtGhw4J4sidt6cqyrfzy94SmfK
	sMrF7UteYZK4O+Mkdn
X-Received: by 2002:a05:600d:6447:20b0:480:7385:110f with SMTP id 5b1f17b1804b1-4830e94c939mr25956105e9.12.1770205145002;
        Wed, 04 Feb 2026 03:39:05 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830fe69e9fsm22558835e9.6.2026.02.04.03.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:39:04 -0800 (PST)
Date: Wed, 4 Feb 2026 14:39:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] staging: sm750fb: remove debug prints and convert
 logging in sm750_hw.c
Message-ID: <aYMv1UsvKfe4hbAe@stanley.mountain>
References: <20260204101536.3311-1-iprintercanon@gmail.com>
 <20260204101536.3311-4-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204101536.3311-4-iprintercanon@gmail.com>

On Wed, Feb 04, 2026 at 10:15:36AM +0000, Artem Lytkin wrote:
> @@ -163,11 +156,11 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
>  			 * The following register values for CH7301 are from
>  			 * Chrontel app note and our experiment.
>  			 */
> -			pr_info("yes,CH7301 DVI chip found\n");
> +			dev_info(&pdev->dev, "CH7301 DVI chip found\n");
>  			sm750_sw_i2c_write_reg(0xec, 0x1d, 0x16);
>  			sm750_sw_i2c_write_reg(0xec, 0x21, 0x9);
>  			sm750_sw_i2c_write_reg(0xec, 0x49, 0xC0);
> -			pr_info("okay,CH7301 DVI chip setup done\n");
> +			dev_info(&pdev->dev, "CH7301 DVI chip setup done\n");

Delete at least one of these.  Pretty sure that Greg will want you to
delete both actually.

regards,
dan carpenter

