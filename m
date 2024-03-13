Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C341FAA
	for <linux-fbdev@vger.kernel.org>; Wed, 13 Mar 2024 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317960; cv=none; b=rshPKCfBr4o3WI7dGcUWfY5SIH6kLE/BchxGI45Rt+yuI+MQc7FOOnCMtayQF6P/eOGH3Hw9hmBYn0EWxMM2kuiJ3RtAnk1i/ZOZFTv7IbrUpZHEO0ru2u7xE5GGzjxTsRv62uIvpA44IGMm50U5LgRwM6tNidgbdsfb9pBTe1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317960; c=relaxed/simple;
	bh=eqbVD2RRAu0aG0Y7BNvgXlEwkmxg4EY2eyGp4+aktS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpuIJRKcNeFlDVnFTJFJ89Q3ucjCVcV3b6hTQbbkF2UBVng00nI7nLGkZVhohvFpefi1bOzdSzTPNP1L34CdWiBLVhC+cWycLym1/wRCecbTVUl47Lr7HnlSmCxvuyg4z3yHt5uSoixA5yG+J32Z0AC8QONW+MdXSm9ZgLQwSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JqwDSlLt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dnkw+AGr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JqwDSlLt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dnkw+AGr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JqwDSlLt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dnkw+AGr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JqwDSlLt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dnkw+AGr"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 454DA21BF3;
	Wed, 13 Mar 2024 08:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710317956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cDUKent5Xk2xiMN9gTplv3IujH718NTiZjFGKKjtURI=;
	b=JqwDSlLtsCx0ouHS9684tbHtkckLhYbGF6x0zhrXM0TngutBSq9KjEK8hnSlKcI8foihbL
	X9TNfyS0CSj3itScbzd8DEv5GZlEAV8ZnFRFFoeQ7smz+QFRv20ot/5Q3j/nw3ynmAPxTt
	h9dbp4Onau90ITbtfCut8Uc9QG5wVhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710317956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cDUKent5Xk2xiMN9gTplv3IujH718NTiZjFGKKjtURI=;
	b=dnkw+AGrKEvG2yzNgFpDE7KzHaOOFvSuRhSQWebhYZFD2A1yD23reMTYfLnT+95F3m4q4h
	rs2amlqpg3gW+hCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710317956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cDUKent5Xk2xiMN9gTplv3IujH718NTiZjFGKKjtURI=;
	b=JqwDSlLtsCx0ouHS9684tbHtkckLhYbGF6x0zhrXM0TngutBSq9KjEK8hnSlKcI8foihbL
	X9TNfyS0CSj3itScbzd8DEv5GZlEAV8ZnFRFFoeQ7smz+QFRv20ot/5Q3j/nw3ynmAPxTt
	h9dbp4Onau90ITbtfCut8Uc9QG5wVhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710317956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cDUKent5Xk2xiMN9gTplv3IujH718NTiZjFGKKjtURI=;
	b=dnkw+AGrKEvG2yzNgFpDE7KzHaOOFvSuRhSQWebhYZFD2A1yD23reMTYfLnT+95F3m4q4h
	rs2amlqpg3gW+hCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 117A913980;
	Wed, 13 Mar 2024 08:19:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XN4UA4Rh8WUmXgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 13 Mar 2024 08:19:16 +0000
Message-ID: <ebea6554-835a-42d6-a226-f4f3480a8846@suse.de>
Date: Wed, 13 Mar 2024 09:19:15 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/43] drm/fbdev: Add fbdev-shmem
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de, javierm@redhat.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-9-tzimmermann@suse.de>
 <CAMuHMdVqWF=M=6aPRxZ0MBqPVM_wk2x+Oike6za754riHWusSA@mail.gmail.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <CAMuHMdVqWF=M=6aPRxZ0MBqPVM_wk2x+Oike6za754riHWusSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.09 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,gmx.de,redhat.com,vger.kernel.org,lists.freedesktop.org];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -3.09
X-Spam-Flag: NO

Hi Geert

