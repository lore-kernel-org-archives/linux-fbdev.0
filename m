Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84CE158D94
	for <linux-fbdev@vger.kernel.org>; Wed, 25 Sep 2024 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251853; cv=none; b=F+sxkYTFPcM2VAaF0QwLilqSm8YpGzaAP8Kb6HeVbL67UmBBnxpdg1gGMPBMiyYl+L3sTY+GQtY2IBei1S06+XW9hOndBnNd6I/yARC+CEDW+4mqpznYOQbxTn9utJEnMGXOFv7hc8Ei/jPayfX/azsKWQNjefzAas6YEVtgKKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251853; c=relaxed/simple;
	bh=wUF1o3AkPJBZeRpaPm+2e/bxd2DtFAMDs4G51MfPD6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loRzeuR9I0WtK3b2W3llmcMUHuv89TC9At6o3dgxM+pyOYZblNeiqw1ZkdVUPpJYHqXkavG5YFAeBxy3DQqpny5kF9PnlFUQYBwXDBG0OYm0xXiUbhSDwEErVZDOJw5UaEyZUdi02D/mVlJ/dDNuOirb7RbADGxFVyOzhs8HRAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WYuGLM+V; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WYuGLM+V"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cc846fbc4so156412f8f.2
        for <linux-fbdev@vger.kernel.org>; Wed, 25 Sep 2024 01:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727251850; x=1727856650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUF1o3AkPJBZeRpaPm+2e/bxd2DtFAMDs4G51MfPD6I=;
        b=WYuGLM+VGJWvSPyNOagLMbdlmKCSV4IRITVCa1MxvIKkbZrI4IsGje8RU5VhD0DvCe
         aMxAc4Uc9Yde2bXkIkmOyFw7CV+IJJax/w+oDR3TvDDyhH8thRoCapDXf32eSY1vIM0g
         gtdzdx2J85Cxuj6ciSCGHKeBkYLfgCj/5Ou1HWD8i+Gvq+JGP7jCXlJ8h4L6lkjVOjhI
         SyUU8rt8rgvwWM224hKjkbP7mw/V2km7fmEFcohhq9eGRDmi9lIopoL2YYSSw817Ahv2
         pTTpAIzhIZuD7jDS7Q9pV0lRAXyQSdlr6wzQwC9E4X+AihzuyL2rFVCLD5tCpcVltBKB
         H4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727251850; x=1727856650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUF1o3AkPJBZeRpaPm+2e/bxd2DtFAMDs4G51MfPD6I=;
        b=SXbtVBwfVG7v3ipNHEdqclDVA3DQ4rZGTfP1/kVNp3XV9158pFrYquumhzXA9+Ro41
         IZTSEqycW8kJDI51YbLAeKfL+iMwtiGL6xIZOrwf7mzw4yJIn1lfA8bppGqFprgXqcbM
         n2QOuTKJR90FfhZYbnEmVJnksMQYM9Xtbm2AiQKOdIExCHUHAqi3Gg4BqlBtTm0ssJhs
         S7KayMw7CaL8Hd48I41o70L//0eSMauLXs/s7pKxHkgYzE5uD91D+gbdxXc+obZkTRYZ
         22IBJAgxjP5GyKOYwjxmssXx62X9MC20PPpEEZC6wLU5a2CACi2faTa0+BT1OyNhkGDD
         fqMw==
X-Forwarded-Encrypted: i=1; AJvYcCUtjXzDTkONBX/P6H2BSe1ACh58ULq/YamGnPN5np4qGeM2s0KWzpTizuzaxmVT3hOuoatL3YgqeY2FQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+OudyEZwQV8YLo0hVQ1Q02qERd12d3JHO8mCBT/QWWhTh0gkP
	vXHNNEvwBQEW9nrHVZC9XiXCkoesVWaMOPxlMT7RAfrP4zg598TUSZoVzqF0r0B7AnPXFeDYf1s
	M
X-Google-Smtp-Source: AGHT+IGn6GRJD8Rwx5J8w8ZJjTWua9r/sU/GDxbO3mmjVPsYbj0GV7sfKvfSRKx47UxiedbotWn/Jw==
X-Received: by 2002:a5d:4576:0:b0:374:b5fc:d31a with SMTP id ffacd0b85a97d-37cc248beabmr1185242f8f.25.1727251850028;
        Wed, 25 Sep 2024 01:10:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2c1eb8sm3308269f8f.42.2024.09.25.01.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 01:10:49 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:10:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Fabricio Gasperin <fgasperin@lkcamp.dev>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] staging: sm750fb: Rename function
 sm750_hw_cursor_setData2
Message-ID: <0125af58-3070-4ee4-bf14-f5d0d498aa9f@stanley.mountain>
References: <20240921180612.57657-1-fgasperin@lkcamp.dev>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240921180612.57657-1-fgasperin@lkcamp.dev>

If nothing is calling the function, then just delete it.

regards,
dan carpenter

