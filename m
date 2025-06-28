Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C9222370D;
	Sat, 28 Jun 2025 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751111449; cv=none; b=szPT58LkrK59TKOebflqjkig9PDvpdT3zCU1beAZeOXXne0AjcNWMkWFAbrUGaICVHIhz7wc7wvfOBa4Xlqffh9lILcpmyNyaqmduJKAiTz2DnyEXQwzfx4hE4C450v6RSiR3I3I9rqJI8vH67J3Fi3pNFoFvLnAP5EwE2N0U1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751111449; c=relaxed/simple;
	bh=pSV6l3T7JmbSCdl9fP3e9xqmfil0Of6rRvqXh+ApX/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOooZNIoj9mG/r7Fv/avQO/52AOiWCg6QKa2gXpMgrQSc/NFxmITrju4IKQpLOFJ62GJ/ppRdWSZ/J4zLLY+U2NDTTNeLGqJfsPGWVmvDQN0p8aAJVAygJ/269TiZS+djNpKQPuacqP56BSgI0yTwY6MqS1i0W5+M/Nb+7fvslA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwFrBJ0u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwFrBJ0u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40600C4CEEA;
	Sat, 28 Jun 2025 11:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751111448;
	bh=pSV6l3T7JmbSCdl9fP3e9xqmfil0Of6rRvqXh+ApX/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bwFrBJ0uiRaZwBWweZ1XvO+QkqB2Q3cQ9ZIwpIuYH04iOvL5y+Mh9OMJYqEGqt/e4
	 0XZ6VZxtasWfRRFt+q72dzoD9ihhGqkneLsdSQJm/7Ijc21wLEojyfNzbaOVOvu6QV
	 3XezHpc0a8tK7zYvtohyfbWUisKqSPlco2TZdo5ttUUFUPnF+wOkWcfNA3/+0JcQgF
	 jTmjwYyD0lJcAxftp3mgKYl+8rgdgAlpKnkG8czV1OY3PNy3Z3CqqVFJzB97JaMZRz
	 EbJFQetmLkU9zsGhSEpxYtQTlPvAUe05AX8cE7mP1V0dcRv+mD2wK9uPo30V8enNZH
	 BUKz8wWbtv04Q==
Message-ID: <b94b752c-d7f7-41d6-ac79-d21427f20964@kernel.org>
Date: Sat, 28 Jun 2025 13:50:40 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: display: simple-framebuffer: Add
 interconnects property
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Luca Weiss <luca.weiss@fairphone.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Javier Martinez Canillas <javierm@redhat.com>,
 Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-1-f69b86cd3d7d@fairphone.com>
 <20250627-mysterious-optimistic-bird-acaafb@krzk-bin>
 <d8d85415-efc4-4a11-842e-23272cae29f7@suse.de>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <d8d85415-efc4-4a11-842e-23272cae29f7@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/06/2025 13:34, Thomas Zimmermann wrote:
> Hi
> 
> Am 27.06.25 um 10:08 schrieb Krzysztof Kozlowski:
>> On Mon, Jun 23, 2025 at 08:44:45AM +0200, Luca Weiss wrote:
>>> Document the interconnects property which is a list of interconnect
>>> paths that is used by the framebuffer and therefore needs to be kept
>>> alive when the framebuffer is being used.
>>>
>>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>>   Documentation/devicetree/bindings/display/simple-framebuffer.yaml | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
>>> index 296500f9da05e296dbbeec50ba5186b6b30aaffc..f0fa0ef23d91043dfb2b220c654b80e2e80850cd 100644
>>> --- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
>>> +++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
>>> @@ -79,6 +79,9 @@ properties:
>>>     power-domains:
>>>       description: List of power domains used by the framebuffer.
>>>   
>>> +  interconnects:
>>> +    description: List of interconnect paths used by the framebuffer.
>>> +
>> maxItems: 1, or this is not a simple FB anymore. Anything which needs
>> some sort of resources in unknown way is not simple anymore. You need
>> device specific bindings.
> 
> In this context, 'simple' means that this device cannot change display 
> modes or do graphics acceleration. The hardware itself is not 
> necessarily simple. As Javier pointed out, it's initialized by firmware 

If hardware is not simple, then it needs specific bindings.

> on the actual hardware. Think of 'VGA-for-ARM'. We need these resources 
> to keep the display working.

I don't claim you do not need these resources. I claim device is not
simple thus does not suit rules for generic bindings. Generic bindings
are in general not allowed and we have them only for very, very simple
devices.

You say this is not simple device, so there you go - specific binding
for this complex (not-simple) device.

Best regards,
Krzysztof
