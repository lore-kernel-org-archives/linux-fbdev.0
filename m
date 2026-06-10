Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFE62874F8
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Jun 2026 02:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781058114; cv=pass; b=cn53vAHk5THVDbxoErYVWmZWyyBNcEcypooqbkyCoINOZVroMnRxSsahrTM/wBIfRPYJ4YaHUkdCWXGhYoWkokC6aP8UKwvWzKrRIHg68dJkPqpEQykZ0Rz9xF4NHHDRAueAVvJpXo8AWR7PKpuOse+4ho2xiyOcu4jKtIr0SKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781058114; c=relaxed/simple;
	bh=uZ5esaeLdOQuUyRODpqWsbo4aP7QJmdn0mjAvv8KEl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F40yD4EOqBB+KcLvdX3Lzk98exaoacnbFO4weyKCyenan+uUXZ66QbTX1KQUwQOw4TIWgTLbFCtITycBqoKBepAQt7zwsYk4iiL1+qJzfMizYGjxl1mqysrwpSh8FyBEmBSgxoFc/NpTavYb+7CecasvlXP69Q/MU8udqMoWYts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4NWRnwx; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4NWRnwx"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-137335bc3caso7904223c88.0
        for <linux-fbdev@vger.kernel.org>; Tue, 09 Jun 2026 19:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781058112; cv=none;
        d=google.com; s=arc-20240605;
        b=XunHXlvFB/yE9eF/C8dn1tyy0fyZ2M6ZMlpFb5CWxmLqtJvAih0hb+2ltoehHuTlxM
         DjHO0Mv/p/I6XYVeGRuQOam6Z0IZOOGP+YByEA26sg6ZG1iauUmRX9Wb5NydR0bGLP/6
         hvufC3BZEQ4qQKmA2SpS5x2DSsMazHiMyymqbBQlKMHoBMIlvZ3yn2heGJfQwAGgjNl3
         2sagD77XoiXEIGtMzFrkwXm9CUpNYMmEKdcHLFg/eGdIBgor8l5pwQp2Zqt4GuBbmYWB
         dp6o3hu7JNbu8ZwRnByWg/Wzdl9tbgKh/WG7bItfwuO6f0O+2y3slbuWUolqrLnGKCUD
         Ga5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LK7VdF/OKk3xdyJSfcwglCeoM26WXv5chd8PTqFxp3A=;
        fh=WBIf5/crYpYx9xSmAVboNw02rH9rLR4O/8iNdwiT3oU=;
        b=ZzmlZMBFYC6/JJHwdUlj+1QYzYTe0aKn6lbOuX02Vx8lrFhiWc1ggMX9XC22iSXE69
         /bJA6bdn6gxr2KGISTzP49Kw6ymXTgUJu36xYeCp36T/zxChUy3pASY5nfLrQ3+eve0N
         jpbBeHuWMfTZEDz4KcXiKNeJXk/OEH2yQ374+g4ff/ffvhibUGl9ad7wAUnXdrGk8CaA
         adNMwXTAb74wMwQeiMlKfv2Y6CxsOj3e1Iv4m5Y6TqiKIj1gqfNebe0Z+Lgm7VVg11u7
         m9XQpqqo/EpJv/bu3Y+CriSAtB5i3MBQ9keoknEpQJVEgF5oIXXb7IiFTIw6126RHLZH
         FWGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781058112; x=1781662912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LK7VdF/OKk3xdyJSfcwglCeoM26WXv5chd8PTqFxp3A=;
        b=n4NWRnwxrzpjpuCKJNuuuHTdKlnd2eHiG3CbYMedvfMEB/vrRnme3AU09prpJLutCH
         sjPAC9dbbULt/OvEZXDdXmyLh4mBWcklzj2+qiBtZz0oPi7Vf1KTJIJqsCNlRnbGY8+D
         Rprt15NUkqJxiBnYYZCmq9BtWSbzzf8L/f8at1A8z9dhKbimMQd7vp8hU2e/J/emUfaj
         U2cRXKoCceRcH5CetTRxhlLbxoNoUCgfTL02eULH7cwK1rtqzIB/ja+m4I+KpnHbCx2m
         qzwSQ0hjxFZx11QU6e/IC/jKXta/oV50dHi5tAIZO5vF6TAw8SVmwZGV+BYkvOhi4rC2
         C4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781058112; x=1781662912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LK7VdF/OKk3xdyJSfcwglCeoM26WXv5chd8PTqFxp3A=;
        b=JazTfrV4CbjDiwsKi+igKu7CLuyz1VfSJkH3ZBtEK/S5yNJXXVmQSFknTN78yvSa9D
         2+1WQttBWwBlrSXABfwP01mpqk2EH6+21zYW9MahISU2Jyl9tbt6dWWtftnLbz/tnq2U
         JnUVTQgVkv7ONLcHfraC1LZtK7hkYSgt65cOZKYUqSkVDozzlOt6bVVTx+NeooBb71rJ
         coBUgx7IqQdSAjfLdEtEhd8ePHH5DnHhJphR0M+G+CK5gFtxofBS6JNoD5ssxpX1QyIV
         Abe653gtNZxSaahpZVyiQHr0K+J7P55WcBehwAkVGh1s1dtUkug2FEzqM2fPCxgIg2qF
         rGOg==
