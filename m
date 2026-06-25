Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB19936C9EC
	for <linux-fbdev@vger.kernel.org>; Thu, 25 Jun 2026 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378242; cv=pass; b=fQQo2giM3Fby8ry0JEALGa/ng1997J1B0p4lOgEoPhVkWXnshm0z1VRw5g/YMFbCVaamcDAX1rrmf29uUKpP08arTJ2fXv6eAsVQe/ZrgARG+Wm6Ly0hvG+M1FiVBQapwpcGZOotpK0GrdG1aT9DKVX9rMmGuCSrTRo6IziracY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378242; c=relaxed/simple;
	bh=k+JtXVe2DiLhrJFE1fbf6myOq+FczHlLlM19E6OsARE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvykQ1dwNVaJ3ZXAqtMhbQQ97XtdrOnnJ7NGYscFELvA9R/Ylz89eK8y17HAd72xFn7zotJqhSUauEmWcHY+7zWELesUgRTWpRlxOyAakvE7O1fvcRXp+cc8AE9DtbX0Hafmk/UfaaS//Lrte5GevP/U3Ae3NmnD7cUQUSMGnMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcb+pgQp; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcb+pgQp"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c8894387780so751396a12.2
        for <linux-fbdev@vger.kernel.org>; Thu, 25 Jun 2026 02:04:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782378240; cv=none;
        d=google.com; s=arc-20260327;
        b=EvyIyKJt+wTbKigc9eZzoo8aAMrmXt+tK2ZVeeNeAfroSF3fI8cVSdr1I2E9oOP4Wy
         xBRkHGZfD0SNQ5u5dupZx/NI+z2IDeE7Ej0ZsxqNaVCLfjng7KUbKCEpRG5l6lnUrZFd
         xVdINRXVtgQDYBN3YwWGJWQ7Pvp6xZyC6bSln3B885wv2klxjkVBLcUqrFccP8lfhpQt
         asjtr1iMwPf+sDe7MKxbm5p8sl97QE+l7HOEr38O6yAigJ7zjVEEJHlQ17Nx1eA48Ohj
         UI6smN70W+/70NLR8njCRm31mBsRMcD3cXW5/4tQxpAkwHv1TEOw4+wplhtPM1dhS9M6
         F1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2s2sz76O+Yw6Ynt/ts8/PPSCfN34FF1Pj3n3Rz2cL5c=;
        fh=LQ0DutyDUMGZmsIkXOpYoGGcM5oULVOvP+4y7YG9QbA=;
        b=HdGgpKHEJK6eXSYuVGkmrov8k9jIsBEGcahv+guhJKuQeEKRUIUZmZh/ZdjrJQNF8w
         gebqNttONsVDsZeb0yOKezdN8pVYKgu8/F+dZ6GFrxSFFyH7SRj0RaAl1wxt4EnY4ZyA
         bIhd7dMgVCfRl0/0e16lGAMrwl15RaS3twbjaOVm7iE0MJmCEUzM5y0k1D2OSIVMnx7Z
         9whwyUbVjTL77T4JI3WjnJAO2QzLlIp80U32HCE+gt4dhhsHGcLrBmMT1PNRcx2a2e+d
         o4vMwyoUBGLX7Kk7sPK4THERvyafiLt7hNcglxgZThKJUJtMK2sP3AtjeXRkuYeT0OJo
         qsUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782378240; x=1782983040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2s2sz76O+Yw6Ynt/ts8/PPSCfN34FF1Pj3n3Rz2cL5c=;
        b=hcb+pgQpc+oizAylITAf30AR8+h4dcAcbKn8DyGZ2wm2HGOUPt1Xy6JL0+m3dx1G5o
         YKCECXJaaCyJFBaYLmvpZXWu/QcRmMSxhzubJvlMkESdU9u++pL+GsyaLqDeoLnU35nn
         HpmsmkYjiBbwYqziHRpAh6kDo4CKiv01jhNGVr/JejT58P28ahxM5223SeuVlYkneq5C
         wP8u/sy0/3V+G4EATTT9yXMWZ1LgEZjVgsU4dNwR0bg2czxgJDcpLxtcHqPRsmkyy/VA
         4WW+qS4ASFQJqA/c5a8L9e949r+NABdioCI5rm4KdPpW0xXrtiRpnQqHgZhAMfV4K/uR
         hN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782378240; x=1782983040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2s2sz76O+Yw6Ynt/ts8/PPSCfN34FF1Pj3n3Rz2cL5c=;
        b=PjlM5T/DkFBMjbpOCeGk5Uwj8amhITgJ70lLvmWlo/sSuCyfS3nEaTRhkKsBNdsFdo
         Sv8ngcFiGcqTAJl8RyVE1er/a4aNe1NLedIpgd+UOMBhZY7G+Mb83l2/WpnB+OSv3ONi
         omVSn9mziBXOB1IfkLhFnrw/2lZRRXu0uUML5JBII9U7z75JCM0eCHF2ZQfY2goNkJg1
         ePxZQkKW8kvX6ChhtiMraW+VvOmBFATc3CKXUk1exq5OpedDBlHGUSdlgJzblpupaXET
         mpHnOLkyNXMHIpCFIb+0sWC3O3NyPK0ouz1p+A4diYr1JSFjI3cNrJzd9r4Q+U2wEhfI
         n7Vw==
