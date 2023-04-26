Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D005C7618E
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Apr 2023 09:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbjDZJsD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Apr 2023 05:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239464AbjDZJsC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Apr 2023 05:48:02 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8242893
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 02:48:01 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:38762.2023710090
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 26301100295;
        Wed, 26 Apr 2023 17:47:57 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-85667d6c59-fm8l8 with ESMTP id 0a935bf104c846ef8f3df231bf76989a for tzimmermann@suse.de;
        Wed, 26 Apr 2023 17:48:00 CST
X-Transaction-ID: 0a935bf104c846ef8f3df231bf76989a
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <543eca5e-bb10-c723-e0ea-d79c9603f454@189.cn>
Date:   Wed, 26 Apr 2023 17:47:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [2/6] fbdev: Use screen_buffer in fb_sys_{read,write}()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        deller@gmx.de, geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230425142846.730-3-tzimmermann@suse.de>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <20230425142846.730-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Tested-by: Sui Jingfeng <suijingfeng@loongson.cn>

On 2023/4/25 22:28, Thomas Zimmermann wrote:
> Use info->screen_buffer when reading and writing framebuffers in
> system memory. It's the correct pointer for this address space.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>   drivers/video/fbdev/core/fb_sys_fops.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fb_sys_fops.c b/drivers/video/fbdev/core/fb_sys_fops.c
> index cefb77b9546d..6589123f4127 100644
> --- a/drivers/video/fbdev/core/fb_sys_fops.c
> +++ b/drivers/video/fbdev/core/fb_sys_fops.c
> @@ -39,7 +39,7 @@ ssize_t fb_sys_read(struct fb_info *info, char __user *buf, size_t count,
>   	if (count + p > total_size)
>   		count = total_size - p;
>   
> -	src = (void __force *)(info->screen_base + p);
> +	src = info->screen_buffer + p;
>   
>   	if (info->fbops->fb_sync)
>   		info->fbops->fb_sync(info);
> @@ -87,7 +87,7 @@ ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
>   		count = total_size - p;
>   	}
>   
> -	dst = (void __force *) (info->screen_base + p);
> +	dst = info->screen_buffer + p;
>   
>   	if (info->fbops->fb_sync)
>   		info->fbops->fb_sync(info);
