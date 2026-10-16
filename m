Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72734F30C1;
	Fri, 16 Oct 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165178; cv=none; b=sdVqYVQZbRmBEo6yIAgDUzR3k7n5iaxAIIG4Y+fsm93S8WGtjHJ/o21yuJ5Hdih5HEdA0pE7RDa9bIGpc7evDIZuaYX3anzsVWAX5cLNZXrEGIY9yMVhhAsZ2mMQEr8ihDYjCU1/J+umUwspZps0lBTdY5DmhaGkUCW3FJbDiFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165178; c=relaxed/simple;
	bh=DBTfS6GgR2JOYsHytsKaQbGgGzHwHCX9MxhZZB5k5lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7i94Y0JKTOj7Dfz333bsO0LjmVKEA3IMpVQ02DsV5yt0HDevCN87bfP0OXg1Zw33/ShZZ7p1jC7YZpNQZ4KAfyO7EkgkpJgX7wRE//ZXS+zq1GoFPAz+SJ4qTgLE90cSc8uyDPpUhAIXG9fCT6yr6zQpxe1r5mLrNwT0i5UrFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Leed4Rhk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Leed4Rhk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A8B1F000C4;
	Fri, 16 Oct 2026 15:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792165177;
	bh=DBTfS6GgR2JOYsHytsKaQbGgGzHwHCX9MxhZZB5k5lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Leed4Rhk7k2sKjAKraXvVR2AHx73ZkQKT52DNG2kxy7LKkl68vAktU1dAi3yItTJI
	 nh+mxSI0hiyrHn5YR3NMO3AmDTZRR8WIj6L2ceB6gmopVRSazoYCrwk9+g96tbsG90
	 cttM+49YqQFKB4VFyFMTmRrFpTkJ4eD06UiNx9zuh9mj+OimuTM1vf5i5QRdRFC5vF
	 9plv/4zCUAdQCfWMLsaCCIvNYU/YIzDMYN35PI0q2Mchkp8vqGlTElXYn6L2ECfpvH
	 v9hmaUtaK040LzUFnMIqN1uX86al6pMC38+Ku7inB85rgJnMhCjsBlcSk/adIQp9ot
	 OrltrQJ3x2MaA==
Date: Fri, 16 Oct 2026 16:39:28 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, Kiran Gunda <quic_kgunda@quicinc.com>,
	Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	mfd@lists.linux.dev
Subject: Re: [PATCH 2/9] backlight: qcom-wled: fix string detection
 brightness on WLED5
Message-ID: <atJFMBqrF5uzmMWM@aspen.lan>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-2-5c14928cef29@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-sm8150-display-card-v1-2-5c14928cef29@oss.qualcomm.com>

On Thu, Oct 15, 2026 at 11:58:39AM +0300, Dmitry Baryshkov wrote:
> The string detection sets the test brightness through
> wled4_set_brightness(). On WLED5 that writes to unrelated registers and
> the detection runs with whatever brightness has been programmed before.
>
> Use the per-version callback and latch the new value on WLED5.
>
> Fixes: 62a1d3f623ac ("backlight: qcom-wled: Add support for WLED5 peripheral that is present on PM8150L PMICs")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
