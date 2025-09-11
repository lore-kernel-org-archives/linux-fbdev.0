Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D2536209B;
	Thu, 11 Sep 2025 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607815; cv=none; b=mxP3B8xz1lIdYsiYu6m2NgrvLrWQN1TpkF915gkOKyjrKm97mbOrg1aRd6ugGyAf4mgE2Ik4izafgb1NSDqeEE1THNZROlNe+niZLCj/MwlxNzwm3DfOPVJYTsud6uInnbBTem+G2fj9wZLIArcqQlJmFsaT8owY6xlMKKpDv0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607815; c=relaxed/simple;
	bh=F0v+nws63Z6NUa9x4RxbE9FPclfYj/nCBDPLwaHkMPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N6jH4lVCpxGjEShxEfKFa0ht4wSNfkLiXi85q97LFcVzZEDdEM7PJpz7ykHuimSzz9uTVf7EBQun0YpwBbvoTUn+DupH5Br/+twuzDwLKh9d3lajcI5NwPfWy8AzRLRSXD3Lc0xSFfnOSuOgKw6O3jZRvoia6gf5HFX/DOrpUiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iOjBxLLE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iOjBxLLE"
Received: from [100.79.161.103] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5CE272018E5D;
	Thu, 11 Sep 2025 09:23:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5CE272018E5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757607813;
	bh=arLDBMZWQoXZroeZ9H6nkMPHxADGvPDE1QVRgov0vS0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=iOjBxLLERQ8kHRO+uJZm+wBvlUyBiJv3iQhlxw66sQtZxCxII4MXqytNQQ/LxWowz
	 RtCayYSGIQF55cFkcJWKVqYl4m8hseA1opAD//EPAfsgcSPkO3hTFy4v/2Z/n+iU7J
	 85Plb5pDvuA0tzwvspAsdCCnOFqCveUM0riYKfg4=
Message-ID: <cb823314-f7e4-45ee-bd10-22fcae300a68@linux.microsoft.com>
Date: Thu, 11 Sep 2025 21:53:27 +0530
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] fbdev: hyperv_fb: Remove hyperv_fb driver
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de, arnd@arndb.de,
 soci@c64.rulez.org, gonzalo.silvalde@gmail.com, rdunlap@infradead.org,
 bartosz.golaszewski@linaro.org, wei.liu@kernel.org, mhklinux@outlook.com,
 ssengar@linux.microsoft.com, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <E2D7F2119CB4>
 <1757437112-2509-1-git-send-email-ptsm@linux.microsoft.com>
 <8a958fe8-fbba-4bd6-a79d-fd310f08f8d7@suse.de>
Content-Language: en-US
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
In-Reply-To: <8a958fe8-fbba-4bd6-a79d-fd310f08f8d7@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas,

On 10-09-2025 15:06, Thomas Zimmermann wrote:
> Hi
> 
> Am 09.09.25 um 18:58 schrieb Prasanna Kumar T S M:
>> The Hyper-V DRM driver is available since kernel version 5.14 and
>> provides full KMS support along with fbdev emulation via the DRM fbdev
>> helpers. This makes the hyperv_fb driver redundant, remove it.
> 
> I'm all for removing obsolete drivers. But hyperv_drm likely first needs 
> to merge the patch at https://lore.kernel.org/dri- 
> devel/20250904145806.430568-5-tzimmermann@suse.de/ It's been tested and 
> works well. If maintainers from Microsoft have a look at the patch 
> first, we could possibly land it fairly soon.
> 

I will test those patches on Hyper-V and share the result.

> Best regards
> Thomas
> 
