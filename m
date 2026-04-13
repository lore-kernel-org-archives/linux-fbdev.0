Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971DC3932ED
	for <linux-fbdev@vger.kernel.org>; Mon, 13 Apr 2026 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065282; cv=pass; b=Ua8y5tJk2Lkie7R+mSh2ZnTr9dHhXoLnq4ks8+a6D5xXyDhqO5zdRwkxq3F1xjX36dOXQdWMr7VQiM8Seqyzd/Otc9kZrHf6lFla9gq285h5clwpoVJbWdiTKl3kftZ28dC85ip2pEmbRZkQ+KxeLRH88aGJRuGWqGcBjSohfi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065282; c=relaxed/simple;
	bh=DlwMyD4t29/8nrFI8IaWu444cA4PIV5uHY3KyCXXzrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkLtyh99DS/O9pArr+FtNiX0L2ABBU/tm1ReT351PDwK+qL4V5rd4g8W6HSIIVQj06b9GlsUO5AO0m+gEQvhi4k7qy2B3W596hd9tkrhrPfFaXYsOB8fR32BMMG5hSnhCsAUeKzm+onkVLb26fhOdxF4J/4gRni1AkYqnVUYwWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QE+OXZdO; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QE+OXZdO"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so753022466b.2
        for <linux-fbdev@vger.kernel.org>; Mon, 13 Apr 2026 00:28:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776065280; cv=none;
        d=google.com; s=arc-20240605;
        b=fI0XoHv8DkUZxuJ/x1qC54MKrCmYO0OVvNP1SBB8+Koa6aHqJUP9BfN/rc2W6Ied6i
         rjNUMVBKqEi1/WnQLsOQFsiNN+ScAWwmMZymcsMLOjBhj/gfjj8FO4Ael1IDcYOjVqwZ
         GW11fQ12IJgtOkMQnP3Q9jTHgB2IQkEPiARLWrH5THd0GR6+OYPycHkrjpANnFki79ZV
         m8VoZj8H1YN5wz45PU1WhXuG9tYaXDZ91ZZ1972eDaSvro3EckakSQVJUJO1fcjpbId/
         03bYubAwAFVza+tkNDguXUsFI+bH32SGeDkYEiShbr2cXoYRPjreqsgUDFmwNEFBJh4C
         MvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=esw3ZYWK8lMWwagwM2py2+1xYSPbr9lpYxI9c74FbXU=;
        fh=htm1lP58Uib2ghfdYOWsahfsD/RoKQWIxMQeXaQuWM4=;
        b=AhO6OzsgmtIne83vZt4rlA6SXsXXOp1rEShEsZhOmM8W1KKSE98gUQwmtsLRYs/ZmC
         HXD6gvszCEzJNFCFU9uPEKXYqdjgyrSY655dABZuqMeVEA/8Z/GBRvGdLeU8fD+D9xcZ
         fM62H3DFQkypNu5YFLrpgf6/5qOaFn23ljkQUuRY60YBLfqp3EfIFwJQV/AjkwCQis0C
         Zy/Xb5hHeYhqghd7IVZ6C9Scntd9HKSdQSxNAB33oByoMnk+0HXbxmeGxU5IY0bbx9v2
         lVAOzCiO7UZqhVlXCagFE2pFKLRQ+etQr2/KkOlS3l5ezwY/hFRrBulSsnG3gPK8ldJx
         N5TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776065280; x=1776670080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esw3ZYWK8lMWwagwM2py2+1xYSPbr9lpYxI9c74FbXU=;
        b=QE+OXZdOyBvGzkaETnv4KN0ImzrfHj64+B62OqqwVt38yUFq5FdjdH2FXoWFhA/LzD
         AOlbVVHpsBq7gJby0G2EIL6QiYZ7nA0pz8kdg9RucoGzpBUmFHMRXb/x/GMeMx7afuwN
         jqrgBp6XaYcom5EkPf8Q8AkdClLTaA+8iP1s7MmUNYEoxYBdBJcZUT4YE93iBpgxObtD
         WmG0KuZWhU+IHZSmA31AFD0VSOIXPLujWLdz8rvKaauMwPuLMckZRnOs8PjQaU10cW6M
         iFRRNGRw29yGixkuWLvCGEE2HyTdwpvT8dH3upGHI53jFWaTq59lRH5cZpWakV9b/kb+
         uc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776065280; x=1776670080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=esw3ZYWK8lMWwagwM2py2+1xYSPbr9lpYxI9c74FbXU=;
        b=hAXZFyZ9Z/9hycIojXvp3gZBhJVHfjbs2hgaSV2o25yF5MIGRDAX06Ajv5cPrS8EvL
         5mPSRbvyliVI4r0IDdEia3JfZhB2roUWwXJWGJmFV0U2FP1wfV4PjTIO68oKbPGvAkSk
         2lD/+i1bj3MncJ+xOHPBtX+rWBVanILACLanYmRVBBW0HOeYj2kbDmCVSfE2C/XESUDp
         CHRGZ8ZHAA75WyzheJRoVpbSm6V4c6x41UsIAJvQaZOH0PA/D6jkJbIoZuBENwZsKMHW
         O9kfR6zMq+SoooGbvV1VabjywA1/xMxsumYb/u/fSNY+qcLY+lrExdJ2dwMQN1aE+alF
         uccQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Gd1OD29lDokxGfiKv9X++V4xvzwpc8+hvpkBrV8rygXKSzkd9JpwuSX9VdH2QFVQIJjmCDwXrJlIf/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOU0/SZi6v/rTH0AbMWN4KVR+NEXZTuIETuyANWjfoaq8yL+r+
	9uJevxNQYoYqOqO6yyL22VTsF6K6akaEvBu4t/oSDIVxWQuM5Bos06ORznRvHIoycL5G6ZGe6ar
	I0pL+MBLwpSsJWWcucDz00B0j3uRBNJDgy/lss+4=
