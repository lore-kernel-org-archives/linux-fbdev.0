Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528488;
	b=bAqdzRdfZe33UT5kjX8+ETS/7MyEummGJaN4nxLmcwhvDtPMnqiX8jysYnIBp6jobTHE
	 v3abwy5J8sKUlv9v2cIYsMUtzWPu+LMYxwh52QXCO56LIvf6mBC8xCeNgQGKa2DagnxxD
	 IK+iufR21g5otgobJzCQNGruVAZxXMOycDIyOidbPV/sN5zO7kM5hlMvkn0CxL3yiVlzn
	 uTwN8O8Xc0MBV0ruHHcvS184cCupBVEaAyVjlcAK+AKsyF5fe6Y0Np3vrFSlkylrslk1+
	 u+XzaoRENgXV6oOQuc2atU+RLynfsyQNMsP6sSvfT/3bgw+u40Dn1zgo/zUd1u/C0bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528488;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=+XQ2jGq2rGRCXe2a+V4EPKMo/+wuS5hCKLtQkSsDTWI=;
	b=diMER4dgzKomVJUjerSmok5lPi1U9BYPtPIDIpSf/TjfpM02O+UvbqQOV7/2NQaeEBlr
	 9JReUJvBAmugLwpJMrCHfiI0uAzp63M8Q7nzV6Nfpb0U+f5oX4dJGErAEdW3NGyEBUZiD
	 zOAe8qZLwDelTdyiQz/0KuJrRtNy5qIQeGQJ4WAC9WpRpwzD1MtvaucTLeUzBlrgz9vzg
	 aDG4PVJjlR57HcX/YKXAJz68e11HpWIp1mtGpmjQlgqeGf+h8Y3pcpb8ToQvTfbmGUrrJ
	 tEHXqLq8+KELGCOWU/EZQQ3VKc6M7Rl0Dn+2ko4nCxJvPtN0/GCueJrNwXq4pCVWiXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Bi97biYM;
	arc=none smtp.remote-ip=212.227.15.18
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279DF606A322
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Oct 2026 20:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 279DF606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Bi97biYM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1792528481; x=1793133281; i=deller@gmx.de;
	bh=+XQ2jGq2rGRCXe2a+V4EPKMo/+wuS5hCKLtQkSsDTWI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Bi97biYMTeu/0xvyfrWRQ7TMpkZGi5QEBhsd6vCtBY4U4Mb5/5vDdNYbDrBMUCjr
	 lJbnHOs0YZ/vTs8CamAGhUEVblfPbZxuT24NxQFKPP9dd5+DZV0wDJU/cVSWRh+HE
	 RgloATcwr5p6TYJPExW0Qet0IwmdWiSO1z+f3dn3hefWuEwgQRiOEnDRDKrUG0M0c
	 MudL7KHTm3UJV4cdNuE01DBjaXUNCFHtU8UCd2orHSA223DLJGbcsEmScp45MWDHa
	 cEq8WKZqdaKrPRvmJ9UN9SW+X3QInI+neVfh+9hKc+l7NQ5+hXjw9ps4YwHZhMMqk
	 L34B9YoVHzeG0NFDNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MY68d-1x6qzc28E9-00PzE5; Tue, 20
 Oct 2026 22:34:41 +0200
Message-ID: <583e7e89-48c1-4a89-b8c2-947af16f977a@gmx.de>
Date: Tue, 20 Oct 2026 22:34:40 +0200
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
Subject: Re: [PATCH 1/5] fbdev/au1100fb: Use FB blanking constants
To: Thomas Zimmermann <tzimmermann@suse.de>, adaplas@gmail.com,
 michal.simek@amd.com
Cc: linux-fbdev@vger.kernel.org
References: <20261009161814.120480-1-tzimmermann@suse.de>
 <20261009161814.120480-2-tzimmermann@suse.de>
 <3ae4590b-c420-480f-a6a2-79700bf20a1a@gmx.de>
 <33fd4c60-43f4-4055-838e-a37e58ab70dc@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <33fd4c60-43f4-4055-838e-a37e58ab70dc@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cYYKQjal5yzw0NXelMBKc+3Iv0UmRk4QTt7jpXuouz/c1BS9RDD
 LnigD9NNexaG05WJ4wwaFxU3XFChHt+zybY5PHZlFFHuG4XlFI13xGDUR+VrhgO9u4CjpsT
 Wi/AylgJzUug0yL7/WQhUiVU5/JpD7cbbX/rNYwjT8ShSJRLH4lOF09nsQr9gVI4Dj0E7LO
 RWxwq3lI7D5g0ulz/vIwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Imh0FZHqgQQ=;rxxeVN7fkJqooC+7UzSWIxcVtca
 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
 gKFlq+JrU8zAvhRor1GQ=

