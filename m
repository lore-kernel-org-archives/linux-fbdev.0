Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795549798;
	b=vHfycXuOnpK2ugWErQtqbJiPEMPtS+pkdMpz0ZWfH0RmbZZosahOXutekOcll3NmWhaz
	 TKj1aXFgcd7079BthQzmGPS6JWOOX+8dQ4NcCe7Ou/zFdAS0LGBnb+G24BY+Fe5z0znV3
	 LcH5gZoVYD8BEOJ0yKvI5GyoN+ScECwGzrUR6GAIz8PPXj84OlCxGE5XmZwr2B2BVWvqE
	 moDih7bklrOAbjJtV96psy2tfYixd/96yj9ZynwZbjDoIw+ge5J+oK9+4E00jYTam4ggh
	 OBWpxB1lpfZQCX3wg3hZba4oANtXjODXOXIgjQUoBKg9JW/4FQcA+JS7i7kwAiHrzPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549798;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=3vQN+p5rn0xSzztfNibN0piC3NtsdsJU2CPlg44+nds=;
	b=0B49Peje9xeGmpodqyX8nO+LqOVwESd0xTKnlBPd+M1mK309y+XfmU4hC2mOeJ37sRCC
	 yvgeaKR+eplYYsbO89Q471V0GUM64QSUR1TJ5qs5W3moGAyluGifCtjm3zgJOpDp4lFoa
	 +vp6+pIj6Ekt7bEC6H31aNib6bsQU5VsXGp7tY8BMWZzpm5FgFnUy6U0gi5lgCLX6cXoP
	 I0AiCUNgeX/dGekKmfs30UFhVF4pB5ePFAvUBQoVGgt6KFntLqPtGD/XaaYBcVf6+4tai
	 yxNmF2jiVTh6MTNg4CiCT4GeRrX4dGUmZIuD3uW4+G9O7fkE+MDXLnELfJtY8mKZF7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=F+B7eqKV;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1D4606A32D;
	Tue, 24 Nov 2026 19:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A1D4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=F+B7eqKV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795549796;
	bh=5+s3ntbrWWKLh7zmQebaGp4DJFwhHHTRju1hyqw1NWY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F+B7eqKVvizIse/ZJu2JcFT0aznOBckGoON/nDF/bRi2SNlidw6B7KJtluVFz9Boh
	 m28lpeAl62x+DfW4To84cgQOW8eGEj3PeKWbQuJTg/6MHkKFdHnd532MF38gqeSWPg
	 YgR5gENYbFJVDuX1jPDCxp/VHT/5HKdALWT/+wJLXpoC85vKJwBa3dNb7uTDm2oRvU
	 sjKaRNFncg7W1GxixFbLnYShuC1sZdofUCSQg7iJWGlCGdfQI8TsrjoCrEjgtAIx3E
	 ouOe3Nw33BQ20w07l51t8BeSx+8DNYDT3S2riYaaM9KWVwsV3r1597eObaMi5Z9AdX
	 NxdzoBJKiTweg==
Received: from [100.64.0.241] (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CC26F17E010E;
	Tue, 24 Nov 2026 20:49:55 +0100 (CET)
Message-ID: <a267fd1e-412a-489b-8c2f-be95b6ad8b31@collabora.com>
Date: Tue, 24 Nov 2026 21:49:55 +0200
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/25] drm/display: hdmi-state-helper: Reject connectors
 lacking HDMI funcs
To: Maxime Ripard <mripard@kernel.org>
Cc: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>,
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, kernel@collabora.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
 <20261114-drm-conn-hdmi-cleanup-v1-4-20e8a33a2286@collabora.com>
 <awQ37kPdVr3Rb4rL@houat>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <awQ37kPdVr3Rb4rL@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Maxime,

Thanks for checking this out!

On 11/23/26 2:57 PM, Maxime Ripard wrote:
> On Sat, Nov 14, 2026 at 08:03:28PM +0200, Cristian Ciocaltea wrote:
>> drm_atomic_helper_connector_hdmi_check() must only be used with
>> connectors set up via drmm_connector_hdmi_init(), which guarantees
>> connector->hdmi.funcs is set.
> 
> I don't think that's true or mandated anywhere, and just like any other
> helpers, we'll probably end up with a driver reusing parts of the states
> but reimplementing part of the logic.

Ack, I will drop drm_WARN_ON_ONCE() and move the guard in hdmi_compute_config(),
before accessing connector->hdmi.funcs->max_bpc.

I would simply return -EINVAL with a proper debug message, rather than forcing
max_bpc to 0 and letting hdmi_compute_format_bpc() still be called, which would
generate a bunch of potentially misleading "output format not supported for any
bpc count" messages.

Regards,
Cristian

> 
> Maxime
> 
>> Other connectors used to fail gracefully: with max_bpc and
>> supported_formats both zero, hdmi_compute_config() found no usable
>> format/bpc combination and returned -EINVAL before
>> hdmi_generate_infoframes() dereferenced hdmi.funcs.
>>
>> As those fields are being replaced by drm_connector_hdmi_funcs
>> counterparts, hdmi_compute_config() would dereference hdmi.funcs right
>> away.  To preserve the old behaviour, return an error early for such
>> connectors, and use drm_WARN_ON_ONCE() to flag the driver bug.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> index c50cedc7fa65..f533d5a7aab9 100644
>> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> @@ -912,6 +912,9 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
>>  	if (!new_conn_state->crtc || !new_conn_state->best_encoder)
>>  		return 0;
>>  
>> +	if (drm_WARN_ON_ONCE(connector->dev, !connector->hdmi.funcs))
>> +		return -EINVAL;
>> +
>>  	ret = hdmi_compute_config(connector, new_conn_state, mode);
>>  	if (ret)
>>  		return ret;
>>
>> -- 
>> 2.56.0
>>
