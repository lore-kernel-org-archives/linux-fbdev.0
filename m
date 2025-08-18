Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E020131770E
	for <linux-fbdev@vger.kernel.org>; Mon, 18 Aug 2025 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508590; cv=none; b=bnkCiZOxv0nKSpl02Ldkn2rDHA/oC1fthzyNFFgpW5h5Gat+vSz/5GtFaG3NzWrILRfFYpvWDSLm5Kj1TLj77dSBPEwhcozdjeR6qcKKvzrJQlgj6/Pmsz7h4qeYOdHXzVWcy+XIBNtcx10BOKyp/J2iNC5dB1YjGs6hHOAG8TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508590; c=relaxed/simple;
	bh=5uLKx4iguI8kGPc2AmysFSfdfkA+TlT9pFoZ/+x9ucE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGvu9unQe1qS5/fqb48CSfBxUq6+wJUoDw8kZZ1rbirPIdjihK1wQC6sQk0N6lGEqiUuP9fJSHKNXQ/jisj8DQJar9sMajXbz7NQksihwieceABbhHSOEB6/ep0ziIMYvWODhIjCfVfOxaYrTZ3NZAlJdaTjmhqv1U9cbdB+hHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=YAovJyNe; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="YAovJyNe"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b05a49cso27864695e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Aug 2025 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755508587; x=1756113387; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5uLKx4iguI8kGPc2AmysFSfdfkA+TlT9pFoZ/+x9ucE=;
        b=YAovJyNe5zxCHo5TBYl+UL2QOQpuegFk98rMaoLockEF0tq5DvbERP+oqzYpvV4nDF
         LZsGPCjaW1J1irUFntNGJxMHACEOzA1bo/goGCwInAp/qPWmba0yAhDaxRx3zUgZlxrG
         eDTp0BmstUD5QWGzLSM03ZfOH/Rq7kAmLnhKFguZtrsmu6yXEQZkQLhRTgLxGAHppv3v
         BpJHG+hvJKL/LroFUL3NTA2DGdFA5HahKkS55J3nA+X/5ni8oRUK0rAabyhEbhqub9vz
         xmgdKHeMghGJxm06tgQu+Mhy3ZiW8UGN5ecNTQNxmMYFHYVp0xChCFvMHiLYaz5LHrPD
         jUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755508587; x=1756113387;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uLKx4iguI8kGPc2AmysFSfdfkA+TlT9pFoZ/+x9ucE=;
        b=dwhtdLNt/xO6J52gyMtshAcQP7LPhkOiQjjwOfzMfa/dG7TkWIPN7RWOGP05HJvLj8
         SMS2bly/vX8vYtxncCVeXkubCZjaAUyXpmaHLtRpiSl519aNNIQyA+27hWZZH6RZA9UW
         06W4nVGE42o7DAvtnROe3XegJtvJHh4UEo8UTvEkR/PmAv/KkrODyKhx8LltY+rTTXPZ
         v3xqaX6DS0DUbHKY09aoB+U6fqq2mvPkJc8lCzt/PIbdIFwEFE7cpI+FP8F0BXGMmq6E
         5IIoVYiyW+4kpm8gWuqClV7Ltw194bSaj/O+VOkCPTnuez5vT2YVINIn3z2JRVHvNrjn
         GjNw==
X-Forwarded-Encrypted: i=1; AJvYcCWVCDfJpZkymf91C4kEB1qPPfmwRm8gRdMgEvi/sByu4IYLcQ1vYKp1LpfIg3sdC7ipU9H9h66GH1tpOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ9RCfL89FOoWsfDA43/hcQIDD+xZuSrLT3FEYIxZBXPauoVGf
	n+8RL0Hu6urJp6FJxV62lQh12vwAeLcTschvxf+VNgIF6AZ3co8V07bB58cV7fAWnJM=
X-Gm-Gg: ASbGnctR5dAA/IPMdS/Vfwmzp3chV9iKZJ0gFSUSXQDnSmoSTiQ7LHXW5qAAImcFyHu
	U8r3ntxHj69cq3vrkMP9BoZTZDc0sh0C5ps2kWMbmYIAk4/v9ENnAxr/r4I78TwXEc0VDcvx3UX
	O5KGFM5oGkEA4cL4SXUHZQxo5jVloEw6e1zgVOFyrjOiH4ss2/ve0AuPRpfhuqt8dW4YQB8IdMI
	jfOKoL0SN9uusdcMpF7eHNmXFI3uFHr15XsXNEKq7n8oN2r7/FlGWgdy7ohAjZoSvwf00FCIiz5
	b/yQnc859/XXiKzEWsh3EFl3NZz9hfvdCPo0Nv2JEdT7XRMVHy2EbAajBocTK0RJkfa8kw6Je41
	jswUkX8vv2K5FwoyjczZbS1UclKmrx2FS6xYyYSxjY1k0uC53W7FhrWAVG1XgM1rgARWG3UylQz
	sDsxaLmQ==
X-Google-Smtp-Source: AGHT+IHDUhr5tbZW68XtBaWVE5750X38A7H/faFXckj5O/o+hqZwSOPx/6BzSCyybhISbzqKROogNA==
X-Received: by 2002:a05:600c:45c6:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-45a2185dad9mr83576675e9.25.1755508587052;
        Mon, 18 Aug 2025 02:16:27 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb68079341sm11907856f8f.50.2025.08.18.02.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:16:26 -0700 (PDT)
Date: Mon, 18 Aug 2025 10:16:24 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Flavio Suligoi <f.suligoi@asem.it>, Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: mp3309c: Initialize backlight properties
 without memset
Message-ID: <aKLvaP55PIVhyFSc@aspen.lan>
References: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
 <14514a1b0d3df6438aa10bb74f1c4fc2367d9987.1751361465.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14514a1b0d3df6438aa10bb74f1c4fc2367d9987.1751361465.git.u.kleine-koenig@baylibre.com>

On Tue, Jul 01, 2025 at 11:22:37AM +0200, Uwe Kleine-König wrote:
> Assigning values to a struct using a compound literal (since C99) also
> guarantees that all unspecified struct members are empty-initialized, so
> it properly replaces the memset to zero.
>
> The code looks a bit nicer and more idiomatic (though that might be
> subjective?). The resulting binary is a bit smaller. On ARCH=arm with
> an allnoconfig + minimal changes to enable the mp3309c driver the
> difference is 12 bytes.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
