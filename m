Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBE8266B55;
	Fri,  2 May 2025 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746171436; cv=none; b=RsX1l9GexHtuvAa/qcyz2s+Hu8YlNITDu9yt+BJa2fjluaPAC8UcPrl38uIWbMvWAXCfUKztL4UJD1NwOzih+VrHlol73jQo82jjYbGwN0Bzxd0Iqp2r4sm9suAF8EjV7AI7Tk8ziwSGlPmxezbQX6cmkMXA7k/Uwn03+gY9xLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746171436; c=relaxed/simple;
	bh=v201QsXuMk2tktiCCnexqwrucy1bAT1qtrUCkc84WXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpjZ40kTY5LeyPoLZwTICr898yG+gF+h2km6aDQH0bcbwgzGf5k6S6sgrram2LTO3vl5N/BNAflDNEFNevWapmz0U+XpKPr3i+4Z7D5lXhEzirjJ9MozxONnXflBIJOAPX96QOwiIPZd3irWWk764A6lWA3rH0LMaYYMqEQDE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-524038ba657so1323785e0c.0;
        Fri, 02 May 2025 00:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746171432; x=1746776232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8llC9jHROc+tcTrdFCCLdaEjIsrrc+65EGVehejnUu0=;
        b=IsDj9/6rkDxIrFtPJJ6oOaj6isa0vPuxx1RUZ5j/NPQM6B3Nb90yC/KzZsLP+Zmvq3
         dZ2WCxWeenzvEJFV+7Tn4TQoPC/x+RRyfLWU9sAyVL2UojkJ4EAwbM7GLEcEH8lJNeY8
         2CpTkjBGhxVoKQzlvbcL4UzXCxCMGqAo84hFVvEougVTJdm4SCx+e2D+2Euq4HlbCIrg
         WruJDN5Z+aKgzC5SCgsDlcsPZBdbKi/AE2WfHqvWafYsnPurQh9RgofFoqRU792umJvc
         NmnKLBcmTrfvryfaoBN4x92GRmsVGUzR2gc4HbNcR4XftKcqFcQt9Gy4n0oRED0wTXi5
         ajeg==
X-Forwarded-Encrypted: i=1; AJvYcCU+bgUAOsNEqUWNMxEYwygAT6Wr2Y9wgVWTSk4LjYzKw4C5yzMYZZIuD/sma1atu0GW742oGPNo9rPl2C1h@vger.kernel.org, AJvYcCWvEyz7SO/B39JMZOJb/kTnoe0bpLJ0F+wa/C98OWGNi49vaMsLcVC7wjJ+2w64/3KR2saxz8n8jAzBHQ==@vger.kernel.org, AJvYcCWwJVMOCmyb60+aPhfijDck4EKW5qcRNm0wTJvUBgRE7NAm5qG0U26+NVLIw8DxaOf0mKjua4Y5fS3X4TdwiKLu@vger.kernel.org
X-Gm-Message-State: AOJu0YwPdNRqOk1eu6y0f3zBA9JDzWgDoRbMmmOVtbgjJtSE7CU8/NXw
	Z+ugpprBTM8l+4F5qhuDoyafnbDre0uvsVvpSooK6TXHON98l8QFvBIWRD0f
X-Gm-Gg: ASbGnct8tkwzSQRRLcVTgh1U57qGln966++rStdbIJP0hY29DB7/fX6KN5KFSW8JpeW
	Fa8TUasa/U8D7v14LVYpnopufhaiEmn5BuKtim7H8AnKiYD0i0GYYGHbG87w4qnG5sJbF0XytV6
	Ki+KtIGO7KHQq0P94r8dIkd4NxsG7zi+FmbMl+ZAoKS/IgF8zhRa/90DUP58St5NrgFF/wbmpFH
	YuILTfXZs8bL/WHQy1vU2OlANojwtOBjGXr9CWc1//YaGlE1GA2z+vVQYQImylwAlnoNKoCaOsx
	IcRjWy/kJgxyylThxCvT04sPKAYBOuERK75+KEjuaoMtmCxHeUgRMPer0lJOUKtt+wqEzDjhbDM
	zV28=
