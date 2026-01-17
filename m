Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17241D9A54
	for <linux-fbdev@vger.kernel.org>; Sat, 17 Jan 2026 06:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768629786; cv=none; b=qvxJUPQH5rw4qQqs6OvWDA0LmPbuR6Wucf/1Ag+dH7kp31A4Oi8JHFEYq4ERGivSb1NE0NM9AVCVCvQk0+EtULJm8F0w1AgmGbqiJIgQwGPR9aEkqoQjH7sJFIVElsSIyn7hR10S7gmcliw+SeQmgwX2bb2FPfwztr20zybe4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768629786; c=relaxed/simple;
	bh=WEY5FHoVyPqz14YMq9W60SdwD5lwX+gn/MRa8GYb4kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpAFNKA5xU20DuYL0dXP2rkQ1sJnsXAZ6XMDIy+dbQxM6qfGlFOe3j/o4XkoaKzbMm4ZQzubNYAS73cD74xlGzFtA4m2zm6cgUwQWXhrymHM7cjSKO7AYOTcElUDbsL5NxqSZIMJmnnLBtsCTz4uCd0JJKIBBFu54Q2QzAH1v+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dn+p+Ssw; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dn+p+Ssw"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a0d52768ccso17708505ad.1
        for <linux-fbdev@vger.kernel.org>; Fri, 16 Jan 2026 22:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768629784; x=1769234584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEY5FHoVyPqz14YMq9W60SdwD5lwX+gn/MRa8GYb4kE=;
        b=YswGgdf2NGgibxfEr8RijeqowsAw02ZGd7t2LkhsX4DDQcqAghu5p/VW/lXRf2FKLk
         61wgaacB6ghjnr9TUXw17HfdorjR+z0IpX+Ogr5Yo1YAUFsX5JW5TaEcM1lu6FrDbe6j
         PK7A/340Xfc92E9qQwbVNItNm+t38haXJKO9t2f01eXLDrUATBLrPqAcYDz+rwuqB6St
         1FYLbf4vEAJCrVtadUP+RkXEVPK45Uw+iOToEqv4DmjXkHjfBwoiaCXWSklNqmygr/Gc
         JDq/KVmE4rbvmUY5MAc8NqzF5XAuPzs/lNyj62sq7dGBb8zdfGgTZ2fmzXJc/C79yjmf
         k2Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXDyLpCXWSwivZl+YZOTnh8fcSeoIczV3L5nEyzGF1hAmdHM64dQj+FiKWRLpy0I7FBEMiz90PYdNJxQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAjHcyC0hzUGsDZbqICx7pXv1c5Kv1keePxrRnpYe117v3xXM6
	x5gUy5VB8rOUvbUHKYMEvEpJXRkaUfTp5Ne33Ga9gmEfuLfaLazxLFtc/74WUToqm/QxlI0A1MD
	vxZfidouaEPt5/1c+nQ454lD/ByoLbxHY21IXlS3bY/u4nSVMgnd/h9ZhGbTUXS8Gy8VP9Lj8Nx
	2uRQIW6m47cQi53D/22yPvKwGw6dPCa6mcOtVw6rrSOPsd58Kwfp3zWDu5P3z9kgWQt04IrGwwx
	aLHwBIYXlCq5yc=
X-Gm-Gg: AY/fxX6G8u2q/pnka8TurPkFAbGHTW0aQnVkBMl6ZBGHbwzIMrca2294V9pasp9YouX
	QAAMfdmk2ujKUIV29O8hPff/R3lukJB0HvgtyUwZy9W3jcwj9UyDGIowgYjn+TE1Jax518uGqiL
	o4tnFWEyfDdu1f9eQTGNSWMg7JkRPEU2F0ZvMNUtvH4G+vuUSR0uaR+xDkz6vobL5wHa3/jT7FR
	Ukaqara2q87QN0j/ooYnPIcothD0ZufxXcISirOZPbOvZDQbSkzuY4klYSu4zTdDe+0BMwUCFoI
	rj/lxW0D/zwxrxhBMO4ZCVMxDhbeu2XIRxjheWgtuXic6s42uBdRMgclfLJ9AH5XCt51F73aLhj
	3+kZrrfOrukguYEyQMdBMl3c8oGanH92avZeRI3NV3gfKYntwLH1Gc+4rBOWfDbTTWk25tTXU2T
	bBm5Us8KBfEkyyLlehn/wn6xCODgITHr4qG/GlnXBtfQ==
X-Received: by 2002:a17:902:d2d0:b0:29e:bf7b:7f36 with SMTP id d9443c01a7336-2a7177eeffbmr56482055ad.58.1768629784048;
        Fri, 16 Jan 2026 22:03:04 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a7190a25d2sm5684645ad.8.2026.01.16.22.03.03
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2026 22:03:04 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-59b2da78573so2855378e87.2
        for <linux-fbdev@vger.kernel.org>; Fri, 16 Jan 2026 22:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768629781; x=1769234581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WEY5FHoVyPqz14YMq9W60SdwD5lwX+gn/MRa8GYb4kE=;
        b=dn+p+SswauI/OdCddXEdDxZKxUX3D3KXq/IJQGoVotZ6SMcA53c9cozwGoTzXSwZRD
         8wjKjXpszgxhcIKQHjv7sPSJ1CW9kSxo6+vbFdPGJjDxmfZfQdXD09sKDk47EjxpxLJO
         Xm80oexUdxtLINBNTBMSmqLdiXGkK/CBkaU6A=
X-Forwarded-Encrypted: i=1; AJvYcCVNb5xe/GUgdnyznC9RQniDdxbsbls5gF3293wvYzA65YKgN1xcnI7zmviSa7ZHVzNa24Jtt8tDcoUmIw==@vger.kernel.org
X-Received: by 2002:a05:6512:10cb:b0:598:f262:15c7 with SMTP id 2adb3069b0e04-59baeef7c0amr1501652e87.25.1768629781430;
        Fri, 16 Jan 2026 22:03:01 -0800 (PST)
