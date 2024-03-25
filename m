Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E6C18D893
	for <linux-fbdev@vger.kernel.org>; Mon, 25 Mar 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363821; cv=none; b=PazWq4TQvWabvaJH5i3TNCSrNan+IOmDo6YmLnOaZaHni2O8jyHXXFnNlqgUTcYwkwzUz/BNFtlfS7pQCSo8/3lR4cAhCIW+g56wvS1T6U2ofoB5OcCf9PO1l/7Z56+tqDWttWigFncjpjYO08rnpzFK8qg1cdsrjVGyRe5P2nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363821; c=relaxed/simple;
	bh=XpSiYldKH5rIkhRiCFgClqdFkLlO1k1YxneIR82EqBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7MNpFTHNcSgOhe9Oo7yRI44soVun+YN4Oc5uD8qoGB6eGPJcmdOB5dqYct0dSANUuD/D3Acw+VVx4WV1pT5OmIlma5xyzjzkQvmed7FLFqeudkV9atFYyY4Y9NCFrxoShdU918ezrJlgBzLzcr+aP2+qGqxn2ekd9C/JzCRvLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GF3E4fxs; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GF3E4fxs"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-341cf28e013so350835f8f.3
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Mar 2024 03:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711363817; x=1711968617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XpSiYldKH5rIkhRiCFgClqdFkLlO1k1YxneIR82EqBg=;
        b=GF3E4fxs7ZgQHREtg/UvCmGvUR2sMSIhAmulkcBsUYdofEVT8Jsid0iVZZzYZvqMdq
         whsvXwQknR3OAo1ak6eI68kLYO7llUBarje3QIRXAeSfVj8wmfhI5oMqg8DE+JbVnM+I
         NHE9jMLjaMA3s4v56WfgvRP58wl0U6xOiuS0vvVbfLnO57Vt4ZoUf3t49HFA4cgBhlnQ
         rdm8QbnoKDxgnPvyFyCeyJ4Rm79CCjvmng+5Z2Z4nYvXGMzGUXf4CmTM+O+2AQ/WB22n
         ljdv5rbov0rTVB8qj36mR8NmuEFDUjGN/7bVIaJP4GvNgXtlOyvio1t9lJTcH6afEa7i
         6MgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711363817; x=1711968617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpSiYldKH5rIkhRiCFgClqdFkLlO1k1YxneIR82EqBg=;
        b=WD3l/w7hUCe77w+kg3//qeHFykxOmvTuIVZXru4Nfn1+NODgK+iPd/HTnClVzbfCXI
         qVvmMU/1jzzGIfgTW1NCDcYpez1TM+orfawJZzB4U56AMfxc+/4W+doBd6SeO6IF6btr
         VKAWl5wTlFiL17faIWBB6D8gb2UO/EapAa1U+7HlEVlran8ojejmZ/xLzfqz4m6f/DhY
         O7Y1En0Syq94+Vtt7scpmBlImoQ59nyxCzeyjQcYh0vz+GsZrpe7ljBpnY99RRHFWpfY
         27f4VSe41qbX8SAR0vAlidZS8rwSKUUtfgIokML3s9i0TEm/NqPXDTeCKtzPnz1xBCaH
         FzKg==
X-Forwarded-Encrypted: i=1; AJvYcCWcaisxM8AEvgoesST9qSu2Cs7ESyRvP9u65YZlFiTtRudr08/kOQ5T5N4BfjyX2aA0elMOic1oZySbdZHEj2Xz5I7OXSGPtntrOQ8=
X-Gm-Message-State: AOJu0Yz31/+i7evZc+oRlXxgFBuB/cjE7IE9h8nqHPcRPeygul7lM99P
	grOiz+YB2u+m1ZctObdRRAdYhr/p1cL3xCV4fZE2iVstMPnoGrnlfxQME2NINlc=
X-Google-Smtp-Source: AGHT+IFuSkdlp7LEl6nvNwBzRtkkJeI8XfwfHdqVCFMNn64T6V7hkopceJ42fI6HjzHaQgPcNU0RLA==
X-Received: by 2002:a05:6000:1b92:b0:33d:2d07:b567 with SMTP id r18-20020a0560001b9200b0033d2d07b567mr4711630wru.24.1711363816892;
        Mon, 25 Mar 2024 03:50:16 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ay9-20020a5d6f09000000b0033b87c2725csm9338898wrb.104.2024.03.25.03.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:50:15 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:50:13 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] video: backlight: make backlight_class constant
Message-ID: <20240325105013.GA182091@aspen.lan>
References: <20240305-class_cleanup-backlight-v1-0-c0e15cc25be1@marliere.net>
 <20240305-class_cleanup-backlight-v1-1-c0e15cc25be1@marliere.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-class_cleanup-backlight-v1-1-c0e15cc25be1@marliere.net>

On Tue, Mar 05, 2024 at 09:21:17AM -0300, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the backlight_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
