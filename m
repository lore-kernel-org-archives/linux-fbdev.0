Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E1D156C69
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Jun 2025 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749763403; cv=none; b=XC9XvEYTIabx3F+Eii+r8KwBLN5dFGvhCl5c7sUy6TNragkPciioauFhHQg74/7SBqUbayluQ/Yk/gMX46mpcgrI4wpIHJNv8P0Q20Kfy7wYT7uFobIrHsdBa3eyjFxe0B5KFjKY5wHP9ho76pqEuCV/Te4NupdKuu/YhbV4TU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749763403; c=relaxed/simple;
	bh=GSof2EEDT1bmrGUY0s9OxfXtpQkqGXqfH4Ct8I0K4YE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rn+zQeju9HpKBUlHYJzPyBCt3AlKCTRl6Z02qgRo0JR5bbRJ3NYvfji0RObK5UUnU9ehslQdKhmF32UWg6E157BE2/nbDgC4biCD2cmZLi1410p2kkvRBONby1vj4nZo6gy5LkVOEz0BTt1/983MEj1iv42bP+KLMNVtIIixiVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=Am2yEgIR; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Am2yEgIR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1749763398; x=1750368198; i=deller@gmx.de;
	bh=EQ/WnXs+ZZBC5/jZvtIeaKmfF+35V9ClldktkpJu4zw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Am2yEgIRWJ0ogjeBX3sQ7VGcrvhrtOEhZ+PdpolvIYTmIUl6ZECyVuLL83QG9SDb
	 BGqhETsG1H5NMiIF5x1xjN8x84fz3uLRfQuBn6m8aRcNXoV4YFlONAYcXXiePm1ZS
	 hf+F8pTqE8hfqjnkr6zKJFv1oYn5LSiuhSkALF3FE5IBqUQg4Dshysld5om7KpBdj
	 zNnAAzPfAPodHbJNUIPK8G0lv2Hun/Kvm+/oZhkMJtALqeAogdvFKBMP5R7RudaC4
	 0G6EqGuXaGapV6dZNPUXIPGWmJojpeNh+Ejm21uxMEOOw51RtinhUTVbbS3YsCqGB
	 93Ef+FsRxchVdacYUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.171]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdvmY-1uziAi2OoQ-00ia7O; Thu, 12
 Jun 2025 23:23:18 +0200
Message-ID: <c73e51a5-6e67-49e4-9004-ec3782270e3d@gmx.de>
Date: Thu, 12 Jun 2025 23:23:17 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] fbdev/mb862xx: Do not include <linux/export.h>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20250612081738.197826-1-tzimmermann@suse.de>
 <20250612081738.197826-11-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250612081738.197826-11-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mdpu6TGWMfwxIUqjDRBNni+FFPWEpunSbirTU/o18p49F5GWL8g
 XYHy7YzeDnDYZSvjq1JLTgsH9Npz6huklFLO1iVvLXIfvAnsZvFrmMOTd0ordqjBVev2WiZ
 0ixsx+z+nhazXInq0IvSGtTS0ZsW1PY6h3qJmDGoDS7SSNR7sTbs6KTjHKyyWRS/lPxDOC6
 FbxxyjJH4r1zfn8O0Uq1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hw/XA+/OtCw=;l+E8cqB7Bc6zk4Crd6j6pPL9oZh
 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

On 6/12/25 10:16, Thomas Zimmermann wrote:
> Fix the compile-time warning
>=20
>    drivers/video/fbdev/mb862xx/mb862xx-i2c.c: warning: EXPORT_SYMBOL() i=
s not used, but #include <linux/export.h> is present
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/video/fbdev/mb862xx/mb862xx-i2c.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Helge Deller <deller@gmx.de>

