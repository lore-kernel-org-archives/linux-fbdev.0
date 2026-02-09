Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8FF318ED0
	for <linux-fbdev@vger.kernel.org>; Mon,  9 Feb 2026 23:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770678002; cv=pass; b=qvQ68wqrxTdNqUF7IemjNGYFHENp1/l5yZGrPuruEmcvD7n1Po9T+LKQctYnXZZDuEqVIkDzedtFFeYaNb4P/Tx6ibLdw+f27GEijBfU2FPOiZrWvqdXV8JleWnN+0YmgSZkj0htzKK/JN+gxtF58WEa3hm1U3HtD/aLO9rPiN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770678002; c=relaxed/simple;
	bh=e8PEklr7uWCqxR5kWo0UrXRis5wQ5nh0+7wTqaw95yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpNmq68f5E2PI2YGePK6zAAQsi7GJb+OTtQvM8txl7kTEfDh5bayIBdxLEpE6lFNmuul2P3vTleJrUTybqyiYNVcio0nxLVZ1+48jo/wyv1ZGvh3aQPdKM6y/QxbWZw8cx+7RKO0EXV+GzfMuKh7nEwFPeCoBI62Xx6YkIKxKes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fi4QVJbA; arc=pass smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi4QVJbA"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-896f44dc48dso18044076d6.2
        for <linux-fbdev@vger.kernel.org>; Mon, 09 Feb 2026 15:00:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770678000; cv=none;
        d=google.com; s=arc-20240605;
        b=SawNmDJ/61E2DiLmTinALoxdmaTJyAiPw66VeuBpFtoewCCC+c/BA5LtFLFMDEtGhg
         WyQKNEh5PpYFTleGkytYhlRzba9AgMTVxhY7DaKWMVPfB/CvIlRiTveJddC3seciKWeS
         v6+lOgvGn4L5vmzv1Gwe4Dmqs2BGyAZCEOP4Q7w2V9S9H2XmeE4RFP20vDsvw5AvkeKP
         uBU9+IrOUpOUuvWFPlilDNqD7E23XLN6KLaXWM5b3rE5LfayXwz6kGmvGq0iwRimTEZJ
         MHyv1aiKWsJ9oBqpjvLIyCd3MIzdwHwrc27jAQvfxIDId0Xs/6ezpmQG4JKQzD8+bL0N
         NSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X6Au6xV8PRd/zxZsbngEl9JrlNyZSnCE+btODQUCmyc=;
        fh=Xs2qXENjj4fF3tgQHNfMtMCD8TVpjIFHcH8yjTGCpEo=;
        b=ISDZcgZ7nO3CV/+uHtbtZFJ7qd2KrlDG5Ete9TLAAOfWQ8fQZksJ1aoNyYmwT3Lv0W
         wNMPAZ71ExgOp12iYxwMxlVEcguPrAVO/SeRGG2sk47N2IhJJHXjKNnvapBZclM9FdT4
         nAvcmYtec6rhsFWwa3T1mIGxfywgnzxguH6vvKpW8Ix2r57cAxLI4RxIYVCk7zL0405k
         LBF9YxkajfTZcub9BwxxwTEkzVcH/4uMyQF3+OCHJsR2fxO+CV+Urca8XBbRdJ0ZG4qe
         33oAXkyGpdGdg9z9xri11RZ/s8xeoKWde0/C8uXUwZHSjwNiKJQjD+Y0cOaTYj3368wJ
         5uQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770678000; x=1771282800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6Au6xV8PRd/zxZsbngEl9JrlNyZSnCE+btODQUCmyc=;
        b=Fi4QVJbAgqaVUx9zEEMqLkqpMAEnOYj4+VZiclMjpMOND5sffBQOB5AcLLgaM0afEY
         VuXe0X8yV3M+5y6EWwjRym+Yh8IvD32pDFSXjAkZpZkoUXoyrvzc9UOvlMjJeaTuG3Vs
         8vkFxRuesfkYHCMBJJZzXA1RwzaZ/VO+2uxokP6qA5SfjJMeNaklV+6W+7DeNuwKj37t
         LHrbq+YH22MICeFpVVBQAZX1XJxrKvEmhKfDuNAY99gLTJDdZd80scv9hpveAHfrl22O
         2RjIAvhTLMAGg3CclFQZe81Bl86sLKxoBupjmtMhvLhOpp/8qOGLcGTDysDz0Np4N90f
         wKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770678000; x=1771282800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X6Au6xV8PRd/zxZsbngEl9JrlNyZSnCE+btODQUCmyc=;
        b=BRKmuoFop75j3u+6lqZtOAU/ouZB50cWvhyufPIr4UFiV4DfBlMILT4+iFzAukYxb3
         9l944IhRpIeac7LBtYHD/PFU1+nMq+FlrJB70/4YjQ8rpDgylJDkHceSOSBUxhoLhmz3
         jW81olaYDk+vzd8UQdYF/gLxRSezPKewUpnrOcIVHHICou9FC9bYrJaYrLMkp7Z+EQi7
         du8kExecV+Z/lyNgHkxEBj5u5c7o+76e5xUNnrjZdypOQu+HkYcbFFgsiN7scLQ8KYPN
         c1ybZhaJOu3hcDxIjEMBfpd/yTiFPKAal4/KITWqePuVLZwRW157GIxEquEB+WlMza1R
         5G9A==
