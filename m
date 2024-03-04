Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4680376E6
	for <linux-fbdev@vger.kernel.org>; Mon,  4 Mar 2024 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548950; cv=none; b=pTKJTt+G60Gih8ssgXUydZtYBOVy9F4gLGIYItSGIUT6tBpe0tRGEmkfyMln10THucX23oA0Ovra88yWVTlMD03GlX8ObwlFbMwTLrQQAePpYWl3A25q512+crA/MzsJrvCvCgDbzH/pabWiUxBbrzCqHLNAt+jDNyU7s8EDes4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548950; c=relaxed/simple;
	bh=vjmJ3VVomkutMCjUxnHOro2eYzLmhZJ6FnvYbU/rEBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUA8VO766tt3jMvxb42+WbNYdvS4K1u/vrvCKczbh3cp+WPcYcVGuqt5OsyQDVAgH70gVhqxo5H/XjE0ofArOI7uUbPn0pJKnWlKG0Zo5hoYUy1i3/FG7hUGZHoPpLAxZrLzxBpQ1mzRj1pR2mUhr9La8fUCiWY1HXM2z/KZOlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OQq472BU; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQq472BU"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so59125991fa.0
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Mar 2024 02:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709548947; x=1710153747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vjmJ3VVomkutMCjUxnHOro2eYzLmhZJ6FnvYbU/rEBo=;
        b=OQq472BUvBUol2bpsEKZrEhNThhAmU/DdyMmNiYmbc4HanLroOE62iGRglttOypDKv
         vZYZCaV4eCg406tauw0onm0FBXmNKZ1CrtyN1ptFfGD18+wvSm76a+++/nEC9KlquuVH
         7fnOs4GSwZqZSPRG6wikboleW7pFK4r82gvfcb6o1k5yC/t5ZyqktH/hDUYToIHsg0Ay
         D5h5VzB4NEJvGIwecrNCpweUUd+eQ+9LizQi/zlzRTFvpoIQiax+xMbH5g7ZSP9bjuMP
         A0n8oMkShnMORZlmhIUhwjJa/Db5FTsX510ljvUULC64dVdoQDnVCAFGJSgiopsM6xR4
         6qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709548947; x=1710153747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjmJ3VVomkutMCjUxnHOro2eYzLmhZJ6FnvYbU/rEBo=;
        b=HmZLTXPwXsJpyobEnRU39OnzYXAcr8Ji5s8fS/Mz927XHppiX7nMY3BgcGZ+spu3mM
         VcmnSlq5xUSzeFWvw3VpsfVa7nz00g3LHDf9VPyHHDuVwuOoZZFymR7PlmOPu7nczMyY
         5ZcgEh//fyS3Y08YLtPUkLEz+ggtRKXm7rXLIcDt5ApA8SfpertO5vk5wB0oKZncLGu1
         FexRDadc9VQMyI5GIXqz0wk28GZrGny3C0cm4S8j9K9OPEtTJOn1Ftjpod8XK6mEub9U
         pYlyWsPB1lxwlt5wQpCIHQnhOrsi+Vm0CIxBkp1/XbHX/NJaP6QJj/AAG3TG4bIa3wBv
         Hq9A==
X-Forwarded-Encrypted: i=1; AJvYcCXH+5Q+lziuUghi5txp0oocYmfZ8SaTtavNo7FzAtRYgkYY3DLANY6JZmJlnNnABKhfLSGSCv/mQ5ESqrOX0oumPHIBXawlvv95iFs=
X-Gm-Message-State: AOJu0YxiWxe4OuGUcdfrBritcXn4b5R6XUtShd3uliza8jQMgXJeitXJ
	/Z15X5rOGlgWrLxJkTrEEFIo9OqCERpZ6XPaP9mGGYMr4i3KP+J8fowe5SZzlF8=
X-Google-Smtp-Source: AGHT+IHtvy7qmcHQLaVLkUnxVi4LgTQC5QXqMaha1pxVW9OFHezE7iDeVI/fRt3Ls8gat7CbfyqlAA==
X-Received: by 2002:a2e:3306:0:b0:2d2:346a:f199 with SMTP id d6-20020a2e3306000000b002d2346af199mr5394143ljc.47.1709548946966;
        Mon, 04 Mar 2024 02:42:26 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b00412e8370a93sm498803wms.27.2024.03.04.02.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:42:26 -0800 (PST)
Date: Mon, 4 Mar 2024 10:42:25 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] backlight: as3711_bl: Handle deferred probe
Message-ID: <20240304104225.GD102563@aspen.lan>
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
 <20240304-backlight-probe-v1-4-e5f57d0df6e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-backlight-probe-v1-4-e5f57d0df6e6@linaro.org>

On Mon, Mar 04, 2024 at 11:11:41AM +0100, Krzysztof Kozlowski wrote:
> Don't pollute dmesg on deferred probe and simplify the code with
> dev_err_probe().
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
