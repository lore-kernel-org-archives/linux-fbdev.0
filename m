Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9DB366569
	for <linux-fbdev@vger.kernel.org>; Mon, 13 Apr 2026 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776063879; cv=pass; b=GSNvvia2o0jxNXQuL38ysmGMZGt2CXYvxvejb2o7uYmnilpRgSXewacpPTkcf+X3mD2LeLzdurpdzfTVnskV/qJ2Dy6SnHvna//pCQC3htFw/ZIRCPIe7LTtoAnldq0qj3H4b4bEYTTegyTAKxhZUGTvxaTUBfCKI/VDhfKGdGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776063879; c=relaxed/simple;
	bh=cHUon7mnOsFivonubjEmKa1tqwPu0cNQ4ngoVsPKvwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kO6WqFwjEzE0fiEwI1bIvfinm1X1+a6NyK0sewDsijF8TE+L+1hg5GCcVeUJq7r/kIFxJrTDMGaBUhGCnBdoy7ld2vxGEvI9nx05OdrrNHyLLHYqcdbs2W6GA2NB/62drgpLHeApEHO3itlqFPGqoBUcesB1f7I5NdHgBYOkKYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGm0gQum; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGm0gQum"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9c01854477so650246966b.0
        for <linux-fbdev@vger.kernel.org>; Mon, 13 Apr 2026 00:04:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776063876; cv=none;
        d=google.com; s=arc-20240605;
        b=Yu1C1lx6cv6ke5gerh+iYMiKvfOC+zcfaaLnAS1wDL5WnHkcu6Nwno71k328+rwA2+
         JZ+BKP+im7edn4Xppbf00DPlmrp76FSGkuj8ik7dl6FMTnX4jBY9zJLrsfqxX2xuHygZ
         X71DDjTwCmZU8n8xEmYgKmYasiDWDKwGDouJHBIVfyoBC58CSjGJHhAi+yYDRy2/4tJk
         IWnSNMNK6Z/A+1fqMHAY4issEFvRmxWHvv2SdaS7R+iJdt7Rk8UbVIboAsM0XGuE5zfw
         4UzbulWPHEUgSUZBQcSMWVPE+Q3I1NM7YbSq3BpoxpPsK07CB5/ZOe8yi6IJ9fj1GfcR
         TXYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cHUon7mnOsFivonubjEmKa1tqwPu0cNQ4ngoVsPKvwA=;
        fh=/G7H8jTeGqNG/g7BRlbWV7ii2oqUSbkJrfnka3Wd3gY=;
        b=BW5ipfAtX844FsyUUq73DeaaOnLlSvJxFx7y3w+d75W6XuB6JSoar6FFRnTCeojYQm
         BZ/ieCDBHnIlbIej/gO9cWpSAhGivtpsDOgeOv1qYKgC5p3ZjAdnmtNho1WIYFkW9SMr
         f9CIC1vJ4yBfa3tdKnaiuJ5qphicT5KiGKdEiOAhq98i+COoJXo4XfS45UqiWPlv2XVW
         nMz5V1zGqw65j5wfXl0QervmGq/SUthkYu1kxmbDMpeIbeR6GSP/B+696yZx7r45Ar+g
         /x8dUx5EASqF0sqSgm3MSn/pOuDOv5cA33BNZwnOXBhBUUr/RP4ttSeyEZq4I8Gf56fq
         wutA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776063876; x=1776668676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHUon7mnOsFivonubjEmKa1tqwPu0cNQ4ngoVsPKvwA=;
        b=IGm0gQumSB33RGFm6tqo66OoK2tpjxg+7oVLW4/bXabKEVqSM1aKoeYbBZW5jGAStB
         vgHZhAjbJMQcs0UBs6Fx8TPYP/Y48GKl8i/p/xWI4lWu7cOWjQ3DaB/DTGUd174M6WCo
         8cdQSPLPHp1d22Pc9LXSUr5PHoPOQXwYopIoWb4L8FSSzRvXceowWL4SjMlCXp8lD0/q
         0nIvmODamGXH/oyAyYB6gycSTQuIQviE0bEvvcGNV2PLmTDlzh7BT8ZcoW4Xp6n71FCS
         +TrALryyZM1rGN3iQLGPGdEhiVMSWYFLsATG7FIa0blo9jcKCq/hPVQ+dLoEwbYqL/mP
         E5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776063876; x=1776668676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cHUon7mnOsFivonubjEmKa1tqwPu0cNQ4ngoVsPKvwA=;
        b=j3HMziN/5Qh1hFaWz6XWEekLKbBqj2GuNLiZtdmMwXafkbkxBbOPKoCaz12d1KvT30
         9lEdGayNuX27ZOpk7wNJxH7rqvNorpUneGkVFf+Ep2W+UrjYoYGX6W5yHFOoOlxZ4QKs
         g96e/O11dFqXKXfq6qsTRWdedtzOllJsV5FZ7qbuf4wCusj2iqVmckV3+91ZZSrhzjR1
         4rqUNYZL1eD/y/s+3uc5u0Mu7/b4acjjYZZXMvxMVyi/KcwiX1WSwa5FPq4E+Vumtbvz
         U1QjVkcESdIJQrwkeEfwyVjZLvltqN22dxe2s9c/iqapY7uB3Dkxl2nW3CV8y6dDsZ2H
         7hAQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qq05Xzmyd/Rd2URQF04gyyFTPeW8HCnWUpBWkF4sgNdTjqsaCpMsQGpJFuHWlTH0/DgcwCu5A7p1V0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YynJ0BurDkVTh+b/PQYjfi3m0qcwISMsNNvMQRdy+x4X2a3EfON
	n892dPeJAcKOiGY2rDcs5oJrAHgwaV8kLNHkLn+lVs7icFYhSv8qp3lU3GEfqX+ASVyPqkYIgNB
	tY+Th2GXm5zY+RCfSIAarhOYZXLH7HHk=
