Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593F71F4181
	for <linux-fbdev@vger.kernel.org>; Fri, 11 Jul 2025 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752220159; cv=none; b=B6AvbQlA+95r3yuU/rm1AOEekr8rtievk3hsTepb13U6myKWTW8EkjWs/2PPQyVVTfQw/51fBy43w6QGzO8k8HRf7QB/smfu3wyMF9Fa/jsRNy7ZP2lhGqH4vxuXC5aj7pi5bsMR3StD1Luh1ZgOqwwGRtBK27qkwRQU7jvXcfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752220159; c=relaxed/simple;
	bh=mnRVnOn745rc6zlhW3a70pKs5ebcseZrteDQiLGcxlI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=V6LXlEDWlf/GdFNDFoTsDzYyDyjiRe2HOq0gO/jma/V2bFvOktMicwWzsMX9o+B+zESNj7euhUNLIzGWpg7ZCfsIkMdklVUelYKf1BtfGlmBOheNwh75my2cetvoYru9NJ6SGHyEBKgHcU89WyLurAPxiCODziWQuIzAFK5jOTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=wJb5lVgd; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="wJb5lVgd"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso3347368a12.0
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Jul 2025 00:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752220155; x=1752824955; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuj2RXHOOyKDpGAVts46ctP8tG8E0kUzK0aOC3W5/W4=;
        b=wJb5lVgdrc+Awpros3y9s4ry0nXiWlN0JEYHcUFmD7EV5XtdqSjSUWUTcKCUyi2nLC
         im/9V9PK91WjBZd3qpINyvRaTc9Dx7NyBIHdsrZ4sQdKtRNNhD59Fk1NLqEQW8L0YTO1
         mgAg9I3aHiKnfCLuqQf3m3ZXBNBrqQPyAhN88wB2ViP2usiQbhgsznujGgQjRTj6UyCQ
         D3BIPutJv87De6qlFztccKRM9acwTKJ33s5G+GejpahI5dVmPeMg0SoVGDVDIuT/pWdK
         zn9h86GtkEQ+bNwDFgkCwp6g9T9fSKMOqC7BfSBk7+E6yi1158hdTOzz4dDP6AeLYk1X
         3oIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752220155; x=1752824955;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vuj2RXHOOyKDpGAVts46ctP8tG8E0kUzK0aOC3W5/W4=;
        b=CLuaM1HauziA9BySFrQjovyGsQVgRbqQ37meFgAIiHBYm/n5vZ6Br4lRvFOip0QUoZ
         tlpq7HEaHck7C2ZCIE8oo+2pPrWenGq/DBj7CC3ZYIPFn8FjK6OKoxPBlEog8j3frG1l
         mYc0pXdWZEc5dz+H3TqNAw3HRNnI6Dy3E2VnBGBUPAsXDaC80X1KhPdmS+HFT3NTnO44
         2Vte4d4rtjVQVnNOFGWMon670sJJhX9Pd7PMRabT0fB27jZhAbvAMtKJjmc8gvvqK/Au
         oDc2q33MxUmIla+KYRJ7fFHsbO0oXEGYP6qSaSYX22xtUPUcOn48elYlVvonsbmd9VwH
         UGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4b6kVuine/Mk/FNIHaywk1CFM5Imw6N7NYl8GkWjKWTBMrFK6TFZueyhNM6PnR94svxDNaDA8mtrlSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJYHG0Rx1Zf8AA0zRQG8+zBZ5AFpzO+8k9ZUpNpm8qMOICFCkN
	8iOaIdp84nznih79cLLk2a557ATyJd2R1SUpiFj2mqXo3+NFniKNlmCHvQ0zCvfNit8=
X-Gm-Gg: ASbGncsxTmxvPh20+iyWcZeUO1oAaYCQOOXDxGPfJHncCCLb5e4m7aV9DIzhGFla6j1
	iJWDXxQvtY49jFZGb+iJv9iMbDmcAw10id8a5vwfxYhc1mRCs6Ahc6bh1cM9dkF6x7PxmL4x+Im
	2xldbXc6K3tihdfrduJu0dnK9XfWVcJr50oBa7VPRVYOS198EyE1zdhSOu5JcnilrFBWeLN/VqV
	YkbkQ4M5X2Ro9TjWUGvzV8GCNY4AjjhPNh3jhpp18nbQlSH1xFkFG0jGEIBg1bAyzg81NQypCkK
	JMYZnO6UD7nbwMLsuaf64uG9mDIqbjdK6IJ6aLU4cNBpPqi6Zm4IqjFprRbqoCGn17nhPikBUXP
	6HRqG21WzW6wi2EzoilK++QKq4HKUHrXWpM1iuxl7U+bAmrZijRYh05Rgk8sJ3vk0tL4=
