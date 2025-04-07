Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA243224883;
	Mon,  7 Apr 2025 06:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744007017; cv=none; b=C9Wn4PcvDWMY0Cn/VBjMMh9CtheLH8IvhIoVoI/aB5g8LeuyjsQu1Q0IDy9IUm9gS08UyFOBXc9xEvH7bmQAa6mW7sTwWnVUtGLdp2wNeQjgGSSWIxABJeU/Y37vefBkQJ6L4mnwigmp2VOceiPflwUeA/tkMV3+7SkNRGGawNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744007017; c=relaxed/simple;
	bh=TyYBkwgsXtht/1q0+sgnW3QamkOkK6zr816aZPw6WXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgGPGfGhJa5cxDTc7P4rzzvOI2xb3SSZBhCgQl+iYjTySQcS6yYqURUqZYHY0ULL3trNbUITtzt43UGO6KxYfMuQrpmGPKApOLGbqJdH+vc7pUroL5cixdPEZ9QjdFJm/Rw3GijmAgctNBiHVouLpQuYi2U+uA+m7EZDUTQsF64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYY88FCP; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYY88FCP"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e60cfef9cfso6455826a12.2;
        Sun, 06 Apr 2025 23:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744007014; x=1744611814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyYBkwgsXtht/1q0+sgnW3QamkOkK6zr816aZPw6WXk=;
        b=OYY88FCPky+0jWgiQkFjwcm2fV4ozWo2iSGGILCU5jEFYUpTmLZc1Gtwi2Cz2+pfOB
         WJGW8UgewE+hbSdSNri7GQXBT7W1kiv1vXO1lFk3PGurP5wqUHrGWKZzfEkucnWp7xIK
         3wZhY0QStEvTSvx1613FLZ4Atxxw/JmPMTCrRQ4+5pjBSG+YMHG65UawQPvQClcYT/OC
         +JGvugCM9KiV/IFV7Bddzepv6OKm6FEwCQHd3VyFD2xce8lkCnLDCaErpWhYg1u8VEpT
         kKhOw7OWzJGbLPB4F22FUPwi7KbPkaAfd9Tp9+QK2kOwJ7Sz6Kyztu2qHHK25QFhO2dm
         iFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744007014; x=1744611814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyYBkwgsXtht/1q0+sgnW3QamkOkK6zr816aZPw6WXk=;
        b=Wv1b+ivVjlTq7M/gkOJjfvPNk0QraK13sz2QdPP+7AN3Yy6KNSzfYQG5RMJAk/D3ro
         TmBGcaGVkfPHcZJRtOT8Gd8tpUsrqmhu7Wk40c/K+A2TGFiuzLKSygWJHaFGsihGkgTS
         CepRwDLXrl77S7sbMXtrfCA53guN2nGgADD3NHRUwIHn2gowv6W9+4iiyy0LVUxOSUvq
         DlzJcTH5fFrrOXcmjOv004ZpMH0bOCXO4TIW7KYKg9YZjATgsWEMmgFgDGd5+YtnRKgy
         1a6PaX5w/ldlSGQG92IZHtmxuajhsRP4ztXHFlfSVHFLEQ0BZ4AAKBZU95ODiWMVlAqd
         A4bw==
X-Forwarded-Encrypted: i=1; AJvYcCUdlUkSq7eirgPCXDprW09LeUesAVZDKsLU3BbXYs0ZQNcxg5qWeMo58Zqo1KQDSlw49AmTlMNOs2o/FKzP@vger.kernel.org, AJvYcCXTmjz9Yfwi38EXSb3TDd6PEWiYGzKe/etpqC4RfRL3eOuv1Xxuj2Huxa1sVx7IhoAonRKXtszvuHdlZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTzBP6ngQKEh4k43BAfM35MH1Wg+l55ZCsh0r0jz+sU3Lvncn
	1mKdCT/0AmrK5tu57VlSssweSiSfQQxD9h0/q4hso0DE1vn9DaQB9x1gcyHoLYp56NhYOC4bIxH
	t24+b0lbXwcJ3m16EWVe+ZuouVBE=
X-Gm-Gg: ASbGnctHKg1ctkonN56lJuusbzUx8xRVNtoJ4y0nMxoB9lA1tYqqtHnItxFhgp1tGD3
	piCZwj+BfaGoCR5PfDaRmAHHThfU9iUYw2cfrnWVdYb3a3TwMEuzHu6wPN8E87+kOY4WP9O6o1o
	mZO80UVUeDr3IwTCynomLOvokW
X-Google-Smtp-Source: AGHT+IGqalXkH8jwQneb6G+HA2MFJkBI8UgaY+XXpORTBearNKmKeH+qC8U0We4DWz3sqDep+zKwZSn0M0zPtKBWZrc=
X-Received: by 2002:a05:6402:27cf:b0:5e6:4ee9:f043 with SMTP id
 4fb4d7f45d1cf-5f0db88a0a6mr5612161a12.26.1744007013996; Sun, 06 Apr 2025
 23:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743857160.git.princerichard17a@gmail.com>
 <2025040538-breeze-espionage-dc6e@gregkh> <CAMyr_bL4Qo_eeVSHhy-_z9_PwcQAvD6N4jfqBb+rtN-Lj+YdmA@mail.gmail.com>
 <CADYq+fY-twT=NruAmfb6EpmYJLM971aTu-CUi-We_Fd6JSP47Q@mail.gmail.com>
 <CAMyr_bLkvFBTpYehG4fs-tqVE18YBf53okddU2=i7+Rr-zbCsw@mail.gmail.com> <2025040711-refutable-monetary-f0c4@gregkh>
In-Reply-To: <2025040711-refutable-monetary-f0c4@gregkh>
From: Richard Akintola <princerichard17a@gmail.com>
Date: Mon, 7 Apr 2025 07:23:21 +0100
X-Gm-Features: ATxdqUG9UKRPAVgDWlaipT9LjzuBKxae31dI3bYorVW2m8bsiBkNNZsH_tYfNvI
Message-ID: <CAMyr_bJuX1vYxBhE2FvpTvjPy9jovqOmapUr-WFpO8r=5uJvAQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] staging: sm750fb: change function naming style
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Samuel Abraham <abrahamadekunle50@gmail.com>, outreachy@lists.linux.dev, 
	sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 7:01=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:

> Yes.
>
> Think about it from our side, what would you want to see if you had to
> review hundreds of different patches a day?

Thank you for the clarification Greg K-H, the change in perspective made
it clear, would send them in as soon as I get hold of my PC.

Richard Akintola
