Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8617D41B
	for <linux-fbdev@vger.kernel.org>; Thu, 28 Mar 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637767; cv=none; b=gHONF4kYHiwSYtOq1+8mkDTMApMTvZu5D36FiBmnIw++68uw1a7+3sNvnLRaIa/4cclOYBLp1vN0EzE1Ai4rne8QFdzM29JQzzfoKd/ls2SFhpHdqFrkL86+XnEzG44+isO4NqbK8eVUghnH/VNEXgzEPjsBO0pMnKlMsjIZtF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637767; c=relaxed/simple;
	bh=5NsJx8hBJTJXN179nVNOCuTTsF0ALFUhXWTVlzdvgnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPkZHOe3jHpJQZUJvs/NzDJm5zBC/dPKcJxVL1yoLQyCD6aVVLhuqm9U88dgwKOks1nhX8gqwLbCv9EyAG2CXT6RCO/VJ3UegD+df+40gEmtiOsPEbOFZwixaeN7KP9wTtcLFTxrnmUNT2rUdm9dTGFALGrvMpKXatSRE0V0Ht4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cxVypfiA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cxVypfiA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711637761;
	bh=5NsJx8hBJTJXN179nVNOCuTTsF0ALFUhXWTVlzdvgnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cxVypfiA73QPdkGEZRRXSgr/gGtfvh6YPPGH7X/rE6eVF26ylRE1ebw63SCW76aFp
	 7l7rNhrdeg68yxRCLqBck30+apQsP22ySGjYkcgu4G6ncls0QDkHMbv/ZGHgdt6NQM
	 rMoiMTSCZ64uxGsoTfJHjPr+C1HwTC3zRRoqob9aUfnD7tIbxsqUT56ObLlSH7AzwG
	 QAs9sK/x+gCrJ+7kZHm5uF1V+R7Lqg5dMQzB54chBb3mpIMh71Ks++jrIeJ+MY4ny3
	 cSL1lNnuv4RJbjCXBDESHkjFfBagFbGKIakq8c5M9KhT82xnb9P4E5gRHBzJctsJsd
	 K4UAakGoy8s5w==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DC396378211C;
	Thu, 28 Mar 2024 14:55:59 +0000 (UTC)
Message-ID: <5be72075-cdf5-4143-a280-fd9620b97201@collabora.com>
Date: Thu, 28 Mar 2024 17:55:57 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/43] drm/virtio: Use fbdev-shmem
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de, javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-20-tzimmermann@suse.de>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20240312154834.26178-20-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/24 18:45, Thomas Zimmermann wrote:
> Implement fbdev emulation with fbdev-shmem. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Gurchetan Singh <gurchetansingh@chromium.org>
> Cc: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index 9539aa28937fa..3d626bbaab9e4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -35,7 +35,7 @@
>  #include <drm/drm_aperture.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_drv.h>
> -#include <drm/drm_fbdev_generic.h>
> +#include <drm/drm_fbdev_shmem.h>
>  #include <drm/drm_file.h>
>  
>  #include "virtgpu_drv.h"
> @@ -103,7 +103,7 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
>  	if (ret)
>  		goto err_deinit;
>  
> -	drm_fbdev_generic_setup(vdev->priv, 32);
> +	drm_fbdev_shmem_setup(vdev->priv, 32);
>  	return 0;
>  
>  err_deinit:

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

