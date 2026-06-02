Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8962331222
	for <linux-fbdev@vger.kernel.org>; Tue,  2 Jun 2026 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401629; cv=pass; b=nLFI1Detx6OHjYcV+S4OKpQnABAgTlw0gFak2YqEwaywpqXSmdmIh/FTyFdylQ4NVhEYUEJnSNQ5NrH2LO+bKTuX0ebCGlQzGYcr0LwY7NKNKaXUdahV/KN2JdC5W4X7J2MYfVMK1UVOkbNPO/WZE6JciJHIC//9DMHlUM8WIQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401629; c=relaxed/simple;
	bh=05RkR29gR0EzADOG/MdNwo8HCGHyLs1e+QZ7FIg+Q3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DN1GWBkO2zDidZv+Y0E50ItUxO7s7WdKebIPjg7hBu1ge1h7cPJi27uy/ReI9fskTzntcoprNIh31pCFMToairXbixoINz+b9LQKbhYEIKMwd3AnApDPM5FyzSXAnt4ecr+3zvkkclytYRr7SPsGdfeeZp0Wd3Vqs0bvhyiSupc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpnsARGD; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpnsARGD"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-307263ad0cbso2226454eec.0
        for <linux-fbdev@vger.kernel.org>; Tue, 02 Jun 2026 05:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780401628; cv=none;
        d=google.com; s=arc-20240605;
        b=O07l56uNBsT3XsjbtySwOSrUGes2bD7GB71pMidglsL21ukN8+Z8dDMZclKdV7ywW+
         lkJNbjK3iFouDMSO6ReDw1AiCyMmOEa210/aSZkD3l2/mtBWPSy7Wd2nWOdYmED8kYDO
         jMUosdNEV65uW7lr7n18GK+db9oF7YC+RAprF8pB79Sn17zhO2Om1PYFcHKBhqSf25bR
         Ivi9fqWvZs8CduJCxX1IUTKxCqdGijFyst6DExK8XtUztOD5pVKMhu7q5UogXiZPYfx4
         JOECsHzkQiy6VCrW2NbmB257ixhfIeGXl39ab5Ldo9Af2wpAVoQn0Kd8eiVwgvvXVwuz
         FSHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ltXCCc4wpurtipYSrGSPv75JAWyLn0B0neQXenFUA+U=;
        fh=Q4ncaQhRSBnLBOoAT8hJvzEFTuY9PDF+/Hr0Y5TayZc=;
        b=eHaO4LVBYwj51mHxBXYqBXlAk1yMAY1ACUv9WBZ5AR0FvWLHyNLgLCYO57i6YFK2/R
         zMRH/Xv6VH3FEw7faZ3dkY+vzhwWawEv5IQLjILB5tvgfJANBVTgei3oM+PVZipbTTVT
         y0hLqz/R0DBhJ9vOAtYRn3/Q7qjWDV+E1HyueFOSuE7fCK/4rVwkAwUgEsjQCPrVcrBG
         uvV75Ia5l96Taz7WYRaiTS7hSwMtjdIsBiiuA1bFOecMcrgrYgEbUn9aBVgmHA0db72s
         l1p647yznDQr/eFoBiYcYIaXIdp9LYJoVvhwZMFLUo867V4mCb0zXeGlohk+zvCGbgjn
         p5Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780401628; x=1781006428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltXCCc4wpurtipYSrGSPv75JAWyLn0B0neQXenFUA+U=;
        b=HpnsARGDbG9IQ8Dv/Qfp9jbpu2ux3zNde1400BTJXTkrP2TPdyLLOpUzZJcSm34fkN
         eP2AsQMgG/vfz3G5vcEBK37CCZ3AkO/BaD+yjBkhtDQcVPSSOgCkq6AEIxF62a6+ct+f
         iw+Jh9ScEE6KmIo82LayCV5q+Iuu2JNsgwzuPCGxSuggPdIqzIMr/7A3mvYCsOHBsKhG
         9hcorNNVF3k2l7r+elR0Qi4uyFQHXO5LT+G94KFCRplQboEDCnyd6GVkLGWVpAqqTc3p
         Yd89XnO0iL4jAfioBfqaElG1Vh+ABP6WCMuu5xPzqQIHQS1bMUpPwzhjcCBD6s2rea90
         fASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780401628; x=1781006428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ltXCCc4wpurtipYSrGSPv75JAWyLn0B0neQXenFUA+U=;
        b=MN43rDRJDky8S25m/H8M53w5GsRxwsLsO+1bI29kNXHU+hVVdPzAjKhmtgvcDnO8GX
         NLj33RApY2viOWmYrd20oPZ5qWDVXqIZryBpXA13Gfm00iDTfQ6EKf5eD9Cicc7yU6xL
         IlY6lpSRo/cOa1g630TsH3ZIaLgF5jwTgyhw+Q/diUsUD3lmpTpCLfiVf493gpPLn9bX
         45LdiJpIaBmxbf4Q6RoxSzBvmMzKs+LjVj8X88Pod2YRPsaflVYCBCVTbCMPZTdSpKPi
         3S4/vA9Vi+orJtv/qs/Au25EnrLqRTTlC6GKrkUh0jDWx5NtT3oW4+E8BcXz7CvcNLcC
         woNQ==
