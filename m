Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD953332EBE
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Jan 2026 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769428017; cv=pass; b=VSni1rGpilKidp5gWjWW1ZYU/FM4Hx4zWFFjcFHean4js0rb1HtMn8eMUJSssra+u9vKM26HFKFjKwQc1cwrdoACxK6zPHz2/hchbCIOklMCo1oHmyoWGI97YEjpPklRp4UI0fXOaur7tNsKt29wGjbDqGx04rhQtzofFNwH7ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769428017; c=relaxed/simple;
	bh=/zv7gs+xuWWvjZkXv13V1WD+hmcrWHWguoqewcwWQiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkZ/sxKmc09NZoejGPVPrNs8sZJTAABbvUAm5C/Jbp5e/D7jydOcLj2CP1ctRvRY5HsFFVm09qt380aVhrJfG4Jw9HUq9ELsEgNrcNwfwgWTCcNRWF3oLJpcnZaSgimh+MxJoEXx66GtgRGbnAngtLymYR7VS5lHwMMuGHNrT0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2ZO/sIQ; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2ZO/sIQ"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b7063004daso238593eec.0
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Jan 2026 03:46:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769428015; cv=none;
        d=google.com; s=arc-20240605;
        b=WYXcN9PLZ3mDATIcdTYXtwBfWfUIAIFQTD3zMGLeQhVfTgsB/IxJyarV5DZ/4vgWHM
         ELVi/Bvy7UujjZC64ZqedfvZFxxwcmM/hldA8yeIn7jWGvL4Fe2Osde/0DJzPsj0OyCo
         Db2VxOoc4OKQJEkU0m3aOOfx/Z4gHnP7JmpFeBgieWmOxrbsmeWek8EkQYLoOcp16VTB
         uJs3wLCzOZ32+U9Kn6Z8/TajjXC0/TLh1cUcAoLCkkcpiPhLkey+sUFsrpP1RSwoQx19
         wLRQhe2qZF6/eD4NF7eAv7RTMjrH5IQ/jaN85Gkmqm+rnsCYoidy07yx+/TD1QLOVkQt
         BZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o3x62Qf9dAWX541AJwNkvWxUTiuyvytUehddtIPb4VY=;
        fh=v75iKeLxO3YbYTBSzmwxTRQLjxEJCSGz26EXDcmA5Yo=;
        b=gOsO06wjHUxYKBynPModbKrZGvGcqSol1sflgdKeRjih7iKlhqnLcqUVLaMA9USKay
         EdGNJF2uI0yerKBOKpzyoMkLfmg/HjvtnAl8tYRHNo6DqL8A0XYsFhNgbmQ9k6gH6db3
         aA0JhI6UqmMyeSzoHgaa4FrSwees+z/4Xx1eJFUzBqcmS1K7vFynSxDPMqO8a05f7VQV
         pi2A8AoFJ7DGBSkyDYBgVEVrOtn+FHYn8t0B/bajcEHiuOZ4nypNUVFhiugdQJNG7X7L
         RmvT1H1/kV9WGFdjcK2lJB46fTjvdCSdCY1ImZQLlDX6X6TGDi2rTb+YGX726Q6IGZf6
         grNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769428015; x=1770032815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3x62Qf9dAWX541AJwNkvWxUTiuyvytUehddtIPb4VY=;
        b=V2ZO/sIQjJ4L2oZR+dghvNVbk/Dt7wH4ewvltflQba+jTQSsYh/JSz4lRj0dmAi+3x
         UYR8IdKgkVFnjXVSw52MlLc6iJldABmHSx5D+DfMi9GqaF6XzHf8i/BtBBMZ+TtLA392
         lUOzd+kj5apKiXtgej37UKkuhrmoMn7IWTQxu/ZjUUVaznxkQKFAKC4w9w8GID7uapp+
         AVBGuL62FOlj5WjiWSj+qMEBdVz2gOzjF1nT0XrAFxf0/btXwpVug9JoMbFJtpT2RHGw
         PGBCKxqstBXIvWlAsvW//liBU59HlGUlo2HkcEx+e4zXROX+DxCcNXHHFQ26aCyv8umd
         gN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769428015; x=1770032815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o3x62Qf9dAWX541AJwNkvWxUTiuyvytUehddtIPb4VY=;
        b=sMVWRAktnMo8l1apoz6e9u3TDHygPsNAUf9jcvz7ar/gLlBwGolcShsCt4XvIqrmu5
         jJ6z63wfar6cQXGHDHemDM5RzGgKduwlM4I5bCeNC686W1boLxXaT1rAQK6Ihl1UCQXF
         zkG7Fc3rMg4HfXBPUsjx4aJEajQrUrvZmu7LfTcMdq5n+vC9RE9tSjGOWwyebWKpaqzY
         DH1DlcFiE84PTlv0YDc4fkOo4f/YCuvsUDKKppykxtdKOiKX8vM6ikhGEk33dcdhDX8s
         cPAbGuWFIJJJrX2uYjQ/0/XMu4HHHUHO1lROkgXM+T+6yMXSZTMwUu24U05L0VFawfBH
         696w==
