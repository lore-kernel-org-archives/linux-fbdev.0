Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C72C08BD
	for <linux-fbdev@vger.kernel.org>; Fri,  3 Oct 2025 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759517055; cv=none; b=iwSxXKE5m07k45OTgMC0a8XEKFQCy8/f6MccecXPWjzDcznZ72T1lZTEFjRyFbYUQic8xXhpOxB2Xe7xeqSZdOi0bDutDMNAAAqSNBSTGI3uDYp0rkOzH2nEEkF/dyPzZbvuUlX7N/pU4zeHNef1/qYVResTIs8B7F37J8gyNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759517055; c=relaxed/simple;
	bh=xyuE14DxlDz2HfrhfyleFTggC3yW/RUkLxL0tsrQ6XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Noexfu/LHBa7I4xoYHeFdM8O37cNt9fiCaqkDmxWZ3+diJj/nRISyMii8sDYSN5D2/UIRmDDYDkivJcK2O8Th83GALpskBS+/zsmXgnuBaEP9CpZxj1oVe3viLLnepx0c11OaKH2FBz67c6Iy2rfjvlddzRndLtoZ2ElJD1Q9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbY9W+59; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbY9W+59"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57edfeaa05aso3191872e87.0
        for <linux-fbdev@vger.kernel.org>; Fri, 03 Oct 2025 11:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759517052; x=1760121852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyuE14DxlDz2HfrhfyleFTggC3yW/RUkLxL0tsrQ6XA=;
        b=RbY9W+59TNw6CKMmN5l9yFJj+avt1jloNcOz9pIWFZYQdGFhclDoQzaXoOha4UW8pH
         oEylxrQwCESCyjYV9K81+Ml+UCEVSxhe4kxHSZzaMjVub+D2VmF4uHZ17m1Pn6+ML2vQ
         b7neQi2oYaU5OZq6mgbHqlOc68yf0M5YJA1fkKxTTE6ud19Bf/If6Am4oDqAljS3jr6R
         eGABWCV9TkKZqCz8O0YoTRsFuLOhJ1io76aMOhQ/HKwUhn1GTfs1hILb2hb1M9Sh4KYS
         XMmEjvqeDbrvLQslzg7+MgYK0+q1zb5bhD8MxzxW9yt7Ga0ZV3ezDHJTzzj+H3KF+QFS
         UQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759517052; x=1760121852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyuE14DxlDz2HfrhfyleFTggC3yW/RUkLxL0tsrQ6XA=;
        b=KjuIPU9NiBoFajN4J6shTO5ZrTJhqrmO355moarXTyWmqBLrIuxJG1OX2E38zzA0Ao
         zCqA8o28+Whep1Xxraj07nKEtUqq1pelG2FVrQw68hZqocgD6/1alroe+jX9Ex3DB8eV
         3bHjx4rnt5pI8d/ZbAsMoOH0VICN5TBjl53ARlhJ+Xt5879iyOs9Ob+MlOUpJ7IamO/h
         hWxakyOcXHVdYXF4pI1gG2JOmqJh65sQJCwuCy2Mx1PSLc/uLRkVjQp7Qfv9feOO11AP
         OAaDoZ5NFtz08Tfj87Ie4cPV2VAnNbkfQknNQWLViZcDExgP6ehIkx/lZN8P4p+In3zH
         sUrg==
X-Forwarded-Encrypted: i=1; AJvYcCUDnKh7SSZv+criYLVTNSskZE5M9701Csp2/xJioFA5svFA86ytD6BjNGb74nrwNqrPNOC606/Qnc8Nmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBiEE0RRFU0EbcZvnzgepYMUn5Wgbxxv5PTnbjIgNGRCvP4KTv
	C3h9cI1Y6SzaN8ZM25wYlJgsNLk5OnXBdr1MTkbuIJ1mZ5K8HXp6is5A/Y7ho63ZwUEIL0CAT/R
	kDcWaUGdS6emUTqa8Qw2wHB3B3todSwvDZ9pfIYM=
