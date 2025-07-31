Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8162821B9F5
	for <linux-fbdev@vger.kernel.org>; Thu, 31 Jul 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753978282; cv=none; b=Cb0748D13uKYL2Tl4XdBrxfYksR/yQ+1s/XSApYZgpquVSRuyMruvBcKBV29XxirYkW2YfF3yYR33d7Yy7ZRk4u367fCO1MapOfVgsJZoryWGlukvHVz5pM5edP+tqx08ONJfM84oEAZK1AwKKsUnTOrynsvt3Ryw8Irh2H/PK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753978282; c=relaxed/simple;
	bh=XPJtLkScF22u86bMP4SDqxdWjENN1xCpfKx6sl1lASQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRvBBLMP7P8sAYsdrN7VsdPkYuHAJ9AaBL+2I4yOJhoyy/VD7SmUpMpD6HqCSOwLcjjE6L0U4lnjcEaHEI/aALJlGhiaP86bbKJsr54c6l7kChyuiIEUz0iveoeJIPk7U3ARJ01TB+m6xnIjMv2bebP9HNghB+uRn5fMsCsDHk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DNGdjfJY; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DNGdjfJY"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a588da60dfso361414f8f.1
        for <linux-fbdev@vger.kernel.org>; Thu, 31 Jul 2025 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753978279; x=1754583079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0pKCmCd/yQbFcsUErfFrwExl3US45KhBWUDTffbqywQ=;
        b=DNGdjfJYyND1WvAdr24uzmGbCBLFAxhJ2TdwwXIh8eLYdPAc2FYY214OF889L3SL9+
         2D/kHjcj0YVamjJ9HAbHOyhwr4bHXrB8SPBfqzBNTyy3LDIMvoKUSSeK2/wr/hbLIp3i
         2jiyYrFLlGiXOqqphN6LF9Rh7Qqa5/5lH8IX4ScMUW3Hddo6ieURNX3kJmuUXh9epdWp
         AIRTMk+PK27zrAIFAbN+0M1/zXXwXhYnb80/Id4KzKIbu1+AhhOtSOMvAK3R8aJo+Jvf
         h2tuAwNT7Ju/xeoS/nPTyhIRk7GOFwMhVL+p74pHPQGT7jFL9izX4rMOLHah1OF9s+S1
         sNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753978279; x=1754583079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pKCmCd/yQbFcsUErfFrwExl3US45KhBWUDTffbqywQ=;
        b=ftSshUMUYr6RAyurlOUG3dtR3o99SpX2fl+px3fLG8R3VYdhXFL74hLv78WeGPaoNd
         j7wPiAghZaqVbIBR0IXPyOlyC1z2HMWtXPBUl/0dhm3XkKIN4WlXid5OOsHuufSI+rzl
         lBZW3Yr0f0v2PNx4lSjEGZH9tHw8xiJo8i35Z2FydoNMKsPGaSHcbyIFu26KQjlgluZA
         3goyuRZhXluEwDW/sjkAFZEd2bwlEsCQWsIRukRwnYo699co0Aifxu3deDlUbAlzHMT+
         3Eeo85NNM5ukAg0pbpXVlBYHjVIMDoAPOfGUIgd+roYg0avYd+msZ/fNxtu8yJ3/xJsa
         WObw==
X-Forwarded-Encrypted: i=1; AJvYcCWEE2iTaZBn3NU0DAMZeYSnv6sKgYbckxVUKnByrUYrhRveHxk+w9pEvuVYCzRx5vFA8iq3/hmMNwXSVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfU8Pggdr/MNmqaVFVrYfmkRxc0li99d4FCTOqgWRqYs+lnCkg
	vOC98hiQtCTvZaqYF0szjscAAlEYQy5u7zZNkknuKBvgNCjmsuJUfPL/KOWw78pD27+056VO+Oc
	A2B7RP6w93A==
X-Gm-Gg: ASbGnctwo+Av4PMQL0+ib61/5ZhJeiqIU3PFxW8dd658dEHZsE1tvX+cKIX7Bj1htwP
	jtBGYQn5gxqdViqRFbJFUXGiMQTLCcfY6iINEDK4G1G71uaxV1e16soWM2nUwZ2rUA7aGzfXX+L
	jaaZOd2bQ4Ie9jYzce+wiLznCWiqxFE0fAgqXqH+K0BOlLwlUK2g7Sm3MQgKy1SWLmjQvRJWMvP
	DORU9hkDWPGvPJ0yg1irsDALIQoOhAG5Bd0hYPLBGGuAJDVfJVBKYna1xv4n90jXvvzhaoU416S
	ubjKWpFECXRVpxcyCXQ1CF3nLJHBCAfPs1WHtJTRE4MAEWc41ruQXcvqpOilwECSK0jfwpgzdwj
	Cw+dAwptO8/oJAJip61y7yphts4A=
X-Google-Smtp-Source: AGHT+IEs0sZIeJXRDqHX2Z8CbdsVOdwVXngFwlkweiuRMlQRF2qpDns9PvEmRvHFDIc5h3NClMUWRA==
X-Received: by 2002:a05:6000:2003:b0:3a5:2d42:aa17 with SMTP id ffacd0b85a97d-3b794ff16e3mr6281554f8f.31.1753978278819;
        Thu, 31 Jul 2025 09:11:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a2f03sm2779242f8f.72.2025.07.31.09.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 09:11:18 -0700 (PDT)
Date: Thu, 31 Jul 2025 19:11:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [bug report] staging: sm750fb: Fix polarity assignment for
 vertical and horizontal mode
Message-ID: <dbd2df69-27cc-4fd8-8e5b-78b6872d5d16@suswa.mountain>
References: <20250723192528.77109-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723192528.77109-1-alok.a.tiwari@oracle.com>

On Wed, Jul 23, 2025 at 12:24:31PM -0700, Alok Tiwari wrote:
> In drivers/staging/sm750fb/sm750_hw.c,
> the vertical and horizontal sync polarity assignments were incorrectly
> ordered. 
> The assignment for modparm.vertical_sync_polarity was mistakenly using
> the FB_SYNC_HOR_HIGH_ACT bit instead of FB_SYNC_VERT_HIGH_ACT, 
> and the horizontal polarity line was commented out or missing.
> 
> This patch corrects the logic by properly assigning:
> 
> vertical_sync_polarity -> from FB_SYNC_VERT_HIGH_ACT
> horizontal_sync_polarity -> from FB_SYNC_HOR_HIGH_ACT
> 
> Please let me know your feedback.
> Thanks,
> Alok
> ---
> Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---

Did you find this copy and paste bug by testing or reviewing the code?
How does this bug look like to a user?  Please put that in your commit
message.

This looks reasonable to me, but the patch is badly formatted.

1) It should say [PATCH] in the subject.
2) The body of the email should be the commit message.
3) the --- should only come after the Signed-off-by line.

Try applying your patch with `git am` and review the log to see what I
mean.

regards,
dan carpenter

