Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1407935959
	for <linux-fbdev@vger.kernel.org>; Sun,  3 May 2026 05:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777787145; cv=pass; b=i/3uIlXzluT0tD8TLgHsy2Q+V9+3oNYaBBcfzAN20y2EtrJ7CslX//s/FR5gGPaUk/P7S1zts0aJHAnHzDj+2RlTxi9pdOH6D2QRgki8tafznV0s1qmcVnOIEZrCudYtClNF8ZU52jyIMxF9PV1eSG9gNVYDYQlikx0Dd9KIeto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777787145; c=relaxed/simple;
	bh=cdSC08rdbCXOt3d7rPSyTVJQtthpB+L8TV6kUCGh9Sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmH6RovTqVBVMyej+TQp3MGsuHbMMwNupu77G1w8gMxkE7z1p6nCR/zD7oDEBs+XnFtiPMnLpH7ghK70hzZbKpbsPLDEulPPyldnRUvMsgYMvTjZLTAR5438kPM1TEbbrBtfAy3MiFRlPOWQl4tCOqeBVrs7LBlHJsPKc3fdslA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jq/ExKwW; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jq/ExKwW"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8b4aeddfacaso30128556d6.0
        for <linux-fbdev@vger.kernel.org>; Sat, 02 May 2026 22:45:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777787143; cv=none;
        d=google.com; s=arc-20240605;
        b=QDym/7IE6/7AZTkLSh+D2XZW3BMBxGKkfubQ1UHSC6V5bboyCgIpkVtobsGtYyJ8eW
         nnPdb2JK/BobMXgiQ7xMqKJINgnj9KYRkc1XSTF+ZTHAC9oWqo9O5z16T+nFA+N3emEK
         se4rer/ePSnVkAtFThjDs57ik9tUkDkXt5pr/lc41FU9f5GECUI/PHDMwwnmbzNaDvfh
         lSvBnKhbm/3/jnXdlSvRs6qD6mQFihm1YBfONPEhXs1BgTlJO4OPIQa66CZ6ylVP2udE
         HkTWXlqpvSOPK1L+rfKMKMNTCqxWgxg2eJp4/61Gpc6+pDvAv8q5y9q9bFnD+AhT90SP
         e9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cdSC08rdbCXOt3d7rPSyTVJQtthpB+L8TV6kUCGh9Sk=;
        fh=wJq3I3Av2ZXblQ74GQnzrqs0wqaoc/UQaiu/lTGQ/6g=;
        b=E6FniDLfrm66L9bs44DynJ1g3e2gHtb/NtsjWan1elYQ7Gs/QuRYyl8eD+fptQZPAf
         8THGPY0SVasTjVgNoGtYD4+B1NzlQb0rPKnsNC7hR6JMnve9myNyDziCvYn/w+kE9i/j
         jEZa3h3fnJ2F8cxXvBYi2L7MzzMFZESidMGT25g5uihtqlTSX4mMHiGaegA4bgW6QnkI
         sOA964RA1qV0knIjEEMShhki6JrJYDCcaARa2V7LgzIJqP2GCAAQtV4/D5tA5X1NzNv5
         NGASdoDptngs2TRitB8wUgo5WJIwbQ0PXQNzalrBq2UHkFH+EQs8K/h1zp6P47yADbjm
         Z8oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777787143; x=1778391943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdSC08rdbCXOt3d7rPSyTVJQtthpB+L8TV6kUCGh9Sk=;
        b=Jq/ExKwWm70WqRbT3eDSH8qDHyBn63uxvKEpp/o5HDH/n9ENGhoDbOIF+LrgI6bB5G
         P81EdeN18QoNvRPOk6rNWj6AiTASPrvkTxgGrBOv2p4hnxAYO4mEAw6hN23LRTrElfj5
         JGJjXB0c8Q+80enawMmeNcQ8NqDC83A1lbAXJLRe+pqwnik/bFrzru2LuG9GPMVhfe+u
         bkx7n92O/JyVNnPU8BJWqn4FOTaozVg/IeudWk2QvkHjwvwgnrQm4DzdmVvUU0ivIOgX
         J0uxwjCotOueV7dEMAyVTCZyLolCqc8qUA7P+M5UediWvSm51VTR5E3l1PmtmWOact2I
         1I8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777787143; x=1778391943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cdSC08rdbCXOt3d7rPSyTVJQtthpB+L8TV6kUCGh9Sk=;
        b=is2Xb+QuFwILV14zcHmLmriaCI+Tn3fNWO8pB//YFCUJes/5rCK5y8iNincvRKOT9S
         u/Ei83+AltlaspRhShdGwDMvFe9eHyx3F416CbcyJPQTpKyz8sU16kT7XpH/uZljhHnC
         f2xp0mTGf4zkESeAFqtIbRSriFEX4DWePk2sxhkU86vkq0svY5GRh4MLNzc8VWFINwXZ
         kiqJRPfi0O/k3xuYN/a8PLi+9Ggxjgi5B339UTwwfmt+EynUgAKPOCYcW+6qa3DDda1U
         rhBQkF4Z497JlEJ40JWm8M+tfLjayQmxpam7F63mYw3pL/r70Xiw7gs/FOm6QdD+cJi1
         5VGQ==
