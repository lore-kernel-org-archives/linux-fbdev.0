Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.161.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792994014;
	b=QAAEj7WrDy16wAK/r11qF7txMqF9ybBOK2sjr/l82XfAelNct9EQSZlUKs0zbtTzX8lB
	 zo90a9EpP74e0+nun8VYVfg0hnSltWIJjMOqk4KGSHDWR4VyAab1M0vL4Egwo/c60IFcD
	 lTWuqUFbhqhZA6V75uY8SVHaHEbALcIQb+6hYH9e4z3DFfJ4sQCZSOzZa7h1ztJJoPA/d
	 BA+2Id5Dy0eH2Be1JLL6nj4hXf1owPLSvJmy0YeVXOLqJk6Rt/Md8h+jfCMHXRVXlvK4a
	 6yb52amyA7Yq5/bCkxUwnTsxkUvxLn3T0AROiLan5wZvppufPEwSmCJc/dkzZDQYqyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792994014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=c42lkr4if04AZ8UiQQ83ZlSvwlPXm235lZQS5qXaBN4=;
	b=hYbveyRZ6gZpDLNHlKFGqsPxAoboopCSitTbI6M/aZ/+oXidLjsPXKD2+blJYl7vdS6J
	 rPgG62aqy9s3JuQgAGrNNHClTEilNs2ylKRXYV6CVx3xjxNBNH7Z0ruiBboLDUcv2w/7E
	 CLzf9mUv7GPQuRypt3NMTHuaZnhWZDoq7FjjGjS5HzyQ7yz34XARh6p1PXqGbj917ucuI
	 Xx1zbUNW9DYWkiVZB/4ERE+oMYyDP6enfLTzr/mQXTXfMGFXv08OK7tTFN48U+icpfD7Q
	 LRodNmjL2wpzkqJ1FpMaJRU/U9lgeUjxbxnxqGOYtZ5gA4BH20ZgYo0Q7bVgxadQNYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QQnJ8DO9;
	arc=fail smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCD7606A31D
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 05:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DCD7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QQnJ8DO9
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6ddef424972so1497512eaf.3
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 22:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792994013; cv=none;
        d=google.com; s=arc-20260327;
        b=LQ1x9HrVpQIBRr0F12VEiy/w+rKz3+uAn2lbTnrdyhrs+G2AIWbEz/fDUare11ePsw
         vqDS5Ok6cjkpfvXl78sp9Al25GSAQi9pFvKQcF3xUnQiZo2fQ7pl+lGVt8avMJZQU6Xo
         QQ/Tg7ISvYLvDv2WnL5nOTDc1Y+fM68yfuONR5mWUlepRDCUBn9CSlWNrwr/q7HVxNTe
         p6wYpdQ0Z8h+ClfvYRGziAXN5NRCu/0KHV9QHf6F+WDiyLKmsH7p3IymZwl1fcNeGmMv
         wDle710oxxQjQPl+XxKV7g8ZPBIInUWgiMSciyS4qMK6B8jxtYJ6+XvRMHTdAJ3ktz7H
         c4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c42lkr4if04AZ8UiQQ83ZlSvwlPXm235lZQS5qXaBN4=;
        fh=V7DQP2d2AemcP0cAqVIaOCeaeOA7Qwqzj5L1moCqmuE=;
        b=TOSUndZyzgqZcT6CylIIRPpqGuX3QzPFSIOr2Z/G7rLxEdcZOM4x/NcK5mgXGD2mLy
         svo1nIb8JKV/EfFA1c4h27k4RImWnpN7PFFetjJfZlNVZtzhsgtSruxPASZyfrAWuiJq
         w3Q/l/Oc2yWvx1sSIRK0z7/SoG28eGZcHK5cw/3UKJ33WhQgvWDd28omLpOvix8Iw64V
         QfmbYG12oGfC2xIhI/QHmxSU1sQPnpGMbBXlhCnegQfU27qCZsnWJ2rYe/zzPNQWLUm7
         5MtGm8K3WVdxqaFc1rdQpNnUk1DjlnGpyjybnpk3/3YPuK4gWTltf0m5sz2b//N4sSxu
         8IcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792994013; x=1793598813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c42lkr4if04AZ8UiQQ83ZlSvwlPXm235lZQS5qXaBN4=;
        b=QQnJ8DO9EggQU3TMGFardjJ5uAX/vee/3ByHaeIbtYthr52YjYZ29z6ZP8jNCvLxoe
         AUlQ85YPlpt2zNV+EI6lug6IHgxmZbXX+GRZ/TyuOB5nXYbAFCJM6y1ogRNKRNKaOgP+
         ujDFsQJwkFVqSgRmpoQxzktgNGQybDgZ+YZgN5vCxpItTAUJzFGE0PO0whwF3fGKPKIW
         DHsvILV4AHXNd4mMdEH3CFQ8FphAPK/J++qaPAQ9zUjsKOO86PttAtjXrDc+mfdVgx1k
         kKvjnSLhck9aw+2BBk6pa8GShT6fPo8bzqOFIR4My6fRRhG+pEbZz0PE39F0Ot/+9ydg
         ZbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792994013; x=1793598813;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c42lkr4if04AZ8UiQQ83ZlSvwlPXm235lZQS5qXaBN4=;
        b=qG63DH9slc5VOi2yb6+Q0Vtu27YIKJGcHrUf8KyO6j5p9C8PmK4awsxCO+A9D5bSBE
         pDV9bb1Wdzm7v/fy4i8WF0qWLSdeBPg6uCdCD7Y0VJ1bSDaDNZPc/Qchr83pMSKFrNtj
         lPkMMVMCHGkLj3ZSXlcQjgjLH7IPimNOiIBB660vGYzLg59h8oeaHJKqwuQH/Nhvp63I
         OCD6H9hfG70k6WeeHW2I5N3cOPW++1u94D9hHYD5crDL1gGeCS22Znh0VpBswxqq75n6
         Hd3ZkO4G143wil5uU18hwz8iRABW3rmfDJkdu7+2Rutjp5VX6+Kka4smkgh2wsANc2I/
         8/RQ==