Am 12.03.24 um 17:14 schrieb Geert Uytterhoeven:
> Hi Thomas,
>
> On Tue, Mar 12, 2024 at 4:48 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Add an fbdev emulation for SHMEM-based memory managers. The code is
>> similar to fbdev-generic, but does not require an addition shadow
>> buffer for mmap(). Fbdev-shmem operates directly on the buffer object's
>> SHMEM pages. Fbdev's deferred-I/O mechanism updates the hardware state
>> on write operations.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Thanks for your patch!
>
>> --- /dev/null
>> +++ b/drivers/gpu/drm/drm_fbdev_shmem.c
>> +static int drm_fbdev_shmem_helper_fb_probe(struct drm_fb_helper *fb_helper,
>> +                                          struct drm_fb_helper_surface_size *sizes)
>> +{
>> +       struct drm_client_dev *client = &fb_helper->client;
>> +       struct drm_device *dev = fb_helper->dev;
>> +       struct drm_client_buffer *buffer;
>> +       struct drm_gem_shmem_object *shmem;
>> +       struct drm_framebuffer *fb;
>> +       struct fb_info *info;
>> +       u32 format;
>> +       struct iosys_map map;
>> +       int ret;
>> +
>> +       drm_dbg_kms(dev, "surface width(%d), height(%d) and bpp(%d)\n",
>> +                   sizes->surface_width, sizes->surface_height,
>> +                   sizes->surface_bpp);
>> +
>> +       format = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
> Oops, one more caller of the imprecise
> let's-guess-the-format-from-bpp-and-depth machinery to get rid of...

Right, that has been discussed in another thread. I'll change this call 
to the drm_driver_() function.

>
>> +       buffer = drm_client_framebuffer_create(client, sizes->surface_width,
>> +                                              sizes->surface_height, format);
> [...]
>
>> +}
>> +/**
>> + * drm_fbdev_shmem_setup() - Setup fbdev emulation for GEM SHMEM helpers
>> + * @dev: DRM device
>> + * @preferred_bpp: Preferred bits per pixel for the device.
>> + *                 32 is used if this is zero.
>> + *
>> + * This function sets up fbdev emulation for GEM DMA drivers that support
>> + * dumb buffers with a virtual address and that can be mmap'ed.
>> + * drm_fbdev_shmem_setup() shall be called after the DRM driver registered
>> + * the new DRM device with drm_dev_register().
>> + *
>> + * Restore, hotplug events and teardown are all taken care of. Drivers that do
>> + * suspend/resume need to call drm_fb_helper_set_suspend_unlocked() themselves.
>> + * Simple drivers might use drm_mode_config_helper_suspend().
>> + *
>> + * This function is safe to call even when there are no connectors present.
>> + * Setup will be retried on the next hotplug event.
>> + *
>> + * The fbdev is destroyed by drm_dev_unregister().
>> + */
>> +void drm_fbdev_shmem_setup(struct drm_device *dev, unsigned int preferred_bpp)
> As this is a completely new function, can we please get a
> preferred_format parameter instead?

An understandable question. But as it is, the patchset has a trivial 
change in each driver. And the preferred_bpp parameter has the same 
meaning as the bpp value in the video= parameter. So it's ok-ish for now.

Using a format parameter here is really a much larger update and touches 
the internals of the fbdev emulation. I'm not even sure that we should 
have a parameter at all. Since in-kernel clients should behave like 
userspace clients, we could try to figure out the format from the 
driver's primary planes. That's a patchset of its own.

Best regards
Thomas

>
>> +{
>> +       struct drm_fb_helper *fb_helper;
>> +       int ret;
>> +
>> +       drm_WARN(dev, !dev->registered, "Device has not been registered.\n");
>> +       drm_WARN(dev, dev->fb_helper, "fb_helper is already set!\n");
>> +
>> +       fb_helper = kzalloc(sizeof(*fb_helper), GFP_KERNEL);
>> +       if (!fb_helper)
>> +               return;
>> +       drm_fb_helper_prepare(dev, fb_helper, preferred_bpp, &drm_fbdev_shmem_helper_funcs);
>> +
>> +       ret = drm_client_init(dev, &fb_helper->client, "fbdev", &drm_fbdev_shmem_client_funcs);
>> +       if (ret) {
>> +               drm_err(dev, "Failed to register client: %d\n", ret);
>> +               goto err_drm_client_init;
>> +       }
>> +
>> +       drm_client_register(&fb_helper->client);
>> +
>> +       return;
>> +
>> +err_drm_client_init:
>> +       drm_fb_helper_unprepare(fb_helper);
>> +       kfree(fb_helper);
>> +}
>> +EXPORT_SYMBOL(drm_fbdev_shmem_setup);
>
> Gr{oetje,eeting}s,
>
>                          Geert
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)

