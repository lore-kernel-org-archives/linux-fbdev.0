Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912E348C48
	for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051157; cv=none; b=fw9dPW5qzCohZ1WnrGKq5NwF0d9SAhMgQX+GNaI+aknSbh3P1zTX7drnX+gMBXBf2/cYFsslpOAVKF9klv69jlYwuDrKJb1iEAdtOLA88JgrbUmR+K0vVw2ZYLLileCyj2VASc80278Btr1rV4L75uC2Bu7169lFA8RRW7W/1Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051157; c=relaxed/simple;
	bh=rvgiEl9LQVqE5UrFPQ7CggVAH3MVjiWMkIFeKt9hmBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4b1zduRVwxKyBdQSJrQCo+F3jpoGwqmcEkF0E3rMu2+QJnRe2IGbMG4BRetWn3grjhgz4h7qT4x2I2pr1caNx+0Sch5XkCTq8Ow8vlgwnfAtGdLSzPD4otSJnkIzOEd09vUOA40UFwlrzByYcEO3C3etbLQZX57e4ixn/Eqj5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAlo1sKJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAlo1sKJ"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-452169ae568so8895132f8f.3
        for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 03:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780051155; x=1780655955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRYr8moLEmjRWHLilv4FqgfxJEhbzr36lw1lU/Q2qfI=;
        b=aAlo1sKJAp4azpfhlBPGmtV76ANBzB2tw3V4GlHMCS+W4pvFgL9RjfVjMjg1dLdGP0
         BQxibvfmpe8/01d+Z3+PKaTkfCpU6H4tI8jqfLvmBtNu/ASIfKRV9V6FR8Avj5lVBVq8
         1D8dlnWbWf1nXC5VQ0AXhssh2dULN17PLS/siBQOW2RMJ++md5OMY7fLrn6X1Sbt7eIV
         900/05ApbffNjHc1fEYv1/6xTeXjzwELuchA9QHI/GMmNRiY1WMYGAxRXFTArJOQ9ums
         6P11807AQq9pNt6PtrEpTGVLrzzuGStu02FGT6QHQe5ixbacm+zXdrxIbfsuI4nxpxTV
         saWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780051155; x=1780655955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRYr8moLEmjRWHLilv4FqgfxJEhbzr36lw1lU/Q2qfI=;
        b=OnxE4txkXbkD69WasldEibhS83orXyOsNlOa27Zuct0VX7ZkAXg1+dMixdPw5Ocm1j
         dkX7P+qVJe3KtVH6sawXUkXVxTHpmFFBiPQTZzvOGQmTUHhADjYh135dS5qXSKSe3Ssc
         ieI0Dm+JNPLnV0ihYFRhfOCCaZ8M5/f4sSMLFmDFw1/hbwm/aPo9dsn8hlUwckKExIXs
         oCzruHhd5/0GVKt+l/WbbWBaZZX4SF6X7mwALc2cbD7X9xRn4xkK1X6Keg1oEzwiO2uI
         SL2+mIE0JzGDwIV2uQaUPlg15pwX3BGC+qQLEtVvPxXRZK3TVdMWnI0IyY/IyCUphDBu
         RgIA==
X-Forwarded-Encrypted: i=1; AFNElJ/8Yqfjg85ojzWDwxmhCoToNVW6XvSd6xOrTNdOJ5RkGBNeb0pyN+15JAVG9CqdXg83ZFaXEDlUQQr9Yw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3z7NU1AqvTvD5dlZ7bxxp6yfXDqfCU62Z4qRqdNQ3ka8LoTOx
	bOqvnRjucTdbGjAjoTZk2mHI4jiXgrKv/u/Nce+TJNVBSK5KlSRaPhzm
X-Gm-Gg: Acq92OFpP9ViWbzqVxCrUvYOE17Tc5WqEGYjd659jMK2cz3TBLTwOLy/Deex/MlQXg0
	gZMiNf6DWqaX7tY8MoBPLb1TGEj5bXiDrCuZVsunNQEV59rWznPJLQe8cYDpOnar0ktrlgAPvyr
	At20Kr362FbNgu24+aFRQFSy9SCcYh3EORqf+62KxMTrvdebplsXMVtbq3fIarFFdZfPyTFc/zn
	DbB9N72pXJ/Nk7avF5O4GHyxfLiaw6tWfdmDxNUW1Ct9i3eKL6rHavDTl516T5lnHZ8bhPzCIJk
	OdS1Qub2LImnNdyfIHFE9xYYx9dSWKfC8st2+c9ZdbTZhzsJUay5R1VKzQqP7RB5qra6j3SVrrj
	uOJ/GvLI/2slibFRYknoGmpFTrUExqqka8CjmOkzNw7bpvDotpF70Y6Ot6VYiNY8FpEGAWA3clF
	UkWHDjzQGydLU5IVTnHVrq8hcKKfNt0063UxOiJMfrZnBT
X-Received: by 2002:a05:6000:4697:b0:45e:b215:12e9 with SMTP id ffacd0b85a97d-45ef140238emr2957539f8f.6.1780051154817;
        Fri, 29 May 2026 03:39:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef357635fsm2492792f8f.33.2026.05.29.03.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:39:14 -0700 (PDT)
Date: Fri, 29 May 2026 13:39:11 +0300
From: Dan Carpenter <error27@gmail.com>
To: Onish Sharma <neharora23587@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: remove unused variable
Message-ID: <ahlszyY6Nd9ANz-X@stanley.mountain>
References: <ahlXYIqzu4O5-u9J@stanley.mountain>
 <20260529101242.10189-1-neharora23587@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529101242.10189-1-neharora23587@gmail.com>

On Fri, May 29, 2026 at 03:42:42PM +0530, Onish Sharma wrote:
> Remove the set_all_eng_off flag and its associated cleanup logic.
> The variable is redundant as the hardware should be initialized to a
> known state regardless of prior usage.
> 
> Suggested-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Onish Sharma <neharora23587@gmail.com>
> ---

Sorry, miscommunication.  This breaks the driver.  This is also a bit
more involved than I thought...

There are two structs:

struct init_status {
        ushort power_mode;
        /* below three clocks are in unit of MHZ*/
        ushort chip_clk;
        ushort mem_clk;
        ushort master_clk;
        ushort setAllEngOff;
        ushort reset_memory;
};

And struct initchip_param.  The initchip_param is exactly the same but
with all the struct members renamed and comments added.  They have to
match because we cast back and forth.

Why do we have two different struct that have to be the same?  You might
think it is for API, but as near as I can see that is not the case.
Maybe it was at some point?  We should get rid of one struct.  Which
everyone is API is the one we should keep.  If neither is API then get
rid of init_status and keep initchip_param.

After that we can talk about getting rid of setAllEngOff/set_all_eng_off.

regards,
dan carpenter

