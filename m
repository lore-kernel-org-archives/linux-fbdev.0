Received: from smtp.dnamail.fi (sender103.dnamail.fi [83.102.40.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DF023A9AA;
	Wed, 21 May 2025 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.102.40.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747868206; cv=none; b=PRjtaGC2JzDwSfsvwMpVS1T04ul6q2ovrB0ufaLukOjkw7ayAL6DmOU0MfdDprhVJRWSkOxT6/wmzyPFYibuhYPb3bhH7HObblDdD17Bt7mh3EyhN5iHv49S6I5K2RmnHhmwXwozps5ZXBj2WmhIB9ajUaHUbzeQtMrjSBEdKE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747868206; c=relaxed/simple;
	bh=qjK+CMLxbfWqwXxuTX0H4cVO3OwkU6LHFEwTySf84tI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvC8GB2tUxcQjVxK5L0sEWlBFDqTj+LPITPQ8df247As9evr7dpMeXEZQEo1ZmfOHkQxXj9mJz7EMFSclMcbuiHAe0wFfBJdZ0FERVetqxMQpBl8v+VCjKnT9XEElSbxC8UbifeDjds1VVDu/X4o2D9SXrJ/rDOkVAdfW8q3ZuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=helsinkinet.fi; spf=pass smtp.mailfrom=helsinkinet.fi; dkim=pass (2048-bit key) header.d=helsinkinet.fi header.i=@helsinkinet.fi header.b=WhEbB7lW; arc=none smtp.client-ip=83.102.40.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=helsinkinet.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helsinkinet.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=helsinkinet.fi header.i=@helsinkinet.fi header.b="WhEbB7lW"
Received: from localhost (localhost [127.0.0.1])
	by smtp.dnamail.fi (Postfix) with ESMTP id C2F1A4098E88;
	Thu, 22 May 2025 01:56:39 +0300 (EEST)
X-Virus-Scanned: X-Virus-Scanned: amavis at smtp.dnamail.fi
Received: from smtp.dnamail.fi ([83.102.40.157])
 by localhost (dmail-psmtp02.s.dnaip.fi [127.0.0.1]) (amavis, port 10024)
 with ESMTP id tqbCkjBvwo8f; Thu, 22 May 2025 01:56:39 +0300 (EEST)
Received: from [192.168.101.100] (78-27-104-28.bb.dnainternet.fi [78.27.104.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: oak@dnamail.internal)
	by smtp.dnamail.fi (Postfix) with ESMTPSA id 8801B4098E80;
	Thu, 22 May 2025 01:56:38 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.dnamail.fi 8801B4098E80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=helsinkinet.fi;
	s=2025-03; t=1747868199;
	bh=rxWxSwacKgU4eNtwkkpnfHn/5VnKtcytBSlilZZ2N5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WhEbB7lWQoodAAam58K7itDKTiLMgMklJDtLQ5QbCOOYlCIx51W2wcuYEjUFXqNjC
	 A1knSsdZ1WwbVc9fPgomeYYHm7ebyJKx1S+ykSw3dSwrjNtBjJiQ7U1h+0COJnAl7K
	 7VHYijq4IYfyDBeTxlknFbTU62hI4ifOltXn46GKvlM+a0DzD4O/H2YRP/gFXBHwCc
	 s50VYuKh/K3Adn4++aWH/JYrXKcDlXYap5xDErVvQc0xjSynSwVlXG1IqKWygBYH3u
	 UcaaTOno7e8V6b2M/4DQuEywyjveIioHl1STkSdgOWKKWuOLVFvWJZb7UNAHInx5hW
	 XTJ77fcj7oEkA==
Message-ID: <beed53f4-b0d6-4d1d-b5ec-2694d2b5d47a@helsinkinet.fi>
Date: Thu, 22 May 2025 01:56:38 +0300
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC 0/3] Atari DRM driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Michael Schmitz <schmitzmic@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-m68k@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <cover.1669406380.git.geert@linux-m68k.org>
 <a9883a81-d909-09c5-708b-d598e030380e@physik.fu-berlin.de>
 <CAMuHMdWHUnWBN7ddBow+fqmt8W--9wFe5x_YMeRg7GQ=BNAL2Q@mail.gmail.com>
 <74946b31-6166-44b0-b2a7-b0633f014b60@helsinkinet.fi>
 <CAMuHMdXSWiM_xofyfgpoc0Jj8a_PwRR_tFe79t8=-X85-7WZug@mail.gmail.com>
Content-Language: en-US
From: Eero Tamminen <oak@helsinkinet.fi>
In-Reply-To: <CAMuHMdXSWiM_xofyfgpoc0Jj8a_PwRR_tFe79t8=-X85-7WZug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Geert,

On 21.5.2025 10.06, Geert Uytterhoeven wrote:
> On Wed, 21 May 2025 at 01:59, Eero Tamminen <oak@helsinkinet.fi> wrote:
>> I tried your "atari-drm-wip-v1" branch commits on top of 6.14.
> 
> Thanks for testing!
> 
>> After some minor changes those applied. Getting it to build required
>> adding "&shadow_plane_state->fmtcnv_state" (struct drm_format_conv_state
>> *) argument to *_blit() functions in atari_drm.c, and changing:
>>          drm_fbdev_generic_setup(dev, dev->mode_config.preferred_depth);
>> in its probe function to:
>>          struct drm_format_info *format = NULL;
>>           drm_client_setup(dev, format);
> 
> I do keep it up-to-date locally, so I could provide these changes,
> if you are interested.

Yes, please!   (see below)


>> However, the result is not working very well yet.
>>
>> Driver gets initialized fine under Hatari TT emulation:
>> -------------------------
>> atafb atafb: phys_screen_base 511000 screen_len 311296
>> atafb atafb: Determined 1280x960, depth 1
>> atafb atafb:    virtual 1280x1945
>> Console: switching to mono frame buffer device 160x60
>> fb0: frame buffer device, using 304K of video memory
>> ...
>> atari_drm atari_drm: phys_screen_base 55d000 screen_len 311296
>> atari_drm atari_drm: Determined 1280x960, depth 1
>> atari_drm atari_drm:    virtual 1280x1945
>> [drm] Initialized atari_drm 1.0.0 for atari_drm on minor 0
>> atari_drm atari_drm: Atari DRM, using 304K of video memory
>> -------------------------
>>
>> However, once screen switches from "atafb" to "atari_drm" driver, Linux
>> boot logo & texts disappear, and (emulated) screen is either all white
>> (on mono monitor) or all black (on VGA & RGGB monitors).
> 
> So you have both atafb and atari_drm enabled? Please don't do that.

Disabling CONFIG_FB_ATARI option (but still keeping rest of FB options), 
worked worse:
-------------------------
atari_drm atari_drm: phys_screen_base 512000 screen_len 311296
atari_drm atari_drm: Determined 640x480, depth 4
atari_drm atari_drm:    virtual 640x972
[drm] Initialized atari_drm 1.0.0 for atari_drm on minor 0
atari_drm atari_drm: Atari DRM, using 304K of video memory
Data write fault at 0x00000020 in Super Data (pc=0x3115f6)
BAD KERNEL BUSERR
Oops: 00000000
PC: [<003115f6>] strcpy+0x16/0x22
SR: 2200  SP: (ptrval)  a2: 01026000
d0: 00000000    d1: 0000015b    d2: 0114e000    d3: 00319f2a
d4: 01181118    d5: 00000001    a0: 00000020    a1: 003e1cbf
Process swapper (pid: 1, task=(ptrval))
Frame format=A ssw=0315 isc=66f2 isb=2008 daddr=00000020 dobuf=0000005b
Stack from 01029c24:
         ...
Call Trace:
  [<001e6bc8>] __drm_fb_helper_initial_config_and_unlock+0x3a6/0x46c
  [<001e6cb0>] drm_fb_helper_initial_config+0x22/0x30
  [<001e85a0>] drm_fbdev_client_hotplug+0x6e/0x9c
  [<001d6efc>] drm_client_register+0x62/0x9e
  [<001e8714>] drm_fbdev_client_setup+0x146/0x14e
  [<00311650>] strcmp+0x0/0x34
  [<001e7bb6>] drm_client_setup+0x32/0xaa
  [<00007336>] _dev_info+0x0/0x34
  [<0044b472>] atari_drm_probe+0xd58/0xe32
...
-------------------------

=> due to me using NULL as drm_client_setup() "drm_format_info"?


>> And while "atafb" works fine also under Falcon emulation with RGB (50Hz)
>> or VGA (60Hz) monitor, "atari_drm" probing fails:
>> -------------------------
>> genirq: Flags mismatch irq 4. 00200000 (framebuffer:modeswitch) vs.
>> 00200000 (framebuffer:modeswitch)
> 
> That's also a sign of two drivers requesting the same IRQ unexpectedly.
> 
>> atari_drm atari_drm: probe with driver atari_drm failed with error -16
> 
> i.e. -EBUSY.

Ok, makes sense.


	- Eero