X-Gm-Gg: AeBDietwLay3fPwNQoFIwu/HrIguvG0dnf/tKYGpTROl7nNW8Q3Oi7YPN7vlKWntFLU
	BrptYBXMh/oE2FiLr9dTZyC1ZXVLT4DfgiLM+t7MJTJEiCViCgwtr3I4THHRw40SDZYY+f2JsDG
	hfgGYxH6lXcbxNugGlyb/j4J4TWNvO6joSnbEtDntkEYe+a02gwE0t77M+6WIUXTM7eZ0STyibZ
	QmOTXuoh59XqYIglywQjODQUmz2Qu1UnkqHb3kwIBoGS8L2hoKIwOknNAus8kGLsFAvmPtXxBqu
	cYU4vzIXGk/fdE6n1BpVJxwhRoQT7xIIJyLgNGk1WwnitLbTLFyU3k65MLzI2TKkBD61Zdgpv/9
	nyVJT0WI=
X-Received: by 2002:a17:907:788:b0:b9c:2a5f:41c4 with SMTP id
 a640c23a62f3a-b9d72683456mr663199566b.40.1776063875616; Mon, 13 Apr 2026
 00:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412144552.18493-1-mahad.ibrahim.dev@gmail.com>
In-Reply-To: <20260412144552.18493-1-mahad.ibrahim.dev@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Apr 2026 10:03:58 +0300
X-Gm-Features: AQROBzA6J9Pun5_-q9iTAp8nKuVUe_q0RpEZJPgZRxShTkw4gmMnUf4srXfMbNM
Message-ID: <CAHp75Vdu6pih=NqkYT0CR_oLyr3YgNKBeqYM3+naqVp52UCgVw@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: Use %pe format specifier for error pointers
To: Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel-mentees@lists.linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 5:46=E2=80=AFPM Mahad Ibrahim
<mahad.ibrahim.dev@gmail.com> wrote:
>
> The %pe format specifier resolves error pointers to their symbolic
> representation. Previously %ld with PTR_ERR() was being used, %pe is a
> better alternative.
>
> Fixes the following coccinelle warnings reported by coccicheck:
> WARNING: Consider using %pe to print PTR_ERR()
>
> Testing: I do not own the hardware, therefore I could not perform
> hardware testing. Compile tested only.

I don't think it makes any difference for this driver. But I am not
objecting to the change. Up to Greg if he wants to apply or not.

--=20
With Best Regards,
Andy Shevchenko