X-Google-Smtp-Source: AGHT+IHF+UIT8lzRUG+Gi81dR379CZsNGMp8TAA1jLven/3EV99Cld3+kcRl0ivBgJtQ89/Q0wzV/w==
X-Received: by 2002:a17:907:e984:b0:ad8:9466:3344 with SMTP id a640c23a62f3a-ae6fc10858fmr222387766b.43.1752220155539;
        Fri, 11 Jul 2025 00:49:15 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264fa0sm248855466b.88.2025.07.11.00.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 00:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 09:49:14 +0200
Message-Id: <DB927EJAGV63.1RSRM7JK907VL@fairphone.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Javier Martinez Canillas"
 <javierm@redhat.com>, "Helge Deller" <deller@gmx.de>,
 <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: display: simple-framebuffer: Add
 interconnects property
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Krzysztof
 Kozlowski" <krzk@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-1-f69b86cd3d7d@fairphone.com>
 <20250627-mysterious-optimistic-bird-acaafb@krzk-bin>
 <DAX7ZB27SBPV.2Y0I09TVSF3TT@fairphone.com>
 <1129bc60-f9cb-40be-9869-8ffa3b3c9748@kernel.org>
 <8a3ad930-bfb1-4531-9d34-fdf7d437f352@redhat.com>
 <85521ded-734d-48e8-8f76-c57739102ded@kernel.org>
 <e534d496-6ce0-46c8-835d-94b3346446a7@redhat.com>
 <6e4253dd-cd73-4302-b9df-44c8c311eb22@kernel.org>
 <vk7xshncx3vj66ykbt3cfdjwdsx5uewfzlqmfsdbjfgju4awwk@lz76hnenxq2u>
In-Reply-To: <vk7xshncx3vj66ykbt3cfdjwdsx5uewfzlqmfsdbjfgju4awwk@lz76hnenxq2u>

Hi Krzysztof,

On Sun Jul 6, 2025 at 1:24 PM CEST, Dmitry Baryshkov wrote:
> On Wed, Jul 02, 2025 at 10:43:27PM +0200, Krzysztof Kozlowski wrote:
>> On 30/06/2025 10:40, Hans de Goede wrote:
>> >>
>> >> No one asks to drop them from the driver. I only want specific front
>> >> compatible which will list and constrain the properties. It is not
>> >> contradictory to your statements, U-boot support, driver support. I
>> >> really do not see ANY argument why this cannot follow standard DT rul=
es.
>> >=20
>> > So what you are saying is that you want something like:
>> >=20
>> > framebuffer0: framebuffer@1d385000 {
>> > 	compatible =3D "qcom.simple-framebuffer-sm8650-mdss", "simple-framebu=
ffer";
>> > }
>> >=20
>> > and that the binding for qcom.simple-framebuffer-sm8650-mdss
>> > can then list interconnects ?
>> IMO yes (after adjusting above to coding style), but as mentioned in
>> other response you can just get an ack or opinion from Rob or Conor.
>
> But, this way we end up describing MDSS hardware block twice: once with
> the proper device structure and once more in the simple-framebuffer
> definition. I think this is a bit strange.
>
> I understand your point of having a device-specific compatible string
> and also having a verifiable schema, but I think it's an overkill here.
>
> Consider regulator supplies of this simple-framebuffer. Obviously some
> of them supply the panel and not the SoC parts. Should we also include
> the panel into the respective compat string? What about describing the
> device with two different DSI panels?
>
> I think this explodes too quickly to be useful. I'd cast my (small) vote
> into continuing using the simple-framebuffer as is, without additional
> compatible strings and extend the bindings allowing unbound number of
> interconnects.

How do we continue on this?

If the current solution is not acceptable, can you suggest one that is?

I'd like to keep this moving to not block the dts upstreaming
unnecessarily - or otherwise I need to drop simple-framebuffer from the
dts patch and keep this out-of-tree along with a patch like this.

Regards
Luca
