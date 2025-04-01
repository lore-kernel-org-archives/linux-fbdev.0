Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C932046BB
	for <linux-fbdev@vger.kernel.org>; Tue,  1 Apr 2025 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743517791; cv=none; b=k+ufHqxijOyZUbU4OeXRsgxH7d4Ahdt7ztndtTBIgA0OSlsJgJmOqEcdHVTowc0U6jK8iDNfysMiAE9l1DeW95WPjTHV4JC6vyvD4E5a9pvkmtho8EXjfgIi5s9MoP1xmmRbF1rQkOKk0wMnE01Yj5pyk3/K4xU75yi1Mbfsx+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743517791; c=relaxed/simple;
	bh=4+DXyGZpy3baMIIEpJypfdpYsotPYKsxA3mI/UuDijo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U64679HS++K1BPgMk2yht0qiJyTeeFB3+zMYgfGfwj7AU2NXurg8yktFSpPoPbDftibpo1czVqKqaToA1tzjnXYaXNA5NMwnhVqBz6QjJLUddNOVEKZBIoWoUoPU9zQHbRHsZ83mq1pWkTpDbXNZLFfCv+iYtcxVcDUP747v+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=mGTjgFrW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="mGTjgFrW"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913d129c1aso4098069f8f.0
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Apr 2025 07:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1743517788; x=1744122588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4+DXyGZpy3baMIIEpJypfdpYsotPYKsxA3mI/UuDijo=;
        b=mGTjgFrWukuCgEL1V89KWiCBAZVaAwkfyWfauRCvEJmnXY5lHfl+spBQxEiMyKK6fe
         dkfqaWxw3weMe4lRZ0SyTzMNg2+nY4+ZD1YhiMH3lMXF9lFZ+WjvgJAWQbZKLK0wKZv1
         EfzkhPpIHr93ggh6ADw0H6f0usvjyhd6tNThiu8VdrJWJVYOzrwCRYW0PmYONL/okXlV
         otpSUU1h3Vz9Uffo0qLBoD85WV9FiQO8sAfyjCLv/X9mybzyJQShC0jtjElLthqPtO3r
         L6bMncHQR5tCaQ5daeBc6i2fsB9T5lRyjfGfxnhRr9gu2yEjTe3TaqXzUrDWXvYcVhuo
         sijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743517788; x=1744122588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+DXyGZpy3baMIIEpJypfdpYsotPYKsxA3mI/UuDijo=;
        b=PGtk7U/mwuZauQQHFGSTich8OYK17rVDPtGlmqMvopdMt7DcIrTuU/4cEQ2FHXscol
         sJpQtjiQBh6L7FtlTC9Cf7fXkB65W5n041FHYUVzgYbTujHWYgGatz4p06s1d8zVyeL2
         Ij8G3ThXmrEGkYEVtVrNIhvT7z0+qZWJFYgMCZtvJWTyTaG/D10mOfuWuKZegCG3qEwM
         6PHEWt7Cuh75qOzEf7JWa/N9A6DK6RiB8FpE1o/iR7naU5GZOwlBUA0XPu7eBtDV1i/c
         SxdIlRj7dex5DJj0LYg+XTMcY3pRlkSVRSGUWNTFCyLd5iM5odKCOOBc+YSq6HIE0EHX
         n49Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1VMFLojGAGYuyCNXjUxrNlim1sH+6hW0YBlr4mCyxyNo/irriy8JhEebX78kYdsNyN9xm4BxH/NFqXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlpKsHmg+iG2VGcp/S82iEOHFLs2wpvyPWrzThwpBZrspEDdyd
	SyTsfBVIhoqSSSy3nHiFm0FFz1FXYUFScqFBReWMJF57t40y3yFLIPbv+DrTRntKs+t2GBWGqNC
	BL28=
X-Gm-Gg: ASbGncteKprHCbxvNKg4pbnjXj2s9jw0d32mb4sYJiF3fK9OauVhglAjjxC4H/D0H3F
	eDcii9MSgNryn0yX+kJpWpP570l2Oio3PVh/48ZUfY4aPaZlGSgeP61fa4kRd7zvNq6RJRA1v79
	l9pF+0zmQG2NAvg1TjwnhiE37XluvV6mFmyd4FGgEHuMobb5g4cogTffZ78xp8gVLmzZsLgOtqd
	ceLKeegx7KJomvnwI9e2VLrcYc8svxtr089KPC/pHnml3uQcrQEe9+skh7/U1a2Pdf3yei2EdST
	CxdjCTKCU7N6rEfcu8Gn7UNUBfGu208hthUDo7R1QLpmJNM/lqkKXudSlunS4SHkJrDAoIgfAhG
	4bLhH7oH1xbuLgWdP/34YGarvKLA=
X-Google-Smtp-Source: AGHT+IHNx4vQ9HZX3k4j4jTP+pXfpW+zl8Y4RdgON0AYVMnFWqF1w5VQnDHa4fobYb4eHhHiNIy/Pg==
X-Received: by 2002:a05:6000:18a2:b0:38d:ba8e:7327 with SMTP id ffacd0b85a97d-39c27ee84f2mr205051f8f.8.1743517788210;
        Tue, 01 Apr 2025 07:29:48 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b66a9d2sm14254936f8f.43.2025.04.01.07.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 07:29:47 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:29:45 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Haoyu Li <lihaoyu499@gmail.com>
Cc: danielt@kernel.org, chenyuan0y@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
	jingoohan1@gmail.com, lee@kernel.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org,
	stable@vger.kernel.org, zichenxie0106@gmail.com
Subject: Re: [PATCH] drivers: video: backlight: Fix NULL Pointer Dereference
 in backlight_device_register()
Message-ID: <Z-v4WansLWJtv9CV@aspen.lan>
References: <Z65fFRKgqk-33HXI@aspen.lan>
 <20250219122950.7416-1-lihaoyu499@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219122950.7416-1-lihaoyu499@gmail.com>

Hi Haoyu

On Wed, Feb 19, 2025 at 08:29:50PM +0800, Haoyu Li wrote:
> As per Jani and Daniel's feedback, I have updated the patch so that
> the `wled->name` null check now occurs in the `wled_configure`
> function, right after the `devm_kasprintf` callsite. This should
> resolve the issue.

I'm afraid this patch got swamped in my mailbox and I missed it.

Worse, we've just been discussing and reviewing a patch for the same
issue from another developer:
https://lore.kernel.org/all/20250401091647.22784-1-bsdhenrymartin@gmail.com/

So, I just wanted to acknowlege the mistake. Sorry.


Daniel.
