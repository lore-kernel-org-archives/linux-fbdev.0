Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C3128819;
	Sun, 27 Jul 2025 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753630520; cv=none; b=Wt4ggynKWAtPuqdq3Urfe7m2nl9gbLXk5clQ8Zdu98zSfd+4OJCgdJw4qadoPAXfUdILgz3taAKWnnFbscieH2K86fH6vnxn4UEuwsKliVO0eFMl3A0iGD59CRON7yFEi2OvZMNNyDk701bngU66pdDtlN8tPn7QMlxr8RLNfRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753630520; c=relaxed/simple;
	bh=oLS9DjHXDEi2Wu+DOtU7+LKO/cwCR/Dqv8I1238NY7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gq+wGaOfdGtpTz+WqRyJyLLiK8Sk+YOROADW3q4Gkpn7ubC5JAR19OE9yHBclY6+SYtQhvlhNStuA6v7TXtuc04Vp9Eb6JRV9bPyuvOMy94gKOgTHkAmMG9Vyef2xKIsOkc7EdQ0kH0KxGtoBowa8OUzCVNYn0i3GffwPLwpgKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=eTl1J54i; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="eTl1J54i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753630515; x=1754235315; i=deller@gmx.de;
	bh=7KFIp9QJjt86jqd8grVfKPODLA75ai887TcSuOQb0Jo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eTl1J54icf4W9bEmP32ZB7NvLxPF3eb752dtt2vut9Yo+jKfweKA5PMxlcI7zJXr
	 odfwVWkNqQKW5Mrzt2Zo+knnw7UpVMnebJw/0RR1oOMs+DqE0HQ7oZunnVlfTU4VI
	 n4CDG4tYBA9yVNSfHtuxiyRxFwOX4U7II8XeXFVcyguycE06WM607efeMygJ9q/VF
	 +HsIBlUx1NEwSPhngXUih57hVEvfTDud0qH1Sut3tUNRZNshMI2KQz86GQrhAOTsp
	 3dswJSTwBExV8zPygHEA6jHu+dUIMXWuaNov10KP91Y0jA40vAI26N4O4TMTqG/Gh
	 EsoGvTjE7l7jDq/+ew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.22]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLiCu-1uxaHz1wtE-00PiE0; Sun, 27
 Jul 2025 17:35:15 +0200
Message-ID: <09e7d9c0-3348-49d0-a390-372031652e97@gmx.de>
Date: Sun, 27 Jul 2025 19:28:53 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: nvidiafb: add depends on HAS_IOPORT
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Antonino Daplas <adaplas@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20250615183651.902092-1-rdunlap@infradead.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250615183651.902092-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IHUNI1p1fU113kR6OYZbvVxGwAn0J7KM6wwR5NDy/erYDrHSSOi
 QIbDbkISPEAcaJU/T643idMZXkViROBAAL1/tgSnEE9WO/xLZdO7Gzy6sHSeXE0ltm/ptqg
 kycRFEccYJ02IE9VUvwAIYx3D3thfwnuvWRXms0l6xfH2XIvS+2zQCswWSbcJtX6d8q8Rd3
 xdDdA18lJ3lU42DiXB4cg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hhUulzEyYdw=;J4LKUArBf27wEDh1W/LJmJ8awji
 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

On 6/15/25 20:36, Randy Dunlap wrote:
> The nvidiafb driver uses inb()/outb() without depending on HAS_IOPORT,
> which leads to build errors since kernel v6.13-rc1:
> commit 6f043e757445 ("asm-generic/io.h: Remove I/O port accessors
> for HAS_IOPORT=3Dn")
>=20
> Add the HAS_IOPORT dependency to prevent the build errors.
>=20
> (Found in ARCH=3Dum allmodconfig builds)
>=20
> drivers/video/fbdev/nvidia/nv_accel.c: In function =E2=80=98NVDmaWait=E2=
=80=99:
> include/asm-generic/io.h:596:15: error: call to =E2=80=98_outb=E2=80=99 =
declared with attribute error: outb() requires CONFIG_HAS_IOPORT
>    596 | #define _outb _outb
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> ---
>   drivers/video/fbdev/Kconfig |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

applied.

Thanks!
Helge


>=20
> --- lnx-616-rc1.orig/drivers/video/fbdev/Kconfig
> +++ lnx-616-rc1/drivers/video/fbdev/Kconfig
> @@ -660,7 +660,7 @@ config FB_ATMEL
>  =20
>   config FB_NVIDIA
>   	tristate "nVidia Framebuffer Support"
> -	depends on FB && PCI
> +	depends on FB && PCI && HAS_IOPORT
>   	select FB_CFB_FILLRECT
>   	select FB_CFB_COPYAREA
>   	select FB_CFB_IMAGEBLIT
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494 # v6.16-rc1

