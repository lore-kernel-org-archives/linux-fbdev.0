Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793007900;
	b=Dklg41x1MIrD02+Ccpqb/QbAlDIV1c81a6j2yVUM21/Y3HqbMa27m/YX/NLXuf4z/53Y
	 ZtQQN5jrmTZQi5BBDbr7VSQIZpTgTi5h4c/4ffGWeS8yZB9+og3CfbZxQ2R6GPZd2qZWY
	 f2BkHe9Kn4NBBLMppBKFvNJRwdBiz3AneJehm7gHm9gDUh3vwr100FiV5qOBshipSSKeh
	 ZqW0YD0D1WWJx1VP3KzOqWlf05830lp2EW3vaedH3bwgDHT1yNFMi78p8mklRn3rDbZ7Y
	 QZbLtmts4B7uk5EfluWye1AEaCqpjdYXjhvoK1UTExbclSj2mjDpwagnORK6ruq0bSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YySXXUFBOHmytywvVTLMkHqN01ZYut8GdXtuh1QQB84=;
	b=TMLBsoa/9vEMAsneU4Rvrn+xEt0/BIieDfLqrOXeZFzvt2io5qt7f8PmNQThMXngoHcj
	 CMYOUKleEqCyxqbRkKQlucHhX8VS6AbekL9KT15ioCCDLgo2jdSTx0EI7ix3yjlYg4+EO
	 EGD9DkuIZm2icFFiVwam/+YvuiwgrzTQpF3elCQN9G2v1NG5Aaec8CrpkQznAah8ZLgZz
	 mIjXJNY6oKUT0rxbUL3ySIZG04asQBdU7+KziAI2Ug0Pp4+xdV/UMrbbYPCbsjNerDKNe
	 Iwyw8yGC5F5pHXH3W4PrNjnBMw3a2loipoHBXRyW6BtAPYeOaXER8msg47du90h3Ilw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NUZUoxMK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7CA606A31E
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 09:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD7CA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NUZUoxMK
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6fbf1ba31fbso878158eaf.0
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 02:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793007899; cv=none;
        d=google.com; s=arc-20260327;
        b=S06V2LbynV7stEc6tHRsDEk8MEd8aKpczz437qImKpeLYCj1CwY2ZdYCTBS32ma2KP
         jyNZ76n2WD2fiQjlyu2ejHKqf+u9jcToM5wSzlzVrTQwxlk6qwFRqY5EAaHwcuvWntIX
         n0gNJsosKk5r3UQGWNmohTe1lEyiDs97a25/WboYF56JBDII6dE2hUThF9UglfgQvC+H
         U40QZMA3o1bd5izFHpyWkLwLJgzemgp+DDYIDzHaKX+g8bowuUy0Mc1JyS/L/COVQYcT
         Uky2t6SRiKutIhpSSvo0zQ0NRENEtBXFG8bjNmxzYR/klEdYP4rWxKKwDlfLmGFkCxTl
         ir2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YySXXUFBOHmytywvVTLMkHqN01ZYut8GdXtuh1QQB84=;
        fh=+nyf0kdZsg9IlfQiIrolEyBQNuOyK8JPrpSgXOS2Gjg=;
        b=KOEcdL/Jf8fxc8d6w45pfvyS182Zy9RcRBHUoOL89qpkFJv612IsyOPg+Kq9XRIBz+
         uG3kKjs/a/g9R2LsZVeRHkCZpbOKLWn5CC9amc8fxeGY048sDmL3CgFYcaxST+bdYu3m
         XSGCjZD6sjk3SfJS6TDNXFvR/hanzwlCa9btpKUXVWl4jfWGddECiP+HMkXuSr79m4TA
         HE7iuqwNu5pO5VUXmh5QE/dfEUjIGARLfVyD4nQNskLl21as9r4g+1JjHuW/DPPI9mjW
         6GofcYgOFWO1pj5hB/EzluDcfRctAHOswDyCqP2RsFzG3lsxusowWJzcu3Jh47VhYXNS
         6Nhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793007899; x=1793612699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YySXXUFBOHmytywvVTLMkHqN01ZYut8GdXtuh1QQB84=;
        b=NUZUoxMKd/nYmtJjraqzUOqRFLTCG2q2gNuxUIv6FD4SNV1axuZFNIlO+6+e9Os261
         chW0akAj9m5q2STjwcFa2UZsQWbj0EYRBh96NHHhwQs4Tgksv7c7rPNHx1jPGMsNShqs
         X7Jx9XFVJJb210Lhbb1ehdpCmtIuuViK0AAvG20wjnSVhOdtPy0e5UgP5eJmUK2oGwB2
         bs4pwW23sMIHnbMMT3tCBeaSoj8IOUBtLCANoYosdLYt7VKV4umpGyulyybFgS44Cyvx
         68KTVojaNcd11gOWCbmxVMSmQGq1JFxHSRsUDslDhCArN/IbIvHqsxBQdNZH5zRAuW0J
         C7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793007899; x=1793612699;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YySXXUFBOHmytywvVTLMkHqN01ZYut8GdXtuh1QQB84=;
        b=Fy0XpNDrj9E8v3F09klpoT9u+OGs/QWBOPgd3dDbupWnQJlsJV5BtS78TL/22X8+Vy
         qsY3qa19odAdWg+tpaB2FpHZnWlJH4/4cPprrz5qR5eJAPZi2NHUELyLDkKZxdFJCFQZ
         cXHTojNa8UH+Rv6s9himTUXyobHJi3VOMksvrdk/PQpUwhSQnyEwvIFaWtKGYQcBPmUo
         Z2R8e3KE3sxdhhm3z4kTFnW9LC0250gtMolJpj+E6Ki+Va3tjh+rz1Fb93QpA8uYAuAn
         V5wFx4SRw9rySiK01w+lv6ribzWu+SvOsqR0Ho3m6C+oq64VzRMELHOMNPiz3lrHSin4
         8TYw==
