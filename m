Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2787318872A
	for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747808; cv=none; b=Wpb+nJTR2hcCfveLO+4O9VhzX2mbf07wV4cMrA6upFJcgWNE4X0HG1uxm6KXE8v3edcn8B1jZnF3PBPSS3jNwOKfalLBZyVBqyBhy4dn+8LFYa4rvF9uhGLFlbE0jOQhPomazY3d2CYcVeVoAE1G1pXX71eqC1sERbEPe75Wc70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747808; c=relaxed/simple;
	bh=LZjFSiJMAk133oX14n4qPnTedQkFhR+lVpMPoTUdv1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9SZef303xkj576yboG2WuNSXsyHvpgdv/hiN0VODb2+sg7hMC52gfaxBCZKl9f3UjZxKQAzUzNhsD5YzudZqoMr2Q5jYDcraKF5fK2A/wfhAANmU0V2c4d0i+zYaIxrIFzW2udPVGwHucnnKTN3iQNhzt5WROtBF1d/rxIFvpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qWZAer/s; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWZAer/s"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44b052142e1so4326434f8f.1
        for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 01:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778747806; x=1779352606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/SqpIK99SX2LQxq4P1qr8bITnns1XnWYW1P90iMrai0=;
        b=qWZAer/slBa8nVAUcTouO45TaZrceVijuKkY4F+XAhMxrQ+a3E11v++xCtsFvKUwA3
         8qgy1FSjIGmlbLL4hsnB6vmAOILeYGh3eNYkmAST6IN50YMobcoTIO6/Evrv6cKTBEk3
         7KgRoHDg7Uil2Q1U848aAL/GFr7zAc3hho9/PVVkRwtYRnZ0+VJSTIC5KMPCY/7P7e1A
         h03JzkIpKOD0iySGBsQzRyz1zWxBjJYF63bym6EFNd2LBmGRbTj81+mPNzcjHPxXBmu3
         GoehkgyjJhz4g3q0Tq19mSkbndmbXKpQD7vpGcdkwAEVasbcx0UsUrp3cYFiYg/51GQW
         qZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747806; x=1779352606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SqpIK99SX2LQxq4P1qr8bITnns1XnWYW1P90iMrai0=;
        b=FUx5+2KAdnAryUfixrNavdho44Pd4/s4rw0mCUXaYCiDBHvHRUU/EGKmwOC0KN+gWJ
         BlkV3fhGtg57fgUXFBv9IV1FqUreJ52/sP8BmrFyQLRAWmCURelFV0LVGqMTTHwnP1Gi
         VZgd3kuaS3ZF2cGEWTJuuLZB6LLX94KiEbjqZ3Yv1fFZzeP2mfo+gORYYcHZerIphCLa
         7VCukPysO/IqmJaNM4mDEfMcLwVYvfMLWjQNYdf/7vmcRGt0WaqGZgLGLogRX97T9Tst
         foczRvMHLom31VOKKHBd8Q7lArv4+NnIyP97okVHD8Elh25FqZ2XVQMorYU/6rRDgo8N
         9VDQ==
X-Forwarded-Encrypted: i=1; AFNElJ9q7ypSOsQ00V6ZfFQ8FrUDnDtN/zJq+rty88nDTZXVyZPD5gLL5y0cthpsSAyjthEzRLN9dgWxoh1MOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPjXs/JR6O0r34Pkzks9bSoMNPY/g/WtF6/Qv+x8qgYetyqiJR
	uatXcN/QbSVUUR4rFO1yGl6GXx+dLzy9VaK6HT4RpG97oSoBFROIObzs
X-Gm-Gg: Acq92OEMrLkrPCYDm9i1KFzysSaSQLK8JUT/D6N031QkLHcaNnX6zaKbm72GCAGoIw/
	ObRfZzTqCwBtnCjJyyQz010kWFECIgMgRTPKw9BKI8jUjR33P8lkQGjt8PsEqiamQD8EA60Ehl8
	YOgpV5qRawUBYdCjGVuLy/WPpdpx5DB608ywI/a0BqNmULkUjZxecLYxdxxGxZcQ57ivbcSG3N6
	V/FGldR3GflEMk1EMoNHlW65Xg/RzwJv9sgS1pWeYdS0M4eDirPJTJd+G4jg3Ecxu/UUEdwTP37
	iMShZ97VHOPZDRnJ5JaDwb128FKrPTI4BWZ4YlNFHmqdrHz/zz2nbFlJNWpisKDGj9hdE425yek
	vWO4c+C8koBrfYZQeJ3vCHuC8X1Oo+z4ypgGMlrscho8ccOaTtNSPP3xNqaMP6jp5p1Ukp098XU
	LmTgQgkAPzb0AMJinuO2s=
X-Received: by 2002:a05:6000:2486:b0:439:c299:4d8f with SMTP id ffacd0b85a97d-45c57bf958emr11214469f8f.17.1778747805454;
        Thu, 14 May 2026 01:36:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a17a22sm5145202f8f.22.2026.05.14.01.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:36:44 -0700 (PDT)
Date: Thu, 14 May 2026 11:36:41 +0300
From: Dan Carpenter <error27@gmail.com>
To: Chhabilal Dangal <yogeshdangal66@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: add missing FBINFO_STATE_RUNNING
 checks in copyarea and imageblit
Message-ID: <agWJmcvuQYCY_15b@stanley.mountain>
References: <20260514080318.39332-1-yogeshdangal66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514080318.39332-1-yogeshdangal66@gmail.com>

On Thu, May 14, 2026 at 01:48:18PM +0545, Chhabilal Dangal wrote:
> lynxfb_ops_fillrect() correctly checks info->state before accessing the hardware 2D accelerator, returning early if the framebuffer is not in FBINFO_STATE_RUNNING state. However, lynxfb_ops_copyarea() and lynxfb_ops_imageblit() omit this guard despite using the same hardware accelerator through identical code paths.
> 
> Without this check, the 2D engine could be accessed while the device is suspended (state set to FBINFO_STATE_SUSPENDED via fb_set_suspend()), potentially causing bus errors or system hangs.
> 
> Add the missing state checks to both functions, matching the existing pattern in lynxfb_ops_fillrect().
> 
> Signed-off-by: Chhabilal Dangal <yogeshdangal66@gmail.com>
> ---

1) Run your patches though checkpatch.
2) Add a fixes tag.
3) Put a note in the commit message that you are using AI and have not
   tested your patch.

Smatch says that the state is always FBINFO_STATE_RUNNING so this patch
is unnecessary but I haven't looked at the code.  Please check again and
resend if Smatch is wrong.

regards,
dan carpenter