On 10/19/26 09:24, Thomas Zimmermann wrote:
> Hi
>=20
> Am 18.10.26 um 15:52 schrieb Helge Deller:
>> Hi Thomas,
>>
>> On 10/9/26 18:05, Thomas Zimmermann wrote:
>>> Fbdev and its drivers use FB_BLANK constants for controlling the
>>> display's blanking state. Semantics differ to similar VESA blanking
>>> constants.
>>>
>>> Replace the VESA constants in au1100fb with FB_BLANK.
>>
>> I understand that this series drops the VESA constants.
>> That seems logical and correct, but....
>>
>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> ---
>>> =C2=A0 drivers/video/fbdev/au1100fb.c | 18 +++++++++---------
>>> =C2=A0 1 file changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au11=
00fb.c
>>> index 39f86ffb1ae3..6c375f389fbd 100644
>>> --- a/drivers/video/fbdev/au1100fb.c
>>> +++ b/drivers/video/fbdev/au1100fb.c
>>> @@ -424,15 +424,15 @@ static int au1100fb_fb_blank(int blank_mode, str=
uct fb_info *fbi)
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (blank_mode) {
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 case VESA_NO_BLANKING:
>>> +=C2=A0=C2=A0=C2=A0 case FB_BLANK_UNBLANK:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Turn on pane=
l */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fbdev->regs->lc=
d_control |=3D LCD_CONTROL_GO;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wmb(); /* drain=
 writebuffer */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> -
>>> -=C2=A0=C2=A0=C2=A0 case VESA_VSYNC_SUSPEND:
>>> -=C2=A0=C2=A0=C2=A0 case VESA_HSYNC_SUSPEND:
>>> -=C2=A0=C2=A0=C2=A0 case VESA_POWERDOWN:
>>> +=C2=A0=C2=A0=C2=A0 case FB_BLANK_NORMAL:
>>> +=C2=A0=C2=A0=C2=A0 case FB_BLANK_VSYNC_SUSPEND:
>>> +=C2=A0=C2=A0=C2=A0 case FB_BLANK_HSYNC_SUSPEND:
>>> +=C2=A0=C2=A0=C2=A0 case FB_BLANK_POWERDOWN:
>> I don't understand (this is not the fault of this/your patch),
>> how this enum in fb.h works:
>>
>> enum {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* screen: unblanked, hsync:=
 on,=C2=A0 vsync: on */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FB_BLANK_UNBLANK=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D VESA_NO_BLANKING,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* screen: blanked,=C2=A0=C2=
=A0 hsync: on,=C2=A0 vsync: on */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FB_BLANK_NORMAL=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D VESA_NO_BLANKING + 1,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* screen: blanked,=C2=A0=C2=
=A0 hsync: on,=C2=A0 vsync: off */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FB_BLANK_VSYNC_SUSPEND =3D V=
ESA_VSYNC_SUSPEND + 1,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* screen: blanked,=C2=A0=C2=
=A0 hsync: off, vsync: on */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FB_BLANK_HSYNC_SUSPEND =3D V=
ESA_HSYNC_SUSPEND + 1,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* screen: blanked,=C2=A0=C2=
=A0 hsync: off, vsync: off */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FB_BLANK_POWERDOWN=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D VESA_POWERDOWN + 1
>>
>>
>> In vesa.h we have:
>> /* VESA Blanking Levels */
>> enum vesa_blank_mode {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VESA_NO_BLANKING=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0,
>> #define VESA_NO_BLANKING=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VESA=
_NO_BLANKING
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VESA_VSYNC_SUSPEND=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D 1,
>> #define VESA_VSYNC_SUSPEND=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VESA_VSYNC_SUS=
PEND
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VESA_HSYNC_SUSPEND=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D 2,
>> #define VESA_HSYNC_SUSPEND=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VESA_HSYNC_SUS=
PEND
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VESA_POWERDOWN=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D VESA_VSYNC_SUSPEND | VESA_H=
SYNC_SUSPEND,
>> #define VESA_POWERDOWN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 VESA_POWERDOWN
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VESA_BLANK_MAX=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D VESA_POWERDOWN,
>>
>>
>> for example this one:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* screen: blanked,=C2=A0=C2=
=A0 hsync: on,=C2=A0 vsync: off */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FB_BLANK_VSYNC_SUSPEND =3D V=
ESA_VSYNC_SUSPEND + 1,
>> which is effectively:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FB_BLANK_VSYNC_SUSPEND =3D V=
ESA_HSYNC_SUSPEND,
>> which seems wrong.
>>
>> Am I missing something?
>=20
> No worries, it's super-confusing.
>=20
> - FB_BLANK_ describes CRTC state plus monitor state. VESA_ only describe=
s monitor state and assumes that the CRTC is off.
>=20
> - FB_BLANK_UNBLANK means "monitor on and send pixels".=C2=A0 There is no=
 VESA equivalent for this mode, because all VESA constants assume that the=
 stream if pixel data has been disabled.
>=20
> - FB_BLANK_NORMAL means "monitor on, but do not send pixels". This corre=
sponds to VESA_BLANK_NO_BLANKING, but has a different integer value.
>=20
> - The FB_BLANK_*_SUSPEND and _POWERDOWN constants correspond to the VESA=
 constants of similar name. But they are all off by one.
>=20
> Therefore some of the drivers (au1100fb) use VESA_NO_BLANKING when
> they mean FB_BLANK_UNBLANK. Others (xilinxfb) get it wrong and use
> VESA_POWERDOWN when they should use FB_BLANK_POWERDOWN.

Ok, thanks for this summary.

I've applied this series now to fbdev git tree.

Thanks!
Helge
