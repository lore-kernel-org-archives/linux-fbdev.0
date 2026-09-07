Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA11B46A5FB
	for <linux-fbdev@vger.kernel.org>; Mon,  7 Sep 2026 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779712; cv=pass; b=kj9FWMQGuCOM9oPyRYBgNPVWpY8LheLg6XqfxwJPCIaruMakzWH/NOBqcqoaYui1zWZYVhkqqAPUgh1KZGjUicVFGqR0uH3qNlM8I9rTk7u1cww2ceHPJv/5R2iIOYo+pgazdjHr2wFKSzE9Om0Nive39a2+fhi1aORCC37W3B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779712; c=relaxed/simple;
	bh=x3cH/EsPBwllf1KwSgSz5xGCaH/IS+9eiLnkhBU1LnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wh2n9PrL5/qOn/vPiVfJt5sLEV6OPO85RU9pVVwAn53/jqyRtRQv/OWHvJ7Y6rV8RS91DU2UIFIhI6JnJmkxBIXAcB0pjaErXibyP8P2E2PinlQq6I/LL6oYspA8to/mftWJRuXX1mCXcnSy0SuiCn1kgN/jGdgsUPuZX3POKhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZBG8cd9; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZBG8cd9"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab1ba47so31520d50.0
        for <linux-fbdev@vger.kernel.org>; Mon, 07 Sep 2026 04:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788779708; cv=none;
        d=google.com; s=arc-20260327;
        b=ESjxGG9XGwkhbCapzBVc51oGsk25RI5xVdfx1S01OHuufeOItZ1OB5QIhjbIl6wiy3
         wU3GpGwmWAumOxRLi1onAyNIcVg1vpCawe2axBE9UwcqOtLvYdeqbfH22R4S7gDmw2se
         1P5QiBWQ6TZuWq7/HIsusx35VM+XIL4XRcydJxHPMQAA/JTi+PIs1VBinFnEDFkhOP4Y
         UUS2ctIV6fYAwfew1wSr521vNWHG/H6Hbdl3EybKZOmALYX7fPMEvnvS1+JwhYi3fcK5
         0F6QQAOo8iSu5sF26mzmUxUXFy0v7U1wH1hKfAL5FoncSFDwnoWupG9rAUAZTGC2yAaD
         zYaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vlJQsDKMlYIU6leKSgzhne93Y2lNrrKfMYXmCpI2T70=;
        fh=po9Go5RKlfLgD4iVypjwqTDefjehzbw5yZSQD5ktOFk=;
        b=ZDV6+pF/lWdizD6AGy9pyi2vRSCurx6R+5HP0zJyJMfVfvfJwT7ryt2Oocwc+dHmK+
         xrhROkCPFsFNPeD2sJ2QpnuAMlSe43p9uoHSEy0ONgJNPktoimgYGa7PfznTobVrTmex
         ZaAu7xXquDNQGUf8wnZB4LcjsMxWC0Arq6Vn5YO+sTTlmgVerin3YEDudnUlBi4jOrvr
         Jhg2cdtLf4YFNbWEVFNIpC0Fv5SLfdbXW8BVH5VEg5VJdl0ALdm5dcGFTLARz/jfr1i3
         sgMeQ586Iciyr+PUEnDm9ZWRglma58KFFIRsyYx7yrXc56c17ckj02yNLDizWWcsQvPO
         3Wlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788779708; x=1789384508; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vlJQsDKMlYIU6leKSgzhne93Y2lNrrKfMYXmCpI2T70=;
        b=UZBG8cd9Sy4Xf3RJfgvTikjDD4FfqWO4IkcHGTdfqFdlMEtILCssyV5iZFjKWiMTBI
         MrZh7IugzJ2FKVh8FnQcfHU+rp3QzWsReDxLfL6/STbMj1EO2U/zxXU96qY5ksgHDBQa
         fP+4RcghzoJx987qx/Xfaixu67oOPxcuSTit969oj5thHLHJV8Zf91EYaaPK9XhTRbfN
         8rzbnn+8n8YIkaoVPWsooPS9v64h0ghW28U16I8YUyZ21kinVfnCq6jQNwHEXFI4O+Ep
         J0914yuNv8Wc9iM3ymS2HJLwvuFHNw2N8ydsQxlU65IuzTkJZIW1mc5GzY212hkcBk/l
         qdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788779708; x=1789384508;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vlJQsDKMlYIU6leKSgzhne93Y2lNrrKfMYXmCpI2T70=;
        b=pdY4Sa/aFTkDlmOnCR8OM996W0nx7Nz+VJ+cZc9Z4Loc+X8+72EIJlzCDOEAEg6JVD
         MkylP+E8xWwJmKmkGtHHKtYuSmMJw3MHo+XhhSURgDyKmSuAELBbsoVTxBWRyn4Iy7gV
         e1kui69tCjh3u3ZVdtZJQWKwfxg+ZF8Nde8hSRqL5O3WNDGsW86zkfCVx02pocJS+QEq
         ajoEVxgHLVJWGrVcBkZmxq7ISA1y8oOKe9JipAeqSnSA3Gx3Bl1xHIzRpVgO/budssq/
         TQNR94Oi3wUBFeF7W8ML6fBenA26D3o2/22e53Qqv8FqI7qj0aGlWgtvxqbkWX5P1dlh
         /KkA==
