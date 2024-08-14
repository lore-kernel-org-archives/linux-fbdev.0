Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D002901
	for <linux-fbdev@vger.kernel.org>; Wed, 14 Aug 2024 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627866; cv=none; b=oCoWYq8cofcOz3faDJy2tMTi7tvgNYrylMPvLifFByfcDqaXu+GTvbtYwtkju7CnA0M3bp/3angdjmfdOwf+YX3BiEpp0kkNmRgCyLxv5Yq26IYSs3ZHMXW/qjb5rNr3NSEWWLUF7ZchJRd4WDQ5nUzE64Eq4kCCMe44rEO3+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627866; c=relaxed/simple;
	bh=WsbPGLgwwh83fgroesz5EICrOmcuHuYiV+iKp6kCNGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzJfO6kqDWpl1M7PlaoM4ONrPnxIGguyk2DI5bwkioVVF/rytM3oCv9Ed1me0aO1ef1w+9L4btueMcwo8hs8CIRlhbGadbiEmIKhd3VpBUOEuj69PCrJCZDeqPVWg00b4mHNi7eal4dSRQGO/hLfTe9MrJgrRZNoHsNPUJ5PdYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XFNNVm4l; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XFNNVm4l"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52fc4388a64so8941617e87.1
        for <linux-fbdev@vger.kernel.org>; Wed, 14 Aug 2024 02:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723627863; x=1724232663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+KbS6E5jHMJIDLTLixLRMsMiOWTcgBIJLTFtv7w7UE=;
        b=XFNNVm4lDEd+wKF6p/DzS3b3Iv+1/nqg0v4Hl1SraqkcOln/m0jd009VlFE314cqmZ
         XK0BXqBY5gPa4yEGnJsK24j6ncIRtmdCZTSFd9+rqw3A+YHlwMFcIkr04GOlobVnbtcn
         jPp9wexhBmlBel0KO63Cls3uzdyyZPbyfoVnkkafZPXX4xeW3D6HvHF4DEdTydjvVRoW
         QG6bo01qvb6fobxSD+9W0bIiCvgIvzbp2XCuYo/iBNH1K64rJD7etDe2dE0Hchq5fTrd
         Ij+qGD2ZEtdK+N8KOO94UN96Y6kI0REvIU0w3QorVJk44QziqlfYe9u8HeyDzAzB/fQN
         unaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723627863; x=1724232663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+KbS6E5jHMJIDLTLixLRMsMiOWTcgBIJLTFtv7w7UE=;
        b=CAkiOZ61VcG5cCbhJUZxqc5MehUePddqebPCHcXaFVEiZojMSYIebhODbKjXFpfmpt
         MJ572VYW6IWR3Uc33iolAAj15rYMkCfMUY+6Ns4f10/FyP5YbKvpVTWUEnH0DGas9Qcl
         zn7cf/famuFcJauCagT57b/mtgXd7X3cTonkzXKxR19IeglMbcR38uRshrTtCZmur6M4
         3emAEMfyWwM9tDB/nOYXakfRW4NYz0JxcER6Hd1xSFNhDkUJ02hZywj8X2i+Xjh0w3Ja
         w9TJZCTqmc2QS4wNkL20pa+wd0QQWUH/aqYtsH6al3AAJFuDCz2+qa3jXxWFZeig/mZ+
         5ALw==
X-Forwarded-Encrypted: i=1; AJvYcCWzXp6MzhwvRB2KSPGrXfnZZNU2x+dBYgdXdA6iN5UqZef65iuRFborR7lQrs8/efYOqB6slpi+YpFuPrHLQCv+0uoPCctO/Y5ZVc0=
X-Gm-Message-State: AOJu0YyghrZ+8p4cAJWhLz/RmHG15Tfu6kCbBWvXuUZHAbvrmgapUYmv
	qI2TzmW4FlZg2cqz4y1QnvbO19qkJ2RgmHRhTl8YgbnPw9bivMSpOejPqoffi8E=
X-Google-Smtp-Source: AGHT+IGLOjNiO2yF+uZM/WShxzq79zjBJ21zqgaSpWhugas9BKUwHG0KuNYWyEZ1yCqqo26VlQTFIg==
X-Received: by 2002:a05:6512:1249:b0:530:c3e9:5bcf with SMTP id 2adb3069b0e04-532edc04875mr1103977e87.60.1723627862785;
        Wed, 14 Aug 2024 02:31:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded32538sm14023275e9.16.2024.08.14.02.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:31:02 -0700 (PDT)
Date: Wed, 14 Aug 2024 12:30:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vme_user: vme_bridge.h: Document mutex in
 vme_dma_resource structure
Message-ID: <545da5b5-fe99-41c8-9cc2-a5861a04ba2b@stanley.mountain>
References: <20240803001814.7752-1-riyandhiman14@gmail.com>
 <1e74a5ef-7d15-451e-8cb8-2743ef95089a@suswa.mountain>
 <CAAjz0QY9jDUx-URQTtdW3kO2mkfV4dhUsJhB9-k12SEt++Gp8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAjz0QY9jDUx-URQTtdW3kO2mkfV4dhUsJhB9-k12SEt++Gp8g@mail.gmail.com>

On Wed, Aug 14, 2024 at 09:11:22AM +0530, Riyan Dhiman wrote:
> Yes, I agree 'mt' is a vague name and doesn't convey much information.
> In this patch, I have added only comments to address the checkpatch error.
> Given your suggestion to change the variable name, I'd like to confirm,
> Should I create a new patch that includes both the comment and the 'mtx'
> variable name change?
> Or should I leave this current patch with comments only and
> create a separate patch for the variable name changes?

I feel like renaming the spinlock is more useful than adding a comment.  Plus
you can't really understand the locking without at least doing a temporary
rename to see what places break.

To be honest, we don't merge a lot of "add locking comments" because it's
probably one of the trickiest checkpatch warnings.  You need to understand
the locking before you can add a useful comment.

When you're writing the comment, your target audience is Greg.  Greg is
obviously a very experienced kernel developer.  He works in USB, stable kernels,
staging, tty, device models stuff, and a bunch of other things.  But, he doesn't
know *this* driver in great depth.

When Greg takes a look at this code, it doesn't take him long to make a very
educated guess what the locking is for.  If the comment has less information
than Greg can see on his own at a glance then it's just a waste of time.  If
someone had questions about the locking would they be better off asking you or
asking Greg?  Until you can answer questions better than Greg then it's not
much point in it.  Again, Greg doesn't know this driver very deeply because he's
focused on a million other things so it's not that hard.

Trying to figure out the locking is a good exercise.  It wouldn't surprise me
if there were some locking bugs in this code and you should try to fix those.
But it's not super easy either.

regards,
dan carpenter

