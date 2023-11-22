Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="VF5AqAqq"
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333879D
	for <linux-fbdev@vger.kernel.org>; Tue, 21 Nov 2023 23:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=message-id:references:in-reply-to:reply-to:subject:cc:to:from:date:
	 content-transfer-encoding:content-type:mime-version:from;
	bh=SC0Nw0my4KjFTp1RacZCDCq2iioSI8JO41AN2e4nWTY=;
	b=VF5AqAqqnjRkem47thuhhInpkmmmxgG7odln5T5AkNXvm1TP8Q4p9OflI7MFxN79WsXgeFj8FLpR0
	 1Px4GtAvbH9I1n4mgnI89TidxsqnvShDMljdpTIcJIJxk+zRyXT86oqhCZ1SfUUXTtqriUayBvGrkF
	 grRvewyPVP2aM3iKlenteSYJQWhzohl+Gd8YTVHCLcW4zUxbHXTWbLAU5oG3jaKC2lOjwtn4ZDGRci
	 9tZQ4hYrJhUI3eghqgcA84E7vx159IIvJHpi8qoutHtSrvwdgyr0lt0k19qAmcMtd2Pwi9Dpcoso88
	 xHpN81P9EgYThVmsNWYmAMcDIXUL2AQ==
X-MSG-ID: c1304799-890a-11ee-893f-0050568164d1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 22 Nov 2023 08:42:57 +0100
From: Robin van der Gracht <robin@protonic.nl>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: deller@gmx.de, javierm@redhat.com, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 09/32] auxdisplay/ht16k33: Set FBINFO_VIRTFB flag
Organization: Protonic Holland
Reply-To: robin@protonic.nl
Mail-Reply-To: robin@protonic.nl
In-Reply-To: <20231115102954.7102-10-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-10-tzimmermann@suse.de>
Message-ID: <6eacca1f78abb718ed1b5bb8b37b6e95@protonic.nl>
X-Sender: robin@protonic.nl
User-Agent: Roundcube Webmail/1.3.1 

On 2023-11-15 11:19, Thomas Zimmermann wrote:
> The ht16k33 driver operates on system memory. Mark the framebuffer
> accordingly. Helpers operating on the framebuffer memory will test
> for the presence of this flag.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Robin van der Gracht <robin@protonic.nl>
> ---
>  drivers/auxdisplay/ht16k33.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/auxdisplay/ht16k33.c 
> b/drivers/auxdisplay/ht16k33.c
> index 3a2d883872249..f1716e3ce6a92 100644
> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -640,6 +640,7 @@ static int ht16k33_fbdev_probe(struct device *dev,
> struct ht16k33_priv *priv,
> 
>  	INIT_DELAYED_WORK(&priv->work, ht16k33_fb_update);
>  	fbdev->info->fbops = &ht16k33_fb_ops;
> +	fbdev->info->flags |= FBINFO_VIRTFB;
>  	fbdev->info->screen_buffer = fbdev->buffer;
>  	fbdev->info->screen_size = HT16K33_FB_SIZE;
>  	fbdev->info->fix = ht16k33_fb_fix;

Acked-by: Robin van der Gracht <robin@protonic.nl>
