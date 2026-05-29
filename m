Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61823BF694
	for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053952; cv=pass; b=VBEBnMX1cgpKlNkd9Bs2mPfKUDMpDCWxbBu9GTbCzixVtdGNnDbiYn29FBUI5u6kRG9H82jQX61wquWdC8yEL5b/PrRkQDM3CNi1ZPaeeM/06aCZRQ6DcKFo0/477i9ao+SMqvwSner0SWRueTTWLmrHr6ffPinlEofIibk1lcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053952; c=relaxed/simple;
	bh=tyqn2TJnhheID9TGsq3UkYy69lM73UdL/LjKv+JJIrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUBHdQGVDrLtSXnNFVojYC7u+EmYehNaGZw2+WkdTWz3eOx5XHqDdjbqlOy+Cmt6AcKqtrriUagC+TGaJk+K1e+6BZ2nB75rPntLs73TyFuvggbM2X5nxmdUWhwIB4PMCr8bKkexEIGDH7TMRzIdR9rqaY19ZSZHZiIYN5ZyjaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5JwRtyv; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5JwRtyv"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bd85ebb368fso2052855266b.1
        for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 04:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780053949; cv=none;
        d=google.com; s=arc-20240605;
        b=NIwkxwCeeeet83NeQ/DpXaROMY/HnXFe+W2ZXU2Jbw1gCRQSXFKJplJwH1p3/I+75S
         +QcmpqQDFnaLxNDmeqyJ2VZSAo7LwPYFg/rK1FF8Dae3AVN1Kk/arCLioIX6FXYQExfT
         eWHKga/P12I1JunAzwl6QYo0IWBHp6qdDy1/Xe3l/tg68WlahDJ5bTnKm2WeESZhIBIJ
         vzyIEwg+17zsqhUo8Np94Vv3sYuVLjPTs60OwT0qX1MFF7HWmIWfgQjkDvO7ODmz7X7X
         xAhMguhyIMyz4lXOU8pdQtGaaokNfm6QaIm8Hd5827skZt/L5EOSOUOv94mHkXBxu3d4
         P9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cG6fNOfDYvWS7EdllG3W2X3vzmOug6Lzt00TaNQYnp0=;
        fh=NFpXV8kbvpxCBq2N9vTiA+YyFqEB2Fy/JP5hIi3OciQ=;
        b=QGZG5VccOWtWJGv6jCAhkx9Pg6o5Djp2U0SuEv4k0+gYdDyQf6AJL2VxnzaNZtlb2G
         +rDvkVM4zi4whqNTSFZXQtmQHFLLzxVpowgZM4VPdqUWCY9sP9Tv5iJnqqpH5LRmjH4H
         +cBhondqU27Gtm1NpvGlJLc1E7OeepttQeQCxisre9WgZKeNorjqNIxR/KHh63YPWcas
         KRu6Ajz6kzHccz+q+dVU9dXW+FmAWeSVuk3ocHz78mJl8VtkH28hXjMC4/V3RBl2IN+Z
         gPrewElTW3XCFT+KCG1HZUHwipyaW49NLk4LYpoBvX4U/XcgDnjBx6VSAWIjKF2Ge4yj
         a+CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780053949; x=1780658749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cG6fNOfDYvWS7EdllG3W2X3vzmOug6Lzt00TaNQYnp0=;
        b=h5JwRtyvs4t0rK/sr4IBOGdaWVtusf+JFlUk4BVJezpzrv9WorY9ej8NjW8DktwTLi
         Po6C2M77SvpwYvgNchFt0eV2gbcDGUwuNlZ3cmEsaOT8WCterYJTkc3WSvexU4Dllk+5
         b6EymAjDTEGsEG7qpvvVecgzTP6GZBsZzn2+JGCkWJfGE4J94xPjMuunVrvdASW+uji5
         aKOLt94XGL1d5NLGx2WNU755+kQd6f5ZcCLh5tBTXQ7e+RIQ57w29WZkfPDOq6pHPjD/
         n59YYpDq+mnxZZouf0fiXkzsp/eO8O+nKeKeAtWGy0sYIwaAW6TIZU883xkTy+r2mG5Z
         391Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053949; x=1780658749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cG6fNOfDYvWS7EdllG3W2X3vzmOug6Lzt00TaNQYnp0=;
        b=HsRh+YvCy6WJ+pShsIQIChSnORV7sg7YspkwakcW56L8UEmCph1Fr6TpJjhByjda9w
         OhFtlZ9qO19FvTjvwH87G27WlING2V1J5Nl7CAa1Y+d7ufXgq/03LYkllWi28scOSpZS
         O+pyKBk08ub39AUYUZE80faDi+Dg2bzAEwyUlwdm36Ei1Ev0lAcGBMqIp8gG9Nu273eT
         kF3WKRhxLw1YmNufWgg3dLRUki4YOxXK2oAtl0/AKR+XLeNPr4UhmoBWE4xSQaZlBc7S
         vpy04PY9mjqT+Cryd38AbOWVaaqpYc7r+S95t1uLHB0VuQGB808J7mqcoTx5Mb3VWrLJ
         G6cg==
