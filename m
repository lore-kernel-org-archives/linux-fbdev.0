Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6C136E3F;
	Fri, 30 Aug 2024 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013020; cv=none; b=Rh1ra6UaUGpPpcI8oCpChYLGNHQkTNB06LktElBrDxxRZ8KeUlABiWfkFNl4L/w1fbiBdiKtiVzavCAh9vG2Qy2zQ8oyOdtBgsmEaE9xCNEzt4vbklBZ8MS0wf7lVbQ2fGgGpGJB9u5vG9X8ydFN998qIzAkMRYBoMPTy+7NZHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013020; c=relaxed/simple;
	bh=2SzCxmLoXpZxEqXLBPSKjcHxY79eq61xyh9zEm1F9dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3XEXbdpnPaQROT2WQ3cXLChTOeUMUTtvcEUQEh0IdA7MvBQXGwNymRMe7qhHasSxZMC5mVQpixdLbsPszZnLMX1zEbxQvMwdUbTTL7guqBzG17P3XrNWJSw3gvur5pmdJeP+GHwHI1R17NunD170Em+mx2cuWxEwgzA57B4AHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=ibawg3Gs; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="ibawg3Gs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1725013008; x=1725617808; i=deller@gmx.de;
	bh=2SzCxmLoXpZxEqXLBPSKjcHxY79eq61xyh9zEm1F9dM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ibawg3GsHN0IAi8KS74KSf1bmFYuk/jL0HzyZuiktL5iSrQm+VSnWaoP5gWINIUO
	 TZvEeSNeMJzyADXM77hoKVFPbWumAOgIOJ20cbmHhxGmsNtz17HaTTUIBwT4IwobS
	 7JV4QL9+QgOLLP8EoFla66SPXExBh0SkI53+7D2GrQTptPBInDWkv3qUVTC96GFUH
	 ljleUVaEYnkCQiB9+aJ8cNG1UYL4Uds32awVvrSxLSohESmIePXQga9S1qKV35AiX
	 Gg3G8hGHfJ0hQVFJ0TmTZclj2GmkveAqM/vdFYOQZO+pBHazoqJpygsfV+tv9qwdL
	 lQ4VMeAQZn3VBv2dGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.126]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlXA-1sL7na0Hp8-00qNAv; Fri, 30
 Aug 2024 12:16:48 +0200
Message-ID: <729c4f82-a683-4302-b4ae-f591ac04daa1@gmx.de>
Date: Fri, 30 Aug 2024 12:16:46 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: Introduce devm_register_framebuffer()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bert Karwatzki <spasswolf@web.de>,
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 intel-gfx@lists.freedesktop.org,
 "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
 "Saarinen, Jani" <jani.saarinen@intel.com>
References: <20240830-fbdev-devm_register_framebuffer-v1-1-6d4186519c68@weissschuh.net>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240830-fbdev-devm_register_framebuffer-v1-1-6d4186519c68@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:auwEi577++FCfEyfghOfg3Y5ozemn23gmuPuHSN8Z/QqnERBoZJ
 MGxS2QKbmkMzj1DZiEPa4l3pCJ7LSbcPoD3lc6eUP1y1teNuVu+GBaof1MoK0WrJ2ciF2hc
 y1LZqTPmkETJaYvWVaMbuoJpHMIs+rmFbrsk+fyUnIhzGnCdjEi6Aje8TqEpYk2V42M7B51
 ssd8BZ04AqyVjiMG9wh3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zuj8S8Pds/s=;gRWpiIHjhNPAW+cyg46akjjyrpR
 8rBc7kbkqBxNtIS0Me4/ZlZm/lVIGKwOmkVWG6dCKCUEsVJ7SSUbl0EI50exmY5hKxyzpMsq4
 JIICgSUoAPjdIYix5mF3i/lshp7l+2p39lA2smlYQDxx6kwnB9S2/KEcciOnv/+ogRiu+DCCA
 hmNAY1eD5YeIyhCNXJPUSDCl2Pj7irHxS7y7WNENHC0X7R9pA2kkbvTOX4LaD5qvwPVnXduRC
 P6k0YHXyypgv1ffPwefsk6MuX9VcxdLmIAYIXX+NypJwWcE1wsG3QbGD+yo1qFOgFKQo6BJOO
 bLyTft89h5NmBRs4Yf8/070wQxQ1XFombhc5muesXPyFMa69aEyTFlgN1MlIOnk80fFVqVe2a
 d8VX9wF6V715+7FvDHVpZDmM6H7Fyc6eOb3HAFvQLLBAox0naomqfP/Vb0NF3Ygij9N1DrZbi
 K2DPU/UcrI1MKrl7W01/pLFhOpKSISxUjMEEpY4MpDtIM4l7UZAumgfIfeJjlPPcpWx2QcLUs
 VN+8sWllKJPS+guSin6ujs3RJIWnJMEbxVMuyiN3kUfB2DxZeJP0BZtAuhKonQQ6MQzch85F7
 6DzkMv+eEizRR+2RjR74jq0A8RBgABPqQRdh5tdvq698FzXKEdrzMotOLscqyHKUfZeXrHgjY
 ZpzfHRRC52LJzLdiS0lKIPMiiHavaDJuJKig4HfWEFA9YiHKJipVWkTWCarizH7xxcMRaA3qA
 o5pptUbG7TurP/uU9hCV65XcKt0BO1qKkzMnBgVkOCNfJUli9VU1slaOYUEGmGo76jknSJqjU
 jrJ9/P843+gPnxfMfEkxeShQ==

On 8/30/24 11:45, Thomas Wei=C3=9Fschuh wrote:
> Introduce a device-managed variant of register_framebuffer() which
> automatically unregisters the framebuffer on device destruction.
> This can simplify the error handling and resource management in drivers.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> This is a fixed resend of [0], which was broken.
> Thanks to Bert [1], and Chaitanya Kumar [2]
> for reporting the issue.
>
> [0] https://lore.kernel.org/lkml/20240827-efifb-sysfs-v1-3-c9cc3e052180@=
weissschuh.net/
> [1] https://lore.kernel.org/lkml/20240829224124.2978-1-spasswolf@web.de/
> [2] https://lore.kernel.org/lkml/SJ1PR11MB612925C1C533C09F8F62F7CBB9972@=
SJ1PR11MB6129.namprd11.prod.outlook.com/

I've applied this patch to the fbdev git tree.
Please double check at
https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/log=
/?h=3Dfor-next

Can you please check if this fixes this new report too:
https://marc.info/?l=3Dlinux-fbdev&m=3D172500784802901&w=3D2

> Helge, I didn't document the function devm_unregister_framebuffer() as
> it is only an internal helper and will ever only used by one user,
> similar to other helpers in fbmem.c.

Ok.

Helge
