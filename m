Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9352A18DB29
	for <linux-fbdev@vger.kernel.org>; Thu,  8 May 2025 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746739048; cv=none; b=JRVZL5oGVZ43bzUSlhi9OjIGoQlgw3hJV4oEIGw1DC4OkDoSV14FoOqrBZg6om5zEdJCTVgNxp3gwUNpswtQJpjXFalNA7YpJVF+Tj8OfE2Po76lJXvaIfo0ae58Pf8/J/BKZUIm37w221WyVi02IMdMjWZwhrZRIB38jcO0V6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746739048; c=relaxed/simple;
	bh=dosNpUzM64Y1vU90442H51v4UDBPWqSTNKKWftxUJaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ix9iqAQqgXiJXrHmC2b12NaEG4RJt9x0Rxy8CB5rEfbt80hunsg/02vAe5fh8Q5uH2AhByOPzjTkhh5ErvFO9aTH5H33BmH7mXjfBLQsN9RVzC106GCrdNKBfXXculKIuT1CXHqRTdCb8c8ApnkiFWSjQrZjsAI0GmZ6yga8QGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=qFF9zGBm; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="qFF9zGBm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1746739043; x=1747343843; i=deller@gmx.de;
	bh=IGSWXCF/rcel7hclMCxJMPl62QlYD1JU7bWAVIn2VNI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qFF9zGBm2Lo9yjfKQKmZ+dm8IbUrpjrIBQLFOUSjUUoaqOncqZNQmIw6qouzprfx
	 Kr2duWKyb8HD3/Fnh+QTAZEuxx0mskkBF6qop9vrWXXBJwprxvI2y3OyjREgIyI4y
	 81xgk4YJiMnE/MjPWFWB6hokoVcLfVlL++Zt0AQvIFrvgpA+wnbq8slBkKUoVH9IS
	 e9fIPdL6R9l4oIqsZ/P8+td7OJJ5HVTOKOWCcJ88WZkOEQc9qzF1jvRb+yHysb6UO
	 mmi5jOcM6Al5obEF0U+RtaGTmI36XK54fBY0i+nHSI+FDbXZI1ZTNka1KCt7hBCv8
	 Cd9YEPKezeDwVviUyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.181]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvmO-1uluwH1uqM-00aTeA; Thu, 08
 May 2025 23:17:23 +0200
Message-ID: <30a19179-6f27-4835-923f-20da56cb04d5@gmx.de>
Date: Thu, 8 May 2025 23:17:22 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernels >= 6.3 disable video output
To: Steven J Abner <pheonix.sja@att.net>
Cc: linux-fbdev@vger.kernel.org
References: <1BHYVS.FW7S9BTTF682.ref@att.net> <1BHYVS.FW7S9BTTF682@att.net>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <1BHYVS.FW7S9BTTF682@att.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:14ns++B6CXjAQnQZKivwMgjc3LiLwG7go7StL8bPA4eZuczzBon
 IKsvsLHI1PciWz3MffoxjAW6KWIR8G1fRpdzqOqOxGe7odXHcCcvHeyAQNNxWCKtiGWI5vr
 tLEusV0knqLplzyBX7hWOlrtqJUZIe92vEu5yvahNUgpCFusSfaFbZuGxDHvc7ZCxxjYEUW
 wyLHclHYx6fiPOW3Ngm2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:83ehHf/kRpc=;ZqNQJ6OScn+lqICKrn0wsbl2q7L
 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
 +J5+vekYJ4lpV7kaPOanchAEXAswUeaQ2M

Hi Steven,

On 5/8/25 20:42, Steven J Abner wrote:
>  > one from a working boot, and one from where the screen stayed blank.
>=20
> AMD 2400g, Zen1, 'Raven' firmware, igpu, no card.
> Hopefully you wanted lasted kernel, and not the differences of 6.2 vs. 6=
.3.
> These are done from booted into kernels, outputs from dmesg > <file_on/o=
ff>.
> Could have accessed logs but felt this would show both "consoles" functi=
oning.
> Added note: Only other than basic software is Xorg, and just added gdb. =
But this bug found even prior to inclusion of those.

This is the relevant part out of your boot log:

> [ 0.000000] Linux version 6.13.4 (root@steven-ryzen) (gcc (GCC) 14.2.0, =
GNU ld (GNU Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Thu May 8 13:55:46 EDT =
2025=20
> [ 0.310823] ACPI: bus type drm_connector registered
> [ 0.310837] [drm] amdgpu kernel modesetting enabled.
> [ 0.310975] [drm] initializing kernel modesetting (RAVEN 0x1002:0x15DD 0=
x1002:0x15DD 0xC6).
> [ 0.310989] [drm] register mmio base: 0xFC900000
> [ 0.310994] [drm] register mmio size: 524288
> [ 0.311024] [drm] add ip block number 0 <soc15_common>
> [ 0.311029] [drm] add ip block number 1 <gmc_v9_0>
> [ 0.311034] [drm] add ip block number 2 <vega10_ih>
> [ 0.311039] [drm] add ip block number 3 <psp>
> [ 0.311043] [drm] add ip block number 4 <powerplay>
> [ 0.311047] [drm] add ip block number 5 <dm>
> [ 0.311052] [drm] add ip block number 6 <gfx_v9_0>
> [ 0.311057] [drm] add ip block number 7 <sdma_v4_0>
> [ 0.311061] [drm] add ip block number 8 <vcn_v1_0>
> [ 0.334228] [drm] BIOS signature incorrect 0 0
> [ 0.334251] amdgpu 0000:0e:00.0: amdgpu: Fetched VBIOS from ROM BAR
> [ 0.334258] amdgpu: ATOM BIOS: 113-RAVEN-113
> [ 0.334554] amdgpu 0000:0e:00.0: vgaarb: deactivate vga console
> [ 0.334560] amdgpu 0000:0e:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re enabled
> [ 0.334585] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, f=
ragment size is 9-bit
> [ 0.334596] amdgpu 0000:0e:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 =
- 0x000000F47FFFFFFF (2048M used)
> [ 0.334604] amdgpu 0000:0e:00.0: amdgpu: GART: 1024M 0x0000000000000000 =
- 0x000000003FFFFFFF
> [ 0.334615] [drm] Detected VRAM RAM=3D2048M, BAR=3D2048M
> [ 0.334619] [drm] RAM width 128bits DDR4
> [ 0.334722] [drm] amdgpu: 2048M of VRAM memory ready
> [ 0.334727] [drm] amdgpu: 2923M of GTT memory ready.
> [ 0.334742] [drm] GART: num cpu pages 262144, num gpu pages 262144
> [ 0.334877] [drm] PCIE GART of 1024M enabled.
> [ 0.334881] [drm] PTB located at 0x000000F400A00000
> [ 0.335145] amdgpu: hwmgr_sw_init smu backed is smu10_smu
> [ 0.335578] [drm] Found VCN firmware Version ENC: 1.15 DEC: 3 VEP: 0 Rev=
ision: 0
> [ 0.356133] amdgpu 0000:0e:00.0: amdgpu: reserve 0x400000 from 0xf47fc00=
000 for PSP TMR
> [ 0.428083] amdgpu 0000:0e:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot available
> [ 0.434083] amdgpu 0000:0e:00.0: amdgpu: RAP: optional rap ta ucode is n=
ot available
> [ 0.434090] amdgpu 0000:0e:00.0: amdgpu: SECUREDISPLAY: securedisplay ta=
 ucode is not available
> [ 0.434559] [drm] DM_PPLIB: values for F clock
> [ 0.434564] [drm] DM_PPLIB: 1633000 in kHz, 4399 in mV
> [ 0.434570] [drm] DM_PPLIB: values for DCF clock
> [ 0.434574] [drm] DM_PPLIB: 300000 in kHz, 3649 in mV
> [ 0.434578] [drm] DM_PPLIB: 600000 in kHz, 4074 in mV
> [ 0.434583] [drm] DM_PPLIB: 626000 in kHz, 4250 in mV
> [ 0.434587] [drm] DM_PPLIB: 654000 in kHz, 4399 in mV
> [ 0.435247] [drm] Display Core v3.2.310 initialized on DCN 1.0
> [ 0.504716] [drm] kiq ring mec 2 pipe 1 q 0
> [ 0.518487] amdgpu 0000:0e:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 11=
, active_cu_number 11
> [ 0.518497] amdgpu 0000:0e:00.0: amdgpu: ring gfx uses VM inv eng 0 on h=
ub 0
> [ 0.518503] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 1 on hub 0
> [ 0.518510] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 4 on hub 0
> [ 0.518516] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 5 on hub 0
> [ 0.518523] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 6 on hub 0
> [ 0.518530] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 7 on hub 0
> [ 0.518536] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 8 on hub 0
> [ 0.518543] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 9 on hub 0
> [ 0.518549] amdgpu 0000:0e:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 10 on hub 0
> [ 0.518556] amdgpu 0000:0e:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 11 on hub 0
> [ 0.518562] amdgpu 0000:0e:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on=
 hub 8
> [ 0.518569] amdgpu 0000:0e:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 =
on hub 8
> [ 0.518575] amdgpu 0000:0e:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4=
 on hub 8
> [ 0.518581] amdgpu 0000:0e:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5=
 on hub 8
> [ 0.518588] amdgpu 0000:0e:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6=
 on hub 8
> [ 0.521453] amdgpu: pp_dpm_get_sclk_od was not implemented.
> [ 0.521460] amdgpu: pp_dpm_get_mclk_od was not implemented.
> [ 0.521565] amdgpu 0000:0e:00.0: amdgpu: Runtime PM not available
> [ 0.521868] [drm] Initialized amdgpu 3.60.0 for 0000:0e:00.0 on minor 0
> [ 0.526617] fbcon: amdgpudrmfb (fb0) is primary device
> [ 0.595813] Console: switching to colour frame buffer device 240x67
> [ 0.628478] amdgpu 0000:0e:00.0: [drm] fb0: amdgpudrmfb frame buffer dev=
ice

You are using an AMDGPU graphics card (or built-in).
You are using the DRM graphics drivers, and not the fbdev drivers.
This is the relavant info how to report in the MAINTAINERS file:

RADEON and AMDGPU DRM DRIVERS
L:      amd-gfx@lists.freedesktop.org
B:      https://gitlab.freedesktop.org/drm/amd/-/issues

I suggest you either open a bug report at the provided website, or
write an email to amd-gfx@lists.freedesktop.org and/or dri-devel@lists.fre=
edesktop.org

Helge
