Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0797D210E4
	for <linux-fbdev@vger.kernel.org>; Fri,  2 Feb 2024 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887442; cv=none; b=lJewCL7a5s821XF6CQIkq6LKgzEA2VoxAuj6xAbM2ag6fkhDJC8W9RQ9E5LDfrRmKZT9Di1xnidnY2t/EIYCDgq9TfWI9BVLIuSB1AWjL2ctwB9mWuW8PcBS8WrogWupoMCWKKqchFUGaBei6DLh9SSnw+PgMWzbJJ3MVxjaIvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887442; c=relaxed/simple;
	bh=4aVZhq7FIbirPhZ1n41A8Y/v4CohpET3+Yrw3Uhku5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ru7lQLfMzEME4k+39YvVVvv3KAtbmSqjTOjPnGnqzy146+mZs9WdP5JKTuyNC5aI4r0/qmy46uzvrEzGmbZWCd/pJOvvrhGSYJt7T+bvkJK39syPLxMcswS5NlJixfJw5gXNRvkGlyVuCfC3tD9ooQFZ4FrcOn1Jke4OWnIdgLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ixo6/KIb; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ixo6/KIb"
Message-ID: <eb221db3-76b0-4c69-8736-df5576392717@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706887437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aVZhq7FIbirPhZ1n41A8Y/v4CohpET3+Yrw3Uhku5U=;
	b=ixo6/KIb0+6clrNw5EHtXu8r2gG9UTTb3DZaYaDjnqX4Mb28QZm6dGE0QRTwq8rGKjnkWL
	NE9gd2Lob6EQGR8MgvT1T0XxGWSk6Zm7A07CJ2B5+ndMcl25SGVaddtYvUuIfcAmEmgUKo
	B/DthZgvkJ5kYJNDCLoO31+o3kM3NQ4=
Date: Fri, 2 Feb 2024 23:23:42 +0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v2,3/8] firmware/sysfb: Set firmware-framebuffer parent device
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 pjones@redhat.com, deller@gmx.de, ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20240202120140.3517-4-tzimmermann@suse.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240202120140.3517-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/2/2 19:58, Thomas Zimmermann wrote:
> Set the firmware framebuffer's parent device, which usually is the
> graphics hardware's physical device. Integrates the framebuffer in
> the Linux device hierarchy and lets Linux handle dependencies among
> devices. For example, the graphics hardware won't be suspended while
> the firmware device is still active.

This is a very nice benefit, I can't agree more!

Because the backing memory of the firmware framebuffer occupied
belongs to the graphics hardware itself. For PCIe device, the
backing memory is typically the dedicated VRAM of the PCIe GPU.
But there are some exceptions, for example, the gma500. But I
think this can be fixed in the future, as majority(>99.9%) PCIe
GPU has the a dedicated VRAM.


For ARM and ARM64 platform device, the backing memory of the
firmware framebuffer may located at the system RAM. It's common
that the display controller is a platform device in the embedded
world. So I think the sysfb_parent_dev() function can be extended
to be able to works for platform device in the future.