X-Google-Smtp-Source: AGHT+IEoE+W16s0SJ2xbxlja3yhtvcX8FAOTA8FL5KkN1dZTpqZBS4bWzy4M4XbQOAKwlm5GGNwBqw==
X-Received: by 2002:a05:6122:1ac9:b0:527:b7a3:dda8 with SMTP id 71dfb90a1353d-52aecb0c9c2mr1211049e0c.7.1746171431702;
        Fri, 02 May 2025 00:37:11 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52ae419c84fsm437257e0c.36.2025.05.02.00.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 00:37:10 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4c32190386eso2016838137.1;
        Fri, 02 May 2025 00:37:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU342xxQt3FrQXXy+seiNh5I/OQbEGT+aJ8R5HNHyfBd6qr7KgY+FWZo/tGqrhXwtQC4W8VnvcxovTJqgsT@vger.kernel.org, AJvYcCXNNVXkZGb6GuoOIzLGZcEWIyOMcu0Y0S8A+2qu+5d6vOruS9G/0KsP28xVhS+mvsLYFE7ixcobzdU5/w==@vger.kernel.org, AJvYcCXwkZk3SjWyi/1xHaUjPuiN3Td1PEApCFxVoMVsXLEcw12MoTBgmGXHLHVQIOP2OTWYlStrsOL1TV44Is2Vib/F@vger.kernel.org
X-Received: by 2002:a05:6102:5123:b0:4c1:8ded:2d66 with SMTP id
 ada2fe7eead31-4dae8bbcf5fmr3872454137.12.1746171430220; Fri, 02 May 2025
 00:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426062305.work.819-kees@kernel.org> <b982d4f1-6ed8-490b-8d47-6dc5231913e7@gmx.de>
 <CAMuHMdVY1_gEqULGD0BzdTd05OAkodhk+RXKRAy-T-0+RJt7yQ@mail.gmail.com> <e68c6218-6055-45a6-b96e-9c8381a4b409@gmx.de>
In-Reply-To: <e68c6218-6055-45a6-b96e-9c8381a4b409@gmx.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 2 May 2025 09:36:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXWCPcjqqxJ2JxQBeTSnQaAUFL0DqnJ7X8kEYko2L935A@mail.gmail.com>
X-Gm-Features: ATxdqUGW6RuInIXJPMsgitscW_CZTwRS749shCj0tpcRFKiOrjcAgwc2y1eUuZY
Message-ID: <CAMuHMdXWCPcjqqxJ2JxQBeTSnQaAUFL0DqnJ7X8kEYko2L935A@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: arkfb: Cast ics5342_init() allocation type
To: Helge Deller <deller@gmx.de>
Cc: Kees Cook <kees@kernel.org>, Javier Martinez Canillas <javierm@redhat.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Zheyu Ma <zheyuma97@gmail.com>, 
	Samuel Thibault <samuel.thibault@ens-lyon.org>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Helge,

On Tue, 29 Apr 2025 at 22:17, Helge Deller <deller@gmx.de> wrote:
> On 4/28/25 08:36, Geert Uytterhoeven wrote:
> > On Sat, 26 Apr 2025 at 13:33, Helge Deller <deller@gmx.de> wrote:
> >> On 4/26/25 08:23, Kees Cook wrote:
> >>> In preparation for making the kmalloc family of allocators type aware,
> >>> we need to make sure that the returned type from the allocation matches
> >>> the type of the variable being assigned. (Before, the allocator would
> >>> always return "void *", which can be implicitly cast to any pointer type.)
> >>>
> >>> The assigned type is "struct dac_info *" but the returned type will be
> >>> "struct ics5342_info *", which has a larger allocation size. This is
> >>> by design, as struct ics5342_info contains struct dac_info as its first
> >>> member. Cast the allocation type to match the assignment.
> >>>
> >>> Signed-off-by: Kees Cook <kees@kernel.org>
> >
> > Thanks for your patch, which is now commit 8d2f0f5bbac87b9d ("fbdev:
> > arkfb: Cast ics5342_init() allocation type") in fbdev/for-next.
> >
> >> I applied your patch, but wouldn't this untested patch be cleaner and fulfill the
> >> same purpose to match a kzalloc return type?
> >>
> >> diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
> >> index 7d131e3d159a..a57c8a992e11 100644
> >> --- a/drivers/video/fbdev/arkfb.c
> >> +++ b/drivers/video/fbdev/arkfb.c
> >> @@ -431,7 +431,8 @@ static struct dac_ops ics5342_ops = {
> >>
> >>    static struct dac_info * ics5342_init(dac_read_regs_t drr, dac_write_regs_t dwr, void *data)
> >>    {
> >> -       struct dac_info *info = (struct dac_info *)kzalloc(sizeof(struct ics5342_info), GFP_KERNEL);
> >> +       struct ics5342_info *ics_info = kzalloc(sizeof(struct ics5342_info), GFP_KERNEL);
> >
> > sizeof(*ics_info)?
> >
> >> +       struct dac_info *info = &ics_info->dac;
> >
> > Exactly my thought when I noticed this commit.  Adding casts makes
> > it harder to notice any future discrepancies.
>
> I've changed it accordingly.

Thanks, but the one-line summary no longer matches what the commit
is doing...

Commit f1a78a7d7827357c ("fbdev: arkfb: Cast ics5342_init() allocation
type") in fbdev/for-next.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
