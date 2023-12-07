Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7LsDMQ0"
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8C01991
	for <linux-fbdev@vger.kernel.org>; Thu,  7 Dec 2023 01:10:34 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3334a701cbbso711606f8f.0
        for <linux-fbdev@vger.kernel.org>; Thu, 07 Dec 2023 01:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701940233; x=1702545033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kVL972CQGLcSJW3AciqVNZzuMMM19Q2E2yNZVzQKrFU=;
        b=T7LsDMQ0s5JLoluO6QFHAxDThv+MoQeu9p3hHoYMrkSzroRouB0dkgXVXCF8inqfQr
         iUSq5tR4MvjfQbjByeHabTbT0FYtrCC1+uwMlGBo02a10h8B5HpYvYDimPHclgidaI2k
         p+RzOj0TdwcURbTHtP4NtQ8Adz8zLD1A++IElf6f7lrGrYEKho+gpzKWE848ReGy3pu7
         9iQNT8imBGN2DxZNmUaG3nnAUThD4qmtSkYduXQJVkSwdr5QMPIACTGWFeUQ9Vc1AFrv
         e9+O4AQC3pmYca5Av0kQFGoKdRz27UQ11wylBWHAqFmHaYMWmfXXEWb3LIZ9hGrqnYoj
         WRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701940233; x=1702545033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVL972CQGLcSJW3AciqVNZzuMMM19Q2E2yNZVzQKrFU=;
        b=NfVgeF5lDUUmbvuTZgR+KZ+P4bigIrVZUbrycCOxoLMuZKCj5uDul1mC1mwMF+kRRI
         t2zuSld+xF9BiGjXCaNZMnk6llkBM78YOFhY4KnDQ5oxDSyGDT7yHcoxS0huUXV23XNO
         tjnLw0P93a78cAqHvv2Xf0+KVt3CBqmavarvIzf5RUEjRTzWI/vYnlCBhrD5KL/TBgj8
         l028q50E+y9jr4EPVnwbaI7jQS+e34y09cjyGX3HKFJZjXPMM7kdbxZlCNtMh2iX7Ey6
         r2euv9E+4cD7QKutVfnjn1wR2ENOXctPATaF3h7JSENaYZRYxNXW/oYed53lcbJA5VHz
         9GEA==
X-Gm-Message-State: AOJu0YxUeoo2GlZLGZDqK8SHUIwiE+vaBHn4L6qM+a0MnGnRWBlsasmW
	McBwoHGqVBKoUZwct6xI2dINGQ==
X-Google-Smtp-Source: AGHT+IH+IApGH4/piJWGesyPfGeXa/LPQoTSHnDHwNL1K1eexST0rVyhW3P9trJFOjmQKc/vrkG3AA==
X-Received: by 2002:adf:fe8e:0:b0:333:41e2:6221 with SMTP id l14-20020adffe8e000000b0033341e26221mr911521wrr.102.1701940233141;
        Thu, 07 Dec 2023 01:10:33 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d5252000000b0033330846e76sm887112wrc.86.2023.12.07.01.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 01:10:32 -0800 (PST)
Date: Thu, 7 Dec 2023 09:10:34 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: dri-devel@lists.freedesktop.org, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2] backlight: ili922x: drop kernel-doc for local macros
Message-ID: <20231207091034.GA135517@aspen.lan>
References: <20231206174525.14960-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206174525.14960-1-rdunlap@infradead.org>

On Wed, Dec 06, 2023 at 09:45:25AM -0800, Randy Dunlap wrote:
> Don't use kernel-doc notation for the local macros START_BYTE() and
> CHECK_FREQ_REG(). This prevents these kernel-doc warnings:
>
> ili922x.c:85: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * START_BYTE(id, rs, rw)
> ili922x.c:85: warning: missing initial short description on line:
>  * START_BYTE(id, rs, rw)
> ili922x.c:118: warning: expecting prototype for CHECK_FREQ_REG(spi_device s, spi_transfer x)(). Prototype was for CHECK_FREQ_REG() instead
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
