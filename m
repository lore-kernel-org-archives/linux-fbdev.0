Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C54E3E958B
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203442; cv=none; b=gxTcx+svgo8NnX7/geGFK+te3vYeXB1cMG202jEqIYdnfPQ06rNeRuQKCjA10CtHU0Y+NYeL9E10qhKzo5B/8hx7i9tGXpvXKCh2oZBI71nmFesinsD7PiUO4P5FSrgqpHcR1LdgzvRTVAFIUOJJjBkYsQSSOsMDPY2ci7LhPKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203442; c=relaxed/simple;
	bh=ZKSgW0O+qa5eygGMy3SgZ5TmviiTwJ16vShc+eliAsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+SSGNYHXXitquykw3NUciN6vc51vQyE/RCRImao4WxXt7OkpjeaKlS54eV1t+0eD9sd/g3oyWUwQJjmOuCs19cdjP38568hXc2sPLYKuNtRmMOPeQBrkcLGUgym/XyhWP3JvLIIwe+t9zDJRfcDt5of7Njtvhc9PHP8/Csnx/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tuIqt/R4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tuIqt/R4"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806f80cac9so37644605e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 03:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770203440; x=1770808240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eIr1YulAlgobkWRt4PikUjH7ZPuHX71f9MLxBLtW45o=;
        b=tuIqt/R4/K7saEAfJtVzMu2Gv+fXSdWH5nARJBdBtGep3kp0rkxyoQ/U8cfzFisssH
         9H0R2X7CZYEG5xtqynTo1KTNFo3/IcQK9NA0sNXNJ7HRcZydMRcrJpHMEfdHfVnsX4eX
         o5RtyeEkQWFRXFetWSUrVTm2zK9DDrWYQqIgu0+v39lxtebEhur6R7VzMLLgvuo6ZjIP
         FTEvqjG4kIxG7+Aq0wg2YubJb8CufV8o/BOaMcFNsSU92DuP5h5RLMVOaTKaPJiE5H2Y
         Tf71vBSQjjS3BQxFgmljvF+/sVdiVfkgRLLGl17v6HahE8+goD8JOGuXZnDCDM0afoqA
         Rq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203440; x=1770808240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIr1YulAlgobkWRt4PikUjH7ZPuHX71f9MLxBLtW45o=;
        b=m3n/8atDjAHD+pvF7i6fbp+NqDh5NbKv+kY/zMcYcirbFTd/moc00KWgu9268s4qmZ
         1O0B8GZiHl6ARpjtL98nBtZFax/2YCmfdc2MNMDR+ScxfwPhsbDRVSlhZM9D90gkfoQP
         n32PN6IO74VE9Jm2vHv0H5zql3r7hxzf9y8Cqr0u7F1h8hnGi1CluYqw33XkTnof50FG
         bubmpar2FXAEtIxnlpe3sXmDRfIhIVkzjXyJb9BAJLjA0FHJ/Myv4+aWTmC9Tfn7v8NV
         K5uhDd5nXQALf2eQ05BvCdzOlMbC8IVc47wArqVYeVIBspsPfaeRtcDnvRc5566PPO+j
         aL1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXH1Njhv13ejwZTwj47bAQv+MQkpsxOFkqEUK5/i1rMR63KdOwkCK8AmN51xMK+oEDjYmnohTSsLV+09g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAmq3H4gnndZ01mju5WTmwacn8h5vcXYGGuY8tU8PGDeSFbyPA
	w3BnzQqH+WWFDesPE/VcI6D6DfKP/4pg87DyjweU5vqzqV4WJeM1+5//Z1EWYzBzcaQ=
X-Gm-Gg: AZuq6aJgYpVRNKJEqMOyGcczl02OLRGIFnW69lfzV3PIGsRXrOYxWuPaGF/v7uDZ2T5
	+BDIkYmeppiqspywpxLsLc3sM9jPlb9oF9xqCzWxlMyiJL2e2CwbNiVpS+rmoFwOiJNSdnXvGbI
	Her/IJNNVLkiKazF/mwowoY52ysu4/HtR3bNC7mwJX1tKuPkr0OsMBlFuz6VlFD+vJZ1nl1jHmj
	w1pQp7c/o/M2L+Iecxg/B1fCMhqznI8bj/k86TJbdtEGyiH+nHAvrMn0PbcMnnUH1SpcCeDNyuW
	ldhIcEv767rMXQKS/SXnTx8WTaGQN0dx4bPe1ikYuPTEETpLMoRnFya4tORsv8HzqRI+u9asVS5
	+ppunqN9lHeIlumVM1aT6urh19u/MI/vTc+rSdz/G3nvNmjzuzvniNsQq5M743FP08uhjOo7fpY
	TXcfvDi7f9Y88eAnd/
X-Received: by 2002:a05:600c:4e0f:b0:482:f12f:f35e with SMTP id 5b1f17b1804b1-4830e9310f6mr32222825e9.12.1770203440211;
        Wed, 04 Feb 2026 03:10:40 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4831084dd88sm37722245e9.6.2026.02.04.03.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:10:39 -0800 (PST)
Date: Wed, 4 Feb 2026 14:10:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] staging: sm750fb: add bounds checking to option
 parsing in lynxfb_setup()
Message-ID: <aYMpLEM7ZfXglGbc@stanley.mountain>
References: <20260204101536.3311-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204101536.3311-1-iprintercanon@gmail.com>

On Wed, Feb 04, 2026 at 10:15:33AM +0000, Artem Lytkin wrote:
> Replace strcat() with memcpy() and add explicit bounds checking on the
> remaining buffer space before each copy. The original code lacked any
> validation that the write position stays within the allocated buffer.
> 

This implies that there is a buffer overflow.  It's important to review
this sort of thing and add a Fixes tag if the buffer overflow is real.

In this case the code works ok as-is.  My main problem with the
original code is what you explained in the v1 commit, the strcat() was
just doing a memcpy().  It wasn't concatenating two strings.

Just resend the v1 patch with the following commit message:

  As part of kernel hardening, I am auditing calls to strcat().  This
  code works but it is a bit ugly.

  This function takes a string "options" and allocates "g_settings"
  which is large enough to hold a copy of "options".  It copies all the
  options from "options" to "g_settings" except "noaccel", "nomtrr" and
  "dual".  The new buffer is large enough to fit all the options so
  there is no buffer overflow in using strcat() here.

  However, using strcat() is misleading because "tmp" always points
  to the next unused character in the "g_settings" buffer and it's
  always the NUL character.  Use memcpy() instead to make the code
  easier to read.  This also removes an instance of strcat() which
  is a #NiceBonus.

regards,
dan carpenter

