Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C8043CE6F;
	Wed, 30 Sep 2026 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754647; cv=none; b=h+RlOUJZ9AIg9xHT+iTfm/XtPyTffZQhvnRGN9VwNUncxJ2EOlEVtAWZ5md5PXFFxn9S3p+Zv1Zq/O/39Vh3bZd2MydnUWscSPVaV+A7dWcMMWew+Jp+a0UJyZhGVFBJ4f5dO4W7C+RrMwW42dr/hSXsan60mcow4+TR8Xd1XVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754647; c=relaxed/simple;
	bh=IInOjLoOZqxUF/njRAMUReLIxY4PvR3rCdK4jUYFbdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D//g1WW+XlLE6EIabjq//nHhb/4PuI/LgfqdTM7X0N6A+EhRgaotX6xyWkvDqfJMapt3v8/ntPwEft3XQOuuj7NKOuaCNFPWMZhbZY9yE2jXzHbybFCZum6fRkWbaW8CqSj+NG6aIk3Y69VtpM+Dqkp1vdabZnsaJTMAxVmNQMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=G/99nNpV; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="G/99nNpV"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hvnK72P1czKnd1;
	Wed, 30 Sep 2026 09:50:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790754635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rb4nWwlxaPy2o69lqksbAluMfoEqrzWeYPEQbVBWoFQ=;
	b=G/99nNpVvjN+Q4t0ht6oc9WzRJSmnV1DgJ/PvIQS3FkjTeoiT4PpJrrETsDyYBulpx3DFh
	1MygqaTB5J0gxRy2nzvPif1T0eoIR0rRfMMokq8CM2UVlIzJ2C1wxerxl9FaZcfrR6MfB9
	0QJxx9lP5f1nSfL223tsigokddcdZY5e0Fuq7cIpm+QR80SNfkhxIK2i70luRqutJT1IGy
	fG9W6cJ7lc4NclOYhTCv55AY4IGFUzyujT/zM8is1SxeQY41bygWNZM9geTXJAiCeeIXmk
	VCbYbkFpkaaYZfE6euWAPK3k2cjFPKVQk0qpEvjzMoq0aYCFyhMQHcvn+nd+zg==
Message-ID: <d1280ea9-ef96-42c5-a613-a4db8de0e9f2@mailbox.org>
Date: Wed, 30 Sep 2026 09:50:27 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/25] drm/connector: hdmi: Add VTEM EMP generation
To: Vidith Madhu <vmadhu@nvidia.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com, Derek Foreman <derek.foreman@collabora.com>,
 wayland-devel@lists.freedesktop.org
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-6-2fcd7d011646@collabora.com>
 <a5bc012a-9b9e-eb2b-d67e-a91f2d93d6bf@nvidia.com>
 <FJ8OpdCORV2b1oivG9-G9Q@collabora.com>
 <9dccf035-2806-7b92-ce17-00f95bcf773a@nvidia.com>
Content-Language: en-CA
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <9dccf035-2806-7b92-ce17-00f95bcf773a@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: g68zfnwjayxji9kxshey3fmwfqszuo7m
X-MBO-RS-ID: e699964b73b7c292c05

On 9/29/26 20:55, Vidith Madhu wrote:
> On Sat, 26 Sep 2026, Nicolas Frattaroli wrote:
>> On Friday, 25 September 2026 05:48:54 Central European Summer Time Vidith Madhu wrote:
>>
>>> Maybe it would make sense to extend the qms_enabled connector property 
>>> introduced in this patchset to an enum of {Off, Gaming, QMS}? This would allow
>>> a standard path to control the VRR state on the sink, separately from
>>> vrr_enabled.
>>
>> An earlier version of the patch series I was working on internally had a
>> VRR limiter property that would either be Off (i.e. Game), Game-Limited,
>> QMS-Limited, and it self-inflicted some amount of confusion because of
>> the way things were named, so I refactored it to the limiter values being
>> what determines whether a limiter is used, and the QMS enable to determine
>> whether QMS is used to apply said limit. So my initial reaction is to be
>> hesitant about expanding the collection of possible states exposed through
>> the uAPI.
>>
>> To help my understanding: what does
>>
>>  vrr_enabled=true
>>  $new_property=Off
>>
>> mean for presentation?
> In this case, it should be acceptable to disable VRR on both the source 
> and sink and effectively ignore vrr_enabled=true. From reading
> https://elixir.bootlin.com/linux/v7.2.8/source/drivers/gpu/drm/drm_connector.c#L2370
> vrr_enabled is essentially a hint and there is no need to reject commits 
> because of its value (at least, that is how we handle it in the NVIDIA 
> driver).

I presume you're referring to this:

 *	The driver will take this property as a hint to enable variable
 *	refresh rate support if the receiver supports it, ie. if the
 *	"vrr_capable" property is true on the &drm_connector object.

My reading of that is simply: "If vrr_capable=0, VRR_ENABLED=1 has no effect" (i.e. kind of stating the obvious :). Not sure I see the justification for VRR_ENABLED being "just a hint" beyond that.


>> Another state I'm curious about is
>>
>>  vrr_enabled=false
>>  $new_property=Game
>>
>> which I assume is the case you're interested in, where the compositor does
>> not want VRR presentation but we're keeping the sink in Game mode to avoid
>> having the display go blank.
> That's right, in this case VRR is enabled on the sink but deactivated 
> source-side. For NVIDIA, there is a distinct HW "deactivated" state of 
> VRR, but we could achieve the same result by setting the frame range 
> limits to a fixed value as you suggested.
>>
>> is that correct, and something that does need an expanded property? I feel
>> like userspace could be smart enough to do that by keeping vrr_enabled=true
>> and then setting a fixed target, if the goal is to have non-VRR but with the
>> display still in VRR mode.
> I agree, I am a little concerned though about the transition period for 
> compositors to adopt this new model. I know for example KDE is using the 
> vrr_enabled property for their "AdaptiveSync" option, and it seems like it 
> would be a regression if all of a sudden toggling it caused display 
> blanking on newer kernels.

Yes it would be, also for mutter, which currently sets VRR_ENABLED to 1 only while there's a surface fully covering the screen.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
