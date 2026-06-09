Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A9B313E34
	for <linux-fbdev@vger.kernel.org>; Tue,  9 Jun 2026 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780969830; cv=pass; b=BkTjbxDap6NDj8Ce8DMYeJtpDP9Kbfxkne398fUHEJy+SAmPRrnce1N+CZDt/kAisES9M9ERyy7opDwArizIfA7wiC3vdoH03zNUubX7mK9UqUNUgKydJU6sn2w/6q3xPVLciz6k3tqVFktcw/zinlIubN5Moeh5uI0nm58YXGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780969830; c=relaxed/simple;
	bh=9+dm8iyl1FFmimzn8mWDuy0qsUo+/kaFvq9DAaWHktc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRly2CvwIiiMPzfPsqwdZS8JCAhPswwkEXfu7+PEm4hQFPJJIJZMq5wZxck/LAlwhBRo4M/L7KNdWSfTxgO36kxNZITWh/GP7efN0oimaQ5aKJ7RbsiydmGTIheHwHenwKQRaaMPQs6cm4VZudwaI97h4jA//Fh+oac2t3K20SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hu+5XBn9; arc=pass smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu+5XBn9"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-516d0db9372so40051351cf.2
        for <linux-fbdev@vger.kernel.org>; Mon, 08 Jun 2026 18:50:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780969828; cv=none;
        d=google.com; s=arc-20240605;
        b=aNVrwjVznzjj/Wfauiwr3RUjgS2SfpkGX+en9MRXiI7qf5IITeG6UwHNSV1jjaFc4U
         6NHG3OF7hgKcbTk9VzWeOqO1wwxGrPGwaf72hxymAsQOjgS+MeEtMJsQgiK4Alfy8AHu
         TtoaNuJE6elgIe0zLSDelQ/WWGSEG8w19Xc/FWGTWagV3ja0RqM5bncY2ZRB7kLXwuPq
         VEN9uMPgi/Wv1KDj8+Sp4g5iduG/W4v3Hi0aZ+iV14wYwOwX2uIRdCQR9hRwRbZukas9
         /PCBFV8cc6Fb1kiLKdGniLHPyBsDpFPDfpnl5/mw0CDJB8PvTCjyUA2QCNhvghDLtJLV
         Jfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9+dm8iyl1FFmimzn8mWDuy0qsUo+/kaFvq9DAaWHktc=;
        fh=wUrc7LKjnuiRa44oThUbsWf6jbbhmJnOxJ4OqI6EtRk=;
        b=V1UpUGlZ/BTcLhxCurQEuSdJm699C/kXhqC+x1md7BNYr/RZyyAsPTBJo+C55GFgYc
         wLma2FtVsLXqa3ZkoM7s4ujPlq6eHvNicgKBtZoHlVzH29T+p8QTZbnICVUO+002RD7p
         Y4NdhXyZ3XW7KJondY684Yeu/unK6bpQFw3+ScgfinRtNBcvOdD2z0YxOeanX4dgnWOK
         52aqjSfgMDb9kIIBrcsA6XPvtjEKHF4EcQsDod/hNSD5FZFIP/rUHVnm4qKWBeQHil0o
         5msmu9yyT0CLS1aVy0cpC1NitrUGi+DNbqQpiWZaAN2kaTT77pSRK/dj7Yn0BcyUxUo3
         sumw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780969828; x=1781574628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+dm8iyl1FFmimzn8mWDuy0qsUo+/kaFvq9DAaWHktc=;
        b=hu+5XBn9fRRE9Nbjistl9sr/gyzBk0tRwV1hPGpYJIQ0Vw1z1LtHlmM3pyHa2hZPYj
         6LojUuIC0eaJGQBvGnXh+u7u1NzI7c98XJ3+RWtgYMI2iz3x2FqwbtteCG2kaJYwyspf
         6+4vfG91lPM+vDZG0Omhn49f1weQ01o905JaOhFUxEiQ+VG99FW+g2/gJI1M0qlZrNQy
         vCxs59XabnmFW+I60HZEyIokoL9Rm2vQ8mtyprdJiTlY+CVhDAlp0spEYz0P7UeNLYOl
         FexGNfBmwZXTQYo2MWU6HNEEflVsJB8STef16/4ymgvcDZFSqfSJWVpkXAU77UHWYbMs
         XZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780969828; x=1781574628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9+dm8iyl1FFmimzn8mWDuy0qsUo+/kaFvq9DAaWHktc=;
        b=NvqtEKE6s9xnxTqi3C7M8p2rYTJnjYhKtk/gIU1DT3TXTMOgDr8EyQFUPVXMIKekUn
         3H9fwHq51X5eQrDXRnjzZ+y/WEcHfLfJc59VQfHyt2ln5qRLRnEYQfvMWLhuyG8T/A0I
         8inrqzomSDLkv4kgV5cjx22UOGdzfv+dMGSNNFmpdtONQ8nUWluOqdhKRAgOzVE+2fAg
         bkZgF3KkEPi4v+pJWhnIO+MJ555xc/laZE4w/0+hPo1GGfAx+ncgPZ4n8H3HLuR/vDvq
         00Hnwq6teMeQDgSRg5qfPbAvhwkY+8HSLfXCxyXW33V8/0YYhfZ/ismpK3mYXnDgBT7q
         aLOA==
