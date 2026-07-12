Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192D324336D;
	Sun, 12 Jul 2026 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783857501; cv=none; b=kQwXVCX3Ni4bkNgNUIyCpAvAvraQV0PxPwWUqrCFWoj/v8ScYMntXQ2ba142r9dfOKFamwko4w6OJTtRToJKJDS+wnFw8KKHoANaFlWIefaSQzAujEMpsl87J7xdYe831SNJ1dqwaPRBrVie+Ny04VDLw4vQq7SWqAHNVbn7Vbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783857501; c=relaxed/simple;
	bh=57pGUYrskAcquwCxXp4iQyn29Vfw0lsKv6HeEBc+8CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCSnPuoyN2YFK+XYtVbBhRRktYVPNxnw080ffRFjg7b9OZ9k6c9R4aooOxSX0dcDQm//Ie6txOMRLg2+ZiPfHpTK1YuhrnYP3ikrJ4MsPS/NVbtClLuvYzWsq7P8xc3TEEEGZ3ldmv4Vy0iJpprWTVfOQ1dG3+hRHswvjICDyTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ND8Kgi59; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ND8Kgi59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9C11F000E9;
	Sun, 12 Jul 2026 11:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783857499;
	bh=yrFC16hsoM9M2XVRLKGX7WGRy7svbYgDfsDSl/vR2dQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ND8Kgi599b5uMp5LNQ6Ynfqa3aim8kYh1xt2+PPwQVAh0hiDdn3L04rNSDPm8cEuv
	 Va9gupRwvpJ0otAHaJul8g2EWGBLJtmb0QIRkbJqA/wNt31tWicEsF9u8J3y6IaCLP
	 evbPkDh26lB0KGzZaCaFkiTiDYaCfCfTfnK8/Mts=
Date: Sun, 12 Jul 2026 13:56:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: toveno <teamakeads@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: sm750fb: fix CamelCase naming checks
Message-ID: <2026071233-dish-finalize-d5a5@gregkh>
References: <20260712113315.38615-1-teamakeads@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712113315.38615-1-teamakeads@gmail.com>

On Sun, Jul 12, 2026 at 02:33:15PM +0300, toveno wrote:
> Fix checkpatch.pl issues regarding CamelCase naming conventions by
> converting internal driver variables to standard lowercase snake_case.
> - Rename pvReg to pv_reg

Please read the email archives for why this type of rename is not
correct.  (hint, think about the name you just picked...)

thanks,

greg k-h
