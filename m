Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA048492E58
	for <linux-fbdev@vger.kernel.org>; Wed, 23 Sep 2026 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178511; cv=pass; b=jBIgVFlTv1KGDiXRJ8TUVlize6Tjf/IJC/J+XtHKdrbn7Wwjp7xSyg1+zbAD9NepGC/UBFqlOpE/P8BCxGWbZtGqyS/ysTVRVG6oEFWtO0ln/3aKNxIuFog1CpWMEIFidnQS0Ng/ZF4kGCpRAzOMKVJq6bFlMhc8wkUHhr7D/Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178511; c=relaxed/simple;
	bh=l2pmTaYj5bsjg/VqjbuilhgmiwEDlikpvuksfpHs4aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePKWh/pK2XVqwE+/EV4iPlV8baq4zYLAA8qf1EJDRFmdEODpDcgF25nru6VEc+3S8+b3a37YDccnHg5w6JvIKN0KUcqnCBvprJOVhFyTz8AdbdcQQ3cv/pNlgP5u6vSebEOTTcknNmF++73dCbGmN8IRFgSlmCkVz67KtbN6WoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oGI8e8Ch; arc=pass smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGI8e8Ch"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-78565b4db77so614251137.0
        for <linux-fbdev@vger.kernel.org>; Wed, 23 Sep 2026 08:48:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790178508; cv=none;
        d=google.com; s=arc-20260327;
        b=e6Ds3slY8VPavG8f2CEa7XJoVlIW6phKjkMXsGDxxa7/xbDwLqFAKKbPj+GfGqRNuq
         90Rm2wB8Rv9BHlhoVQm0IQF6B7H+pFqPAXrdRZPFiYlxJw5R9QpAATJEuDD/00j+8P1R
         gFoi0PI0+/tPpXihmkHovFhOwV9waNVA5DPBgkt4WDQeRDJUqTt5y68MRC2IR5zJk41Q
         XmK2vyqSZwqecdqafQC1ESdCm6ArmcQ3qCEDoUP7xa5Go5TE5HwYWWv0GcGT5u/wzbTk
         CPO87jjg0AXE0euBUNbHOc6QSXq7DUEm0lNmj+KVgJ2sIDIRGLI0GCCWos7C1MUh/siM
         dPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f4WPZ4zqm8ezSWOAuYy2kHwqmOGcyX5dZpEWb9VtYmM=;
        fh=5bIV+jm0ZFQK7PNbUQkgrjwj2W2RlV0Vk0JcjUNPLNE=;
        b=r04pA+HdNbGRHK2Be0W+f1PPcqbpJbfKc1BtfdWVzJjgMvuhnrOE0zCP9M6ptLmZWg
         Lngre5PNUmkrH/IRK0yydB+DbcvFdZ0HgoetO7VsatLv4MYZan3Z4jNxyC9unJt4gZN1
         gD/e71aYCn2sCNmVPnPKqnfRaQNYlnN6gnP4E97b56DARtJh65mYYOD8/aBJpoW7x6QB
         yRdBP6Ktx5oVkTA3lsIdCjAH/Vnxai1cy2oISYRMkvdFcW1uy7LTOHudSzSr8M3CbZ2d
         WVLxAYgraQnN3DbDsn+TK3vhtDSKapQa41uN4V7iYP/2HilZBRBOqWI3/3+xwoyo+5p+
         TRNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790178508; x=1790783308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f4WPZ4zqm8ezSWOAuYy2kHwqmOGcyX5dZpEWb9VtYmM=;
        b=oGI8e8Ch9CslqENIh9rJ/YNJDO3OXZPNrLIl/kIOBHHkXclVmMCY/1YpY6EAbJ2wcO
         f3xWGohKrHUq/P4lSx5l3jgISlPrBILr6qdS/mC48HSTwsAqQLuC6jO8eQKPDZ7nJP2x
         nppla6NjIFZQ1U8ILQHXVMFxalXcfaNr8RDBm8KOT8lkiRq9VNaPfT4Y6dijHYhSpC6j
         ORl6yIjWVy43TAdvaXGProAheapLSSDsNE7UewZ1bW7yXilS0jvpW1+0N3bmzl/oeRSl
         8yfJGA7F7jXAHYXdEaFVitfqpTN6TfDpDJ2n3Q35FAEcWUX/97v/i9YwjWx/0OPcy7P9
         6g/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790178508; x=1790783308;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f4WPZ4zqm8ezSWOAuYy2kHwqmOGcyX5dZpEWb9VtYmM=;
        b=g7iGpGXzfP6sKJO8NtxSMZLxUkplpP46AT/nsVJfvwAqO9HHCpesGxf0X3lo+V/KrK
         Z4pzNUwzyGmVaMsc/fLC6g4yZOTX1bPEXXswiBMpnbaWVfownkiltxvqlryWbhnd3Oiq
         VFjJE3GU40M+a4DDW7Ve0JJt1p/8e+9/KtnI4zSaSkZAaDLBDMIGoHmlN0gSerAxGOvG
         Hh4HoARQSmwl0dh/9iDfaEv7lmUoFptHbyinVMEhX88PFzDwvNiw5cl358sLUe0+VvdI
         YsC5IR8StnXo8VhLaRFItYUF5W45geZfr8pYitkQrELpXOkQVo1oCuYpfwHIugPxTSkB
         5Iew==
