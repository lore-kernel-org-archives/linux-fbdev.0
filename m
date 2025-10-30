Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F087B3E1
	for <linux-fbdev@vger.kernel.org>; Thu, 30 Oct 2025 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828880; cv=none; b=BmIQNgEaPX+5Rio+KUZ91/K5juEl100D54NFjVStuCsDGFEidBoGZyK0+3uiHBgMV4cvXGLYIWIUpe7XCpjUvRm2Ke23Uoia/xC1GJnl/oHjHL3OUIoLalPMsV2+cueQlZ73c9Vj4uzgaafSCIPE6GnxgC4DQIM15i39ALfYwtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828880; c=relaxed/simple;
	bh=Aj9GZ008QzUzXkooekBjbFcppgAMbSxcHVyDcsJ/Xj0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jNppTAO/x8LCtpoU7nYZnc/CAz2l68Vt6sfjpj9leDX9ci05XZPrIbY53W6vdIJgAJi/C0cze9P/NiS/OWllMB1xr3R4oS/eDMTeLB3msaPw5Qmp8fRZEpUKzhMXvQToornRd4q3SKO3cc3Vko4MAbjeJXCdEls9YeWEzBM8xWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dDRPXxFq; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dDRPXxFq"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C5803C0DAB4;
	Thu, 30 Oct 2025 12:54:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3A2276068C;
	Thu, 30 Oct 2025 12:54:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5C64011808A35;
	Thu, 30 Oct 2025 13:54:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761828875; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Aj9GZ008QzUzXkooekBjbFcppgAMbSxcHVyDcsJ/Xj0=;
	b=dDRPXxFqLQfdPMh32gGnTc2/SmpBp6YBxCrNHSWhaPl/FhC3ncwmGD5dFpF/1QOViBjWtv
	k71/ZyjEkgcNW6vJW356l+c70qnktSysYC3P0KmCcKQKck0yMPlalzfqZjvajjUDSfWXX4
	dG/x++236sSrVFzu0gCmNSZjF4iVYwBtwBQbeHFFxn+lkMjTlykbCXp9Bl+A4pj/qT7F3s
	ufiR6vTnHU0b1UL3TVi7R4/+PMq88hdRVPCPyVIx6k03jvuiP3HsgwlxOgwtYsbLbPEKcJ
	s/QTKSbaC3JA6btc18m24FwyN5L2ktKVmcNrSgXMGfkMIA0ksgTXjZeE+qIU/w==
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Oct 2025 13:54:29 +0100
Message-Id: <DDVO7L4Q3GC0.1B3RH5DEQ20HV@bootlin.com>
Cc: "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "tomi.valkeinen@ti.com"
 <tomi.valkeinen@ti.com>, "lee@kernel.org" <lee@kernel.org>,
 "tony@atomide.com" <tony@atomide.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
 "deller@gmx.de" <deller@gmx.de>, "jjhiblot@ti.com" <jjhiblot@ti.com>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
 "saravanak@google.com" <saravanak@google.com>, "herve.codina@bootlin.com"
 <herve.codina@bootlin.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "alexander.sverdlin@gmail.com"
 <alexander.sverdlin@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "daniel.thompson@linaro.org"
 <daniel.thompson@linaro.org>
Subject: Re: [PATCH v6] backlight: led-backlight: add devlink to supplier
 LEDs
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
To: "Daniel Thompson" <danielt@kernel.org>, "Sverdlin, Alexander"
 <alexander.sverdlin@siemens.com>
X-Mailer: aerc 0.20.1
References: <20250519-led-backlight-add-devlink-to-supplier-class-device-v6-1-845224aeb2ce@bootlin.com> <6e6039c815c7125e35b43ca2f8d32a0fa3103fea.camel@siemens.com> <aQJSqJOrtETMKt8x@aspen.lan>
In-Reply-To: <aQJSqJOrtETMKt8x@aspen.lan>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On Wed Oct 29, 2025 at 6:45 PM CET, Daniel Thompson wrote:
> On Thu, Oct 23, 2025 at 12:41:30PM +0000, Sverdlin, Alexander wrote:
>> Hi Lee, Daniel, Jingoo,
>>
>> On Mon, 2025-05-19 at 22:19 +0200, Luca Ceresoli wrote:
>> > led-backlight is a consumer of one or multiple LED class devices, but
>> > devlink is currently unable to create correct supplier-producer links =
when
>> > the supplier is a class device. It creates instead a link where the
>> > supplier is the parent of the expected device.
>> > <snip>
>> > Fixes: ae232e45acf9 ("backlight: add led-backlight driver")
>> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> > Reviewed-by: Herve Codina <herve.codina@bootlin.com>
>>
>> I've noticed that the patch in archived in the patchwork [1] but I wasn'=
t
>> able to find it in any branch of the backlight tree [2].
>>
>> Could it be that the patch somehow slipped through?
>> It does solve a real-world crash, could you please consider to apply it?
>
> Sorry folks. I overlooked this in my backlog and never posted the R-b
> (which helps Lee figure out what to hoover up).
>
> Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>

Thanks Alexander for pinging and Daniel for reviewing!

I double checked right now and can confirm:

 * the bug is still present on v6.18-rc3
 * the patch applies cleanly on v6.18-rc3
 * the patch is still fixing the bug

Best regards,
Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