X-Gm-Message-State: AOJu0YzJo0sNebvZDUQMbTWvME1EcdBzr18CzM2DgmN6WjsysuCID/wE
	/+sSk43sydshF1zvykI8lJ1r0BwiYpfJvTZaS6ZySsZKYfr+mh6tr9DVXsmj4mYNWy2XkttLWy9
	g1yQMCYDOIJ4rdVtVZSwr7lig3zlq0/zwE3NZ
X-Gm-Gg: AeBDiest4IVBq9amqkv/lXPtE1W1/t9VUOHSAXtovS/bIDEHrm3NKSnnMjn8hM/pgy4
	4GvXLXdKXBmeayiFGJQXh0MKnS26kFerfhhRVoQWkVQw+o4V7NkMZ61pIYeHMMA9f/PCyz2PCvw
	uq0lMW/8AVYrjFz7LGro982Mz16etEi0HmOmRIlTRQT0B3Ri+Pm7a5fp7F4iqlnjYBqDiKLNAoR
	NZZNEf2vR7yACXH9g07+YrETuLJuzlpmkHdwkNMKyfYVN4cICFM9Gh2lge5Wyajkavg88ARoFBa
	d88lLvzZPylR0K14VpQ53MZGdDm1bBPNOUlspykYm/JaKxnXXgbCpTpbdnWSOhqRaQOoH5Rp/0P
	9+S4=
X-Received: by 2002:a05:6214:e84:b0:89c:cfb1:b59c with SMTP id
 6a1803df08f44-8b667e6defcmr98464646d6.23.1777787141982; Sat, 02 May 2026
 22:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503045653.33522-1-enelsonmoore@gmail.com>
In-Reply-To: <20260503045653.33522-1-enelsonmoore@gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 2 May 2026 22:45:30 -0700
X-Gm-Features: AVHnY4KRqvnR0qoc7lxLs2WO7-KScXvDLxbq4exQrb_yKcbteiHK2bBazSJEqWM
Message-ID: <CADkSEUhJBAp=XK07vFkQdZAdPPe5PyRMpatgDvQofjXkXeOtvg@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: remove Hercules monochrome ISA graphics
 adapter driver
To: linux-fbdev@vger.kernel.org
Cc: Ferenc Bakonyi <fero@drama.obuda.kando.hu>, Helge Deller <deller@gmx.de>, 
	Jakub Kicinski <kuba@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Hisam Mehboob <hisamshar@gmail.com>, 
	=?UTF-8?Q?Martin_Kepplinger=2DNovakovi=C4=87?= <martink@posteo.de>, 
	Diego Viola <diego.viola@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Wei Liu <wei.liu@kernel.org>, Prasanna Kumar T S M <ptsm@linux.microsoft.com>, 
	robgithub <rob.github@jumpstation.co.uk>, Hardik Phalet <hardik.phalet@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 2, 2026 at 9:57=E2=80=AFPM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:
> The hgafb supports graphics adapters compatible with the Hercules

The hgafb *driver*, of course. Oops. Would whoever merges this please
fix that up?

Ethan
