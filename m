Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794477404;
	b=s1stw/SQuBAayk8VvJeSQUYjPgl4i89P3o8/uIl3hRI/fY7Cc78d4MHq/jhhFxmQTEht
	 NvWXUYuB5HUbM+7V0BBm5n8vb3JQGvIGEbg0GhT+g3R8rzG5VB9GTCHWPPY4pKg/79iC0
	 41/QwD84rCEqqBznxeoXEI59wLARCqC0HD4Whz6PLKolw7GAs7Vw0KLJf77Lo4m6aqmm9
	 tc5uiFnHP7Bja7X3qWVMn/IuLIMoNV0qOrwUCejZi5kipBPOcO7bgPFSy/bbS6lutktPd
	 mnQjhAWSLtkxnY6K5Y8pQu122jJ5z7nhWVLtnMrqaVlY2EiXllyB9k2l4Um7txD+mxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477404;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=sZ1t4uATYa7cR4Spc5Z083HpP4Ftl5L9B64B7O16jSM=;
	b=JZmZs0j2DgoWK4KUMqIgmJ2YVA3tOifNG01FnFDtlC6EJnaIw40CS7YnGT8WfmyXVfhe
	 ahbSx6jMKEO/91mM6vnaVM3Nsyj8MvqzZfxy1pTmC3OO51mqt+Lejy6n0+TdYTMFYgPrw
	 1mYPzL9m7KOhqPU4yE7rnL36CBvOG9yMf1T9nCPNMTkhhKI27AbDdOV46bTQheAtaHByl
	 Df63E/8mlXbWfq97TpM+cRD2Gl2NGlikMWifBHCR6MfS+P3j6vz1y7hH2QU5ii05/oELb
	 S/PEmxI1Cwyg5rbQ1O5V0TYZtyFtGeJf59SZn7sebXLmq7MC9vkD5S3mDGj/oS2v6ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=rO2kpAxL;
	arc=none smtp.remote-ip=212.227.17.21
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26630606A31C
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Nov 2026 09:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26630606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=rO2kpAxL
DKIM2-Signature:  i=1; m=1; t=1794477401;
 mf=PGRlbGxlckBnbXguZGU+;
 rt=PGxpbnV4LWZiZGV2QHZnZXIua2VybmVsLm9yZz4=;
 d=gmx.de;
 s=s31663417:rsa-sha256:HYyNKjn6ai5Iut0K/DPzLhBph9PD
   5ZRo7GjOz2/U+T+VVdl6+Jh2d7xAVGMxbNh1Rm+mkuLua+LYud5Pebze/B3o86839BAoqjKWdkE
   DmNzsPDs3r6rRK2FAYFcwoit3cuT1JHV6sgv+h6T11MSWu4XIHR3g6oHpID9aYiP3Dfq7mtvq3G
   2ee7Tq1b23o8eOyXsin1x3AwwASpIoULeMoHM50ktZrH5RJm3J1v3pwU4xodWrJ5dJIgzp0vEp0
   p7Lc0f3zXUK4HIrnJxBuP1a12egCa6q6PUuGTSAaQjEU6OsILu3/0rsBj753KXkyKUVSTJVPRJq
   20rH/hzQs+jZ3A==;
Message-Instance:  m=1;
 h=sha256:
   0fJf1/vc2NZ1uqzXvSxILoPoMxmqZQexUx69TvS9Bi4=:
   /MMLbbam3B7knaPSkDd8A4WNShinmpMcL9o9lq+QpfE=,
  sha512:
   S/XJiAC8XLwegZRDMEMj4j+Ye7Uc4srNZSTS1nuWSJBkjNs62klSWief2+VABI5gGbyTX6G9b24dom3/lM24Cw==:
   W/ZA9Opqha1flGXMt4vCIEuToQEahK/6GxwYrcd4lUMseTkCWA9JiyQCf4/ydDwmjbcgw12Ni66DK/IYl7mNDQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794477397; x=1795082197; i=deller@gmx.de;
	bh=sZ1t4uATYa7cR4Spc5Z083HpP4Ftl5L9B64B7O16jSM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rO2kpAxLG4B4qZXnMeQGDCBaAEoD48WeVZuIVkDIehTAhTBUIRhwcbkq4i/CPjdI
	 FTUpuXv4p96RiWoCG/DA0hQ1tZpFgSTBPuL2Ni6m7sf4qmuiwEg7QLwSqudqIx8XX
	 NoK3P9xbJuaFimrg/p6HHrX/6r/blFNG+JJF2NxB/nJziMyNjVq7GIgPy6d673Dhf
	 Fwm+I97+R/tzv/5nySmvE7Zho9cpiqADiesCqAaRlpBc8Vcbhgj0Fhjuk5tAsLSJp
	 BIfcVgU290rwgP5iV3vnm8ZCJUSuXG5txq/+7iAcb+Ec9hHpnGt2MzYrAQcWME4BV
	 wVQKQWQoTqWUwTq6pg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9MpY-1wMKIa3usO-00tUMY; Thu, 12
 Nov 2026 10:56:37 +0100