X-Forwarded-Encrypted: i=1; AFNElJ9KQeV/N1KvOkah8YWZiu7Raga5LT6bhtlMQwklEbAnDDboqcrax3o2jcQ3HVGrJQLbkKQuuT8vAYF7ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSYQsSh/C74r315pLUxXwj18Aqi02osAC3HgFJFj7FVQjx4MVz
	0DzRIwjG4l1h8t54GgEqQa2YaEEd++o0i5yflOsjOf1n7ykXK+nUu8kPo9K+kotLuyyUIPl7FOX
	x2HdSEoNvQRuid+qqcfd9vv5uJA3coG0=
X-Gm-Gg: AfdE7cmGFXDZpZn4IoM78IZlL14LLNauIEfEFGUhnxiKz7bnwid8Vcr/17WhTnsgbZE
	lzAWEoshsREfk0fVSBXqXuwHwjR1wFZ+uZZ3QoBRD/q8HlCeM7/KAOjJMtY2oXL1SrMVgVAVsI/
	pKVjQlPdlkOy4zluqSnW7qE28i7wDzrHFfqLa5MkEubdsMRHZ2IjvPoGOOTfi0W5kj1O60wtZdF
	dTpu1ZG6spb1b1tAr+bQwar5yCA5u5SawA+IqQf0XTWfnDl+3/n9nvRIop9O07OP6pjY0UPBc8=
X-Received: by 2002:a05:6a21:3994:b0:3b4:8818:fd34 with SMTP id
 adf61e73a8af0-3bd4ae0fae1mr2051656637.25.1782378239883; Thu, 25 Jun 2026
 02:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625071348.132880-1-suryasaimadhu369@gmail.com> <f5be5a78-a649-447c-8145-b32a530194c2@sezginduran.net>
In-Reply-To: <f5be5a78-a649-447c-8145-b32a530194c2@sezginduran.net>
From: Sai Madhu <suryasaimadhu369@gmail.com>
Date: Thu, 25 Jun 2026 14:33:48 +0530
X-Gm-Features: AVVi8Cc53RXuWK3UWJw0EbLd9833JD4VvuGzf-QBSWTw5okmWM0R3ck_QE3pMms
Message-ID: <CAB0uMAezsY1huYMfbkknzYTfdV5bwm+c=BKP2sDydbXMKg8V+w@mail.gmail.com>
Subject: Re: [PATCH] staging: sm750fb: fix const pointer declaration
To: ahmet@sezginduran.net
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ahmet,

Thank you for the review.

I compiled the patch with CONFIG_FB_SM750 enabled and it fails
with the following errors:

sm750.c:773: error: assignment of read-only location 'g_fbmode[index]'
sm750.c:775: error: assignment of read-only location 'g_fbmode[index]'
sm750.c:884: error: assignment of read-only location 'g_fbmode[0]'
sm750.c:888: error: assignment of read-only location 'g_fbmode[1]'

The array elements are assigned at runtime in lynxfb_set_fbinfo()
and sm750fb_setup(), so making them const is incorrect.
The checkpatch warning is a false positive in this case.

I will drop this patch.

Regards,
suryasaimadhu

On Thu, 25 Jun 2026 at 12:58, Ahmet Sezgin Duran <ahmet@sezginduran.net> wrote:
>
> On 6/25/26 10:13 AM, suryasaimadhu wrote:
> > Make g_fbmode a constant pointer array by adding const qualifier
> > after the asterisk, as recommended by checkpatch.
> >
> > Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>
> > ---
> >   drivers/staging/sm750fb/sm750.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> > index 89c811e08..8f533f3b1 100644
> > --- a/drivers/staging/sm750fb/sm750.c
> > +++ b/drivers/staging/sm750fb/sm750.c
> > @@ -21,7 +21,7 @@
> >   static int g_hwcursor = 1;
> >   static int g_noaccel __ro_after_init;
> >   static int g_nomtrr __ro_after_init;
> > -static const char *g_fbmode[] = {NULL, NULL};
> > +static const char * const g_fbmode[] = {NULL, NULL};
> >   static const char *g_def_fbmode = "1024x768-32@60";
> >   static char *g_settings;
> >   static int g_dualview __ro_after_init;
>
> Did you compile this patch while sm750fb module is enabled?
>
> Regards,
> Ahmet Sezgin Duran
