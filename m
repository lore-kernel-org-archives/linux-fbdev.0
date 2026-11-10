Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273763;
	b=EHYT9bBovQ7dWlq7eTYS63XbvG6JuLpq1kC3VwqEJtF7IEjzjMgWe3Sz8Lu+kF+AHY2O
	 bwDD6LeifgxhNfwHhLvZhF+04PZGNX1LqrV9QMLIL34nSuWghERk1t7PuHN4znWNeniIQ
	 IxHjsaN3GjBCLz/UCd62yJG3pT0Y6Ku6yCgKjX1eM6u8pbYvOcc9eb93X6jPK0RltU54m
	 Qc3I8sW/OZaLi/U+bGCL7lizwhbir/KHy/ec03m1nVBI34Gxe7SEq76tJ/Ud3pIYdzPvv
	 kQKbhyQJBbccgf7kgmxeDWKFfSE/ltdaaZtQAmtAHafbzA+ldAnxd3ri+bcX1bihDZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
	b=TIEOVtMGINgWq/ZixzL1z0sM0fEGG71kkMdqcDrx60U0BrUWO7v/1qAEzRpGjKKb701y
	 HYQN1B9pUpGCAIakIsSL39G1geEiszUgDsZkKP7QwayShBPP/RCAoyOCNwijhRkbvunEY
	 +pDGQFNyUqXxmBvRbdci9rHmDglfYnV2idYZzCFTcPQKhnzVIa8tFl6IIzyppy7NGFJB8
	 vxf37rS1LIG/GZ0N8yNageU7uBMNYJhV6GPoo/Mi8l+1z16ww7410MPJ8eLjhhRBV1O7l
	 WMcLnDs012jsB7Y/th9biqR53GoLoTtAb7gzaTY/Li0XGWhaHRmbd34Sg1XTEecyY4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Ou4cAn8l;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E116606A338
	for <linux-fbdev@vger.kernel.org>; Tue, 10 Nov 2026 01:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E116606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Ou4cAn8l
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c450ab1483cso245944566b.3
        for <linux-fbdev@vger.kernel.org>; Mon, 09 Nov 2026 17:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794273761; x=1794878561; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=Ou4cAn8lRLuj9v+zYDHMdqsUwHcN48aTRoCNIMr8PcXBBgKQMuS4AOLP07BwRN9cMM
         1cBTUEJz/CP3eHTezyzBkmW1elA8+3kNmZQwES6tVTS91II2MeuG9uKyJTO1ygoh5nV7
         jvNUu40sVdZxFc93mFYaxdaXwQR8YoTDQqZyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794273761; x=1794878561;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=LFCVjSAuBvVwZp0QAp8hLlMB35YukLrbCZQH2UC7kA680CwDhY0/0/tD0WqnU6aInJ
         A5TvvucL9W8jIx8djXkzp+8vWh1JPNsc4XWz6HsqF24yfY/EgSP9XMSIBUM37AIXPBcr
         lTk+zjubeEgSbaAK8JgLKLQSh5kFt6rPZd6ekISzVfeZ/kpjbNR8abIpVWTdd/4EKzOY
         iaqNtPWyCE09TSJ3oHYcREud3NSmjSRrCgPNeB0j6/sM9af8N8UD66Z4GsEuHls200jt
         fumbSIgFp4YD3xN1mxYnG+5XRrSpWKmGnD/qexHUJ1fTprUDyuENKm8yZypXCY9B/i3G
         kVNQ==
X-Forwarded-Encrypted: i=1; AL+hErH9xhpVNd7OCsmHl7E6no8QDl4kGa5S/stEuDaxM+fPS+pNV4n5Ut6Hd4qjvCJIWqnOTmAi5kgnZcxzrw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZUdV25P0MGNWNt31kAN3DLVW6MviY12/S9C/TankbrnuUW/0V
	6Kzr805+Z7pTM1DPDx2iOV6CCAkFHRLLUNO1pbyNuHm5wghHdUMDQua4Iz4sJDIk0K95ge+wXCV
	UJi+uw1pcvQ==
X-Gm-Gg: AYBFou3fh1sL/2VdzYwOSni1zDuCH+GZ09kAldCd+s3kL2UbK4DDWzG+Ycgdon385el
	3HYfvs8ZZRA0kz1dgsBcwZyuFLi6Nu1R9o+xI+GJVOTdu0Au5wsPpzjsyOiVaTheNTqpVY6+JAJ
	7dfGBRztsLV02qqPtv0zl13Sdl8+XlEKwxOsyWSE2Dl9BtJViQvd136dttizOBab2jPuUjp8eTA
	VYvmQwwzLFiExIVrwTWDepjfnefUdY7/V5aF9HUMmi8dWzS6sAUvISty/OehcjA9o+qKc4vCJii
	fYxnTE3srKOQY7qzAKzgLaXPQZs2jD3me0UtAXhntrxIbdrvuOV2l/EiDTdOlCGJBNm5jMjGD0x
	SsBYt+KKTqc4zFn0hnz9W/HHpigJsLEcv0sR6mZr6UbV6ZyBoReAcskQcCydY9BDz6tGWuJXzJ5
	XwyUV0w6DDtD9SpGuySq4dW7R/SPcnhxaQ2CxxP8gvU4s83ovq/lstolcZKvdVsIApu3iyhARHM
	VEBzY2R2kvxZ8+1rypejqEck0WdNN+haDB31XJMH6KprTK6t4ZvDovKjOoATuB+Bui8g9Jig7nl
	zt06vsu0r6/TbRFM/GbnCL0j6C1TmB6NJ0gmbNGiVSJZCe6ZDnPMf/5IbGF0U9zZ1JnuDGKgfat
	pUQ==
X-Received: by 2002:a17:907:9451:b0:c41:1750:59a2 with SMTP id a640c23a62f3a-c50495dfbd5mr88267466b.12.1794273761470;
        Mon, 09 Nov 2026 17:22:41 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5704aasm41581566b.25.2026.11.09.17.22.41
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 17:22:41 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c450ab1483cso245943466b.3
        for <linux-fbdev@vger.kernel.org>; Mon, 09 Nov 2026 17:22:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFEVNgg1L4YSsxzsNtbAduHVeB4EdVAfvwHsY5xGjkskh000JeS6inH0ZhHvxcCa0ffyPxNzsHTZOeMcA==@vger.kernel.org
X-Received: by 2002:a17:907:9451:b0:c41:1750:59a2 with SMTP id
 a640c23a62f3a-c50495dfbd5mr87253466b.12.1794273275844; Mon, 09 Nov 2026
 17:14:35 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
 <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
 <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner> <20261108185953.28054fb3@pumpkin>
 <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk> <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <20261109214558.0d9d5228@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Nov 2026 17:14:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
X-Gm-Features: AclHuK-x8jcOOQUqd2amGoGEAKER9jIFGaeL4LxxWAd0cGV7dz_RR64PtDogpPU
Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
To: David Laight <david.laight.linux@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Christian Brauner <brauner@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> Just that the cast would have to be:
>         u8 *foo = (u8 *)bar;
> where 'bar' is 'char *', and I don't think you need a cast there when
> char is unsigned.

.. and just to clarify: 'char' is always unsigned in the kernel on all
architectures since commit 3bc753c06dd0 ("kbuild: treat char as always
unsigned") back four years ago...

            Linus