Message-ID: <39ba3f97-dc6d-49ac-ba72-8c2b7c6b0250@gmx.de>
Date: Thu, 12 Nov 2026 11:45:43 +0100
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
Subject: Re: [PATCH] vgacon: Fall back to the dummy console if mapping VGA
 memory fails
To: Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
References: <20261111-vgacon-ioremap-null-v1-1-6dd05bf390ef@gmail.com>
 <CA+=Fv5SHTC9XWQJZY7DnZbpMPnk3b7eYNiiH6Dnii+eLJo9YgA@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CA+=Fv5SHTC9XWQJZY7DnZbpMPnk3b7eYNiiH6Dnii+eLJo9YgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nyEnrrW7rXdR88F9i+QtQ/SGD40MZUyTyZjrzWU27JXhaS/WsAC
 Eltt++jkysNgE9sMgbTImj8XyojxXZLqkPz0XrZEY2diNKm6faQK6fLCiQqvFSXEwrE/WGe
 Xsq9sEC+seX32EaPERUvb3psnhu8tJD3Ngo4GPSUmqztcBY/ZBin2X1FXU54ahNd3ZnpqqT
 n5JW0iqZFdxdKOxAtmFtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qCNa3rxzIyc=;jznISJcqYasEXLyajfHqgrvoKQg
 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

On 11/12/26 09:47, Magnus Lindholm wrote:
> Hi Matt,
>=20
> On Thu, Nov 12, 2026 at 1:30=E2=80=AFAM Matt Turner <mattst88@gmail.com>=
 wrote:
>>
>> On Alpha, setup_arch() registers vgacon whenever CONFIG_VGA_CONSOLE is
>> enabled. On Marvel (EV7) systems whose SRM console is serial, no VGA
>> hose is set, so marvel_ioremap() finds no hose for 0xb8000 and returns
>> NULL. vgacon_startup() then probes video memory through that NULL
>> pointer and oopses in console_init():
>>
>>    Unable to handle kernel paging request at virtual address 0000000000=
000000
>>    pc is at vgacon_startup+0x174/0x910
>>
>> VGA_MAP_MEM() is ioremap() on Alpha and powerpc and can fail. Treat
>> failure like a failed probe and fall back to the dummy console. If a
>> VGA card is present, locate_and_init_vga() still switches to vgacon
>> once PCI is up.
>>
>> Cc: stable@vger.kernel.org
>> Assisted-by: Claude:claude-opus-5-5
>> Signed-off-by: Matt Turner <mattst88@gmail.com>
>> ---
>>   drivers/video/console/vgacon.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vga=
con.c
>> index e7e6750f1f87..09f7c376b468 100644
>> --- a/drivers/video/console/vgacon.c
>> +++ b/drivers/video/console/vgacon.c
>> @@ -324,6 +324,8 @@ static const char *vgacon_startup(void)
>>          }
>>
>>          vga_vram_base =3D VGA_MAP_MEM(vga_vram_base, vga_vram_size);
>> +       if (!vga_vram_base)
>> +               goto no_vga;
>>          vga_vram_end =3D vga_vram_base + vga_vram_size;
>>
>>          /*
>>
> ....
>=20
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
applied to fbdev git tree.

Thanks!
Helge
