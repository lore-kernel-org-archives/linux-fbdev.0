Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16631333426
	for <linux-fbdev@vger.kernel.org>; Tue, 24 Mar 2026 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356450; cv=none; b=hOVH0VFIqAjGbf3X2TSpNrBG1yZj5R3JmZKKdi5pZ36KHuVAtBpU2T4Xve/LrinYLHLVTWsDfiGm4rXxQfOboQBeuAamBBs3tatetLJS7rnCoR3A0kLCcr0ctPgQhBfT78KlDGVFa0fgbhpk2v6/0Yz51c1xWyCmOuCTy72rUTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356450; c=relaxed/simple;
	bh=zaNQlDH/IYpkir6Zh1G82dzyVoUtO9YPkNS5RZ6NPAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeF+xeT4MKn9gWxevkzsaABNVEqIWcGqPgTJSbIw2ixXmPBtuVdgj4FVmk7BujMpEyWOJ1NfAF9waaefYCKuFgaY/LYd23RSa0KndHvrUUlApBVK+ugczMB/KtupcRTBU7N6KvvUAcpW3xqGYvGp9lAou6EAp0fDzfhyd9/6EsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyKcqltR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyKcqltR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBA9C2BCB9
	for <linux-fbdev@vger.kernel.org>; Tue, 24 Mar 2026 12:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774356449;
	bh=zaNQlDH/IYpkir6Zh1G82dzyVoUtO9YPkNS5RZ6NPAk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TyKcqltR5sHRXGtJsm9mYbzaDJc/5b8g3bzAUpDnKVK2CfrX6o0+0R0OrUvRr6Ore
	 u12du/9dDjZdg4zezRspx9k7uPF7pvuxFeT/kq/RfJsWdk5L76Ds0wzP6/E2XalvlL
	 eyovR+zQ6KJf3BNVpmzn0Is7c04Y/N2ob22S3VdlHB0CqZ+hU/i9omAtt6csKGXOn4
	 38mhP/RLPS+wxVWrPypa/WT+HpLZRvocdUWZnHLTlRMtNDeX+lW28Jr0HaHGUSDZMv
	 U07ldCScEZzNkZa9f9RCSAwQ6zX65e5Ecss40NhN/062u0bJoyZ7Bf6nWHlqkUx/vP
	 ghxR2+D9YWc2w==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-46726528f1cso3611859b6e.0
        for <linux-fbdev@vger.kernel.org>; Tue, 24 Mar 2026 05:47:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvtfEYmkfBOT0mPxH6N1GJysIiFJvBvfa2EzaqoSPNYZxAD3p1tDbZ/tn2j3l0o10MHIQVBFR3Ww0Y0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YydqmHxMGWzRzZ2VTTT08r6q2/UCsqx2Z17ATZUnx0TIrBKZVC1
	vmSOjVBW2eM3qd+qvxCnfppFP2IHIsMjlxFzvtQhNUsu36rTOKf54KKgZUlFODTwHhAeC1AGAWR
	RetjLtRky9m6ZxJf6k25a/Amw1wz9PCo=
X-Received: by 2002:a05:6870:f150:b0:417:c116:ea79 with SMTP id
 586e51a60fabf-41c10ff9ddcmr9412403fac.12.1774356448889; Tue, 24 Mar 2026
 05:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5084777.GXAFRqVoOG@rafael.j.wysocki> <acEOf2pI_NpfA4EP@aspen.lan>
In-Reply-To: <acEOf2pI_NpfA4EP@aspen.lan>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Mar 2026 13:47:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0itCrbwM2k4_3F0kQwTfAwKXFQ5G4gcn=bM65Y2NU9YjQ@mail.gmail.com>
X-Gm-Features: AaiRm53t3o66QI9GTm-Ambf1zwPR2-4cMmUQM8M9mJmuxwinEHxg5u9awX495MI
Message-ID: <CAJZ5v0itCrbwM2k4_3F0kQwTfAwKXFQ5G4gcn=bM65Y2NU9YjQ@mail.gmail.com>
Subject: Re: [PATCH v1] backlight: apple_bl: Convert to a platform driver
To: Daniel Thompson <danielt@kernel.org>, dri-devel@lists.freedesktop.org
Cc: Lee Jones <lee@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 10:57=E2=80=AFAM Daniel Thompson <danielt@kernel.or=
g> wrote:
>
> On Sat, Mar 14, 2026 at 12:50:11PM +0100, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > In all cases in which a struct acpi_driver is used for binding a driver
> > to an ACPI device object, a corresponding platform device is created by
> > the ACPI core and that device is regarded as a proper representation of
> > underlying hardware.  Accordingly, a struct platform_driver should be
> > used by driver code to bind to that device.  There are multiple reasons
> > why drivers should not bind directly to ACPI device objects [1].
> >
> > Overall, it is better to bind drivers to platform devices than to their
> > ACPI companions, so convert the Apple Backlight ACPI driver to a
> > platform one.
> >
> > While this is not expected to alter functionality, it changes sysfs
> > layout and so it will be visible to user space.
> >
> > Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ =
[1]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>

Thanks!

Unless anyone has any objections or concerns (in which case please let
me know), I'm going to queue up this one for 7.1.
