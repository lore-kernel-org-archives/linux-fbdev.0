Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189063376B0;
	Thu, 27 Nov 2025 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258946; cv=none; b=HnGOUtB9I68hGIoZvoOtTffOiBoQjj31/0tdvCwlJbbEug8M7NLQpIjuRrHteIbUamDnHgrwnQXiYLv2xHIzrT5b8C7Li5rnh/PyQ6+9Ffg0/rP1cZPqp6qPBmN4PANzoHDXO7eaKGct1KC8tIUieTnOMRvvTzn2pvD1mf4LzTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258946; c=relaxed/simple;
	bh=79PrYF2iuQAc+y+8JIgjRAAux2ndHI3wVSQ8aGdIWUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBSDxoqfu6r9tIGm/t9RE6Uget2nrjzknoSKh2a8W1TKeZYXcZolvk+j147KYLU7eyINFScBMwYMjWbKcIsRsUow2fj70hfAXBQRTw/7OiXdvzWun/fhh3/ZBoDEqoDgt9rvaqSreS5RbG568D1Ssx3S/+MMW6blIIMZ5FDQAkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgOslIUY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgOslIUY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0779BC4CEF8;
	Thu, 27 Nov 2025 15:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764258945;
	bh=79PrYF2iuQAc+y+8JIgjRAAux2ndHI3wVSQ8aGdIWUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fgOslIUYs0AZCw799d0aeqrZbiD6pyAm2YhoR41il0xyM0tYRo3WJHXWyGRtIBJQ+
	 Mj2WRqmbidrW/SmRYUA9oszt1rhc3PpLV4sb2QLce9rW7YxoE9poMD+IPzmJc+D0NB
	 vjbCZZaBQnXVqf37MUNMvjUKWeDJqWwNgMO/2EO/zNTKh7nyzAhQREOCf6Cg0dfRxL
	 zf8aO+LF+JWRb0kc8Nnf2tQz995m3fPsu1ahIbgGXG+AlstG8n/0/taPt2VHmCYa0O
	 +xw/cRiT6fmJ73kFT2DLLpA6UQ/8vARTrvBcLMRc3gDoR/jU0CrNtA4bauMwhOpyZl
	 25U6f1cncmO0g==
Date: Thu, 27 Nov 2025 15:55:41 +0000
From: Daniel Thompson <danielt@kernel.org>
To: petri.karhula@novatron.fi
Cc: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 1/2] backlight: Add Congatec Board Controller (CGBC)
 backlight support
Message-ID: <aSh0ffjtRlow2WO-@aspen.lan>
References: <20251127-cgbc-backlight-v4-0-626523b7173d@novatron.fi>
 <20251127-cgbc-backlight-v4-1-626523b7173d@novatron.fi>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127-cgbc-backlight-v4-1-626523b7173d@novatron.fi>

On Thu, Nov 27, 2025 at 03:21:59PM +0000, Petri Karhula via B4 Relay wrote:
> From: Petri Karhula <petri.karhula@novatron.fi>
>
> This driver provides backlight brightness control through the Linux
> backlight subsystem. It communicates with the board controller to
> adjust LCD backlight using PWM signals. Communication is done
> through Congatec Board Controller core driver.
>
> Signed-off-by: Petri Karhula <petri.karhula@novatron.fi>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