X-Forwarded-Encrypted: i=1; AKwUvBzdlt8w+QnuZCEME+BsyQfSn3C3cf5dXxVwJQszJQtOXAFqONXJSNE4EEPtvywSFqVY/Cp1tuSecf3NMQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIvqIcECaC3dG66tWnkR+ozt4u/QP9XUcHM9VXxPYbbhm6QLcGI
	VFmWcx3EoWVv3XoCf9sCxozDXOIarlGe4PdnRC2msn9IdLFAORo0Q6S7q73hdAXFMX5aP7DTkTD
	vfJtQ5wlm7k+mAhNndaM8Xwv9frBoDKc=
X-Gm-Gg: AYBFou0z8hjGwLlR7AcNYeTI32UsN/+1mzhpiAhUxya9cJLa9xd/SQ8dXEzdKqP4VDV
	Q4T9EYl4MqcWr+9feONhGbl6iZbZ5IZ7qkyXBCjVEImgR+x51K06KBd/gFBV/y+qF/uFJn2kqvt
	VbUp3c0WN4Rdjh0cmGrEfQBARR4ZHpxgwfUz5YJKCzXDFLfK+Q2trjKwxOJnFzgewZuxEq2LFLw
	62UsCKF/EBd/iEyjbgA3k/csachZxU+YCWP1jJO8u1bmBEUTKxAbyZI1P86H4mHpT1XYqA2rbm7
	7mgtogW8zzVAlVJIeZdFPmgf1BAbIORLXAGlcD51D9jQOpEN95Y4TxS+bzNldAWTob31Vr3njJD
	em5RMZV4Z1zHLzS9kz2Xa25qaW69/UqFucLwTyxkKbOKz6MnmFMmAl96QPVw6W7VH5GBUL1K4Z0
	nzyoyfS+lh4eyotqMd
X-Received: by 2002:a05:6820:7089:20b0:70e:2096:8098 with SMTP id
 006d021491bc7-70e20968319mr679857eaf.83.1793007898903; Mon, 26 Oct 2026
 02:44:58 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026092423.66168-1-himanshu.bakshi478@gmail.com>
In-Reply-To: <20261026092423.66168-1-himanshu.bakshi478@gmail.com>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Mon, 26 Oct 2026 15:14:47 +0530
X-Gm-Features: AclHuK8g_L7SXnsINc9C_3whJRkCHOJJj2ujrSiDjnaE7GbNryakHGpTdm_klP4
Message-ID: <CAGLmz9KsGrVEFRO-dQv559ArJRKs7yOiR5wY4T_aFAeuvNhg=Q@mail.gmail.com>
Subject: Re: [PATCH v2] staging: fbtft: Remove unused fbtft_init_dbg()
To: andy@kernel.org, gregkh@linuxfoundation.org
Cc: dennylin0707@gmail.com, cenzhang@linux.microsoft.com, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	error27@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 2:54=E2=80=AFPM himanshu bakshi
<himanshu.bakshi478@gmail.com> wrote:
>
> From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
>
> The fbtft_init_dbg() macro is not being used, so delete it.
>
> Reviewed-by: Dan Carpenter error27@gmail.com
>
> Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft.h | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.=
h
> index 40a7567df1eb..16459e4e0ba0 100644
> --- a/drivers/staging/fbtft/fbtft.h
> +++ b/drivers/staging/fbtft/fbtft.h
> @@ -420,13 +420,6 @@ module_spi_driver(fbtft_driver_spi_driver);
>  #define DEBUG_REQUEST_GPIOS_MATCH   BIT(30)
>  #define DEBUG_VERIFY_GPIOS          BIT(31)
>
> -#define fbtft_init_dbg(dev, format, arg...)                  \
> -do {                                                         \
> -       if (unlikely((dev)->platform_data &&                 \
> -           (((struct fbtft_platform_data *)(dev)->platform_data)->displa=
y.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
> -               dev_info(dev, format, ##arg);                \
> -} while (0)
> -
>  #define fbtft_par_dbg(level, par, format, arg...)            \
>  do {                                                         \
>         if (unlikely((par)->debug & (level)))                    \
> --
> 2.56.0
>

Hi Andy,

For testing, I have compiled the driver successfully and
verified that  fbtft_init_dbg() has no call sites in the kernel
tree.

Thank you for the review.

Thanks and Regards,
Himanshu Bakshi
