Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CCE21D3C5;
	Tue, 30 Dec 2025 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767081684; cv=none; b=iiqkfNA/GhButDoVloBPUFZgisG9lZWjzirOxsJvjz7YAwShFbLlfCTqc4I8+oPm/5teSavfILMotjFKG/LXrOGTwA8sbpy49aU66mmYApovXI3BwavTpVfni3Zk0/Zf++2mvStNMyUofx5iZnT7wvJ4tpWC6pJa3XBe/db0Awc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767081684; c=relaxed/simple;
	bh=XzFlufQBAGY1a122gXiQWJa7ASmSs8VApb7l0+3YfiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGEN6mWe/3sVu6LkeuRvO4BcC9feA/I3NR6708Bu1Qkjq/9EWO3lTM9wMFFa+aEkn6feMOYNQPvwASw+8yX2Q3O8vvWDR7zOAQDxggTPHzu4VF1++ZTwEo0C0FueuZJ11Y/Dp7AXyB7cJ+9XLkdRE6QQbiKORqCBa/1tXHGqu60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K16J1h0E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K16J1h0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CEEC4CEFB;
	Tue, 30 Dec 2025 08:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767081683;
	bh=XzFlufQBAGY1a122gXiQWJa7ASmSs8VApb7l0+3YfiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K16J1h0EerHEiIGYP2K6evJykMweVj4iojSQFbWZBOa2IXOJ1jwrwjlM1lwb5yEsZ
	 bFXhlujiNOYh0iqjAJh+18bQFiRpBf8SEUsOhN6OqrMG1raEo/PPlJV0AMr3hv6JeU
	 LLk+bDLQr0IIgGJpK8mdlhajRF9EKwFsY9LHXEIeRidCdxAc/vlW1FDnEDCAFixNbT
	 EvEmBaABYyNvw1cyYtj+e2g2ucElML0hFCPws708HujrpRFQAzds1Rmvws7/1JKbgQ
	 JAO0MM1abZawVu+U9a3uhQkLodF0DSVbsBRwOn/MRvphb4ptdoQ+tnnpSweJ4lF4Au
	 qVsnQSk3RUh9w==
Date: Tue, 30 Dec 2025 09:01:19 +0100
From: Helge Deller <deller@kernel.org>
To: Chintan Patel <chintanlike@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/4] fb: Add dev_of_fbinfo() helper for optional sysfs
 support
Message-ID: <aVOGz2zGZQ2qBCUy@carbonx1>
References: <20251230052827.4676-1-chintanlike@gmail.com>
 <20251230052827.4676-2-chintanlike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230052827.4676-2-chintanlike@gmail.com>

* Chintan Patel <chintanlike@gmail.com>:
> Add dev_of_fbinfo() to return the framebuffer struct device when
> CONFIG_FB_DEVICE is enabled, or NULL otherwise.
> 
> This allows fbdev drivers to use sysfs interfaces via runtime checks
> instead of CONFIG_FB_DEVICE ifdefs, keeping the code clean while
> remaining fully buildable.
> 
> Suggested-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Chintan Patel <chintanlike@gmail.com>

Reviewed-by: Helge Deller <deller@gmx.de>
