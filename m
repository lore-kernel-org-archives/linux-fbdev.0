Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642838;
	b=n68DSSL4pxRWUEnlSHAL0P5nxSTZE2y5ioNs2iLvUZiBncc57ajfEGZKf4qxjvliz4Ft
	 ZhE8kiVZwYVMBKNLfKcXKmGS98BGvxtnRd4BABG4aGnIxo1peUHZOGa7UgMk6Z6fF0OGD
	 rzwB6DNAN3EZ0Wp/NCE+fohjzdqCj0S/0T835hrMyXkAU9JWV0v7nLiBdVt427CghKCHe
	 0VoRYEMZlcouw60a3YumLmaalvJXXwa1nJ2AQGKAHIy/NAlPJv7FN6gEAV+CcpsukL+W7
	 OyIKz5CQcaNW6yGm7/2YpJofh5j0fNESVuXUAitjFmeW/1fcmQ2SmfpDTRv3/PAkgMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
	b=ZcqVixpBu9kU6mkoSrlszPllxZEvwXHdFfCxbp/Sf+r5It90bcV7zdZ6RNSXJ5rdJw17
	 XBf5YY3BScs1PL/ps/ZYQYdKvauD292s3nnJFIZ4WcvDIDvwBTHkLe55c3m/Dp/l4CmPS
	 SPIATJhVZQ2OLamWXb3tdx8YsB1AVBKgY1TOL2M1mJat13m7gLqPfL/T8JtRfhPhmxfF0
	 aPZSeZnVhatqgYbuZVaYAcLnMW6kGhcgAeeYTGh+AaDMLUkZfZbLHJFOrpOnGPmuKIBSb
	 3KyNJt+fP3YPz2r2qrqFl/lRA3JwbJn8lgRaWu1xnGFKJIoPzXX53gtodIHChFT0ReQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=H+CzZMUv;
	arc=none smtp.remote-ip=209.85.208.175
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1849A606A324
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Nov 2026 18:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1849A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=H+CzZMUv
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ab3b29a210so35860821fa.0
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Nov 2026 10:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793642836; x=1794247636; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=H+CzZMUvn2qC9TmXRv7XlRuuKjtaf8JVhBSz4IvSEAj5/uP4mdnRN8vzL/JllF4NSL
         N9JAzuk1m69I1F/cun92w5xFfSXtJUyj+SZj6UT3Vm6uMcHsjJnTn1oqU1XKxV5E2Xhu
         eyS0I857ADvCugZ+vJuPVHG8CI/qhalT5oeAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642836; x=1794247636;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=maxy3zGBYBpXPsMfRugfmMdDjSFmN8BgaopHf+0SpvooCX8y0uur8XhhimqU1sTo5c
         ddieYfuDekoVo0mJR+09nD8/kfJuqiRjJWL+kXZ1qspF6uJ2ySaWn/JqcCtJxpn+q1K5
         nEUqbAF3WLcLMSOz3FitVZGyiAIsr/c3Qs1n3yw1KJZovi8255clgjtCtn/Y1Ht1BmJN
         Hrxb5NfHR2Jo1l5uKpf/p4S9kzqADUX3IpE3sdtJ+zqnKLjLm85Qn4/GHjHxkT9hMfCU
         ROsGpHdBNbnwfzk6q6+ThH+bqisjHUFPFMkNm8hhMYQ67w3PuckcB03vB0HX7mqFX1TN
         iTCw==
X-Forwarded-Encrypted: i=1; AKwUvBwph9f2Gi1mETnyRsaannPt/45p+/DpQFrnkGfknZJRYDpBgecks+G6azyy1Cyoie7qrXFHUjzUJuf+cQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/4FqhClZmn3mgOMwzIZxwqIvFj8n49RYabX1NRZM5PJzCIFwap
	F6Yq+hF4i2WtonNrB5YCOMD3eDkWZMCRU/TT7jRIx1U0C20ef2St9ZV+WuHaK50ZMNqw7CCfXMo
	5NIEq/HEJtg==
X-Gm-Gg: AYBFou1F3dapqFyPLS3XKrzkhkrdmDGrCgzMQ6jySbO9vI4ew1OkKT2TCqeR1YS4bqV
	mklPH8+LEZtrnzORApe9Q2FXHwWgglnoN30E65ChBY1wimYcNyQruEQeNbEMi0yHtruzx8NGRrr
	WQDBnPL2Guq9EQeOqoxGiOEvVli/lxMKMWe/HDFvfeb3R8LQusHC30VqAvnOG0EBQkLY+S5i+Se
	7gYcIi7tS2/8dHaqDrBLKVSkul4UaFwfNMQ3tIUUKg7oEvWiMzxwxoASvhwM/tEz2jQ+FP5AM9r
	sU8baIBZln6+++/byNKSyJtbH3oKk1J4omB50uBHrL44XhO5pjphqy8Ziyc0txcPFc1foxRVLlm
	XgMsJFAjQa1A0ju1YCsRivh3iZ2cejtMy5NmfDqroJg9Flgqa6O+ZR4r0TiK11W/gnkM7bglZdt
	JCSzfu1GWAkZuzYCRlqyxTqohYFflDRKh0tewylDDDsphGBxkEu7vVBLjnSmxtMJ0eegVTEjNmK
	/IuxiRdyEjWdk6qg2uFwOmRCE9+sXmqiOT8mITkHiTemJyQUUXSXNmezudPIbnePoXyTRwcEsGE
	/VGPXv6WsfGeH6Or42C0Vkgyeeq8aOxAT6P4+/K6S/dPzsmFmAWEPy44jEPet7DEI1r7eKfiNb8
	ilw==
X-Received: by 2002:a2e:a553:0:b0:3a9:8775:5f11 with SMTP id 38308e7fff4ca-3aca57a55e9mr32700781fa.4.1793642836164;
        Mon, 02 Nov 2026 10:07:16 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acd5c41bd5sm962281fa.28.2026.11.02.10.07.15
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 10:07:15 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bcb440d1cbso2156925e87.1
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Nov 2026 10:07:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByG2UcbaCySIoYPTmJwN6vUGQ1FW3M8bDePxtqOjoGbtt5sR+AjFXNlY0WWwynw+h5sPByitITTchS3jA==@vger.kernel.org
X-Received: by 2002:a17:907:d94:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c4ca7426f6emr874452266b.0.1793642348398; Mon, 02 Nov 2026
 09:59:08 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org> <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Nov 2026 09:58:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
X-Gm-Features: AclHuK_qZTBVsLQIdymgRHScSFenC6XsGggUDmcuOugjrSTbuVkeASUmC_hYPZo
Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/38] PCI/proc: don't truncate the position of config
 space accesses
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
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
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 06:22, Christian Brauner <brauner@kernel.org> wrote:
>
> proc_bus_pci_write() truncates the file position to an int. A pwrite()
> at an offset like 0xfffff000 turns it negative [..]

I think this would actually be better with rw_verify_area() just
checking a per-file maxbytes.

We already have that logic for lseek and friends - using that fairly
hacky combination of s_maxbytes and !unsigned_offsets().

We should combine s_maxbytes and unsigned_offsets() at file open time
into f_maxbytes and check that not just at lseek but in
rw_verify_area.

And then things like proc_bus_pci could set it's size limit in one single place.

Hmm?

                   Linus
