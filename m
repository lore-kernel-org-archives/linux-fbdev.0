Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97A4233D7C;
	Fri, 27 Jun 2025 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011709; cv=none; b=Gi1o78oVPCjPhxnt0xiKw2WqfAKHd8Uz/dPymA0tcQNE4u+Ii2Kf41dun8u6WAMSAZihIy9/cyUELnh0CDMm3zM4Ph2/DC0OpVpGPZSGKTEiglRniOSPxvVIoc/9Pc7lwr0hwOnHXcB6+n69S0Ubq+Ii7z03OziukGivFjPrZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011709; c=relaxed/simple;
	bh=PYP9Imqu5GjDkVBHcvLr+ztBK6R3xQ+B5FYXugyhx3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxPLn+hrzQi83KmLa5yR6NbJDDEIp21DxL0lAHgUOjEYldubBgWNZsaJlutEIu2QPyH4Lne7WfJcujXTnrr3u7I2B687UZbZ09ZNinZ8MCuWgAXfQ5Ok33PiAO6HAhu3YOkWFyiXoJU4zvFBFsBPiNs9OEtkQF8NwuPIeMD693g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8DivVTB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8DivVTB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB9FC4CEED;
	Fri, 27 Jun 2025 08:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751011709;
	bh=PYP9Imqu5GjDkVBHcvLr+ztBK6R3xQ+B5FYXugyhx3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8DivVTBC8AdBk4Fn/V/IyMSs5cc29CEAiWP0gy3wE+6Rbj6bjo7KK5GhYoiMBsaV
	 /qrPrjmRHAtZjZHrpNC2OQOX1l7kpCRcva5Tuo3gCWhxUndg2auts/kO8ZjSEyyVqw
	 RaffDG9g62XJVhm3nHAfd4p7He45PfaBv3a8IL7CqYdiu7m1oOYjOiTLzukEq08w9P
	 8ncQO0Wy+GENY3BcPxhucS104Hgfmfd0NbpLtXcdY+35jcT8BGL7U1LF9LtZqpe2qI
	 iiywZ0Zl07ZTDFxOAd5rrH7i/FPgfWl0V+oyoqD99s38d4cgPeb05K8qAL98lvHfjg
	 mZ8JJDpyN7W3g==
Date: Fri, 27 Jun 2025 10:08:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Hans de Goede <hdegoede@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: display: simple-framebuffer: Add
 interconnects property
Message-ID: <20250627-mysterious-optimistic-bird-acaafb@krzk-bin>
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-1-f69b86cd3d7d@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623-simple-drm-fb-icc-v2-1-f69b86cd3d7d@fairphone.com>

On Mon, Jun 23, 2025 at 08:44:45AM +0200, Luca Weiss wrote:
> Document the interconnects property which is a list of interconnect
> paths that is used by the framebuffer and therefore needs to be kept
> alive when the framebuffer is being used.
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/display/simple-framebuffer.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> index 296500f9da05e296dbbeec50ba5186b6b30aaffc..f0fa0ef23d91043dfb2b220c654b80e2e80850cd 100644
> --- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> +++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> @@ -79,6 +79,9 @@ properties:
>    power-domains:
>      description: List of power domains used by the framebuffer.
>  
> +  interconnects:
> +    description: List of interconnect paths used by the framebuffer.
> +

maxItems: 1, or this is not a simple FB anymore. Anything which needs
some sort of resources in unknown way is not simple anymore. You need
device specific bindings.

Best regards,
Krzysztof