X-Gm-Gg: AeBDieuVFEFw/GPxcmz2R4H7IGo8kJv/9vwUtmZVZv9dLCzKwySOPE7sTH6QV2FOkxD
	V/q+NwuC9wDXv830UYFn0AH4Vt5gEqEz2AJQkuX8F9PllBJFd+omhFHpEluatrx+8StMf+fBYrU
	nGlk2SSOOYmaC1ZeMGd1VtowdUkynBTVdIay3CLEhzjzkisS9nmCOKwiY8a4P576LxZR+aQGKfv
	wuhm0k/b+HR4IyzXDPRx3srLIq2TnRWCAw4Kw0V6t7JuxXm1y8HT1VVqYa8R9eAmy3XAfBOA4ol
	tWzz9pYz8e8moz0XD3r08WM0zS8zgZZ/j1aW16MGQPSRaZRYyYmC3EAEjdiWJd4Jhuz9L7eaOGj
	lhUPUlRm0iS9R1e6gsA==
X-Received: by 2002:a17:907:a807:b0:b9d:6cec:23b9 with SMTP id
 a640c23a62f3a-b9d729c06ecmr660809466b.41.1776065279751; Mon, 13 Apr 2026
 00:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411152220.89174-1-bcmouli2006@gmail.com>
In-Reply-To: <20260411152220.89174-1-bcmouli2006@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Apr 2026 10:27:23 +0300
X-Gm-Features: AQROBzB4Yfa7E8b9N0W--P-qDaiyqe5XsSiklgo618k0sYtUqoQ1QuzhuPe_kPs
Message-ID: <CAHp75Ve3gDPXOCqhXr=Ue1T8tX9rfh-JJrtOoFa+thcsXq1hOQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: improve TODO comment clarity
To: Chandra Mouli Baskaran <bcmouli2006@gmail.com>
Cc: gregkh@linuxfoundation.org, andy@kernel.org, linux-staging@lists.linux.dev, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 6:26=E2=80=AFPM Chandra Mouli Baskaran
<bcmouli2006@gmail.com> wrote:
>
> From: Chandra Mouli <bcmouli2006@gmail.com>
>
> Clarify the TODO comment in fbtft_ops_damage_range() to
> better describe that the current implementation updates
> the entire displayinstead of only the modified region.

Please, spellcheck the commit messages...

There was an attempt to improve that. Do you have HW to test?


> -       /* TODO: only mark changed area update all for now */
> +       /* TODO: Optimize to update only the modified region instead
> +        * of refreshing the entire display.
> +        */

/*
 * The style of multi-line comment is still wrong. You
 * may use this example.
 */

And also note:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/dri=
vers/staging/fbtft/README?h=3Dstaging-next

--=20
With Best Regards,
Andy Shevchenko
