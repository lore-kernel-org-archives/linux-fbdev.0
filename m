Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E072D7DF7;
	Tue, 18 Nov 2025 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489437; cv=none; b=epGdc5OWB9AEP/cJ1WCWanB1SfTCa8SjI7KAleo+NpY7dCFcY2gayg979/6ujG3WyUkW4BncKasVR86kMbFKBszmyHTyV++cFTE8jBpbfLU04mYab+tYnAQ1kOjLXaGq0pe7N23mAiG/+bvMpA6lwENUY7rg3jjCjqnNYnEzz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489437; c=relaxed/simple;
	bh=G26ClVXWETxoz3CRO4rAONJmSKqzBRQWYIkNvbFxDf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNZQK2mQYaLFVbszM3mHVWo0OsMc6HYTqSM91abHR4yQC3mIEG6/yxgF2r1lp+aVIOa+1YjvCJ21+FTXKsPfRJkkYZbjeOz/Klt8vy7ONyLyif+vdTx06v2Dc29fE/rG4i8IsmAM3SWyyi9me0aXUFIVdkl2loaIfyl517WBtZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eD1y3QWC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eD1y3QWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE40C4CEF1;
	Tue, 18 Nov 2025 18:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763489436;
	bh=G26ClVXWETxoz3CRO4rAONJmSKqzBRQWYIkNvbFxDf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eD1y3QWCcWAcNqgJ3QcXmKj9xWs58zdkNSTOJ91Iu9ftV+eZHH+VFMTtSMTISRhCQ
	 dnyRONMkkjcfeB7ViR7C24W//i2P3TJG2GhNGHIaROU1yBHg1/TqDUQN1U+zbtL5Pl
	 bd9RP4x4SRPeA6TiJc42DHM1d3rn6ZsuMJx8rWbCTuNm4IBtDwGUs+u0kmWkKXbFJ2
	 ByTMg/4zVNueEC5FK2RXVSBmdlaXzvgeDORWcOx/cdl86LX4Pq1Fsik7qQcv58Zp7/
	 nNMZ+lGsc/nKs/64YG4yZFlTStH4xux4i3HVBIfV0AmMKFVzslvbYN3m11c3rib5sX
	 VNAfXm20nCyGg==
Date: Tue, 18 Nov 2025 18:10:30 +0000
From: Lee Jones <lee@kernel.org>
To: petri.karhula@novatron.fi
Cc: Thomas Richard <thomas.richard@bootlin.com>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: Add Congatec Board Controller (CGBC)
 backlight support
Message-ID: <20251118181030.GQ1949330@google.com>
References: <20251118-cgbc-backlight-v1-1-cc6ac5301034@novatron.fi>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251118-cgbc-backlight-v1-1-cc6ac5301034@novatron.fi>

On Tue, 18 Nov 2025, Petri Karhula via B4 Relay wrote:

> From: Petri Karhula <petri.karhula@novatron.fi>
> 
> This driver provides backlight brightness control through the Linux
> backlight subsystem. It communicates with the board controller to
> adjust LCD backlight using PWM signals. Communication is done
> through Congatec Board Controller core driver.
> 
> Signed-off-by: Petri Karhula <petri.karhula@novatron.fi>
> ---
> Backlight driver to control backlight behind Congatec Board Controller.
> This driver provides backlight brightness control through the Linux
> backlight subsystem. It communicates with the board controller to
> adjust LCD backlight using PWM signals. Communication is done
> through Congatec Board Controller core driver.
>     
> ---
>  drivers/mfd/cgbc-core.c           |   1 +

Please separate this out into its own patch.

>  drivers/video/backlight/Kconfig   |  11 ++
>  drivers/video/backlight/Makefile  |   1 +
>  drivers/video/backlight/cgbc_bl.c | 281 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 294 insertions(+)

[...]

-- 
Lee Jones [李琼斯]
