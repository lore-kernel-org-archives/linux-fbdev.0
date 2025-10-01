Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12DE2D372D
	for <linux-fbdev@vger.kernel.org>; Wed,  1 Oct 2025 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759339148; cv=none; b=tiAJM1cMFLnkJ4LmoxHfhUV4ZCzGfHS9ZIKd43c3q1awImT0Dz2xd2redOO2xxPxUX2bXB1EQsyMTFaki+JFwjTBu/qbcLmn0pkqliaEuuXsGMd2+bpC6YW5XcrdzXSqKzEwmlQliAEv0dtThN7IgBFM9+iP3eXdIorshRW40P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759339148; c=relaxed/simple;
	bh=0kcmI8aEU5QUSDgRbCIIeZGutsdROd4SPxVbBnnnC9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWlus93iryzRP/9r+vp2aWuBx8tiVv3rHls0O6jEDJaGKgJ09qP4pvmfUzkG7P85TjWUL8WeOBHQVR/96Lditta6Bo8A+nHZGDKW3e5cqjN/w9hZ+KnaWguNtbkVN0Edh8TB6E6yNrh67MZLm8EZd/LGC73cHqiQW39GKyiEmF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJSHYuyo; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJSHYuyo"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-78f15d5846dso2282336d6.0
        for <linux-fbdev@vger.kernel.org>; Wed, 01 Oct 2025 10:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759339144; x=1759943944; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zopXUsDspNb1mWWJAWkCzCfsfjyf3UGPV6M0TUuo+6k=;
        b=VJSHYuyoToYFOjVIdIJvQi1fhRNLlqXY7aiWGsf4nO3XJCgHxowhiMzdUHw2cZ5Z3r
         kKcBgcLSMI6mgI60yAKMSoghiHi/I3lKj32S5qRSb23eqgV/pA1Ng0FfEjKi33VMIDv1
         yBfKx+G8JubA0m55Pj2Ly70lVhCuGiUhELGp2WrvGXEDlb02jixPJGiY1tntqkKLVJiE
         jlxe6FQdaJogNM1NqKlK5BZb5h+WfdAlkJlgY36Zxl8q6SQYrCBUKpSpLVXpIbFj8/TP
         QC7r7fO+PbEFNJN31PcT3ei/l1LcxoWLAUPJWOZOMj8f2DkI/POZV2GxgUiT0UKNPtN6
         4fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759339144; x=1759943944;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zopXUsDspNb1mWWJAWkCzCfsfjyf3UGPV6M0TUuo+6k=;
        b=im3Ixhp1E4lhg0s+QSM5kBxt31KjTVoNRu06ZSIKpl7sBOcOZsb7PxCLRte8jdXVz5
         JvMD8kQJzmY6FfZ1TzSlun4BMwznhsb2rZTy/5jcJorfhgJYrWsqRdkwRgH5J1drCiiL
         M0d6MUJjC4273AJBArd9VoeirXxYB1BqpPOjBsSRkkXc8b1NBzrivKDgtt6yY5drfh3S
         +UWKVS7ER/RvnUz2qISU8lr3do+4Dbc+3Agm7jG+Hhw6fOfnBoV+xAm7m+ZPOg+S8kD6
         ag4vonH6EX2u7EEf8WHfOOgoAtDGlaupF+j83dF5Te3GAFBWQxPkv3p5HGE/nibh+Fei
         OUbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAEfeBtvZYAWc4T+EyRPXMDcQ/z/ySi/IMrfWtcbosuS3wv6kukCHLiuinmpZh2a52aUPPwW83W2pCIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3OtInfk+HQCsFxxKACjzwVqU8s0C7YAR1NpZhmetjr2WZ8yAp
	jgZsf89Bn5YNmFAXoY3SDYiqIWLB1bH8/bKMU8pyNBWzwQtijVH6MwHe
X-Gm-Gg: ASbGncvtek/Jizd8zOBmP1lhN2E46Fv3V/Nu9tQJq8jHGUKfP6ebJm3ri04dzp2cr0Q
	mNdMdX8phcUucEkORDiNl+InsgFzcRbXoh4eLo+6BcrjXqi9t+uAMo6uj2LOKhuL3XmDXDZBOkz
	VzrIcicbtwG6ux9w4K//bre6XiTaYKnqsE92jH7cpPCBEBr+M7lhR0aL7SMqeJdsnYNYEK0uLdb
	uDujxoe1Pt5ftoCvSr5YHURXLfKw8bwVIJndz2qJEuyGl79UqjnnY+8YSqlMElVzi7UK53ajwEs
	hdUmfOCBr5B9fa789J+Dlk/VOYYtfrYHE6y0VZP0zatf8xXu6X96qkofnbI/y7VxOQi7YbkmzwI
	NdxjObge05LsieJnrSTfblDVMpz/gSKWUqpftvvBwJQ==
X-Google-Smtp-Source: AGHT+IHQhkaGCWCGXg39uCPJptTD10njVMqUQyeE04a/E92c7P5/6wo4qNH+/bkTJGYyPUCAdw9t3w==
X-Received: by 2002:a05:6214:f01:b0:78f:2eca:2000 with SMTP id 6a1803df08f44-8739be1b61fmr54866566d6.13.1759339144483;
        Wed, 01 Oct 2025 10:19:04 -0700 (PDT)
Received: from arch-box ([2607:fea8:54de:2200::9c5c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bb53e2c5sm1905136d6.25.2025.10.01.10.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 10:19:03 -0700 (PDT)
Date: Wed, 1 Oct 2025 13:19:01 -0400
From: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Simona Vetter <simona@ffwll.ch>,
	syzbot+48b0652a95834717f190@syzkaller.appspotmail.com,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: Add bounds checking in bit_putcs to fix
 vmalloc-out-of-bounds
Message-ID: <aN1ihRfB-GHTEt_4@arch-box>
References: <20250927075010.119671-1-albinbabuvarghese20@gmail.com>
 <cb00a5e2-6e50-4b01-bcd7-33eeae57ed63@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb00a5e2-6e50-4b01-bcd7-33eeae57ed63@gmx.de>

Hi Helge, Thanks for the review.

> I wonder if the image.height value should be capped in this case,
> instead of not rendering any chars at all?
> Something like (untested!):
> 
> +	if (image.dy >= info->var.yres)
> +		return;
> +       image.height = min(image.height, info->var.yres - image.dy);
 
This looks like a better implementation than what I had. I thought it might be
better to skip the entire row instead of rendering partially. I’m still new to
this subsystem, so thanks for pointing this out. I’ll test the suggested
changes and send a v2.
