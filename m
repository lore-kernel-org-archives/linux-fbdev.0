Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C132130AC3
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283425; cv=none; b=DWr02gTbJawyEUeFyCsgHAyvyUBW3FPNPPuZY70yY3x+GT+vs6iAg8NCyRXAoyTQnkwyHFRRM2cVdX+I2U7r5SE/sGHoKk+3XHA2uxW4VLkLo3gW7U2V9rXbvG1hWQ+FNGsQX1LYqoBIcSxNJuC05BHanmXfXOhoZQwKSz/sb4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283425; c=relaxed/simple;
	bh=QnwEYUnAMy4ho8UqAYwwApVBxejvQ+9/8j4xlbVh6V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Abf6qJ5O6mqpxKBRKETNEa4b4sJQojBOiW5U1paooF8dhQYCYfR+JFvegqUSuz7tNrwX7ndECn86G/XldP8Ucxjqa9cnE3jMnwadXBKYUOV4dbt7i37v2mKsaWNSKugO7ayh6bxWbT2p9tWOSy+jtTFQ9NWZd8uSyMfArDFDjaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=aga9EUgt; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aga9EUgt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rAUIS3yVirb3SdFi4Pa0WJBsT+vscixY4akkzpTzcpc=; b=aga9EUgtFG6ylbk/Wfmgqy3zJA
	Gf76NLyMS2DuunIzWQW4JngA/dcFKj1PMVrjYoaEMtKDwSbA5MeurY6N8TPA/pdMyI7GnnRlTQ/Hj
	3Ov0XJPm2NYuKJ2hVMEvSZUE8cmmNI4mLnUjkkZl+yGnwHcVdNV/ogAtHy2ZPI5Wl/6BKZCzfprrT
	7NBhvwak/3iKWraoPbQA75YkUonkyUY5f4z62eDgtGIQVzclbnkSJ0e4CdZB6p+yaACwXiyK4qae4
	YYy5svolZuB5yb1LYQ1lnxkIb8g4ijCdm0F6eayceV+W/kC0K/XcUzuYPHjWeRQfqdfjfDMXiO94K
	VrYcXUcg==;
Received: from [177.34.169.177] (helo=[192.168.0.139])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rwlHJ-005DZu-HC; Tue, 16 Apr 2024 18:03:25 +0200
Message-ID: <da33f59f-b5b1-4216-b58e-231c9a659574@igalia.com>
Date: Tue, 16 Apr 2024 13:03:15 -0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/43] drm/vkms: Use fbdev-shmem
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 deller@gmx.de, airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-21-tzimmermann@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Autocrypt: addr=mcanal@igalia.com; keydata=
 xjMEZIsaeRYJKwYBBAHaRw8BAQdAGU6aY8oojw61KS5rGGMrlcilFqR6p6ID45IZ6ovX0h3N
 H01haXJhIENhbmFsIDxtY2FuYWxAaWdhbGlhLmNvbT7CjwQTFggANxYhBDMCqFtIvFKVRJZQ
 hDSPnHLaGFVuBQJkixp5BQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQNI+cctoYVW5u
 GAEAwpaC5rI3wD8zqETKwGVoXd6+AbmGfZuVD40xepy7z/8BAM5w95/oyPsHUqOsg/xUTlNp
 rlbhA+WWoaOXA3XgR+wCzjgEZIsaeRIKKwYBBAGXVQEFAQEHQGoOK0jgh0IorMAacx6WUUWb
 s3RLiJYWUU6iNrk5wWUbAwEIB8J+BBgWCAAmFiEEMwKoW0i8UpVEllCENI+cctoYVW4FAmSL
 GnkFCQWjmoACGwwACgkQNI+cctoYVW6cqwD/Q9R98msvkhgRvi18fzUPFDwwogn+F+gQJJ6o
 pwpgFkAA/R2zOfla3IT6G3SBoV5ucdpdCpnIXFpQLbmfHK7dXsAC
In-Reply-To: <20240410130557.31572-21-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/10/24 10:02, Thomas Zimmermann wrote:
> Implement fbdev emulation with fbdev-shmem. Avoids the overhead of
> fbdev-generic's additional shadow buffering. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

> Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Cc: Melissa Wen <melissa.srw@gmail.com>
> Cc: "Maíra Canal" <mairacanal@riseup.net>
> Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
>   drivers/gpu/drm/vkms/vkms_drv.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index dd0af086e7fa9..8dc9dc13896e9 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -17,7 +17,7 @@
>   #include <drm/drm_atomic.h>
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_drv.h>
> -#include <drm/drm_fbdev_generic.h>
> +#include <drm/drm_fbdev_shmem.h>
>   #include <drm/drm_file.h>
>   #include <drm/drm_gem_framebuffer_helper.h>
>   #include <drm/drm_ioctl.h>
> @@ -223,7 +223,7 @@ static int vkms_create(struct vkms_config *config)
>   	if (ret)
>   		goto out_devres;
>   
> -	drm_fbdev_generic_setup(&vkms_device->drm, 0);
> +	drm_fbdev_shmem_setup(&vkms_device->drm, 0);
>   
>   	return 0;
>   
