Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="gxXZbPtB"
X-Greylist: delayed 280 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Nov 2023 23:47:40 PST
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7255110E
	for <linux-fbdev@vger.kernel.org>; Tue, 21 Nov 2023 23:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=message-id:references:in-reply-to:reply-to:subject:cc:to:from:date:
	 content-transfer-encoding:content-type:mime-version:from;
	bh=oA1pu36Ecm05PvEFejRKpdd/suHx+bVmVkYV4CS0iV4=;
	b=gxXZbPtBe5x4WKBAbh1R5Bcv/cxbbPwF0B5lkQVb0eS4BI8iOHFGQFq8m5IpUcUcKWoNG802bMnam
	 uZRS2QDq/otL5+sXiWph7kXhaJl2CKC5/bierORRKfugG2hTzp9hP1n8ou1/NAg7nEkpLNyUT+9xqO
	 3N13mc4Ny/FlY8RZ7bIMrtK5nP+iHQn+N8CQAVd5lpAYJUU/qhzk7mTUFebVhn2U3/HSQHkhAT2tsp
	 n5BuoKBRj1YO0BV+3gJ3ugmB+mS8VzKmcGPEKX7Dnl6KqMuKBnpNgVxPyWCOix93/r67pH7LPP0DP3
	 j0MgXuk0TuIrTZwDwWUwjlZUfJ6R7iQ==
X-MSG-ID: 687177d5-890b-11ee-893f-0050568164d1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 22 Nov 2023 08:47:38 +0100
From: Robin van der Gracht <robin@protonic.nl>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, javierm@redhat.com, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 10/32] auxdisplay/ht16k33: Initialize fb_ops with fbdev
 macros
Organization: Protonic Holland
Reply-To: robin@protonic.nl
Mail-Reply-To: robin@protonic.nl
In-Reply-To: <20231115102954.7102-11-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-11-tzimmermann@suse.de>
Message-ID: <96c2d4bd1408de26af93b3380f372474@protonic.nl>
X-Sender: robin@protonic.nl
User-Agent: Roundcube Webmail/1.3.1 

On 2023-11-15 11:19, Thomas Zimmermann wrote:
> Initialize the instance of struct fb_ops with fbdev initializer
> macros for framebuffers in virtual address space. Set the read/write,
> draw and mmap callbacks to the correct implementation and avoid
> implicit defaults. Also select the necessary helpers in Kconfig.
> 
> Fbdev drivers sometimes rely on the callbacks being NULL for a
> default I/O-memory-based implementation to be invoked; hence
> requiring the I/O helpers to be built in any case. Setting all
> callbacks in all drivers explicitly will allow to make the I/O
> helpers optional. This benefits systems that do not use these
> functions.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Robin van der Gracht <robin@protonic.nl>
> ---
>  drivers/auxdisplay/Kconfig   | 5 +----
>  drivers/auxdisplay/ht16k33.c | 7 ++-----
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> index 4377e53f8f572..d944d5298eca8 100644
> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -167,10 +167,7 @@ config IMG_ASCII_LCD
>  config HT16K33
>  	tristate "Holtek Ht16K33 LED controller with keyscan"
>  	depends on FB && I2C && INPUT
> -	select FB_SYS_FOPS
> -	select FB_SYS_FILLRECT
> -	select FB_SYS_COPYAREA
> -	select FB_SYS_IMAGEBLIT
> +	select FB_SYSMEM_HELPERS
>  	select INPUT_MATRIXKMAP
>  	select FB_BACKLIGHT
>  	select NEW_LEDS
> diff --git a/drivers/auxdisplay/ht16k33.c 
> b/drivers/auxdisplay/ht16k33.c
> index f1716e3ce6a92..2f1dc6b4e2765 100644
> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -356,12 +356,9 @@ static int ht16k33_mmap(struct fb_info *info,
> struct vm_area_struct *vma)
> 
>  static const struct fb_ops ht16k33_fb_ops = {
>  	.owner = THIS_MODULE,
> -	.fb_read = fb_sys_read,
> -	.fb_write = fb_sys_write,
> +	__FB_DEFAULT_SYSMEM_OPS_RDWR,
>  	.fb_blank = ht16k33_blank,
> -	.fb_fillrect = sys_fillrect,
> -	.fb_copyarea = sys_copyarea,
> -	.fb_imageblit = sys_imageblit,
> +	__FB_DEFAULT_SYSMEM_OPS_DRAW,
>  	.fb_mmap = ht16k33_mmap,
>  };

Reviewed-by: Robin van der Gracht <robin@protonic.nl>