X-Received: by 2002:a05:6512:10cb:b0:598:f262:15c7 with SMTP id
 2adb3069b0e04-59baeef7c0amr1501644e87.25.1768629780919; Fri, 16 Jan 2026
 22:03:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229215906.3688205-1-zack.rusin@broadcom.com>
 <c816f7ed-66e0-4773-b3d1-4769234bd30b@suse.de> <CABQX2QNQU4XZ1rJFqnJeMkz8WP=t9atj0BqXHbDQab7ZnAyJxg@mail.gmail.com>
 <97993761-5884-4ada-b345-9fb64819e02a@suse.de> <CABQX2QMn_dTh2h44LRwB7+RxGqK3Jn+QCx38xWrzpNJG5SZ9-Q@mail.gmail.com>
 <f3643c19-c250-4927-b39d-37d2494c7c84@suse.de>
In-Reply-To: <f3643c19-c250-4927-b39d-37d2494c7c84@suse.de>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Sat, 17 Jan 2026 01:02:48 -0500
X-Gm-Features: AZwV_QiUnz_If_z8Rkd9UgQ6zWILOg85OCTnKGucjTIyh0yZ4kAyPDhffMT5Rew
Message-ID: <CABQX2QM0_6DJtrahJS7x9iF_wcSZRc4dohEiPnMCtAg7Vt7JPQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] Recover sysfb after DRM probe failure
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
	amd-gfx@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>, Ce Sun <cesun102@amd.com>, 
	Chia-I Wu <olvaffe@gmail.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>, 
	Deepak Rawat <drawat.floss@gmail.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Hans de Goede <hansg@kernel.org>, Hawking Zhang <Hawking.Zhang@amd.com>, Helge Deller <deller@gmx.de>, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	Jani Nikula <jani.nikula@linux.intel.com>, Javier Martinez Canillas <javierm@redhat.com>, 
	Jocelyn Falempe <jfalempe@redhat.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, linux-efi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lucas De Marchi <lucas.demarchi@intel.com>, Lyude Paul <lyude@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Maxime Ripard <mripard@kernel.org>, nouveau@lists.freedesktop.org, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	spice-devel@lists.freedesktop.org, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	=?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, virtualization@lists.linux.dev, 
	Vitaly Prosyak <vitaly.prosyak@amd.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e368b506488f35a8"

--000000000000e368b506488f35a8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 2:58=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 16.01.26 um 04:59 schrieb Zack Rusin:
> > On Thu, Jan 15, 2026 at 6:02=E2=80=AFAM Thomas Zimmermann <tzimmermann@=
suse.de> wrote:
> >> That's really not going to work. For example, in the current series, y=
ou
> >> invoke devm_aperture_remove_conflicting_pci_devices_done() after
> >> drm_mode_reset(), drm_dev_register() and drm_client_setup().
> > That's perfectly fine,
> > devm_aperture_remove_conflicting_pci_devices_done is removing the
> > reload behavior not doing anything.
> >
> > This series, essentially, just adds a "defer" statement to
> > aperture_remove_conflicting_pci_devices that says
> >
> > "reload sysfb if this driver unloads".
> >
> > devm_aperture_remove_conflicting_pci_devices_done just cancels that def=
er.
>
> Exactly. And if that reload happens after the hardware state has been
> changed, the result is undefined.

This is all predicated on drivers actually cleaning up after
themselves. I don't think any amount of good will or api design is
going to fix device specific state mismatches.

> The current recovery/reload is not reliable in any case. A number of
> high-profile devs have also said that it doesn't work with their driver.
> The same is true for ast. So the current approach is not going to happen.
>
> > There also might be the case of some crazy behavior, e.g. pci bar
> > resize in the driver makes the vga hardware crash or something, in
> > which case, yea, we should definitely skip this patch, at least until
> > those drivers properly cleanup on exit.
>
> There's nothing crazy here. It's standard probing code.
>
> If you want to to move forward, my suggestion is to look at the proposal
> with the aperture_funcs callbacks that control sysfb device access. And
> from there, build a full prototype with one or two drivers.

I don't think that approach is going to work. I don't think there's
anything that can be done if drivers didn't cleanup everything they've
done that might have broken sysfb on unload. I'm going to drop it
then, it's obviously a shame because it works fine with virtualized
drivers and they're ones that would likely profit from this the most
but I'm sceptical that I could do full system state set reset in a
generalized fashion for hw drivers or that the work required would be
worth the payoff.

z

--000000000000e368b506488f35a8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIBCK
e4A3z3CqFQe3IsyXO5x3uXMpy+yDDD7NQNrNRe7NMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDExNzA2MDMwMVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAF9UCNrjUszuJyZJ9qD2nUurudemOC2+7qfQ7d0R
Fd8hSPqIRTjx6cZZQJH7DMqista1wyBVAt66WJvrfIkfmE+SSHy329BhgBxmOqMOVFmgJLjKST5e
Z2KW2VXkLf4m4m6Mq8gsyqGUQSQts8y45CBdoxQQLmJZ3h5BJTugR3nb+Dd4AfDUmIdj3hQRAjXl
vKvlXxhBFnnaR4gMxLqVy9TKIuR3U389sytYtUYLa/ksIr9Mdqp/66ONtMDlnapIqrZR8k/FQQtv
wu5sgNRRSoA2A9tvvbGMnrLX+fjz8D7FIF/mesRtFgJpfjSsOJ4XmGmvc0GvayR9Y3jNLWLOI2U=
--000000000000e368b506488f35a8--
