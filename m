Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1824AC77B60
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Apr 2023 09:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239544AbjDZJoI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Apr 2023 05:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239819AbjDZJoG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Apr 2023 05:44:06 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 543CB10EB
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 02:44:03 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:35176.1168600400
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 41AF01002B2;
        Wed, 26 Apr 2023 17:43:58 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-85667d6c59-lhcrq with ESMTP id 88f4a772e8bf41fb8e056cbcaf3486a1 for tzimmermann@suse.de;
        Wed, 26 Apr 2023 17:44:01 CST
X-Transaction-ID: 88f4a772e8bf41fb8e056cbcaf3486a1
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <9f842e90-94f5-5d4b-36c4-25e157bed217@189.cn>
Date:   Wed, 26 Apr 2023 17:43:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [1/6] fbdev: Return number of bytes read or written
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        deller@gmx.de, geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230425142846.730-2-tzimmermann@suse.de>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <20230425142846.730-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

The whole patch set is tested with fbdev of IGT, on LoongArch with 
drm/radeon and efifb driver. Test results say SUCCESS. Tested-by: Sui 
Jingfeng <suijingfeng@loongson.cn>

On 2023/4/25 22:28, Thomas Zimmermann wrote:
> Always return the number of bytes read or written within the
> framebuffer. Only return an errno code if framebuffer memory
> was not touched. This is the semantics required by POSIX and
> makes fb_read() and fb_write() compatible with IGT tests. [1]
>
> This bug has been fixed for fb_write() long ago by
> commit 6a2a88668e90 ("[PATCH] fbdev: Fix return error of
> fb_write"). The code in fb_read() and the corresponding fb_sys_()
> helpers was forgotten.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Link: https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/fbdev.c # 1
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>   drivers/video/fbdev/core/fb_sys_fops.c | 24 ++++++++++++++----------
>   drivers/video/fbdev/core/fbmem.c       |  2 +-
>   2 files changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fb_sys_fops.c b/drivers/video/fbdev/core/fb_sys_fops.c
> index ff275d7f3eaf..cefb77b9546d 100644
> --- a/drivers/video/fbdev/core/fb_sys_fops.c
> +++ b/drivers/video/fbdev/core/fb_sys_fops.c
> @@ -19,7 +19,8 @@ ssize_t fb_sys_read(struct fb_info *info, char __user *buf, size_t count,
>   	unsigned long p = *ppos;
>   	void *src;
>   	int err = 0;
> -	unsigned long total_size;
> +	unsigned long total_size, c;
> +	ssize_t ret;
>   
>   	if (info->state != FBINFO_STATE_RUNNING)
>   		return -EPERM;
> @@ -43,13 +44,14 @@ ssize_t fb_sys_read(struct fb_info *info, char __user *buf, size_t count,
>   	if (info->fbops->fb_sync)
>   		info->fbops->fb_sync(info);
>   
> -	if (copy_to_user(buf, src, count))
> +	c = copy_to_user(buf, src, count);
> +	if (c)
>   		err = -EFAULT;
> +	ret = count - c;
>   
> -	if  (!err)
> -		*ppos += count;
> +	*ppos += ret;
>   
> -	return (err) ? err : count;
> +	return ret ? ret : err;
>   }
>   EXPORT_SYMBOL_GPL(fb_sys_read);
>   
> @@ -59,7 +61,8 @@ ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
>   	unsigned long p = *ppos;
>   	void *dst;
>   	int err = 0;
> -	unsigned long total_size;
> +	unsigned long total_size, c;
> +	size_t ret;
>   
>   	if (info->state != FBINFO_STATE_RUNNING)
>   		return -EPERM;
> @@ -89,13 +92,14 @@ ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
>   	if (info->fbops->fb_sync)
>   		info->fbops->fb_sync(info);
>   
> -	if (copy_from_user(dst, buf, count))
> +	c = copy_from_user(dst, buf, count);
> +	if (c)
>   		err = -EFAULT;
> +	ret = count - c;
>   
> -	if  (!err)
> -		*ppos += count;
> +	*ppos += ret;
>   
> -	return (err) ? err : count;
> +	return ret ? ret : err;
>   }
>   EXPORT_SYMBOL_GPL(fb_sys_write);
>   
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 3fd95a79e4c3..abc92d79a295 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -820,7 +820,7 @@ fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>   
>   	kfree(buffer);
>   
> -	return (err) ? err : cnt;
> +	return cnt ? cnt : err;
>   }
>   
>   static ssize_t
