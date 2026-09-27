Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8443F20E3
	for <linux-fbdev@vger.kernel.org>; Sun, 27 Sep 2026 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790516240; cv=none; b=BSKNejwAwzdNB5I5bNBx7cU7hejEwy96XHw6ngygp9wkZ6WAEkqC2T9mGuPobk3R+gOAT0HK5fttGosiXbffIgAWH23jQgici3wmukfVOFC1qywEI3cnHgpndrWzqMkFe2Jdv4PZJGzS5OaJI51suiIng2Uzwacuu3erpuaCanU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790516240; c=relaxed/simple;
	bh=NLbwPHvCiBJgx7ebzZxRbu/Tp+bn3nfDoOHERKWL7Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyNvTRCRwSYaXizGYl1lh7mnAD7t62qRCAM3HHsBGS8HgjNyLmfsqOD33lJCB5iLMCLr7kZTCgeLkmJMoCvn4fNEeSUjPRO9O0QhSEKCMCX6v+BgxnP7YGgnrM7T33sqQCKQ9O5vriJ9USofMWuMhtf5+xArFGU11j+5Ltc/52U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-79028ca9371so760571137.0
        for <linux-fbdev@vger.kernel.org>; Sun, 27 Sep 2026 06:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790516227; x=1791121027;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EvrrFDOEfw30xeCEywR2DrXxtTlrcUlKoMxF2l4mFYQ=;
        b=RnxNpdmFoqDVooQFkL7Q0E9cH0GQq4Bxp/N0Dqn+XZjE7gIHEbmTj81Y02EG8VUHB5
         TOdqoEEHxG4iUKMLK1d2vdS9DtWMjuccf98yahHksrNEGFUe42PbIO+d8w/A+eGQ2Sfz
         LztIaQc0xbv7bqAuIHTr2Lo1VWW5vhFEH0TfE7FA3qeiPbrgDVjUDbVA0QZYevI+amDo
         3ZG9S9QVLViF3wEfrIVjA4DUSN0Qqt+v6/lCooJyyR2eSDVlUCc12E1xBDTeQT80Fv7U
         Jz0BTCJPp7hc/+kuB4LtR8jqQ6gOJTKIw7+GkT+zE4MU7J2qow2pZ/HCuFoxiOIe/l3s
         utBA==
X-Gm-Message-State: AFq9FYJ/IUgX6rkj/sFwDiqYmW04T/pb/tVYaZ2x62Tod31Ij+9kp9H+
	nZNb2kRkEaHAyLiGqe6+Vs0ThpCSDbNeXJBwMduqcMl5HT8jQo9/Q270yaIAmEib
X-Gm-Gg: AYBFou3LdcJCaTQceFffzCw9JDWUmk3K+hBVQP3zRFFOybnA2Ly97IrouZJspb+BDvO
	P8cpm7EKhId31fOAWDpuApMAMezOECMePZmNJ94FErRQXT1KOX2FGQPKDEBswyJEK242YMh/P6c
	HxehSykivkZzraOjMcVDhlhwX/XENkGSTkyjXxbkb8u5kwOnEdF5FXr2lchFGgh+7wEIOMYOJ5B
	0KwNu7GmECj4X5KolpKNP3yu8mVRDybh8ogny63k/dVFR8q3F+UXoQ0oHNg+D8SVgMJd40P/LGi
	8qTzNlJmgcQCuoCPOwyS6ei6MDFM6eD6b/3NlXvQ2BPWLwNK1a8mXPb/PTYyl3LmKCUfHbm/S4W
	VrVzTQEDBx4G27FgqbFD5KYAEmUDtqIjGsmQnbNllViJwdmFhHcWrwkcl86tx+WAG59V31HHLRh
	w8/msFHwzCTGQwI1eajarqf1dfDZLK5leJux+wGUrN9YNl61DSJC/jOv4+44+UtX27fmHcsyRm9
	4Cqwf2jjcZ9ntzvC82pIqAkwS4++ByVEmIh
X-Received: by 2002:a05:6102:3ed4:b0:7a1:f7d2:e80a with SMTP id ada2fe7eead31-7af1eaeabd3mr3498624137.18.1790516227090;
        Sun, 27 Sep 2026 06:37:07 -0700 (PDT)
Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com. [74.125.227.38])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9889ae9eaf9sm2740122241.0.2026.09.27.06.37.06
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 06:37:06 -0700 (PDT)
Received: by mail-vs2-f38.google.com with SMTP id 71dfb90a1353d-5cd1d9d66c9so644178e0c.1
        for <linux-fbdev@vger.kernel.org>; Sun, 27 Sep 2026 06:37:06 -0700 (PDT)
X-Received: by 2002:a05:6102:41a1:b0:7a7:19aa:f0d0 with SMTP id
 ada2fe7eead31-7af1eff6b23mr3197807137.29.1790516225994; Sun, 27 Sep 2026
 06:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926062136.162108-1-deller@gmx.de>
In-Reply-To: <20260926062136.162108-1-deller@gmx.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 27 Sep 2026 15:36:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVB0PCGQnbNRVDT6D2dDNM6034GnkNk1FS-vZfwzRdVZA@mail.gmail.com>
X-Gm-Features: AclHuK9ucjDUGnCQyC4VU3A8-llcICjZdwnLW26_tqxRQfUZez9PgO5NLvXPejM
Message-ID: <CAMuHMdVB0PCGQnbNRVDT6D2dDNM6034GnkNk1FS-vZfwzRdVZA@mail.gmail.com>
Subject: Re: [PATCH] fbdev: atafb: fix sparse warnings
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	kernel test robot <lkp@intel.com>, Miro Kropacek <miro.kropacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 26 Sept 2026 at 08:23, Helge Deller <deller@gmx.de> wrote:
> Fix two sparse warnings:
> - atafb.c:1092: sparse: Using plain integer as NULL pointer
>
> Use NULL instead of 0 when assigning a pointer.
>
> - atafb.c:2824: sparse: switch with no cases
>
> FBCMD_GET_CURRENTPAR and and FBCMD_SET_CURRENTPAR seem to be
> historic defines, which are not any longer in the kernel, and
> as such the code isn't built any longer and may be dropped.
>
> Fixes: d463633d63e6 ("fbdev: atafb: Add support for SuperVidel's SuperBlitter")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609261313.kgFtkz2t-lkp@intel.com/
> Cc: Miro Kropacek <miro.kropacek@gmail.com>
> Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
