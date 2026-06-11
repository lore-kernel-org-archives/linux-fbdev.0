Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237002C0F93
	for <linux-fbdev@vger.kernel.org>; Thu, 11 Jun 2026 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181115; cv=pass; b=ZSvkTleYgBxosQ8lwDyJclnfynpE9Isib3ArQeHTNBkdJTjXfhuqxSU9w52cvPzf7rMs8LTyfquvZbKegkHpgv/dCWQ67GxA9FwfeZQIr2CH12UuFQO0G3/Qs+ZzqAz7irVFJkBeUtlWQblpgwrZFN8PH7Oa4VvvwK+EmM4e0f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181115; c=relaxed/simple;
	bh=N9w8AQ/izAnL6SZkvE0t7Zg95S0t93+i10d7C13tBDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OiOrWSWf02pnG7jpDIp+gCkHr7ma5bGzFbSrDsFWLCbT+6s7Z6ysiwW70kHXmqZrZKeg8IXYj2tvmM46YSi0ARhYP4eBlGAHAFnCq5dY15HGYx/8DK3ePsYNCAttm9sOPCjeT9gEtsbPoxoVGuoBEJOLk+grn6t+7yBV0TbhptU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMrjbGU/; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMrjbGU/"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-304d7f31215so7095477eec.1
        for <linux-fbdev@vger.kernel.org>; Thu, 11 Jun 2026 05:31:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781181113; cv=none;
        d=google.com; s=arc-20240605;
        b=Lh2mZT8lCc6sCuAc4itW5xc5mAiKOeo4xu75I8NrQjrSO4L96xWcvhq5ytTQTnSB6F
         1K8Elb+9ThPegTMTxAVD8FJMjeXSXxSNwvBbFrGkoVnLAnl587ZRGKNTzwHlo7pbEuCl
         qbHWk9G/vVUS4XM8RfeQbFpi8uvnabDHGQ3NguonCttsaa/I3wbqzARj0KC7frEwfzy4
         sIWDMmEi9oCy2Acqk01/Y01HxDn+xvC/JLEiFpQe0k+W7z57aMNvJ+JUILLgDk35ISiz
         /rvEeZbc50tCtm3IL5C8BBAKk7v2CUN8B6TLcXqFSWWxdHOR3z6iTk5sN1J005RpmBK+
         THdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w4CyzohY6NxCIsHAPrysIwJ2ZeDEULVaTSdexi5v2m4=;
        fh=nCXFLHX2eqPaKb4hyC2KzZBsarjMU0gIKvkEzYpx590=;
        b=FtbnB7Lhifs5P5AL0nFXeCZcsAC9E/z1GVqqsYIGyB7mkLvBoLwlqwx1xk5B3U2Z1N
         PLaz6y2vyrxSlain3q4IaaEdoAn/i48XwLdVS3ER0wSka7KRlC5Z1SnS257gUwNNJzdQ
         7ZYn4XbhLo3zEgi6XSEd+Ahb8lJPVoHRIyrgFQznpzvCaIer+duEm2/gRmAlxO8YC57d
         VJ0AwAw/ZuszzZE3+7QaH+Y0F0P/5mgnau4K5yL1OxvMUxGVl4E9GABHwFV4rQt97Fwj
         ArMld6O8a2lI0c46rkeErcuFepLxGHZdISDupTDkUe0Ldo1WYomgmKbBq+ty5Gohn0ZJ
         JjYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781181113; x=1781785913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4CyzohY6NxCIsHAPrysIwJ2ZeDEULVaTSdexi5v2m4=;
        b=jMrjbGU/K/MiY2zpDfjCinZekRAjsHLsioZc4nj7eI4VhBvHnKb1u0mEDXZ6rpWSDc
         AFAhW+U8S/DDVHpdGjmLBtrX60cuCucbfedeMIigZmiyxFnFldmIr6MZ4nxTnrDPDhNk
         Djj0Yrjtf3uuX4fjdVvrEtKWaucr1c71MLU6RrNKuPHywTKCL2i7fnDs79eHmkqVkxgc
         7cwj57+IS/kQ+HMIFG5awsEfTAzAS6H/XvUC0URVujIuLj0WoxmR81MdiiNc0TVjTVbU
         p0UEzyUbVf42N3mVisgHO8vf2ahgMH92KtQOYVcdOJc6n20hj5gecF2MxtIDBesF9yVi
         3sOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781181113; x=1781785913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w4CyzohY6NxCIsHAPrysIwJ2ZeDEULVaTSdexi5v2m4=;
        b=YG5IqsIwYO3Yoid2E59abFdtO4pNERT4145zTGoDO0e8/46oU4Mskg7+OCVuD+5R8C
         N3hXxUUOEZOR3rBwETNOQOrZpi6v4SDo8Wx/K4nEM1pDbf58f8PSaQwZEaJUOaNEg2R7
         tg/7UfclqymueuxcFrTR3UpKTyIEbVWe4DGtt6oWc5nTVBT75F2pdb5axorCcLN+MkOW
         D21CNqOVECIYqxuzkJcaP9tN5i3p8Kh6xAI3WAfyc9sfQC3R1e1VRR6PeMxXHmg6P4yy
         OS6rwT4QAUyQesvUpZr8e6y4hgzXs8KSXsQCM2mQcQOQfy679C6yQzz+u2Dc6n2YnSVM
         raOA==
