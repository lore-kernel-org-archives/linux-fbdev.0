Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E36359B64
	for <linux-fbdev@vger.kernel.org>; Mon, 18 Mar 2024 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710800553; cv=none; b=eifDpV9g6hjlgMSgC00R5q037ctFkD4zuZfEMYJl3Zy5/I2e0FWzPEgz4oZPLyJ7kQB1/NKhwHPJrFoPOVbtsWvdnCoC5pWDfYwjSmEPIQjt0zQ0JW65X7sf2l6iyHAPKAzus6urVpwg11VEuxAfolMp194K9Jod2+UTLCR4y6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710800553; c=relaxed/simple;
	bh=NH+Tp4njbCnGeIjkqDzQGdWfaRlH9xlNHrb5HNjj4Hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSpJaYwv/C0G8su2RofjbChG7E/mRh5HpAKo9GP9NRJZ2gEOgNc6h7JurhTAUFGry6BRQgKiQ1nUhwADCUlwZtmncXHT8rMR4wBB7DdUOY4fpHECJXlBYVE47ic8MQV23GvayZXqyXcDxzUdCEF2syFW8m0cn6/beX+XvasFWhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nOX1kQV8; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nOX1kQV8"
Message-ID: <0d56ea1c-6b9c-41bf-9f65-63693fb3e266@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710800549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYCVjE5ZicCEWStHRAbjTxuiDF06WEh4aBTViF8yw7s=;
	b=nOX1kQV8nz92heW7po3QpM00qJz9FKsarhIkPrgA3dBVJLztZqVXYXnp1HmdN21j4o2Zbp
	iwNTn4PcDReX7Gln+btzSehV0WlhoDtf2+gw0ALegvkeAWkRdmVcHKCzM3/TUtsYZ5dvfB
	4kE7gU0+8wNrAbicy2RKqu5EFZPcmKI=
Date: Tue, 19 Mar 2024 06:22:19 +0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [01/43] drm/fbdev-generic: Do not set physical framebuffer
 address
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de, javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Zack Rusin <zackr@vmware.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, stable@vger.kernel.org
References: <20240312154834.26178-2-tzimmermann@suse.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240312154834.26178-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/3/12 23:44, Thomas Zimmermann wrote:
> Framebuffer memory is allocated via vmalloc() from non-contiguous
> physical pages. The physical framebuffer start address is therefore
> meaningless. Do not set it.
>
> The value is not used within the kernel and only exported to userspace
> on dedicated ARM configs. No functional change is expected.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: a5b44c4adb16 ("drm/fbdev-generic: Always use shadow buffering")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Zack Rusin <zackr@vmware.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: <stable@vger.kernel.org> # v6.4+
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>


Reviewed-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Tested-by: Sui Jingfeng <sui.jingfeng@linux.dev>

-- 
Best regards,
Sui

