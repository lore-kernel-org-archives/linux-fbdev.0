Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB68390211
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 08:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611862; cv=none; b=u+goaGhN6gJ7SUiCwUUDpE36iw9LR8io8UbFHW67eBlPA1Ih2xE7FGE1Kba8K9bo4lCD5orPKqznueQMktViEgsojaGoydsWjNspYUBKBNtrlY75QRUL8sPz6/ACmE+TGEyheatHU2GZvu/JHJrxC3LJRwhNQvLNzPEbU6ToYII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611862; c=relaxed/simple;
	bh=1gMlLUXhCv91U6qxn9U4jYEbEj/754SDso/dXbzlmxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGwhhw3s1Mx8ZluZ638pmS0qPmqBJLy5JssZCxhrirHQ5g3kz2cI5RZLQUnY9c4zpFR/bVhQm51DPkmddmLMHn2Ln/ndK6fqAZbDICWw+8qPQmHDZgkxr8IqLC3fTsx/SnVwQp+8X+6CXqMDJJNBpNj0EuARxzJ4XkRcqXxv9Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SadrRLje; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SadrRLje"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48379a42f76so53859495e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 00:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772611858; x=1773216658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i8pSDKN6l/7Id5MISZkLrIAbbIL+fWy4XY0gx/wOsW0=;
        b=SadrRLjemTGRxE/e5nZqcbWYz8WOWl04T7pd+bOaAKyfY7h0qGgLPCDr9IGRB2+Jnt
         /KyytuzjUgFpSPREoPoSxdBUTNaTrB8UGQtMTnsznklfH2TVpVxbmuR5gdk0+F3PEQ6w
         1Vd+r0HEbInzcGfC4Il3crsT8IiiefFsBG94lJ7TFLSIrm1BRIW5a0GbJtpwZ6YDduTc
         JLCQyoNfl1IEvtqsK7yw1xTNsbXv2wKAVyWkI7qu7KRo4m6JDPP+ji/Rtlj7fQI6b8to
         pEChMe9OG6kPzHwk+aTMOYDhrgSuwskHQi1ugfNUdCBUAWdUYILULtocsO03PMeR1T9z
         /Tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611858; x=1773216658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8pSDKN6l/7Id5MISZkLrIAbbIL+fWy4XY0gx/wOsW0=;
        b=FWxRDuvX+h9jJN7eK15YugzWnreVS93nqzTp8dFxpohDauqKlTDIUvv6WkkpiEZB4B
         iKAyOFjfTw0W0WIATocz8F+a0OcQJvI6lsopk0HUGDb39tD3tmoqX9jmiFF6WwRCygAk
         MAzrgXx7gjxUIN8CcOMnKJCP4/4CBMNvrIIYZk6aVzjmbtX0NzpjG1nnYI8rHBSVgAmG
         T+FFpS6RArZbAtJB540uk2yC/IZtH2Y9OjsKJvBQbFOKxNnrw6zA5oGB9HQBwPBNQvKP
         5p9ZOph27TcHm+5hQpVkb0E7wj/j4v0c327CCn/G4XOV2ac1mtmQPCXfCttis1gjjLYq
         qycw==
X-Forwarded-Encrypted: i=1; AJvYcCU2WddGo0hN9QZ8T6MX1MocLXehfKzFiLgKhwxWco3/CLllV4l43gXq86wiVoKvyCwTAi5QOPUpuZBjFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXyUFPamh/R1v6szqY+s+RPSL7tTqvlLmYRQdf7Cwf0kRY11RO
	ct2jiJzGfTrZ0//85HNFG+SV8Vn+HyowUhSPCVihj1PEMLsA9xbf1XPTp0hWfU+pyUc=
X-Gm-Gg: ATEYQzzuA63KXoB7iaSGI//FWpyjzjdxSfgD/jD52J0uVfIdMuCGOTvnK2kBnpo0Wqi
	vaRMyZhut0eMsLwF+JoZ/kaS/NuilQ7lWwihNMUae3R1T7XT1KX4kPTJeWGkSLsTYpobXWldaKR
	n7Lu4gjheFG97Jm27oJyRAXmgrTpDiAojo5AQQ6rRERnfhk4zkFzQgygDW+25oHBlYfSPOVZK3f
	dUeq7O9KK3iiVS7LBQ8ckuoschH/Fa6+lb419GNECVBo7j2DHg8NpSEg+lVOPdWHsa5VkkPY5Pd
	7NI4bH7itF0Od44paY+Qye2W8tTCo8tlEsJozcOB6b47UsSB4NS187HmRt2+HQgoYrkym5kMIg7
	N49vtjTHM/zWE4BNzgsQO0KhF6KlK54JgoLcyT9bf7+/A4qDBV1586EB0GVBbPemdPqq284oSQt
	q2N0fvEswBZjItoprT8K84z1Vmpqv4
X-Received: by 2002:a05:600c:4e51:b0:483:7783:5373 with SMTP id 5b1f17b1804b1-4851988ce8fmr17102135e9.23.1772611857549;
        Wed, 04 Mar 2026 00:10:57 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851a8d4b3dsm6444525e9.9.2026.03.04.00.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:10:57 -0800 (PST)
Date: Wed, 4 Mar 2026 11:10:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gabriel Windlin <gawindlin@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] staging: sm750fb: remove unused CURRENT_GATE,
 CRT_HWC, and DMA register definitions
Message-ID: <aafpDlf_m2SBNg1b@stanley.mountain>
References: <20260303232434.1850583-1-gawindlin@gmail.com>
 <20260303232434.1850583-7-gawindlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303232434.1850583-7-gawindlin@gmail.com>

On Wed, Mar 04, 2026 at 12:24:28AM +0100, Gabriel Windlin wrote:
> The CURRENT_GATE_VGA, CURRENT_GATE_PWM, CURRENT_GATE_SSP, and
> CURRENT_GATE_ZVPORT bit field macros, the CRT_HWC hardware cursor
> register macros, the DMA_1_SOURCE, DMA_1_DESTINATION, and
> DMA_1_SIZE_CONTROL register macros, and the unused
> DMA_ABORT_INTERRUPT_ABORT_0, DMA_ABORT_INTERRUPT_INT_1, and
> DMA_ABORT_INTERRUPT_INT_0 bit field macros defined in ddk750_reg.h
> are not referenced anywhere in the driver. Remove them to reduce dead
> code as noted in the TODO file.
> 
> Signed-off-by: Gabriel Windlin <gawindlin@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_reg.h | 41 ----------------------------

We always remove unused code, but I don't really understand the point
of removing these.  It's not like they hurt readability.  They function
as documentation.

regards,
dan carpenter