X-Forwarded-Encrypted: i=1; AFNElJ/Ron5//aviPOhzZDM2Mpqzl34+8JomNbv8hdhRZYYlAV4xaaFi5jTzXj3Li5yrIoqhRAnCDxmt+k0kCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpxP97viNvJw+uIe+ZeZzDvXbbtjKRPb8o0CxB1n4tEpC1Y96f
	Fc59luErDv8eDJ8knbCPhoSteTmKETwPzZ04GTMfwTU9oucOmdO4UPp3rmEAnH6l0O/EpFlESC2
	jO2Ujy8UFPa1E6jw+czht+bVdkZhyGd8=
X-Gm-Gg: Acq92OFteQDP4HwDr60g4+XxYfv/Wz/X/hcEReWhGE51JYteLT4QIIdjz3cOuP+VElq
	4MJaWd+nLvdX13m15kO8uuZQN7SEF5YcHt2Z6rGP0MSIcD71m+VCr4of76VKfjr+R6lYY5ToWPn
	zM4AJRN50tjRLHmkwyW0zZLPBVThoxMAvWwQiaPH4zjacmtzUHXUATetuVG6sz/+vaNN5N6y02C
	VyNrcig5bY5AszNZ/s8oB+VeDJ85ENo4i+LfbZ7ihEryBJc1+3CAol17XU2QQSqSyJ1jRW+AJwY
	QMI05tCi3MvAs8X08hA=
X-Received: by 2002:a05:7300:2205:b0:304:13f3:e461 with SMTP id
 5a478bee46e88-308047892c8mr1778310eec.3.1781181113170; Thu, 11 Jun 2026
 05:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com> <20260606045738.21050-8-clamor95@gmail.com>
 <aihl9yIqN3adKWLr@ashevche-desk.local> <CAPVz0n2+27QVeWNgPm3PH6V2Ceuym6sbMtUrh7hSHe9PcRmfMA@mail.gmail.com>
 <aimxK3asZjebYrNt@ashevche-desk.local>
In-Reply-To: <aimxK3asZjebYrNt@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 11 Jun 2026 15:31:41 +0300
X-Gm-Features: AVVi8CfaCeDkKO_UpXhT478yTj8VjHK953EzmbL2Rc52Hp0WrpWg7gTbUSSSXw4
Message-ID: <CAPVz0n0z_6fuoxBzLcN0VdUBUWZB1c0VGsAkDW3xXnPuwZj-3w@mail.gmail.com>
Subject: Re: [PATCH v4 07/14] mfd: lm3533: Switch sysfs_create_group() to device_add_group()
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

=D1=81=D1=80, 10 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 21:4=
7 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 10, 2026 at 05:38:38PM +0300, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 2=
2:14 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > On Sat, Jun 06, 2026 at 07:57:31AM +0300, Svyatoslav Ryhel wrote:
> > > > Switch from sysfs_create_group() to device_add_group() including de=
vice
> > > > managed where appropriate.
> > >
> > > This should use .dev_groups member of struct device_driver.
> >
> > Specify pls, device_add_group literally uses dev_groups, I don't
> > understand what is wrong.
>
> dev_groups of the struct device_driver. It means that the data should be
> static and be available before driver probe is called.
>
> ...
>
> > > > +     ret =3D devm_device_add_group(&bd->dev, &lm3533_bl_attribute_=
group);
> > >
> > > This will make Greg KH very grumpy. (For the record, original code as=
 well
> > > but it already is in upstream. So, thanks for trying to address this,=
 just
> > > needs a bit more of work.)
> >
> > In the prev iteration YOU asked to me to adjust this. I have adjusted
> > and now you say that this is not appropriate. I will just drop this
> > commit altogether.
>
> Yes, and I still tell that this is the way to fix that issue.
>
> You can even do it yourself in a few clicks (hint: `git log --grep` is th=
e tool
> of the day): 93afe8ba9b01 ("ACPI: TAD: Use dev_groups in struct device_dr=
iver").
> This is an example of what I meant.
>

Oh, very nice, thanks!

> > > > +     if (ret < 0)
> > > > +             return dev_err_probe(&pdev->dev, ret,
> > > > +                                  "failed to create sysfs attribut=
es\n");
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