X-Forwarded-Encrypted: i=1; AJvYcCV+cutfOOjjUj/GseJniebcmh+XuTBRL7gyLKQ47yXmaoYUOEE1oq5+SMPNlbCTNMVIqKHSU4OMHETN0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzauBaLwnR3AuQpU4wEqhXrNB+NtxAh4v0kKG+6HszSxARCS2yG
	iLus3SLgOA9EKG5ZP9m5W7z3nbKuyF6XMFhB7EEUAPbSKfgNwjfFSmaQMIXNbte3RcUycIYQmYy
	h2vBH2tZI1ZhBLNdGXUYUTn3idtrPtaQ=
X-Gm-Gg: AZuq6aIofH6fHlsDXuhsdGQz702oaE+nts39HitVj+Ba4pOUNaZwpvKQXXYTovU2J7E
	P5GUj88DbA0oYJWkKILbA0X/CHgEN1CqoHL9utbZgck3AfygfFuU5qw9schYlKNFATNZeDrNopG
	edDb8UnPsI/JtlTUSsq4AOFWeUaiNYpyujQcurERbY1AVmXGWmBJ37XTVv7AtL6502EEjKy7zcv
	NQgipyULGnO5cHkfNZz8FIFid/Ma6WOEsN4Ko9mq0kAiislXI3HgGauRuJSj2QBtoIpgG/GBgNE
	bhJKGxyeYBJYH2Sg8mKLhTB6PmDKu3w0YnIGpgbNbf1KXmmQUT+HNKYAPO2ViVsgFapqMlA8bsF
	8zFQvP6UCmx/5dx0JGtV0RMk=
X-Received: by 2002:a05:7301:1f14:b0:2b7:3835:21f0 with SMTP id
 5a478bee46e88-2b76420a89amr1152037eec.2.1769428014494; Mon, 26 Jan 2026
 03:46:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126081744.781392-1-pengfuyuan@kylinos.cn>
 <ed48e82a-cb94-477f-83c4-b2d87ae3cde6@suse.de> <DFYG7MT5JINY.1T8ZZ4ASIWXU@nvidia.com>
In-Reply-To: <DFYG7MT5JINY.1T8ZZ4ASIWXU@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 Jan 2026 12:46:41 +0100
X-Gm-Features: AZwV_QiVehF8RRi7itklBIsdJdhL1p075lkEaX9CIFh4ljGe-kX6fmrMO2Whn90
Message-ID: <CANiq72kRhkLKcc279CacJ8CnQ18JEZ4A9-vkcg_k4Jw88O4EDw@mail.gmail.com>
Subject: Re: [PATCH v1 v1 0/4] [RUST] Framebuffer driver support
To: Alexandre Courbot <acourbot@nvidia.com>, pengfuyuan <pengfuyuan@kylinos.cn>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Danilo Krummrich <dakr@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Hans de Goede <hansg@kernel.org>, Lee Jones <lee@kernel.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Zsolt Kajtar <soci@c64.rulez.org>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 11:28=E2=80=AFAM Alexandre Courbot <acourbot@nvidia=
.com> wrote:
>
> This, and the patchset is also obviously AI-generated.

pengfuyuan: the generated content guidelines I mentioned earlier this
month in another of your patches have been merged now, please read:

    https://docs.kernel.org/next/process/generated-content.html

Thanks!

Cheers,
Miguel
