Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85294309DB0;
	Tue, 16 Sep 2025 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037890; cv=none; b=eY1sGFvNR78HlekwjKFGn7q2ibU5uABawA/idGu968f5OcXrXu0PHd6Yz/u4X3WMJvBvOgfJ6hKHN6AeuuDpzWeJnx756HTluIDXX22KW/Sk+fR8Bhfdd4TTkQ3qJQocyo1n/NAeeeHnUAt71F+Yp/OJO+ieA5eI03lhtJX+Gaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037890; c=relaxed/simple;
	bh=7GlYPEVzSRDSbVodus+jSvHu1Ffdp0gsTnN4YNNOFto=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rLSzY5ciBy6DxkDO/7U0CvbIYe+xbEznCPBvNYti6uxQiyo2UueQ/Yrstpl07uAUAhSLk+jQ9qahGNOXiDx1EwE/FDEbsmC5WbaWIgp7g9uN1Is/Hw5Co27qahj1W4pc1JcukzAeB+loI4s+iAxhGFd9phHAZUhh881jF6PYVAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVQMdr12; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVQMdr12"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969A9C4CEF7;
	Tue, 16 Sep 2025 15:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758037890;
	bh=7GlYPEVzSRDSbVodus+jSvHu1Ffdp0gsTnN4YNNOFto=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bVQMdr12VUj3CbkRKEffjlqa6dXBb9jEbQTn9g1Jvq0Ew1cX13Wa5UuTzPjIw6NnF
	 2bt0Iv2SFDU8R0zkilJYl43zciQk3A7lc5l1rnJ6RPaN10LQehlSzdjpLnCMX8OnTW
	 M3Ua0Chc1Y6kKY7N2N3XBxN9RG/Jwzd82Eyf3ttHWlzu+LxA5SEOW+YU4OIuonIwMr
	 A+YfDJmyhK2+r7PNzgDapvSlBjs6i/ImOi7j4T8EpMj9szdvqzb+e2utH6HtFGn1u3
	 ycE5dHThwmBnmIjwj/o0KBbOGuTQ/V6sHtlr/5w4XAlvU8BWN3E1hRlmB7FT1ygCrl
	 cfFhJ3ThTYFxA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250909074304.92135-2-clamor95@gmail.com>
References: <20250909074304.92135-2-clamor95@gmail.com>
Subject: Re: (subset) [PATCH v1 1/1] video: backlight: lp855x_bl: set
 correct eprom start for LP8556
Message-Id: <175803788835.3884534.15678496091804574819.b4-ty@kernel.org>
Date: Tue, 16 Sep 2025 16:51:28 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Tue, 09 Sep 2025 10:43:04 +0300, Svyatoslav Ryhel wrote:
> According to LP8556 datasheet eprom region starts at 0x98 so adjust value
> in the driver accordingly.
> 
> 

Applied, thanks!

[1/1] video: backlight: lp855x_bl: set correct eprom start for LP8556
      commit: 07c7efda24453e05951fb2879f5452b720b91169

--
Lee Jones [李琼斯]

