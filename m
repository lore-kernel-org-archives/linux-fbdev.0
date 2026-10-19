Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423BF4E3EF3
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407991; cv=pass; b=I71QR3WGlYe4u03x2hh3Nz8VAKoPaGCoU3cGGTt/pkPKMNAgsmvHrwtDRS+l27KO8qNI5ZbVFbP69CBp0RWX9I7Tr1EMEx7Hkee0Fx6vLmbd8i/LBwXQeFwA29KQRNQ+1wZkKoGTYXD7W6TVeK4/ekKBmp6vGRebR+3rchAD7kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407991; c=relaxed/simple;
	bh=ast1zHJ9Uz2YssWCBu1jREzUx8HTb4eQoYAKdnW9yDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bm5sFmeMYEx3cR4oToYjaCrZajmguEXjEu991BB5QEVDtrAoxoVid8Q3UFDFEuryiswjAD/Nldg6YAHHympONzIMToAFqDd64MGzkorr5z6fVKRqii0J8485pOUXtmf8ymy9wjI7wnPo2jKRMNIZh8iz7gtl95mg1sjPkjtWv44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=royPCape; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="royPCape"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-676858d42f8so1498195d50.2
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 04:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792407989; cv=none;
        d=google.com; s=arc-20260327;
        b=iV/WfPla9E72c/VL/Iuwqtc1pgK/yIQM8FF5N5shp/navDZBiRX9vQzvfU4bYJV+I+
         PiS0Ib1/8Y29mchl8uURypI9y42giXxzRQvBA6BZr9bEfT5w56iw8g+pzZxTb0CMuovp
         FZl5LZOykjMTJ0MH0E+HVzw5iaMGk3IfMzf7jy018+2PtH8+AgmjQwPlZtogWe5NRaNZ
         qwEXTI4zEJ9WysFgJbsDSDxmsyXpYMwU6pu9mdDdMhuGIXfOsJ2YCqEtQDTSQm6+DFv6
         Mk8kcY5KkBXpS5tih8oXgcS2q3b7O4QhUKWoodA/KJapXFv4pxsHos0vPISoU+2auWKp
         z/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ast1zHJ9Uz2YssWCBu1jREzUx8HTb4eQoYAKdnW9yDE=;
        fh=Albluaiw85bzsw1lB8c2A0C5ouGBozNseJ3RjTppn58=;
        b=bcAM2I9FAvkx+odXYOGfoRl53NpPHaE3mugJTBuAEu8AZaRJjnu67uwf9kH6+Qf3/K
         8r6XqN5qtcN0ego31zXLLeVfrfdE+YTWvAnUp6viQiUonG/wDVmvTDJEqjmpbCruSpOG
         H7IKx+jDqgHRyH8f5FQkWDzcBoKDU/Om2FyxIgx05QoEq27D8naZbHQ+VdeDEksDKtTK
         MoziWBEpV+dpSUzzgkpt4cBZd/lVfWRWb5n0wYwGW/i8073GbJgWsGzWDeEz7Xzh3FCd
         C4h1J+vsmxGSk3Rrc11a4h3AmGEYsFva+jEIv5ABEQUrh2YCDz2ENIPdotkbytOrGlDX
         cPzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792407989; x=1793012789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ast1zHJ9Uz2YssWCBu1jREzUx8HTb4eQoYAKdnW9yDE=;
        b=royPCapeeg/TQgjtdyW6XI1Z3Y9e0kRCaONDaRN4LR9+5/t2f+H0XhtfNxbSsaAPSZ
         7i3m8d7zAS5+SENiU/wHZU2/Te3ph1w8kjCx19pE0D++Xt3XA6TtH0yu9xuJIlS9MpKA
         q2o4pB+JXo499xZg3jH9iivZgQH1EFi2QlrvuHZPxqp2IwMTVSEUj/JSbrN8kADmBlYA
         5JfLtbg1dRt6PlOBtRpDvYrISOrrLEGMV9wSQ2T2gKTQrNT+WD+PLc0y/l5ZlHXGmCS5
         ULU6yinAJQlOC8/TC1Lg+Q2LMxFj7MrJp4+0qF2AEfNPsK6sXkpZ+ejwMsDUyKWBZiGa
         0XdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792407989; x=1793012789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ast1zHJ9Uz2YssWCBu1jREzUx8HTb4eQoYAKdnW9yDE=;
        b=AI+vEr3M0cDWv2xqQ64B+2BDL7Qypy7CRU0U3vKdh1ynqdH9bRdZXraD7O/i0Ti3Z8
         C1kxvC/WML3Qvip6dNwxsHqmb/qCkbyStZBkPKBZdCTn5JYtLJuxSML6mvcNPtGzutU/
         Lm0U4bbdwe4rdzLUJ+yHKBWlTgDMQPKWyE7I0RzMJh6yKtggu9kGEsmISuZiYDu4l8TU
         hL8SMePn5soVIofoU3147j1SEF+MX2w5Dwv43WwBz7huoZO0v6Xt9p4OP2YLZPDopR14
         WCByCAGE39JQ/iImyG6y9JnJLE6vClaRb0kP7rU2dbayTzv/ZxPVLGQWVtt/UcI/wmFS
         HnzA==
