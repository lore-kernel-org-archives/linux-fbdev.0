Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E648537D128
	for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784375864; cv=none; b=k4S7Fmbp+KvILvWOPHKL6w/C/FDWhBhDrMN5sSF+s6F6A/5DIvWljXJzYjuxnzUiOo4yvGmuwEiBJ6+UmzZj96rOE7Tx3sDP5F8j2BAWGxvU2ad6SlaXmokicGjD2bj3LXaClYJHCvQnyVjSTWwaKSXlmxF4BJ8hO+qYEyRYUCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784375864; c=relaxed/simple;
	bh=bRZ7r5ito+ISYPPpW3iV3q8jRne4kVIXg/UH5tYXNOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXRp6laGw248k3YDhA3GQAvTZ66jClnAu7b8jqfQrT23j3ZhSee0Bn92rivhtJcwCLSZluICSnSi583bBXbw2+/SQ+NlI0VZKpfqSLcFf+9QIzVNK+G+7z6biXNrjw4rXR3nG5h94/Q0hOgZ8/9FYEY+vhuwOYS+WW8ZW6XnZ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nV2CgT8F; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nV2CgT8F"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7eb787dec99so5152032a34.0
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 04:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784375860; x=1784980660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3/gVjW7F0KtjB8QhqPU1YYK9NmfO70mkrphRQOGidpk=;
        b=nV2CgT8F4LupCZyW1367FJg9CvVgtvvviVahWhTIHCUP0I79SbUghiyVhs7dsAmYjH
         qoMgNrP0LlI59LPAfGm9qJicr0ieR9ZT97U2hAV5/E4PNapwVw69ZtElA7PEZVH4xJpv
         LiU89dbR1WTE7r7Q73P4/+OtMg12RLL5Q8qMiDyiwujQBxXxfc1awIGCiCB0fgpvOGxI
         S2zLenWpen+2w1KMcu3TxCoSJV1wLz0wBTbcHHUk5rvkrb9dZKf0JMZcH4DJJ1SqfhCs
         VkTSCLnQfgoJ8kWbXmXYfRRcGwtINi617PGAYWPb72b7g//z4oLVGK8kV3J1+ulHEFzq
         Zj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784375860; x=1784980660;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3/gVjW7F0KtjB8QhqPU1YYK9NmfO70mkrphRQOGidpk=;
        b=OJhuSRCXo40MPOvcedXNvTy17rma8OcbGAkpfaU5Sp845WruvgDVYZnQZJCsrvinvb
         S40izCkgeyx4850GbErTc9JYTy1E13S7hiGdvfA+wQEHdCwA+xfTwY5WEtlbfAz3/46l
         PhE5UgBLtY47GAaTAfHQ0g92iAGUkid9BkwJHCXd/JrCefQ9L6+p5KBwtOWXB8DAfxC7
         jkNtLNyhMTmcsBNg71pmNUO5W+YdjOZZWarBoKCo+dOpYy7Gn0cp37kjo94BR425y2aP
         11evSFYkDj44GmY2RqOCfE/7j5GsyoWASuO8hiDT1NSAtxclqXfpWvd8kpLmQuT1jKQ6
         WhuA==
X-Forwarded-Encrypted: i=1; AHgh+RpswOeF5weD3D1FUOxLNBhj7Z5MicCwXIDUEvTsuE406Lq1FpT3hywq5tVRoLyxbLdhsXZOuXnboD9Wmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwGnkwgBtrNpxArvNSz8gDuz5eMYYZkMEG68i4gZ/e4hu/jiGg
	d7Rck0XC+dBuwg1kpFDAHVwMPMYRL6NbdOt65KUEskjS6hlZUocMebJ/gGJ9m1wEg+U=
X-Gm-Gg: AfdE7clrUWuQI3Ty6A5k4iBLTJvBdigyPjnwko1cmG7r2P9dePGrHTlnJl2uqvwDqrL
	vSTGXn6XqpFf5z37myvyJHCfeqYE+zPu5Ip8BH88aN7qN8r8Jol6dUmm8CTuqiY0KB6Uns5hMZ7
	cSQiw/q2egyYtYdQepbunRCMytaPXhk8XLQaBK3a/D6xozmtx0PnFszKB8WbpF3CSAxdbPG4SC5
	nqhRjDUX8HpdPsy4IKMll4VTO0bzGy3NAv4RjFd+WHkCMbaA22Vk1EecJj9tTWPpYwGn8ERGGKu
	MPdjxG7gPVNw0/eTjxEds5nMwxU7RudqFRbo+3vAjIt/rlq9VhyFoZO1pwo/dmm+qNlk1bYWhol
	d8SQWHXcOie3CO20G/QqAKb6NW0HbJ3tBmbgS8LanrB+tdrhjpJ1g1rtBPkHhvoB59faFLQ==
X-Received: by 2002:a05:6820:151e:b0:6a4:cf9:9a69 with SMTP id 006d021491bc7-6a5366c922emr2917108eaf.20.1784375860437;
        Sat, 18 Jul 2026 04:57:40 -0700 (PDT)
Received: from localhost ([74.80.182.90])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a516c03f36sm3343831eaf.7.2026.07.18.04.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 04:57:38 -0700 (PDT)
Date: Sat, 18 Jul 2026 14:57:32 +0300
From: Dan Carpenter <error27@gmail.com>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: fix mono image source stride
 mismatch in lynxfb_ops_imageblit()
Message-ID: <altqLCKzCdGLaMzl@stanley.mountain>
References: <20260718103103.18082-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718103103.18082-1-meatuni001@gmail.com>

On Sat, Jul 18, 2026 at 03:31:03PM +0500, Muhammad Bilal wrote:
> sm750_hw_imageblit() advances its monochrome source pointer by
> src_delta per scanline, and computes the correct rounded-up stride
> internally as:
> 
> 	bytes_per_scan = (width + start_bit + 7) / 8;
> 
> Its only caller, lynxfb_ops_imageblit(), instead passed src_delta as
> image->width >> 3. For widths not a multiple of 8 this under-counted
> the stride, so the source pointer fell further behind the real
> per-scanline layout on every line, corrupting the rendered image.
> 
> Rather than just fixing the caller's calculation, remove src_delta
> as a parameter entirely and have sm750_hw_imageblit() advance by the
> bytes_per_scan it already computes for itself. There has only ever
> been one caller, and that caller was passing an out-of-sync
> derivative of the same width/start_bit values sm750_hw_imageblit()
> already has, so keeping stride as a separate parameter served no
> purpose beyond letting the two calculations drift apart, which is
> exactly what happened here.
> 
> Fixes: 81dee67e215b2 ("staging: sm750fb: add sm750 to staging")
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---

There is supposed to be a little note here:
---
v2: Added a Fixes tag.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Obviously there is an inconsistency between rounding up and down
but without testing it's less clear which one is correct...

regards,
dan carpenter

