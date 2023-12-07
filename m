Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dppiFzHN"
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB0310CC
	for <linux-fbdev@vger.kernel.org>; Thu,  7 Dec 2023 06:28:48 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-332f90a375eso1009523f8f.3
        for <linux-fbdev@vger.kernel.org>; Thu, 07 Dec 2023 06:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701959327; x=1702564127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=siQf2yGcuKbINax/017dn/aIzi9vyOaDmow1c81WvIo=;
        b=dppiFzHNRvBHRoMiYi5jk2GzYB6GsoLQTdKJ8dCLkQgVj5pm/StwLPvc/nnYv0d/EL
         w/CqYxrhNHT45sm5pI0Dm/V897m0gXFbtA5BOW79lq6gbaOprwMMNr+ZpiUlyxBA1epf
         enfAioD9O8sUIfX93D/6n/laxLPhhvImvznstwJ4f+1iUe4+AuKA4TSAbzLq45CH40mc
         AFX/k46CP6opKA9vGgt9DiAfkW0B/rfu3o2wffoPa1k9s8cveQczvLfzTv/zQaM3xh9u
         4b8Ls4AmS+Ge9WEVnBz+YD2SZ7u3BHCAuzXu9aSoqCrxTNavD5Ol20q4+KgUcbvWRbIt
         G81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701959327; x=1702564127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siQf2yGcuKbINax/017dn/aIzi9vyOaDmow1c81WvIo=;
        b=NCZc/32qn5uHCkiJF9p9p2fZFAFQAMsOMqBiiIgew1COuFWwHpVkOEf08/LqYdgWq5
         lmH6y/P/JxsZlsKKF94RK4C6nbu+yXStPIWcamztxu93VJ7qzUZRZSF36csW/XcPw8dq
         BW0glABr2Nsr2tDWyq/bvfiRgmkQnfQehBGiKkiUKrxHuhcuXUO9zPJDzYy1pz/oQDVY
         X2EgG1LSG8Xc+ae4su6kcH3+Seyy4g7A5QBS1jnMqNMGM2dJCLqnO20IdKGC8tOFcQ3X
         90fmciKy45o2a5fVe45jFj8UCDzCjgBd63hBSvfn8iiAkZ/fPRT1HgMEfG/Eu3bnx4Nm
         hPiw==
X-Gm-Message-State: AOJu0Yx3UHeo7SUTQKSm1wMrh3Sn4L2Hc49g9fGkMB4zdhkHDA75LuIc
	POi8ruMam3REifZtecFvl+DbQw==
X-Google-Smtp-Source: AGHT+IG3fjLcVnbgN/JM62HKhQ/CpsfIghOkkqs4Bf6SrVZBPi1Z/DUH73yzVRZSk42YeYyrPH8xFg==
X-Received: by 2002:a05:600c:a43:b0:40b:5e59:c58c with SMTP id c3-20020a05600c0a4300b0040b5e59c58cmr1686676wmq.182.1701959327359;
        Thu, 07 Dec 2023 06:28:47 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id b16-20020a05600c4e1000b0040c310abc4bsm216659wmq.43.2023.12.07.06.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:28:46 -0800 (PST)
Date: Thu, 7 Dec 2023 14:28:44 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de, nathan@kernel.org,
	ndesaulniers@google.com, trix@redhat.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] backlight: ili922x: add an error code check in
 ili922x_write
Message-ID: <20231207142844.GA151182@aspen.lan>
References: <20231130051155.1235972-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130051155.1235972-1-suhui@nfschina.com>

On Thu, Nov 30, 2023 at 01:11:56PM +0800, Su Hui wrote:
> Clang static analyzer complains that value stored to 'ret' is never read.
> Return the error code when spi_sync() failed.
>
> Signed-off-by: Su Hui <suhui@nfschina.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
