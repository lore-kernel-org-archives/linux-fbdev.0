Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E273C78685;
	Tue, 18 Jun 2024 07:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718694892; cv=none; b=d5GSkQiKYWZEssYUXhYnpYdMxOtp+uKwA37EKetzDpVi5FOzI2QYvFuoF02PONOM0ecQl6Dkiwffgb8WPmGMxp0BShhDYUnhRfrA0VgVd1Liut6whwBSKJhJ8a0KzrsZBCfP9lskL4D6VMGEN20qSm0tjBqk1rgRFKG0Uq8qupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718694892; c=relaxed/simple;
	bh=MZfw96ZY4lyuDL1eut5U5Wp4+N8ISP/QZHIF+wEzR9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJrEmFGLZF3NAgPgH9SDYlEH2LvRXRpyXprbEqzPjQpw4hTRIPWDJy8So71X8WoZOXkKRRBTtzeG5GcKBHI+7sXb8B565I2LItcgDo0Z3AunFhHSg2kKNYAf2gas+09P8cJJHDY/Q86Zxh/9/eAuf8pgxG5etDidbz/SrWphsCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-63186c222eeso46963107b3.2;
        Tue, 18 Jun 2024 00:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718694888; x=1719299688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rz6LJGzD4G8AYqhBAzwk0Rq4f7QZMRwIAsp6KRs4lxo=;
        b=cZsjxAk/MCmoD59QVH1CM1NhKfZFnRDRjeUcbX79rpRM1BKr9+G1T6y2VcTShHTyY1
         0hmHnHfcumI3m+PbIBDMYJVOO1ArdLsfI3v9OL68U4Tnerbo5asLRUdNrniWf2xRkUiH
         LG1yHtiyobUdsnHPhxUCSuYMQHPnne9UmPMejZ+i/fB3hDRokGu0OEbxLKaWWQaWOTC5
         lYgkfpW9KB5j9Dr+/N7vpEumv/ps+T73+kGESq1U5w83YA4Ynk4r9zFRq2kszke6IQL4
         /TPeRfMRfmXlr78jD88jAghWuh8i9HUSQOVg/R0uyOX679IeX5jSYIZG68e9djAW29dC
         qoVA==
X-Forwarded-Encrypted: i=1; AJvYcCWFLzotiqM9WtJJMcu+xRlWcKlm9BQL1N5j7VhngBTx7oPusuRR1FOXgIkn8gD7LvQ8d50/vwBhl2q6etHRX1wxCYODqmvAn0HW5vYUt3hPcrP80pCvGbmei5iPXsBF3iMTxAd2RJdY+qkGYBC4yeC0AMWOwZrNp9O2PynBsHHstefEHiQtCSvgclo=
X-Gm-Message-State: AOJu0Yy4jnU7P13bhTFOWfjXA6cQluSCC6UuqvEjJz6YBh2aeLNZ1+YX
	UoAMJPl1J/fWSka4gatfsQI32DBC0/mgzMibixUVud21N1WU43gqjGKQFWDb
X-Google-Smtp-Source: AGHT+IH42Z5KMOvIe6Jop5M3yX/Iy3Ae4qU5+meOcku5VisPGlWheHapZoxGfs7P0pX5m9Goy3Mz5g==
X-Received: by 2002:a05:690c:84d:b0:627:7ff0:fb4e with SMTP id 00721157ae682-632231463bdmr114553337b3.26.1718694888579;
        Tue, 18 Jun 2024 00:14:48 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-631183d80b8sm17191777b3.7.2024.06.18.00.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 00:14:48 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-63186c222eeso46962937b3.2;
        Tue, 18 Jun 2024 00:14:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6g994ArvguYO67ypLL5ClyB02l/Uco6EF27bINH95jFerPnDbzz2VfqM+tRlN4o91NnTRl0EnZ8/WFT8bNRot6g2UkK91JGYij7IS5ZCuBlTHzYT4U+tOG+EJih5H79inGHeGeY02V3ZTnU3aSU4beaLzxmr3udvVXc0IecvYHNWZk+oWRmXI56U=
X-Received: by 2002:a05:690c:24d:b0:62c:efa2:a091 with SMTP id
 00721157ae682-63222a58bc1mr110730687b3.14.1718694888087; Tue, 18 Jun 2024
 00:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-md-m68k-drivers-video-fbdev-amifb-v1-1-85f74746ecd4@quicinc.com>
In-Reply-To: <20240617-md-m68k-drivers-video-fbdev-amifb-v1-1-85f74746ecd4@quicinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Jun 2024 09:14:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX6G6sXpJmtHXCZobuOstvn4Kw-90mpky-ZXPcoe_ezUQ@mail.gmail.com>
Message-ID: <CAMuHMdX6G6sXpJmtHXCZobuOstvn4Kw-90mpky-ZXPcoe_ezUQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev: amifb: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 5:14=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
> With ARCH=3Dm68k, make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/ami=
fb.o
>
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