X-Forwarded-Encrypted: i=1; AJvYcCXr4Hn3zkaLotmUa3OEst0IOjoo9xXW9Y4oBY/EKaziQPjrAeIfNWNjrOml+Wi+Gv3mMRnacxRmbZvudA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKdQ1ikXGXj/0oTPki2BrByHPwCRO3eXy++OT3nMjlOXzTNM1M
	ZrDK5m2l5G13YU1Sqp+fCDLp0N77FStKSXOyrHbhE00UZB4eTpqPh2zpJFfg1nv3Jz5UiG6XEcL
	9XgAio0NbCxBd2w/jXiAM3Apb7xogcug=
X-Gm-Gg: AZuq6aLN2r44dfBt2dEhTPNpwkfvmKSscPmUtO24xOsX1fEllsiwsTdjaAPflD39kpW
	rkoFu/NXl86GTh9aTZ3YHxzBFCOyPiWSkg8KIL1vEF0H7Q+BbAz7QwJ0cVJOcM1X9nYCB05cjmv
	ymQ5bjSfIwW1lf9bXCkoRvl0aLJegVpTWrhajojxs9QArXjQyAUy61WgrDGtmXmU+sVL9zPbjLP
	fNITj3jOqwxlzb41QDwug9FeNrrlwwoIGFMQFkbrMd269/zDSSMbOwR+4xSZN+KmGZ0DrkDBUbq
	PcgsdFmpQl1gGQzQYMkyftl84yGyZouSCtAB2akNmiE9iMv6AweZ5ZF0
X-Received: by 2002:a05:6214:2aa8:b0:896:f7ed:6eef with SMTP id
 6a1803df08f44-896f7ed7b58mr94491996d6.20.1770678000112; Mon, 09 Feb 2026
 15:00:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209005212.32370-1-enelsonmoore@gmail.com> <CAMuHMdUPX_ynhX_t8GtB7eRqF_6W4BwqC8w7SRpro-1Okxd70w@mail.gmail.com>
In-Reply-To: <CAMuHMdUPX_ynhX_t8GtB7eRqF_6W4BwqC8w7SRpro-1Okxd70w@mail.gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 9 Feb 2026 14:59:49 -0800
X-Gm-Features: AZwV_QiSC9VCcDqO3yktkcGVN4OLgv-YcSY9OG226TJzXFBcFYkY1Eq0Yy-1w48
Message-ID: <CADkSEUijZBkWbXvUtbn91NeKGtNPV99R0kU210TiqEwyM3vPRw@mail.gmail.com>
Subject: Re: [PATCH] arch: m68k: remove incomplete, unusable Apollo hardware support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Biggers <ebiggers@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Thomas Huth <thuth@redhat.com>, 
	Greg Ungerer <gerg@linux-m68k.org>, Finn Thain <fthain@linux-m68k.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, 
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>, Kees Cook <kees@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Wei Liu <wei.liu@kernel.org>, 
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>, Sukrut Heroorkar <hsukrut3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Geert,

On Mon, Feb 9, 2026 at 12:03=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> Thanks for your patch!
You're welcome.

> I didn't know that is a requirement;  one of the advantages of Linux
> is that you never need to reboot ;-)
Funny. I was just using it as an example of how incomplete the support is.

> Seems like you missed https://github.com/geertu/m68k-bootinfo...
I'm not sure how that happened, given that I checked every page of
GitHub code search results. Maybe they had never indexed the repo.
Would you like me to send a new version with the UAPI header and
constants retained?

> Apart from dnfb, this only removes code under arch/m68k/.
> Is any of the removed code blocking further development for you?
No, but it's better if the kernel doesn't carry around this unusable
code for no reason. People have to touch it when they make tree-wide
or architecture-wide changes, which just wastes their time.

Ethan