X-Forwarded-Encrypted: i=1; AKwUvBz0dvGh2PKoLvPH96UE/waDB01nEEOT/D+m3+1PQpqSs89vFImCI1JssGMNtn1LytcrZHJ5bm75wZz/pA==@vger.kernel.org
X-Gm-Message-State: AFuF++lHtt06SznPpVmhgmNwJwlfcEMWJ6wf9Jq8OiP7CmHjopAg/EBd
	pOsk7J1+41+d/UlS/0CKmg5V6pO84Ow0XFu7FfURRp+r/w+mfkeF4oqNUg/qJrnzNywOfyG5GNE
	0K8dB7Ix3QDkfG5uu+Gr6uyV2o3zeAyY=
X-Gm-Gg: AYBFou1/+oeIsh+vQeeBgGpvfX6IcakFPO3Y7Q8I4U7m4BlS8/SAYdJ4BpYEw6+dH2c
	QuBSG70MLPSKLhBjqYuteYLbCItNhxbKOYRKcoikTsoCqIexiE18rNylOdxzDu//KzcBTTffeZE
	KMua4nrpz2qsUj7cmbEAsOOGmXVhGZHkd7cPzxa9XUM2vIRXi3cE3ZoU74xOO3vI2fEMpIb1LFd
	7pIu3ESV/St0kV6GkRfR+zeMgPNH7s/+j15EWSPu178xtiLDyCxVCz01aeCO7CZLY8D3hohNb0n
	oVC2qt3E9pO30wYO6mIhv6GK0Uk9je0JPaGLeAUfVKgmCxusYJgidNKSAGFkojTtmtxle351VnQ
	vEJMT5J5XVI+1pr9PyVTNbOAWpdvlwycXu2t6FaR1LrB1PagjMcsMA7Q235LKKyFuPrHcfJsD+b
	CrnuK3xKfTn5mYU2IDpJYDFOnwKaoCYn3pCtg/EfOBYPk=
X-Received: by 2002:a05:690e:4403:b0:66f:c1bc:404f with SMTP id
 956f58d0204a3-670f4bbf268mr32396d50.48.1788779708527; Mon, 07 Sep 2026
 04:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827093948.2825531-1-lilinmao@kylinos.cn> <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
In-Reply-To: <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
From: =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?= <miro.kropacek@gmail.com>
Date: Mon, 7 Sep 2026 21:14:51 +1000
X-Gm-Features: AcwNN1V5COwUc4nP7hlmxy1WTzJmRl85tss2dbdH15pC0LiCKmy15_QroF5u0Bs
Message-ID: <CAN5rfbSh9ZoUkReAqv9rHYowqKcZFa-Svy6LP-MHvqfBVhjdBQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Linmao Li <lilinmao@kylinos.cn>, deller@gmx.de, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linmao, hi Michael,

On Sun, 6 Sept 2026 at 11:49, Michael Schmitz <schmitzmic@gmail.com> wrote:
>
> Hi Linmao,
>
> thanks for your patch!
>
> Am 27.08.2026 um 21:39 schrieb Linmao Li:
> > The SuperBlitter operations derive an integer byte count per pixel.  The
> > accelerated fill path handles only one-, two- and four-byte pixels.
> > However, the operations are currently installed for every external
> > framebuffer in SuperVidel RAM, including planar 1/2/4/8-bpp and 24-bpp
> > truecolor modes accepted by the external video parser.
> >
> > For 1/2/4-bpp modes, the byte count becomes zero, so accelerated copies do
> > nothing and fills fall through to 32-bit stores.  Planar 8-bpp uses an
> > incompatible memory layout.  For 24-bpp modes, fills also use 32-bit stores
> > despite advancing addresses by three bytes per pixel.  These cases can
> > corrupt the framebuffer beyond the requested rectangle.
>
> I believe 24 bpp mode can be rescued using something like this (entirely
> untested):
>
> --- a/drivers/video/fbdev/atafb.c
> +++ b/drivers/video/fbdev/atafb.c
> @@ -2463,6 +2463,11 @@ static void svblit_fillrect(struct fb_info *info,
>          case 2:
>                  memset16((u16 *)line, pix, rect->width);
>                  break;
> +       case 3:
> +               memset(line, pix, ((rect->width * bytespp) % 4));
> +               line += ((rect->width * bytespp) % 4);
> +               memset32((u32 *)line, pix, (rect->width * bytespp) / 4);
> +               break;
>          default:
>                  memset32((u32 *)line, pix, rect->width);
>                  break;
>
> Can't test this on hardware, and would need Miro to confirm it works as
> intended.

Linmao's patch: I ran it on a Falcon with SuperVidel at
1920x1080x32bpp, all good.

Michael's 24bpp fill: I cannot test it because the SuperVidel has no
24bpp video mode. It was planned but never implemented. Its mode
register offers 1/2/4/8-bit bitplane, 8-bit chunky, 16-bit highcolor
and 32-bit truecolor (24-bit RGB plus an alpha byte), with the
remaining code reserved - and TOS offers no 24bpp mode to set.

Unless I overlooked something, the fill also looks wrong on paper: the
first line is filled with a repeated byte and then with repeated
32-bit words of the same value, which cannot reproduce a 3-byte pixel
pattern unless all three bytes are equal.

On the fbset question: no, the pixel format, depth and geometry of an
external framebuffer cannot be changed at runtime here. fbset -depth
16 and fbset -xres 1024 -yres 768 both return success and change
nothing, because ext_decode_var() only validates against the values
from the boot argument, ext_encode_var() re-derives every field from
the external_* globals and ext_set_par() is empty. Only a reboot with
a different atafb:external: argument changes the mode.

-- 
http://mikro.atari.org
