Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFE513C820;
	Thu,  2 May 2024 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670799; cv=none; b=ZCAd/SmVsHMO8t25x6LQFUKWJt+cKx0Ut214w6YHprqbskQwK+iLIpTOE8K8mDogLzNt0kY85nBI55bXf35I+5u0OGz5oW/LsRMo1RYG1Fw1m6Wiq0OYqkd8pXKJziIk/u+cGA3GTPO5emwRJGcG3lKl5FTC8s1zaypntHgJpPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670799; c=relaxed/simple;
	bh=ZaiiRZ2rHARj9qlIVThHOdD9gBPLlRdbHjtki6AAwhM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CmSsR2TAo13FGbNx3raR3kgtYJ/xd0gUWdxq4OjK52Wp0CPbr9+1QCyw5PZ1fiYRZP8XSpA/weAQbN9QlmjawjbjdY9U5FXOwV/QeeDY3kHXuUecd2aq0k+X/E5513d+JY05fBjOI6WvDTwf90fQ7VsENJIunyu+1g/+A2D9Rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdpCAseE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdpCAseE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1FCC113CC;
	Thu,  2 May 2024 17:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714670798;
	bh=ZaiiRZ2rHARj9qlIVThHOdD9gBPLlRdbHjtki6AAwhM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LdpCAseEXC1l0+nRg+IFZwPvDYNnioSl5U++nFBZrw8Aa40h7cPTx6ym1wzsOFPqX
	 nl0O5Ffm38F29REUyV9MATORkoPzLjho+VnQTvs4vVzYdSBK+Jd2DfHzKXvcstlY57
	 R1kFl9hJUtJQ9FykDhHys2FIFa29Qiz9cJH3pUR02e5ArKGDwGFAGXhWYKiHfAAyRm
	 G+zDk3TpR/2Y/1wm2MbzSA6jBcpByiqBQtnEJORz1J+HqNBlwvRtHmb3wHaapNpe73
	 CIs3p7n6GrJz22v9+2qP7CSVWYHOpMBbefhxDeZWQt1CRelkbopMn5U3xnfToo8h7n
	 6jsfMgtcz/Zyw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, 
 deller@gmx.de, Shresth Prasad <shresthprasad7@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, javier.carrasco.cruz@gmail.com, 
 skhan@linuxfoundation.org, julia.lawall@inria.fr
In-Reply-To: <20240502172121.8695-2-shresthprasad7@gmail.com>
References: <20240502172121.8695-2-shresthprasad7@gmail.com>
Subject: Re: (subset) [RESEND][PATCH v3][next] backlight:
 sky81452-backlight: Remove unnecessary call to of_node_get
Message-Id: <171467079621.1227065.12439900385268240993.b4-ty@kernel.org>
Date: Thu, 02 May 2024 18:26:36 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Thu, 02 May 2024 22:51:21 +0530, Shresth Prasad wrote:
> `dev->of_node` already has a reference to the device_node and calling
> of_node_get on it is unnecessary. All conresponding calls to
> of_node_put are also removed.
> 
> 

Applied, thanks!

[1/1] backlight: sky81452-backlight: Remove unnecessary call to of_node_get
      commit: 4da294108e38bf9cd5c62c2caa47611e5dbb7fb1

--
Lee Jones [李琼斯]