X-Gm-Gg: ASbGnctFS595sEUQgf3zCgSrd3vqLhzlK2K+0by1xga6EFElIt+eIKQWp4W7JvDopIY
	6WXM/lMLe2O0VJZRQrzVg0vT8xVCwaYrZyh9SBWADui9GKAQ+ylknhHzI25T83brlTXT7Nkl/VX
	oiXIYml/q8EiSkNe72yM7hz7wwnUmrUU/fVVEl/khpa5nZhuaceiSVkZ0MyFxUl/I951k0G9inT
	R5ySc+TujjdBzxIf0ue00Q+Xkj6HGmVPtA2JTuKOuDe1z2wD5/dtKn1BGy7qixBz39Sp3FUGHXP
X-Google-Smtp-Source: AGHT+IFGjI23yu+zZGYIIYp5GAvADK1Td8K5f92lbt6d4punv+uO2Xi2qzgSwr+Eyr8h+dgbxKZKruLqIS6Oqk0H0Go=
X-Received: by 2002:a05:6512:1245:b0:560:9993:f154 with SMTP id
 2adb3069b0e04-58cbbdd8224mr1238522e87.35.1759517051928; Fri, 03 Oct 2025
 11:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924175743.6790-1-hsukrut3@gmail.com> <202509272320.3K8kdDCw-lkp@intel.com>
 <bb9d90ca-aa4d-4168-bdc5-543109c74493@gmail.com> <CAHCkknrZ-ieNKeg-aj3-NVqgGSk770jJpUpCvn_SuffkPu+ZrQ@mail.gmail.com>
 <edccab86-321b-4e6e-998f-3ce320ee0193@gmx.de> <41ef536d-2399-43f8-8041-c6b0e642aba2@suse.de>
In-Reply-To: <41ef536d-2399-43f8-8041-c6b0e642aba2@suse.de>
From: sukrut heroorkar <hsukrut3@gmail.com>
Date: Fri, 3 Oct 2025 20:43:59 +0200
X-Gm-Features: AS18NWCgP_BX7ybrXY0sJ6ucNdQs1TMwDO0SWiLqnHgEzd_63diU8v-qea2nPRE
Message-ID: <CAHCkknrAKGxzAYE-R3QX20W4faR9Wfjgn37peyHRJcZ6PRLENA@mail.gmail.com>
Subject: Re: [PATCH] fbdev: udlfb: make CONFIG_FB_DEVICE optional
To: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>
Cc: David Hunter <david.hunter.linux@gmail.com>, kernel test robot <lkp@intel.com>, 
	Bernie Thompson <bernie@plugable.com>, Arnd Bergmann <arnd@arndb.de>, 
	Randy Dunlap <rdunlap@infradead.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Zsolt Kajtar <soci@c64.rulez.org>, 
	Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Oct 2, 2025 at 8:52=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
>
> Hi
>
> Am 02.10.25 um 08:41 schrieb Helge Deller:
> >>>> kernel test robot noticed the following build errors:
> >>>
> >>> Did you compile and test this code before submitting this patch?
> >>
> >> Yes, I had compiled & loaded the udlfb module with no errors. Please
> >> let me know how to proceed in this case.
> >
> > Look at the reported build error, which seems to happen in dev_dbg().
> > So, maybe in your testing you did not have debugging enabled?
> > The report contains the .config file with which you can test.
>
> Can we rather make an effort to remove the udlfb driver entirely? A few
> years back, there was one user who was still using it because of some
> problems with the DRM udl driver. But I think we've addressed them. The
> discussion is at [1].
Should I send a patch series to completely remove udlfb, since [1] echoed t=
hat
DRM udl driver is good enough?
>
> [1]
> https://lore.kernel.org/dri-devel/20201130125200.10416-1-tzimmermann@suse=
.de/
>
> Best regards
> Thomas
>
> >
> > Helge
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
>
>
