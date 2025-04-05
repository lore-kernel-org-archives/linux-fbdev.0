Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1865E79F5;
	Sat,  5 Apr 2025 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743862584; cv=none; b=rVM5GRlUsa6MPLOGH8jmRsWlBpT4zPv/KmdYUhulol6y/xjNGfns8n6qF2fHp0qbfR1O2LWmy+uxlL5mmMbYdvd+IGw1nuBXLi18Hj8Bf6O20+bExL4VFZi8Ki1S+B8pKLRiCvfZ2yAR2zFjWCjUyFZeVtU+hHFKpvJCStja2Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743862584; c=relaxed/simple;
	bh=N8VFWuNLt0EzUPBfuJZdNKc5rTQ+suxpRg4mT0cMgpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnfCzS7DAhAJsWNi7+pFx7S0fUSe12U1iOLl1R/bBu8Sq1yEclTdeDDxA/dOFP6SAQ/fJIYUxzq8mA9XFeOjq2FMt+P/rWMu5rJ3GaW25t8oaAQQaCj4EP8GyZmtusq4PvHEJsJLN64IPlNP0B+ekWRwqAFWFCVi1ObqriijWDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=araJY2Dm; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="araJY2Dm"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-524125f6cadso2870078e0c.2;
        Sat, 05 Apr 2025 07:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743862582; x=1744467382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XP90vPE7np1SiE0r2dwd1h544jc8ixLSRTP2M+wVC9g=;
        b=araJY2DmY+7zE9cwuHA2tJM8aUTblPZ9L+jkMlreLW0hfXgMc/PJKhWix+u3h5cs4E
         tyjCFpETUzpNwqPuUDIHG+OtJfymyG4WtKcd4dcwOZxIrvgATDGcMyNborNRPkJl5hhc
         HIneGLZfheRdj9UQ8qTHvbz7wEYS2U6QiFZa1hCBBiwIOFD7I1j4wbnJAWRYlWMCLP3/
         erPih4xfFQ48b7u+tIzWwXnDTpWv8nzhLrfpxUbxuMbnqPAmhnQGIy6djdHCfo4U86s6
         6BEqlL24qatihYxtonBHIqCYEHhG2qhu5M7Q8jzsk1q/8DpEKG8s6L2F+m9AfKkj1lC1
         FfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743862582; x=1744467382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XP90vPE7np1SiE0r2dwd1h544jc8ixLSRTP2M+wVC9g=;
        b=s8YcPVd4b/jYMeDPdgyupEdM4yWcvcUkvIayV1+73ZJgeKsvh0dip7jfibKOR5z0Tf
         tLXrc2M1Z3dwDeMF+eyRfmJJL4Ze1EEx+hEBbQqXDjFdGM1EpwqN2YTP2coXbjL4oBhW
         BhyASAyFSwKIOWehtcYhxjLh8afrhSkbpR2OvzD62H7Wo18YJn4ZTBnXz75kG+abNZYM
         UYt7nv0QhYYSLNr9UTWF1Bjg/JdOSUux7QCh3AtUqgD38C84kLTrZjeVrviaybVRbWLC
         IK28R6oSqf1UhinSmcdB6FHYvtqpVqUj3N8iAJRgUwhKrBQNEYCdRg6xBOSDUdOA3BBX
         aYOw==
X-Forwarded-Encrypted: i=1; AJvYcCU6BSkHu/A5dNjB33tv6T26NEpJuiNaEvm97DmeNc6pWVxOv6iIkujz3q4vpjDH4oXK+WeGDuPwJ/kNGu1/@vger.kernel.org, AJvYcCXnyjnbanTdcZoIzP5yva/cEu+oPBvQQFlUzKKNWqs33QbPyDYaK4YU/ZWoMpSVx+w+0o3pjQ22MNYy4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yylh99BbYVoMyROQs1Rv6GN0jD7cJdjNKUCvzbKZ+3SxH5D3Ybd
	70noMxlFmGWIb0kJ5fp4rHxH06q0cLCR36ozJOQki75LTmz7Fop74okuiaJXvWdWG/kSwRQ7vRr
	pZO1kRKtn4WbLSer7IhVhxWti6kFGR26Sjdw=
X-Gm-Gg: ASbGnctLY8f+0KyxwhvGyrxXNSEfYpydnHyJUX10H1LrVYHhZQex7X3UVruHYHXI9V2
	J3RTR5RR/mIZqH/+r+eN5WiaSHrVnHCURg7QvgzU4IJw7OIS03vxv5yY1gdEAuewIJupDd6B3fQ
	UJ8d7F/43aGelAwF8NW98krcdQGLV1lK3K+1dBZvc=
X-Google-Smtp-Source: AGHT+IE7iQqA1fokLwrOvDbzoLIHYYX9oCNCNZxIIYZxSE2JfS3gUtlLIRy2TZF9FMty0xha0eHu8o9Hk40X6S1rSMI=
X-Received: by 2002:a05:6122:2a0f:b0:520:60c2:3f3 with SMTP id
 71dfb90a1353d-52765c34756mr5188927e0c.4.1743862581842; Sat, 05 Apr 2025
 07:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743857160.git.princerichard17a@gmail.com>
 <2025040538-breeze-espionage-dc6e@gregkh> <CAMyr_bL4Qo_eeVSHhy-_z9_PwcQAvD6N4jfqBb+rtN-Lj+YdmA@mail.gmail.com>
In-Reply-To: <CAMyr_bL4Qo_eeVSHhy-_z9_PwcQAvD6N4jfqBb+rtN-Lj+YdmA@mail.gmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Sat, 5 Apr 2025 15:16:13 +0100
X-Gm-Features: ATxdqUHzzqrCgUrOAQpmBEZ9dYl4sXGFnMfLDkfxfZaxngKtNc6FpmaqtjF-g8s
Message-ID: <CADYq+fY-twT=NruAmfb6EpmYJLM971aTu-CUi-We_Fd6JSP47Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] staging: sm750fb: change function naming style
To: Richard Akintola <princerichard17a@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, outreachy@lists.linux.dev, 
	sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 5, 2025 at 3:07=E2=80=AFPM Richard Akintola
<princerichard17a@gmail.com> wrote:
>
> On Sat, Apr 5, 2025 at 2:37=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> > - This looks like a new version of a previously submitted patch, but yo=
u
> >   did not list below the --- line any changes from the previous version=
.
>
> Please, how do I resolve this issue?
>
> Richard Akintola

Hello Richard

THis is the main message from the bot

This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

It basically means that if you made a change to a patch, you will have
a new version.
You will have to indicate the patch version and also what changed

So lets say you have a first Patch then after review, or you edited
the commit message
or made a change in the code or something,
you will now have a new patch which you will call v2.

you will use git format-patch -o /tmp/ --subject-prefix=3D"PATCH v2" <commi=
t-ID>

then when you want to send with mutt, immediately after the signed-off
by line there are three dashes (---),
You will then write what changes under these three dashes in the format

signedoff-by: Richard
---
Changes in v1:
   - This is what changed in v1.

I hope this helps

Adekunle.