X-Forwarded-Encrypted: i=1; AFNElJ89vij3PE5/dcfRh17pCLA0HSsRN/yp3zgU5PxKP0zSu9zg1ZKfwELuoheARUFzSlhNszKAiHX+VPP2Wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYeUIw1nSnu1MWvKF+rkcX23Q8D3Ipzu1PrbPhtjXQdyMrLKpm
	MxG0HkmjaCHoV87s6IYL6LvhNg3AgAO/HDBaVK6BQ78LgzfTE/X5y2Hioa5B4q2Iu0L9IaZ9qce
	ZshEdKY8vjUQhRE9ce5O/tmvkMdCPMv8=
X-Gm-Gg: Acq92OGYMPro5z/ovPtILGW/Yqt9AIPm+aosDokPv2YEKTK/ko1BHZnxd4i9J1c3pyP
	ew7p99JoDnVDUzzYlTSdjpOIr8b1iWv2c6BbO4/LDEWFwiNJWqO1WeyjxkhU/xaXto/8T1r+rce
	7dA9tB+9Pz6vW5SYmJ2O8L0riiUUa1/oz3gHWY+VPPcvHD700Vlf7LOjhmCnaF23SILxf2oJSjp
	LrPCcQUG2LNQRu7PNTuh9sFFQ4h2TVXCFqvM8QB6qLsrAF34OHukYYAT0cw4eZPCqXOu929Gnu9
	sUJ5NQAFPymeCJkAO/c=
X-Received: by 2002:a05:7300:6da3:b0:304:cf6c:4cfe with SMTP id
 5a478bee46e88-304fa4d506emr7133140eec.9.1780401626958; Tue, 02 Jun 2026
 05:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151831.76350-1-clamor95@gmail.com> <20260601151831.76350-6-clamor95@gmail.com>
 <ah6TGjRNnDpQGO60@ashevche-desk.local> <CAPVz0n21RGAaJc1sda4xyp1h0z+6R6FJ4=XWdOtB1mgtV8=RUA@mail.gmail.com>
 <ah648F2plc4UHTM1@ashevche-desk.local>
In-Reply-To: <ah648F2plc4UHTM1@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 2 Jun 2026 15:00:15 +0300
X-Gm-Features: AVHnY4JW9CHRHy50Nkm6GtBSzM61Oxt7rnaqb6kAIuOEvYU0rp0GBajm0chAidM
Message-ID: <CAPVz0n2J6cmWyYWL5aQcFJeDEezD0P_ianTjqUzXiFuDsYbVmQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] mfd: lm3533: Convert to use OF bindings
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 14:05=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Jun 02, 2026 at 01:31:44PM +0300, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 1=
1:24 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > On Mon, Jun 01, 2026 at 06:18:25PM +0300, Svyatoslav Ryhel wrote:
>
>
> ...
>
> > > > +     device_for_each_child_node_scoped(lm3533->dev, child) {
> > >
> > > > +             if (!fwnode_device_is_available(child))
> > > > +                     continue;
> > >
> > > Do we need this check?
> >
> > This is nice to have if the node is disabled. If we assume that there
> > are no disabled nodes, I can remove it.
>
> It's already implied. See
>
> static struct fwnode_handle *
> of_fwnode_get_next_child_node(const struct fwnode_handle *fwnode, struct =
fwnode_handle *child)
> {
>         return of_fwnode_handle(of_get_next_available_child(to_of_node(fw=
node), to_of_node(child)));
> }
>
> And I believe it's written somewhere in the documentation (if not, feel f=
ree to
> patch that).
>

Very nice. Thank you.

> ...
>
> > > > +     ret =3D sysfs_create_group(&dev->kobj, &lm3533_attribute_grou=
p);
> > >
> > > No way. You should use .dev_groups.
> >
> > I did not change how driver does this, just swapped lm3533->dev to
> > dev. I will set is back as it was.
>
> This is a serious race condition that needs to be addressed. Since you ar=
e
> touching this driver the fixes against known issues probably are the firs=
t
> things that have to be done.
>

Fine, I will have a look.

> > > > +     if (ret) {
> > > > +             dev_err(dev, "failed to create sysfs attributes\n");
> > > >               goto err_unregister;
> > > >       }
>
> ...
>
> > > Can you think on how to split this change to smaller steps? I believe=
 it's
> > > possible.
> >
> > No, I am done with tinkering with this patchset. It is broken enough
> > and it has inflated enough.
>
> Probably you don't want this to be reviewed then? I believe other kernel
> developers and maintainers will ask you the same.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
