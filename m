Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF5B3B9600
	for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051277; cv=none; b=M95zU5/fLGxEzTyUjyueZRfLne8VQs2xqyuFwIhNd+9n4gS5bgOwI2cO123qKrn86wWABN4FFNl1qKAX4DcGggtfN+jFvTcSc6kTTV4KRcOVrPVyI30xB+DVv7llWFutYbgBP14P9oZ8VYWHr0xDPcrvrENdZEucwZfyJkHKl0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051277; c=relaxed/simple;
	bh=oHKZ7aZuBlsJtJpEtPqvcdM7AnR3aUHFHT0UZkB5BHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaM4fjKnDA2PxGHrannP5QIfcIlbdhtKUuzuhw1WaDVG6KqnigxG/fjbZ6/5jY0bjEiFA7ZpXNv91rsE7ZGwP/seG4+8d9rPB6ZIkL4Ten6CkYkI+PsE4sswgQeZFx/amye3s7PbNg7tif0s7dIWS6dMt7Zt1rCrpiGW2uYS4cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rqJEGbBX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqJEGbBX"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso60618425e9.1
        for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 03:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780051275; x=1780656075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqhodKoFqMFPzDEPcNHt1DpRqaaJn5LAtjO9WeibWTM=;
        b=rqJEGbBXQ0jeA80icbx42mLnrGCK9UvYglOS0Yd7SOETrV8LXgHKNNBf4jjXbEI8Ih
         m3UCak8MxBIi532w9YxxDACxmsqNWDFb7w7Q4dNJpk9mKTpjVsBkFrK+PC4r/hWNxBhJ
         Ph+b2eFjzfueVxFllM2GoCbHtk2g5a2bmAUhnmgTpD108LkuPu9FY+Poof8y5kLIKMWC
         CFMxT6QWbd8HzNvZCxN214fogKaT4qnel9gfbKh2zFOAkY3rkUor7JEMqFYhCaEkzf13
         /tpv8zxeEdCBBf15EEGhJ0JnDqKMkZBbc8LYXe0188QxeZV8Lglvf0MIlLMgUG4afwgs
         3fUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780051275; x=1780656075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqhodKoFqMFPzDEPcNHt1DpRqaaJn5LAtjO9WeibWTM=;
        b=VXCaMiaaKL5d2Jb3MwQUqkeSeq1v/RLpzf+AIhHZ+3CG1oD5PTYCBegiwxAaWKVjsz
         vD7v7Ju/QROXoLd4dhDUX+NYPuFL7pkuRiZAfPp2xKmCELMDDzXsI90REDrOMUk7BPqo
         dDq5sLN0mH4BPqMrdpmPVDIN3FOLobaEZlPGsR064q5r+FZ351KHE4cwQPIP9Gk6/n8Q
         gLQeYN6r+arC8LNnEBchSB6INigpAKKM0IjgfumUHP+tGG7LxC38t153BVP+9rq0FJEI
         8A2AQLDpnaDrMlizx4sFXr3hrxR46YP//M0qPdQC/CgFc+QULOxrfdRitE9fsOC2zhI1
         XJZA==
X-Forwarded-Encrypted: i=1; AFNElJ+ewetCXQmFwiTQNwj37+ASbnvNo8zFeLb3MgD30mMaCi//i6x22DgrezWIaHGsGz/EB6nd2l3Zv/mnlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWhvw+ouScZKaNgez+OVDeW44HbUP6pELDD4dSNyJB/XsxI8+L
	bNC4IqGXlR6tY3y3tmhkErH1Y4EqsCKAQYXq0bHflPJEpyIKe8TRBMjmhZsJ6Q==
X-Gm-Gg: Acq92OGoC6TmWflOi/i6MAqpdmF7rKTo9LqDULkc8+vOpa682KHqdw0JKufokkKc50V
	JXhUGMvtAHHtZ2zX6Ub161IKZBhHjXe2+7Zag4YDs7vy1B+Y0tnJ7QESN4Iv9FSZurKVFZUcoIA
	Rrlsm2gTsQqzqAkTP6KW/5UFzUioJQOWYJAZpvcErCns5NsepIwH19s8Zcp7PtDK3WFLsFeJ/JE
	5XpXc3gbWOuFZnKhzCBePCQ4jRlLueLBdCCQM2E/cKYCqoo9s9YqLlTVRInKfOtgRUlpzUlUXgf
	xFX9bj5pkBZxpiJeg1l3xQCh0LDCc6WeE5gSaBV79LwmgPh/KCp32seDlMFf8FK6w6hZ5qUnTWO
	JXybePhx1HT5VPXE2JI2Iy4Cw8K2VIZLPf4WnUy2XhPKUuDWzG0MW2ZawDjuDJRTJqNSqGM1u3e
	pHGW5U0ciGYRD3J3IwVZNzcRa7EF9OvtiTmg==
X-Received: by 2002:a05:600c:6287:b0:48a:7676:30bc with SMTP id 5b1f17b1804b1-4909c08cd89mr42255635e9.14.1780051274994;
        Fri, 29 May 2026 03:41:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0a4dc0sm17471315e9.2.2026.05.29.03.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:41:14 -0700 (PDT)
Date: Fri, 29 May 2026 13:41:10 +0300
From: Dan Carpenter <error27@gmail.com>
To: Onish Sharma <neharora23587@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: rename pv_reg to io_base
Message-ID: <ahltRvVgehkgvDFx@stanley.mountain>
References: <ahhN_kiSb-yRWfiI@stanley.mountain>
 <20260529095233.9015-1-neharora23587@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529095233.9015-1-neharora23587@gmail.com>

On Fri, May 29, 2026 at 03:22:33PM +0530, Onish Sharma wrote:
> Rename pv_reg to io_base to follow kernel naming style and improve
> readability.
> 
> No functional changes intended.

Run your patches through checkpatch.  Also v2 patches need to be sent
in a specific format.  This should be [PATCH v2 1/2]

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

> ---
  ^^^
There needs to be a note here to say what changed.

regards,
dan carpenter

