Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F67E16D4EB;
	Thu, 25 Jul 2024 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721893183; cv=none; b=j3MSnECcoR+9k1TuRYc60eipMup2c0M/AP23JGW6LDxw2Yk4sEihY0qdNYWDaBISpAvXjoOjiNAlXrC/VY9turQGrKldgDfo+Fo9ztdWUBRx7qap3SKdSjRm0fevnkkPHVfilf/fF+HEiNNXxW0wLJgJXX+M+22usf2F9SxGoSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721893183; c=relaxed/simple;
	bh=rZbqeLmUbzXJmgBM3m+8k4Y0LrMSil6mRCOoJlqsPPo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FaHiprACj49iU59Ypnfqsu2JNBp3dFmj/4shQGcfpNNQX5KJkv0mPy/1gGJBgz1fgjKdy34kaG/WI81T4vQhk/w5KBGDSt3oQhCViVu4ZBW1KSSU9r8E0sp7z5snM0OWuovYBBfb8SSWEPIcAJsswERrKPw9tsDrWtnC23leEPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDV5N8hE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDV5N8hE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4845FC116B1;
	Thu, 25 Jul 2024 07:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721893182;
	bh=rZbqeLmUbzXJmgBM3m+8k4Y0LrMSil6mRCOoJlqsPPo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MDV5N8hEtCO8v1cR/SlO+GLIF1XKIo80Hj9vJHi28c8i96PMInGdR+xCPn3L80MJJ
	 jASqv7keBWlUtODBJdo+WLJJlx1HL1zZH+MQkrcERdKZEzpFrbIi84gCAbeyAa+SH5
	 0rpFvT1ZlglEFpRHMB1Lm64310Pmwq0UWuJ9aJmtqpDis4mio31l0LJ1CgR2YZFG65
	 Q/u5KWjU4QD1AC1o21TvSeHGdP+AYphlfrwRSBsdLTBWnBRMeSmYmP0etem7jx43aG
	 O6uardvjUyLp7IEUUIJHWPZedxwtA54+FTi34w/tIg0yPzO5Y0bxfHAzIN7cc8xnnq
	 MRrOwk8p+f4Kw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, 
 deller@gmx.de, Chen Ni <nichen@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240705092800.3221159-1-nichen@iscas.ac.cn>
References: <20240705092800.3221159-1-nichen@iscas.ac.cn>
Subject: Re: (subset) [PATCH v2] backlight: l4f00242t03: Add check for
 spi_setup
Message-Id: <172189318103.830301.4585902101500100253.b4-ty@kernel.org>
Date: Thu, 25 Jul 2024 08:39:41 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Fri, 05 Jul 2024 17:28:00 +0800, Chen Ni wrote:
> Add check for the return value of spi_setup() and return the error
> if it fails in order to catch the error.
> 
> 

Applied, thanks!

[1/1] backlight: l4f00242t03: Add check for spi_setup
      commit: cec01c3b62f11efabc8c92f91472575651c593a9

--
Lee Jones [李琼斯]