X-Forwarded-Encrypted: i=1; AFNElJ+ykWpL6fXz9zS3x2GmLOnUg3+/PF7cETLS4VF5vun5tXhMbpmuSgW1XaoEgXp6bCKbnaeXSoaHl7ipoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/N228TNfinGChOWDf8nqLoBH/+XmlgzceTcvbj5afIhf0ErWa
	AaorXPwwKeJ7mm/MryhLUA84NGrIGt8I9rJVas3ZjLHUfhPArpS71uv2Q9XJ9vKYJD4Mt4iXTvq
	D5W122A98r19aa1GNFxbv9RcRhJfeJ0A=
X-Gm-Gg: Acq92OFaOrb6n2/LTiR6zqc94tfvt3fHtNCbTbZFLFIpKaIN6Vd5kBgk5fPFf7Gmuaw
	9X3sGR/+anHf0JXZ1cJeExRAdBdAvdImVOBVFfaj8a5lRVoJMxFsohGBxnQzGTMxDwhF64r2eN4
	tLrE4c9o22aYy0wUiXHwTcU4GaI97Tpkc9FDJ7la18vReVPpSwe4BspEqqQJ3WmzoQy2NDc9p5Q
	T1mpvSoDO6qI68ZCWZDEd8l8J6qNzQajdTImk7XhAoGvJ9me4kRrCekoWmCEJVRIFHk7g7k0fPT
	Ne15GOROd0NUNePHxHwsiyKaH2LXdPXMQI+fPlkjE7oTGTGSEzFi9BFBaqVJFV3nJBJHeJCMTaL
	8Ifw=
X-Received: by 2002:a05:622a:1b09:b0:50e:631c:c390 with SMTP id
 d75a77b69052e-51795c5be37mr269805601cf.44.1780969828323; Mon, 08 Jun 2026
 18:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607210203.229613-1-deller@gmx.de> <b80a379d-87e4-45c4-a078-09e84a840895@suse.de>
 <1492766a-c349-4cca-932e-bf608b922b6b@gmx.de> <CADkSEUg948W-XT3_ODe_6p4i5Y8AKEcP=rmJ+7qJq30Uq0d_EQ@mail.gmail.com>
 <aiclYUfQvMokMu64@carbonx1>
In-Reply-To: <aiclYUfQvMokMu64@carbonx1>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 8 Jun 2026 18:50:17 -0700
X-Gm-Features: AVVi8CclBz3tJGvpm6QTFFfs_QYSfEhhbHcxbqfMUuBKjZ3-CDGVL-ri5mElbOA
Message-ID: <CADkSEUiU07XkMkvoyTTxn0VXprKok5tKj80fFnc4k=JHeK8FvQ@mail.gmail.com>
Subject: Re: [PATCH] lib/fonts: Avoid unncessary 64-bit math in font code
To: Helge Deller <deller@kernel.org>
Cc: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Helge,

On Mon, Jun 8, 2026 at 1:26=E2=80=AFPM Helge Deller <deller@kernel.org> wro=
te:
> Does this patch fix the issue then?

Yes, it does. I remember you suggested this solution a while ago. Thank you=
.

Ethan