X-Forwarded-Encrypted: i=1; AFNElJ+XWmb5z0kXJKPaltsvZkEdnhh4z5tIwoAzh7LSw9Wb3z7003Ktu+o3QQBSfKeTnVONMB8XEs36UDEswA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGl7bGEPwittqpEV3AM9Xknar10C+rIfGIH4Izlzj35RmSH4u6
	pXnbUBvTdMHQbrbiUyye0qYpubPVFiwOlxk1E4jxM5a7n0wCfPPiuBHMT1V1BPsa3qYGbAXxxXr
	awz78ZjiiAsg7JZMsaVYI1QNgdS0ywxc=
X-Gm-Gg: Acq92OEzJ9KS40huxkYnb0CTe9f8CC/nVmlZgIx7usKgIgywvJi6WLDPOzQthkV0SyR
	IwtqggCdRNcddrbWl1Y5X0xCJQDnMxOmqbXbzxq7nn4UYTae7dtR046YDY8/ktdnrVA/L1Xgu8g
	8Yq3A77ItaMm5gss81vMZ/GvsYJXCKk6j4ncXT4ku78kWIF8Z72Qsmoc1GIeRPpe71ruE+w69FK
	mEJCYYqH9Wt/Bnfxx73ABFVXoWarI9jK85I/sUWzB61y83mhwVcjGIwGP2BaoXrP1PDLMSeX7/y
	JpuK++q5YXUXHoRp7Aw=
X-Received: by 2002:a05:7022:111:b0:136:6230:5834 with SMTP id
 a92af1059eb24-138066fe7a4mr11542095c88.31.1781058112318; Tue, 09 Jun 2026
 19:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526091507.421730-1-islituo@gmail.com> <2d96dd04-855f-45d6-8bf1-7b6704181397@gmx.de>
In-Reply-To: <2d96dd04-855f-45d6-8bf1-7b6704181397@gmx.de>
From: Tuo Li <islituo@gmail.com>
Date: Wed, 10 Jun 2026 10:21:39 +0800
X-Gm-Features: AVVi8CcPjWyZW8sK8-ajf2c5r8G03jQW0fWCJo0Om5yrHDG--NDHYOZmUxzofhM
Message-ID: <CADm8Te=BiTgpzAnkeiZ4+bY1-Rr5-mb4M0oUxV42Yy33RMuN4A@mail.gmail.com>
Subject: Re: [PATCH] fbdev:modedb: fix a possible UAF in fb_find_mode()
To: Helge Deller <deller@gmx.de>
Cc: simona@ffwll.ch, kees@kernel.org, tzimmermann@suse.de, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Helge,

On Mon, Jun 8, 2026 at 12:12=E2=80=AFAM Helge Deller <deller@gmx.de> wrote:
>
> On 5/26/26 11:15, Tuo Li wrote:
> > If mode_option is NULL, it is assigned from mode_option_buf:
> >
> >    if (!mode_option) {
> >      fb_get_options(NULL, &mode_option_buf);
> >      mode_option =3D mode_option_buf;
> >    }
> >
> > Later, name is assigned from mode_option:
> >
> >    const char *name =3D mode_option;
> >
> > However, mode_option_buf is freed before name is no longer used:
> >
> >    kfree(mode_option_buf);
> >
> > while name is still accessed by:
> >
> >    if ((name_matches(db[i], name, namelen) ||
> >
> > Since name aliases mode_option_buf, this may result in a
> > use-after-free.
> >
> > Fix this by moving the kfree(mode_option_buf) call behind the access, a=
nd
> > add corresponding cleanup before early returns.
>
> I wonder if this isn't a typical good use-case for the new "Scope-based
> resource management for the kernel" [1] feature.
>
> Instead of adding kfree() at various places, we could do:
>
> diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core=
/modedb.c
> index 703d0b7aec32..b6926764a99c 100644
> --- a/drivers/video/fbdev/core/modedb.c
> +++ b/drivers/video/fbdev/core/modedb.c
> @@ -626,7 +626,7 @@ int fb_find_mode(struct fb_var_screeninfo *var,
>                   const struct fb_videomode *default_mode,
>                   unsigned int default_bpp)
>   {
> -       char *mode_option_buf =3D NULL;
> +       char *mode_option_buf __free(kfree) =3D NULL;
>          int i;
>
>          /* Set up defaults */
> @@ -724,7 +724,6 @@ int fb_find_mode(struct fb_var_screeninfo *var,
>                          res_specified =3D 1;
>                  }
>   done:
> -               kfree(mode_option_buf);
>                  if (cvt) {
>                          struct fb_videomode cvt_mode;
>                          int ret;
>
>
> [1] https://lwn.net/Articles/934679/
>
>
> Do you want to check if that's correct, and if yes resend a patch?
>
> Helge

Thanks for the suggestion. I think that makes sense. Using __free(kfree)
can simplify the cleanup logic and avoid manually managing multiple kfree()
calls on different return paths.

I'll prepare a v2 based on this approach and send it soon.

Sincerely,
Tuo
