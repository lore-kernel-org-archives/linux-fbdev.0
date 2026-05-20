Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773C83D47D3;
	Wed, 20 May 2026 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271904; cv=none; b=PGbPm8uvjeptMNWK54yzMU7mb6p0XUq2ib7X5pmog8dCYTxMlqTvWWZzsM+K8Z39uanORSVPKju9h2SRJnPu/rHDDUTa2HnNIHkGn63a7DnpvKT8PSkPPrUJfYCJDv9g3vElFf1nyrM64/2IiTx7josfDdStYg7oSCYbsYBYwC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271904; c=relaxed/simple;
	bh=cumtjCa8QwrCrkYkP/kSqm1+mOlUg9j/RdhZCXpxwTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4fYIBIB3egs7Ok58StfIjl69HEUE9hVsXWFtfk9N1G/fBe/FH+jsM4STnTrKP/RMF4atUJ+oUuVReEXhvYVdL9xjShrt98UqxfevnSGFtg5qRGtsd846tzOlzvR8liwJOyO0m3XRIGuHFp8J0Kv23qvXObPG/Yt49LDNuf5qGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=CK65Sxxs; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="CK65Sxxs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779271880; x=1779876680; i=deller@gmx.de;
	bh=JEtRmAEGAUw0HgCmHSGKGPve2zkA65121FWaYFQvDKU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CK65Sxxs4qOKIfw/ILpZbm2eTDxR46tc2fISgPb522AYocZljGLstX9IS9T6VSkK
	 46mF3ZJ5PVDdBCmryiX/RlR2z4rCxtXwTtuuSVFx5+R3bFkH4dxEpt4EBuK+1/ZgK
	 OVm0PBz9KzPmmJ5HTprzfxGPE7hYo3mNti+MzqwAWtYtANwwxjpcN3+uZVo5qKcpv
	 uPfAOarQtmh/U84qgGlptc0wKTmWioGQobAGw5cPwTsU3VP7Hn4VUoHZndJ4ZKee6
	 A3rhVgKRV+QSdaZ/f5XDQawcNU+cgDEXO6LPgn9agJec8JJ3Lca7yJdaIAXBEFH3H
	 PUEFnqTQfl2SCKAW+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwwZd-1xIr9H0hD9-010xd4; Wed, 20
 May 2026 12:11:20 +0200
Message-ID: <6f1e1da5-a086-4261-aacb-f1117e22146b@gmx.de>
Date: Wed, 20 May 2026 12:11:16 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: Consistently define pci_device_ids using named
 initializers
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>, Andres Salomon <dilinger@queued.net>,
 Antonino Daplas <adaplas@gmail.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-geode@lists.infradead.org,
 Markus Schneider-Pargmann <msp@baylibre.com>
References: <20260430111637.211336-2-u.kleine-koenig@baylibre.com>
 <ag1xQVCCzXkc_Ucu@monoceros>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ag1xQVCCzXkc_Ucu@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S62MKqJETVPKDPugYV2lzkWccfOMXOhv25ADUBSRL6/RURD3bdA
 mkzHbgB96Wh9IESIlTDq2RVLnDmyqaJ7BSVYTbqUdali5l63JTpQNTQW1EgZ3Ma864jYUjf
 NEQXwOgyjrB3hyF58RchRK0NfPUu0auEWx6Xurw1IICTYBiF/LNcolut9t3iIoBE9IurdYO
 HaEL+Yxe4TBlAnmR9kSmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xu2onO/S+Bg=;PWNfM4qLCCZNlO04DENVNCcXuct
 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
 AFv7Zw==

On 5/20/26 10:46, Uwe Kleine-K=C3=B6nig (The Capable Hub) wrote:
> Hello,
>=20
> On Thu, Apr 30, 2026 at 01:16:36PM +0200, Uwe Kleine-K=C3=B6nig (The Cap=
able Hub) wrote:
>> diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video=
/fbdev/matrox/matroxfb_base.c
>> index e1a4bc7c2318..22774eb1b14c 100644
>> --- a/drivers/video/fbdev/matrox/matroxfb_base.c
>> +++ b/drivers/video/fbdev/matrox/matroxfb_base.c
>> @@ -1642,7 +1642,7 @@ static int initMatrox2(struct matrox_fb_info *min=
fo, struct board *b)
>>   	int err;
>>  =20
>>   	static const struct pci_device_id intel_82437[] =3D {
>> -		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437) },
>> +		{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82437) },
>>   		{ },
>>   	};
>>  =20
>=20
> after further sharpening my tooling there is an additional change that
> IMHO should be done here:
>=20
> -		{ },
> +		{ }
>=20
> and ...
>=20
>> diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.=
c
>> index 3f6384e631b1..06aefad75f46 100644
>> --- a/drivers/video/fbdev/pvr2fb.c
>> +++ b/drivers/video/fbdev/pvr2fb.c
>> @@ -993,9 +993,8 @@ static void pvr2fb_pci_remove(struct pci_dev *pdev)
>>   }
>>  =20
>>   static const struct pci_device_id pvr2fb_pci_tbl[] =3D {
>> -	{ PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_NEON250,
>> -	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
>> -	{ 0, },
>> +	{ PCI_VDEVICE(NEC, PCI_DEVICE_ID_NEC_NEON250), },
>> +	{ },
>>   };
>>  =20
>>   MODULE_DEVICE_TABLE(pci, pvr2fb_pci_tbl);
>=20
> ... here:
>=20
> -	{ PCI_VDEVICE(NEC, PCI_DEVICE_ID_NEC_NEON250), },
> +	{ PCI_VDEVICE(NEC, PCI_DEVICE_ID_NEC_NEON250) },
> -	{ },
> +	{ }
>=20
> Would you mind squashing that into the patch you already applied, maybe
> adding:
>=20
> 	While touching all these arrays, unify usage of whitespace and
> 	comma in a few drivers.
>=20
> to the commit log? I can also send a v2 of the patch with these changes
> included if that's easier for you.
>=20
> Otherwise I will put sending these modifications separately on my todo
> list.

No need to resend anything. I'll clean it up manually during the next few =
hours....

Helge