X-Forwarded-Encrypted: i=1; AFNElJ/JOkEh4NxVKccMTZykRWhSaNqS3xlHYrmTwXAXACfJT96hm2lVHL/bw2TXSO/X3T0Zpn0RJL1xfmPVDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMY3PQreHXiv0jM7YSAKBG69hFTQhPC8VDYSLpOTxfyZzVgKXt
	xWo8V2fyi+QlCtLKNJeKk0+9WzOju3AYIHt9skgG6m0sVYHgU96PkRzPhTEtsDCFPD+Gi1W/jsl
	ezKKeB43jukZ40E1vvsRAHdfFfwQRo1Y=
X-Gm-Gg: Acq92OEqUG4vI/JorQJpZmhcghbEaie5QyguQK7nN5HG10R+i+Uht5SQW2az7VCIWAH
	bi8Re+UpMiaHowou1BgLNPqqtXGiwySLGvf3DZIwsZ2TeNRGpXh0y2jxomeL2mXqs2S63/y59A3
	Zo20SXAM9/od4VLLrT/GIDSjcvyzBSGgAaBPc8W3hDzVKjVjJ877PPUNXZ5BFaBz+6nqsdKJUdo
	0urwdM+z0wPt/VFTXzih7OcyFS9rq55csI8nALDHJteRYqFP6AzOJ72f6IWSBIbSvNwAHLsHoeP
	sF9GDxVcs1ojQWSqPJXtazb1Qj86y7y0QAwo6Tq0sZZRLdS4nzj6JMrEc7yG
X-Received: by 2002:a17:907:a0d3:b0:bdd:90b8:e39d with SMTP id
 a640c23a62f3a-be9c8e629a9mr130627866b.8.1780053949072; Fri, 29 May 2026
 04:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahlXYIqzu4O5-u9J@stanley.mountain> <20260529101242.10189-1-neharora23587@gmail.com>
 <ahlszyY6Nd9ANz-X@stanley.mountain>
In-Reply-To: <ahlszyY6Nd9ANz-X@stanley.mountain>
From: neha arora <neharora23587@gmail.com>
Date: Fri, 29 May 2026 16:55:35 +0530
X-Gm-Features: AVHnY4JAyhUqKSCPhpw74ET3c-2bMb-3AMQcUCC_hgyap9vwciL2wDwwedMwBIQ
Message-ID: <CAOWJOpuS7poyE_cDB1xa_te_B_fT2+7zEJwv8hnM_UT1hH8fAw@mail.gmail.com>
Subject: Re: [PATCH v2] staging: sm750fb: remove unused variable
To: Dan Carpenter <error27@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

After looking into the structural dependencies and the cross-casting
between init_status and initchip_param, I've decided that this
refactoring is outside the scope of what I want to work on at this
time.
Please feel free to drop my previous patch. I'm going to shift my
focus to other areas.

Regards,
Onish


On Fri, May 29, 2026 at 4:09=E2=80=AFPM Dan Carpenter <error27@gmail.com> w=
rote:
>
> On Fri, May 29, 2026 at 03:42:42PM +0530, Onish Sharma wrote:
> > Remove the set_all_eng_off flag and its associated cleanup logic.
> > The variable is redundant as the hardware should be initialized to a
> > known state regardless of prior usage.
> >
> > Suggested-by: Dan Carpenter <error27@gmail.com>
> > Signed-off-by: Onish Sharma <neharora23587@gmail.com>
> > ---
>
> Sorry, miscommunication.  This breaks the driver.  This is also a bit
> more involved than I thought...
>
> There are two structs:
>
> struct init_status {
>         ushort power_mode;
>         /* below three clocks are in unit of MHZ*/
>         ushort chip_clk;
>         ushort mem_clk;
>         ushort master_clk;
>         ushort setAllEngOff;
>         ushort reset_memory;
> };
>
> And struct initchip_param.  The initchip_param is exactly the same but
> with all the struct members renamed and comments added.  They have to
> match because we cast back and forth.
>
> Why do we have two different struct that have to be the same?  You might
> think it is for API, but as near as I can see that is not the case.
> Maybe it was at some point?  We should get rid of one struct.  Which
> everyone is API is the one we should keep.  If neither is API then get
> rid of init_status and keep initchip_param.
>
> After that we can talk about getting rid of setAllEngOff/set_all_eng_off.
>
> regards,
> dan carpenter
>
