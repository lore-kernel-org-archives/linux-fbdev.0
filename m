Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E981B3BB685
	for <linux-fbdev@vger.kernel.org>; Mon, 15 Jun 2026 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507074; cv=none; b=eUw+mCtHC1J2niSPOY+3PqFQLVQkW6TzuJogX8hlDgxZMSusEvWqEtr1yag8WzOuUMAWhZcJPdQbRoo13UARO9tm1cxBhbo7q8mEddREZ7mznH9piOqAbLqDWCkEhgl514CL/CDbH3+8SJmniqHbwBjkHpLhiu4kip8oKvLiHsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507074; c=relaxed/simple;
	bh=BS+zjw4eLL+0rpZ4fo0H95h1h9szhgSOmNArPS1Fd2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUQ6e/R9geuwYnITdlN17Fze1QHmT6dUj9PlLmibM2UUBEiwlhmYS8PAM1FyLQE1kzNrrkLknddGhlLOExbV0MhhvPsudowafm1qbcRrl10tZbyAg246UgCwVkGMSb4GHDPN8PGpBds4ODWg2hTIg3kSk4F8BQ9bExXD1Eb+yWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LY42v0CI; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY42v0CI"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5177b1a7441so43283381cf.3
        for <linux-fbdev@vger.kernel.org>; Mon, 15 Jun 2026 00:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781507071; x=1782111871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+RENlgkMWjL7wUhEcHLmNILGCKgCfCzFao/ekYQxfiE=;
        b=LY42v0CIKtOiECIuwgdL5XHi6ZI6U8s64CSiYrwPA4gUmJ3NHn0uw31T9Bgjs+mHXD
         q2HqdbcQflQk/2ulzP7llXAZAZJeJUlPme5LlkihQ5ak4dPZNjHdrouoAMFeWL2cFYKB
         4mnfvA3ULhhUV8VPxnUHCfv85GR0lhqknVwtFvrY4GvxdkkJ71pVqoFThCCuY4zbSnQz
         EoIIbjsF7RN9v78MO9dkaylQDqT8xYcGNHlzplV6VbHRF4OsX90dtypNjH0y0nk73Zy+
         HyQ5qqns9wmoR0jghEhSShv2nuoT4v1zdKQO8MW6VKun5pVIZLr7KqwXfTDPDa3pzUvD
         +CsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781507071; x=1782111871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RENlgkMWjL7wUhEcHLmNILGCKgCfCzFao/ekYQxfiE=;
        b=WLIKvUno7jSe7YR9a4gjnVCaaeCzR39O49udZFbROssmc7nxYTPcYpsWBZCkMWPi55
         24msnpgdshYL7Jzn4nJyTYGypEL8NI/vNb5aqlRWSXme5Jrj+qFB8EJa6XuzeyXCzij9
         kX5E1e4IOLf7z7r7f0tkl5C/dqgDXynhRtUywOfWQvUzSK1XNhKVcoTq1tw+JkKv72dj
         QPfbk85eCe/V2HmVQHTxUZt3wYo5CVrhEUakLUAm1JXew8optABNZF8antncY8r1NKy3
         n6hihSJ77bN3luRMryw4jaxY6Og1RcV1/pu8NXOO6STJ0nampZ5pMrga+Qa3gh4tNA6X
         /s2w==
X-Forwarded-Encrypted: i=1; AFNElJ/cGgnZCQerbYe6H6WR+Lyebww7ekEmqW+OwxtNnr0hYJjeHGrHPW+JZUSmjk5uRdRjxYN+eKEIebU/Ng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlz0rgKy5JsJBFVNC2sXK8tVw1mINQYCkaPvbDJDvYIeind34o
	rH7TFLfmn3bDxIIIy7yRROCg7kWoQ1ZEX1fCm2rtaqanIHaB5x/vn5ox
X-Gm-Gg: Acq92OGD1qWpkyMkUxuqupufqz9giKdF8nG52amwSBt52KlkhOh2EZ2eS9Zwnzfpmjq
	g94fUq1mkDd1cSQNgZF11w9fvSjxUi+w7Ukm4UAw2j99+xqcoGBJWs7vlz2PM3uyScyAOLCdb2H
	adGiaegXfetjlgpvB0xttYYqtevA7n35nvicJb3we+i0fcfjiGqwk9SEq61sqJ3LDf6f+ue8q7J
	cStrK2RPpFBtLq3FXSHaAqla3J2BaY4wWPGK13zikcacqtrA2r6yTsVpPci/mKsGAWOivGJkkLn
	Nd0dTJsR0VC9XfoUPyYn9yiLC9m+A8xNSwfhlGTEbX0zOdP/JsysQpEYcbNo8+qZ8o5sSohPoQC
	gbkFdeq1GSR7owBwQRkGPzNVFAIn9EGhtRkTvfA6DwoMsWQCJsaNHiDA9GytFlNQCqZNVV+G1uB
	O1qABFmkAe/aaCME0Dux5FuzmLEOg=
X-Received: by 2002:ac8:7d55:0:b0:517:6350:ed4b with SMTP id d75a77b69052e-519535366bemr150581661cf.36.1781507070757;
        Mon, 15 Jun 2026 00:04:30 -0700 (PDT)
Received: from localhost ([43.225.189.75])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb61eaf4sm99229171cf.4.2026.06.15.00.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:04:29 -0700 (PDT)
Date: Mon, 15 Jun 2026 10:04:23 +0300
From: Dan Carpenter <error27@gmail.com>
To: neha arora <neharora23587@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: sm750fb: rename pv_reg to io_base
Message-ID: <ai-j96dVwtPMERVM@stanley.mountain>
References: <20260529111927.14138-1-neharora23587@gmail.com>
 <CAOWJOptv1JcOGcEt39HVy7LkpAsvzbw9yj64kJG+X5J=VbWrMA@mail.gmail.com>
 <CAOWJOps9RBNAGsPFsBCbzFkEUN1=75YvwmqJX6RdQBbt1C6W-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWJOps9RBNAGsPFsBCbzFkEUN1=75YvwmqJX6RdQBbt1C6W-Q@mail.gmail.com>

On Sun, Jun 14, 2026 at 12:45:05AM +0530, neha arora wrote:
> Hi everyone,
> 
> Just following up on this patch to ensure it didn't get lost in the queue.
> Please let me know if any changes or a V4 are needed.
> 

It doesn't apply to linux-next.  Did you work against the lastest
devel-next tree?

regards,
dan carpenter

