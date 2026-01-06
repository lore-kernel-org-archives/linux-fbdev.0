Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C986D1C3BF7
	for <linux-fbdev@vger.kernel.org>; Tue,  6 Jan 2026 00:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660167; cv=none; b=bxKlLTX0iwrXJ9om0rcyB8vUSFAzMGqn+H75Vsvv47DVdSqX95WMMaU+9In8UfI2FgKbCBMVkr1CrHcGHvncpjmnvNWmA0vXhPgwKzgq9AUxgE9RkCwZDq4ciJIso1Z1s6DPGiz3XmqZcuixkw7KtGFfTZ9B92UQ8ybhcGyQgCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660167; c=relaxed/simple;
	bh=QrzGH0rfY1PbzfL/LCC45gDfqDTjAUZLlnoS+Yp6OBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuwXjXcoKlznqItj0dB6x3ZsSEjX9TnBy66xRL8M/yb3f7A5vxu9ezAl5C6DNVb838US5W/8bt5k1U+YNcWPgZjbP/sAYoXR85zhDRGzLHfSi4Qtlkddx+H1uCIK1nWySp/hfCa9HHc339lefTOWKmqdIq4g6427gX4Y5USX8nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTdkwW/I; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTdkwW/I"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6446c1a7a1cso432069d50.3
        for <linux-fbdev@vger.kernel.org>; Mon, 05 Jan 2026 16:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767660165; x=1768264965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrzGH0rfY1PbzfL/LCC45gDfqDTjAUZLlnoS+Yp6OBQ=;
        b=BTdkwW/I2u7cm7pXbmYIvTej7ndiWtMiNH7X0YlogzXpeLhoTHo9EHZuz5vxxfUfii
         k6igB0AZg5Chyik4uB0XG+GjTnlgH/FmH2bwpFMnnn8v9cEyhgTpbXAfAn26MbokdiQp
         ODdv3b59tybZtISQg+MvM1pu2B50Ok2ojdU+VLd1spdDvCqMUWLc7VgptniNAcTuw7n6
         G/qCbv7beON/saFCc/fLOHrHhxOS7oTdR+xIJw8pXUjj9RAOzminvJgm3J4EBAdPiZcs
         1oLi5Yzq+cxzVGE7ErvQjWarlMlyqb278qaMOcO4qnNSAOUROFw9bRtulaRG3wbEdXD0
         mr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767660165; x=1768264965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QrzGH0rfY1PbzfL/LCC45gDfqDTjAUZLlnoS+Yp6OBQ=;
        b=nps2wkYc9NGvRhgScm4pPl9VqBACcgpseTeqoTsHFwTVDu8jJsCrtlp5fjnAuzh5YR
         RxKAGvnyerbn9wJLwlJA7Kvv8w8qVNwdDyp2Q12shpuSwKq75ezyx13wW49+FFDmTlWZ
         Gctnb3Hd1GJxEUbmzpB9YZkC/vzUhG6etErl70Sr9TgXz2aB8HLptj0IZLZtNMpKp7XR
         PSDa2y6SS8MOfx7bifRmov9cDFxd3PCzc2kTmCOowhYsgMjRiEz9XzPuh8r8qjYB0o/P
         /dx9W1CgZLtw4DtYt9mWBjDjCe+vKsCWGLkLtjJhVPJsb0hwGFv0c2aBcmE9H3LmgkY5
         rKRA==
X-Forwarded-Encrypted: i=1; AJvYcCXWUzs48aZoDCz3wY4BLDeSMXZkSRxwEejyHqwXXq0GuMpy2BpYx5+Ayl6hIbB8u0pPTNpc+9nYtz22Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzstolX7C99msHkRW2EzT/SMj2kbxShYuuiIdwqzHqxv50hj3hU
	XmskUbKjP/m/RguY/OtVUzFwk62M/e1D66G/VUDAD09LEOMG882KZEGSVvYp1xVHMeMIUJHIxQS
	gAlK6zG10iTNgfN4Wzr5bprWEFYMN4FQ=
X-Gm-Gg: AY/fxX4VVkwi+fVtYDScdvPiGeOwGEtDeGSwdG3KNigajS7hvhffHPNM5n6L5Zf8Akw
	2/Rne5ZDYhr3Rpl3+AN47+OIOuMh3+Ovu4V8m6YvhaDUPItgaQrrbJeonGKW7onR9hlcQ9DCxcp
	ktRNV4PhdO5De6BmHbqcB2hfRwS2930dnOFeoyV/x/uJq5zHeuaLvpC4FgSpc3+BZdpoE3dN0fg
	IM7AE/MHo5Z4H9044oLp/lEbAbnh5xu14RZZJnbtlKr5ALBxKuNYrMcE2jfh2nkP+6ziorFJVp6
	QlQsFa7a
X-Google-Smtp-Source: AGHT+IHL3mPJHriDypHyBEX+RJjLxwusS7faLWaHDC2qzlYJncxpcgVjuftmU+FyBZTns1j64beDONSID2hEF9V6+GA=
X-Received: by 2002:a05:690e:4144:b0:646:68b4:a7e with SMTP id
 956f58d0204a3-6470c83e595mr1080386d50.18.1767660164612; Mon, 05 Jan 2026
 16:42:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104110638.532615-1-sun.jian.kdev@gmail.com>
 <20260104110638.532615-2-sun.jian.kdev@gmail.com> <aVvmr2qOrFvoEKGV@smile.fi.intel.com>
 <CABFUUZFeO51MW5n1uDp0tcwJeJvgxDRxY3rDqkj2Z-6cO23TwA@mail.gmail.com> <aVv_w643SMuIELDE@smile.fi.intel.com>
In-Reply-To: <aVv_w643SMuIELDE@smile.fi.intel.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 6 Jan 2026 08:42:30 +0800
X-Gm-Features: AQt7F2oAGQEcEWE-V0GUrqr8ClkpEqurhwv9xHbSb0ypc4-wA_p502-iDKi-NtM
Message-ID: <CABFUUZH0pxar-tTK6LA3j9x_eokLK=FW0B6Uej33s=2YsgOcgA@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] staging: fbtft: core: avoid large stack usage in
 DT init parsing
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 2:15=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Jan 06, 2026 at 01:00:33AM +0800, sun jian wrote:
>
> > Thanks for the feedback.
>
> You're welcome, but please, do not top-post!
Sorry about that - I'll use inline replies.
>

> How can you test without hardware at hand?
>
>
> I already explained in the response to the cover letter. Please, read it.
>
Given that=EF=BC=8C I will drop all the changes.

Thanks,
Sun Jian