X-Forwarded-Encrypted: i=1; AKwUvBxu8faTL9+KxvSNBzM2bCEgCny7B8WhySBdh3b/wOyngE9RrQr3/ppU+mUFoUY4CGEo3G7qBDQXYGDsMA==@vger.kernel.org
X-Gm-Message-State: AFuF++lM8Tu3g4k3wtEbHxaXubSz3ilzFxxJFVJvm8tK6q4E9Xpbclp7
	pzTX8FFH9UAg7zhmGZ+j0DnA8eDm5P1VgIJ4AVns/RsmVTcFTMslnuxHln8S36gQIAoZIqC8+yR
	mf6g8SfvtekoiGD2wMoELqAeyibLuM2I=
X-Gm-Gg: AYBFou3tpvUOZpi7g41FyQSkUhZJVUUv8NglyrAaQAj+/4FfpY2VyTdO/ZEfz8IhXLo
	7NRNhPVP2PV9qO7M9I8rCBvpsqViCiaxm9fAR560sRgDU7nc/aWB11sqBcw34swFXzLxrroXlf0
	vXoZpybGI4wcbkzDxmi4lhPoZUr3sRlw8Iaqwzjl1PvguW0rNrOHX7ghTrhTBkOI+lOXmUjJPBE
	JRv4CxiakmDTSdwtAfj5Vag654wm12r2W0Bbts4jc2pyyxFcGgqRCLrTLW4E/CdcjpLWkIMikh/
	rTMVru6sxqAHB/n43+XKA4Q1SyEeLqFzdyeFFDLxy2dTGVSgSwQ562DZZc2+rynITHRo4+KKrgU
	iJNPOW3NMSMs4
X-Received: by 2002:a05:6102:5808:b0:7a0:f7cc:5045 with SMTP id
 ada2fe7eead31-7ac1ace44e2mr3005717137.9.1790178508346; Wed, 23 Sep 2026
 08:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922225501.1792665-1-inakisobera8@gmail.com> <e0bf7dfe-c03d-4fa6-abdd-ac88cab8faa8@sezginduran.net>
In-Reply-To: <e0bf7dfe-c03d-4fa6-abdd-ac88cab8faa8@sezginduran.net>
From: =?UTF-8?Q?I=C3=B1aki_Sobera_Sotomayor?= <inakisobera8@gmail.com>
Date: Wed, 23 Sep 2026 09:48:17 -0600
X-Gm-Features: AclHuK8teJhZIneAm-pS1paRCtlXiHjDfzAKz7zCRFZ5JookA8cSJaHe4mqvE2Q
Message-ID: <CAAqk8=3zK9bJV2Oejb9vTD_tKA9agcsCWnKgEEPm5tgnza8A+w@mail.gmail.com>
Subject: Re: [PATCH] staging: sm750fb: mark g_fbmode as const
To: Ahmet Sezgin Duran <ahmet@sezginduran.net>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ahmet,

Thank you for pointing this out. You are completely right.

I mistakenly missed that g_fbmode elements are assigned in sm750.c
(lines 762, 764, 872, 876) when handling display options, so making the
array itself const breaks compilation when CONFIG_FB_SM750 is enabled.

Please disregard this patch. Apologies for the noise.

Best regards,
I=C3=B1aki Sobera Sotomayor


El mi=C3=A9, 23 sept 2026 a las 1:27, Ahmet Sezgin Duran
(<ahmet@sezginduran.net>) escribi=C3=B3:
>
> On 9/23/26 1:55 AM, I=C3=B1aki Sobera Sotomayor wrote:
> > The g_fbmode array of pointers is only used during module initializatio=
n
> > to parse display options and is never modified. Marking both the pointe=
rs
> > and the array const allows the compiler to place it in .rodata, which
> > avoids accidental modifications and cleans up a checkpatch warning.
> >
> > Signed-off-by: I=C3=B1aki Sobera Sotomayor <inakisobera8@gmail.com>
> > ---
> >   drivers/staging/sm750fb/sm750.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/=
sm750.c
> > index 8b93bfeb2..c3f391cdd 100644
> > --- a/drivers/staging/sm750fb/sm750.c
> > +++ b/drivers/staging/sm750fb/sm750.c
> > @@ -12,7 +12,7 @@
> >   static int g_hwcursor =3D 1;
> >   static int g_noaccel __ro_after_init;
> >   static int g_nomtrr __ro_after_init;
> > -static const char *g_fbmode[] =3D {NULL, NULL};
> > +static const char * const g_fbmode[] =3D {NULL, NULL};
> >   static const char *g_def_fbmode =3D "1024x768-32@60";
> >   static char *g_settings;
> >   static int g_dualview __ro_after_init;
>
> Did you compile this patch? While SM750 module is enabled?
>
> Regards,
> Ahmet Sezgin Duran
