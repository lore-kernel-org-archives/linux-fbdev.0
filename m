Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748481C84B1;
	Sat,  5 Apr 2025 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743853387; cv=none; b=oNW1JfOOdaTa+zJQ/GdIvuosxQ3UZMow2jxNRkoJYpyOl1Vx92RsTRm5oBnzT7901ol9XVbEG/CCSD9YUSxpoKOs7XK7+JIK7Y074BIV3DqNm/i5G13TrSP8j97Qm5PocQQ08CApot4CYFwjm8Kf4hA2XXk4NIiWDQ5M/egVQOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743853387; c=relaxed/simple;
	bh=IeHWiIJlta9V/CcKkQRliZD2ZLDbrn5xIAUOm4xlQVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCqRLM15DqDMw+22gxWZcADKMmIurwEiqgegMNyyh7HrLTJLIhmMyhtHDxaU9pCnku6gTv833taWvJRYuudRF1rNM+hTA7S3/U3yAfRIZzBwub4Li4Mp7AqQ4wV5GfgpUaC0FxkTO/o0eHPCRBghapNQQjG6kezey0GMjrRXkKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fv/saHJr; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fv/saHJr"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so4496509a12.2;
        Sat, 05 Apr 2025 04:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743853384; x=1744458184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAQCxkgn54QHpXGK+XuJQEXzbLMiEpvUoIf5Iinc0gE=;
        b=Fv/saHJrjyX3cexJlO0aOUuZfmdZlkeQIJfN0r5C7hSKeU7rNWu4qdXWM77i0z+R8L
         kT3cOA8q9v2f8W38GU0wqPOveIv11EFC2Ll+6j/LpF/KueOuss5135HIVt7D5tWUdkFA
         HVqE6v68itnIK0tt3PAmxm0iEGAKv5RQqiocnJ+hLZ/AZbcW26yuzAVRHfDqMojf9mc7
         mfobIu3agnQb5zXbXL6XuwBvC4tPuUzVgtVkdg2AkCfys9VMNM7FuNGB/X1k3tcRLxIe
         sxPiqhu/JyOrgn3QtxuT1H0xMRhIDr3QruqnOz2qRSWn7ShgI8Qo6BscfnDiiI1TMT+E
         FdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743853384; x=1744458184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAQCxkgn54QHpXGK+XuJQEXzbLMiEpvUoIf5Iinc0gE=;
        b=aimd3G+lvH1NUd19ZBl5jfXnx7VrUU6ApMyb9zdp9DXZxHO1+PHYjTH/q1nW9ThfaJ
         th9xH97JV9GJ2cqVO7UX+7LyDWtmK70s98G8ggfEDkoBKgQgzbgMslDjT9dTFe3foOam
         y2DwQvhRCr1Qv7Af1LaJRTvA39v2brrm5tsOqXeXIYjNRn3jRYDGVlIB2qtSlp3K5bnp
         Sgq7dg2gG7jk7y0uOMsuZKhZmnCe/rv9BStbhmmBQr5UZF/P4k31qXjNmyRCcqYu2I6m
         JYxhwumIvx1rxay7f02UjA5jjRonrOY96Dqf4joFCvrZZN1pIh/YCuwQajLNzq1T8uGZ
         hNZg==
X-Forwarded-Encrypted: i=1; AJvYcCVXqPMZKxLjD3swwCmWXN3Y4Jl5z/d5TBElUL/uUgwk4/N6Zbe/8HauA3k82CQafantqVO6okJk158XFA==@vger.kernel.org, AJvYcCWNdSsF8eQWMT5P8lC/8gvz0UHzcZspAbEf0IXqgpK2Ss0o2A/epD6fvONBmJsyPQaAxbDV1Mb4GSmLPUjU@vger.kernel.org
X-Gm-Message-State: AOJu0YzaZMw9USU7a7wgQtkVrXplYBgCDichpmeiqRArxwhF+eEkBMU2
	YZ2Qv+5yiG5Gv3dJzQFYbRucn1yHxzY48tTSP25khGhqJ5Gz4Es+R9f7B13T7HTBlxddYBTv8wX
	q/iYvJdGL7lPM057sOQUYb8BXf9o=
X-Gm-Gg: ASbGncvQcRYOwzAf6mJFBUt6Kn36oVuboinviR/KsOSeKRxqZHAZMADQ4Fz9erWnqfG
	e855OafqJdU0Uvz8YjufBl9SMjqMeLaE5Sz071iI4vz9GqD0w14EuFBLzezK7fd46eRa4Hr/014
	ko+szfRsPYzTod23iLY9SK8Cj21w==
X-Google-Smtp-Source: AGHT+IGR49Meudv61iYvBzrEPGWBseWjPkmDlmkAguahpWMV8F7NVB92wvM8pzyr8lhEzQ+Zp2Axv76kLM28VS0iFds=
X-Received: by 2002:a05:6402:350e:b0:5ec:9e9e:3c3 with SMTP id
 4fb4d7f45d1cf-5f0b5da703fmr3990871a12.6.1743853383704; Sat, 05 Apr 2025
 04:43:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67f0f9ff.df0a0220.33076c.f0e5@mx.google.com> <CAMyr_bJpE=NHi4bS=_eAWcm1gxKiKDA3YQ_mYRCDi3tjuBjknQ@mail.gmail.com>
 <2025040505-colonial-pencil-69b4@gregkh>
In-Reply-To: <2025040505-colonial-pencil-69b4@gregkh>
From: Richard Akintola <princerichard17a@gmail.com>
Date: Sat, 5 Apr 2025 12:42:35 +0100
X-Gm-Features: ATxdqUFvWlhgf0Awd-vyZfu_-zhGNfH85tFXXZeE6evOOSEAfi9M90Pk7W_DZtQ
Message-ID: <CAMyr_bKq9dnc2bzu=qq1pCsqkHwMxK+xLApbOy45MYtXLXnTBg@mail.gmail.com>
Subject: Re: [PATCH 1/8] staging: sm750fb: change sii164GetDeviceID to snake_case
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sudipm.mukherjee@gmail.com, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 5, 2025 at 12:06=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:

> All of these need to be linked together, you are sending them
> individually.  Please use a tool like 'git send-email' that does this
> automatically for you, because as-is, I can't take these, sorry.

Noted, would do just that.
Thanks.

Richard Akintola