X-Forwarded-Encrypted: i=1; AKwUvBwY/td45wzCca+JqtHXKXNxHdKp91KYZCpYFM4r+Ub9Vm6AF0idkkneBL3Zc08JcHxCLnUDeKYKPWMNlw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLt7OmlbKUwzOGgsly4pfVYmyqjTBUZpdDEI0RYvmMhRAbne/bQ
	rcTe36jjXyuboeddGtg5yk1c+yXi93CCTr9R+TvPlEQdICnjC2UOmd9msJ3N/0iGgGrJrYPKyZ/
	1V0OX+TKEsktT+phSChy957Wl0GtCQzU=
X-Gm-Gg: AYBFou0rFuzOryt3Q3QgTfQRa3AfDSqmpNmtorHIqcRvRexN0wMMeRMS7uDM4qWWyQQ
	FCVPbEwpEHOSffSKvkJZ6RvKJvK2eZ0azrshxPvCOIW3NmTU8YL/IK/OQ5xeG8qi2p9ymAIDKDz
	an2/Dl3qPCg5+7UV9ZKvOFr8HQdnphbB2twKZxhSQFKcQIHQ6INUCXgIcCHJgvdU7swdy4jJ6U7
	G10Ov1WxhvM4phN8vUVjaq27KNHTmnU8vyGVlr5aV6kmTs/BIwEKp2EMaWcx9rt6JHqs35mN8tT
	5uEMvv+qGfgFZzfxK0iJEFusUGGEV7haBn+KaewMqwOGTycZ/sGdgZDObYbz/EAMa7mT9EdB64X
	hX4rVmoX9mjZRMvb/GThdF+slqHcOstDxkNPBAw2h1O3ERCanNQ+jC5nErtUpTE5iriBqb6oLQi
	o74I5lag==
X-Received: by 2002:a05:690e:4004:b0:676:e85e:5ec with SMTP id
 956f58d0204a3-679ca93e9c2mr2047972d50.139.1792407988921; Mon, 19 Oct 2026
 04:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016162912.64581-1-lukapanio@gmail.com> <20261016162912.64581-3-lukapanio@gmail.com>
 <atX2Sf4GJNFYq2ZY@aspen.lan>
In-Reply-To: <atX2Sf4GJNFYq2ZY@aspen.lan>
From: Luka Panio <lukapanio@gmail.com>
Date: Mon, 19 Oct 2026 13:06:17 +0200
X-Gm-Features: AclHuK9BPbEV3xXNig3O4K-KotL1JMndrdN2hrEB4vNyiT7qjydGuoSSOSI_klY
Message-ID: <CACi=Ov4qxW_HmgcjRJLg3SWGKd2S+3rcevjpp8ELf6z7RBP3qw@mail.gmail.com>
Subject: Re: [PATCH 2/2] backlight: Add Awinic AW99703 backlight driver
To: Daniel Thompson <daniel@riscstar.com>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, pavel@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, deller@gmx.de, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Mon, Oct 19, 2026 at 12:51=E2=80=AFPM Daniel Thompson <daniel@riscstar.c=
om> wrote:
>
> On Fri, Oct 16, 2026 at 06:29:12PM +0200, Luka Panio wrote:
> > Add a driver for the Awinic AW99703 3-string WLED backlight controller.
> >
> > Register values follow the AW99703 datasheet (V1.6), the structure
> > follows the aw99706 driver.
>
> Given how much the structure follows the aw99706 driver I'd expect there
> to be more code sharing between the drivers.
>
> Cold AW99703 support be implemented by extending the existing aw99706
> driver?
Thanks for the review. The register maps differ completely (chip ID,
brightness split, enable bit, current range, boost options), but the
driver flow is the same, so I'll turn aw99706 into a per-chip-data
driver and add AW99703 support to it in v2.
>
>
> Daniel.

Thanks,
Luka
