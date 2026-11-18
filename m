Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026712;
	b=ef28VDpNq2ZlBC3TpwLhAcEg1K+rWoAgBCeDsf0/G8Wmzaaji4+2+ScX48vix+CWEUy2
	 ZwVEgyQ+uUdHo6zwxfw6ZCkkeiAVkzwgSQHhdLAXsAkeA/a2fo8aR9IPlsW+rXwyYf8Cw
	 01bnj6ZyReIIZkI1xSHK4Vc5kmBXQy2dh3H90aDrvJgDBVLiFrAxilZf2XCXejTO1f+HL
	 fzaCt8yIJr2uBRTg3ks1mRHQ39sl4fArbNGQUhk3doQAW45JmdVZF0VF16WmCq/VysgNg
	 68+95EZPJPyNNMVlnW2qVtP5XWEVjmwkL2l1e3Oub0kBkr0RxaL2ZvCBSf36en/cjVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026712;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=RJi98NFxDVa1NkBOfXJQs/zymJlreN+btRKlYRnvEMs=;
	b=hOSWM1ND+lyb+8VPRUL+cSBrs8ujM853vTWbNHfXLqckhLxxe4yHI71QlQt0ZrW5htME
	 saXEFsAF6Y/RRuiXEslw+7KUAhf9Jb03gGtTaiiNqi3MfIse5J6Cw3dlsqfGBBVRmOvgS
	 t0JH0YNe//7FQ1ALMeDmvF/Sut80SZyXMLeCwkPgXj3Svn7kM8L2VedhZm00ioKRKzdyi
	 3B5aoodVf0t2onV+wIrLDDYPa6C7/jVNXARFEhdWkljSeO6u6OKeLEjRHXIDZiWrXsLDJ
	 kz5uIANCAPaQdxAl/ExKRvDHsFHnQZzmls++kog8upepQYADmgZnnjNQvLsYork2NSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=XDMbCt8i;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51037606A31C
	for <linux-fbdev@vger.kernel.org>; Wed, 18 Nov 2026 18:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51037606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=XDMbCt8i
DKIM2-Signature:  i=1; m=1; t=1795026709;
 mf=PGRlbGxlckBnbXguZGU+;
 rt=PGxpbnV4LWZiZGV2QHZnZXIua2VybmVsLm9yZz4=;
 d=gmx.de;
 s=s31663417:rsa-sha256:tG00pCCQvVSiFo714NKvUSdsCKce
   tKudLAlFIrnRagfvVWXpXXV0OHIwwLJPeaLt3S1y+OZpYjyMtYv9wFE2xheU1iSh4TloF4hMyVD
   +/9hiGQ7iDZlCtwfXnKZDS3ikFaO6N36pK/3iqhWKdkXVjmj2scykbqPJ3Gotvrs8EiuduVM/Oz
   zkoil0hiHjCKVF3aKcrzFjX10Iu+AygjTek9F3Dw78Zm8qLdZ9lN4IWrI48O8Gd6AMnhjZyUN6V
   r7x6Rn5NTZiFWoY2nTTqT03DHg7CktoUiR9xXTd+EDPqSE7K/+3CgEhb+1cM+EM3FoaVbVAoz1e
   jxa0GlGdGgntIw==;
Message-Instance:  m=1;
 h=sha256:
   UG942lyQaZJMF8YC0psz948JAwF9H1cRIjyYO4z2P/8=:
   5bXO06uclWF1q7MRU5rS/wf4RcqvFmbBejxiY6ZM8x0=,
  sha512:
   zXXrxpmnTLySFi6gut4hbllEmVb5640q9qWfK7Yyc6gxAsQnSjNQxTBb6zxeHSDRslqkNQcOb29ucPL66PQFng==:
   Owfcdont7MTbTu17gMEMnUU9rFpCWcuozVs6p3OPFC/nLSoO+vhXRu2PMCRPFTM1cU6j6D7b5mJFKI6dJbriBg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795026709; x=1795631509; i=deller@gmx.de;
	bh=RJi98NFxDVa1NkBOfXJQs/zymJlreN+btRKlYRnvEMs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XDMbCt8ikejaiZu50qYswWRQIEuIAFB9L+hdth0qENY4NWE0qZmSkafzXvUK8lSJ
	 OeG7SFtM4o2+IKij2jFgtAzS7mvQBCIozHLpE4lKz3dObTD3W48rDpcNv+zpeYEet
	 U+cB77hVQzOuHIWYEOJLYVbBc1zoKF/LCO4Vtd945j79+fx8s6yuc5r5KLktyfGNm
	 GBjcHFRajctBkQ25MF4VS85CiHAXSTIktGGnXvHhjbbcBjBH+5vZgGoI9MEjzN1wJ
	 9NxGIQnVCAtu9LIxSXa6QAqhEagchiAt2SGS/XZLYvN95a2tyOGFA/1eJf+vIJvyH
	 nOLN67OFQouask+ZXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0XCw-1wXG8O3yb6-00tGb3; Wed, 18
 Nov 2026 19:31:49 +0100
Message-ID: <8eb861c8-90b2-4531-bf02-6537193542e6@gmx.de>
Date: Wed, 18 Nov 2026 19:31:48 +0100
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
Subject: Re: [PATCH] video: fm2fb: Fixed iomem access.
To: "Steffen A. Mork" <linux-dev@morknet.de>, linux-fbdev@vger.kernel.org
References: <20261101141327.997784-1-linux-dev@morknet.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261101141327.997784-1-linux-dev@morknet.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:otPJylGf8yom9P4yuyEFFzH6LIyIGrD1d+TFAQd2O1TqB4q1a78
 /596U8JV9Y4T+12EK32G0zdE7mj6rv1+rGUBobegQ9yi6clZmnf0VHCwQ5gWh4zORWBSzyl
 Bimij25NUnbcySFsJgBaFtNClqq4Oh45kr0kuMcngCk9Hl4yTmxlNN79ldfjR+N6vvdByaz
 +AZ5d/3s8A7doIOF9bAYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:huCyos4fPKU=;CX4AE6LosuMBT+aBG0XND7Pme0u
 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

On 11/1/26 15:13, Steffen A. Mork wrote:
> This driver has not been tested for at least twenty years. In the meanti=
me,
> the frame buffer API has been updated. This patch addresses this issue a=
nd
> makes the driver functional again.
>=20
> Signed-off-by: Steffen A. Mork <linux-dev@morknet.de>
> ---
>   drivers/video/fbdev/fm2fb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
applied.

Thanks!
Helge