X-Forwarded-Encrypted: i=1; AKwUvByTjN6AnH0SixQ+C9UyJ5eBJpNStB+N1HxuRWrJaTOG22UUHH6ZmGnV2ce9I8UOFaNgM4kxllrRsKLyOA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKutEXSBeRAlpQKCZtcA517D7uNAYNgLyqCyTjviQ+vgPzCfly4
	08syF1PbZYGkShi66JLnwNjCl8nf7X6GkvRAOIs6MzNrGYOFBvp1iu64bADgMVcv60yKptOmCbR
	TpoJiZw4Rm3Tm6/lxiUE+O95JCpRcJEI=
X-Gm-Gg: AYBFou2DTPeTf2W+kKEVWTgn/GPfuf17ABRK+vJuNLHyDBCK2ZGmEu/ZvcU0r2Atgd2
	xALHl+mrGk9egfji2J/Wdy+RV+PXp6OK5F3rXbYpcmIqD+mxFk3/uwJTrBNb/JNX2TUiXbhu0I/
	wcM61MXVtmi5ChN0GT4l7ea/vX5jDjHZ/6/5iueBytDDRx4uwYvRMXOWvjerJdTitgoe70Wsqz8
	KNIP5eDmwaxGgUXGRQBFFB67ZwMQFBa6Rz8lGQzcK6IQQdzLGaOOYceEKoeAW1Q/WKcseHKXR3r
	5zHAUYE3GftoAxGqRJIhTP4sEmt9GBVS4e4UfVSJkBNE6uCE+dZSrtMAAIVcm6+zqV0u5vEhc1F
	LA9/iRc2d66r2yY4iRurGjq2gcHL2seY+JlbaW/bJjrlLDlSv9rXFIGgT9uRKvcLEUPQJYJM=
X-Received: by 2002:a05:6820:f012:b0:6d9:779e:4f78 with SMTP id
 006d021491bc7-70ba0b69198mr2999266eaf.9.1792994013424; Sun, 25 Oct 2026
 22:53:33 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025164003.143864-1-himanshu.bakshi478@gmail.com> <at7pu4hldDTgZtXy@stanley.mountain>
In-Reply-To: <at7pu4hldDTgZtXy@stanley.mountain>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Mon, 26 Oct 2026 11:23:21 +0530
X-Gm-Features: AclHuK9kT-5mgEdeGVApWUOJUbhIUBpwPQFl-e5bzcx7W80tdoK-Z_OClF0xJzE
Message-ID: <CAGLmz9JaXM8s4BHQ2Cn5QQdBZpzDXmHyb-GQ_jXtj4Rz6SJOJQ@mail.gmail.com>
Subject: Re: [PATCH v2] staging: fbtft: Fix line length warning
To: Dan Carpenter <error27@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan and Andy,

I have sent over the comment on the v1 message chain and
also sent over the revised patch separately as v2, I will be glad
if you will go through it.

Thanks and regards,
Himanshu Bakshi

On Mon, Oct 26, 2026 at 11:18=E2=80=AFAM Dan Carpenter <error27@gmail.com> =
wrote:
>
> On Sun, Oct 25, 2026 at 10:10:03PM +0530, himanshu bakshi wrote:
> > From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> >
> > Hi Andy,
> >
>
> We don't need this in a commit message.
>
> Also I would prefer to delete these weirdo debug messages.  The
> normal dev_dbg() messages are good enough.  Plus, is this even
> used?
>
> regards,
> dan carpenter
>
