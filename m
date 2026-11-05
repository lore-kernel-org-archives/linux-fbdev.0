Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872875;
	b=ZumGRzAs0ryqBVV0Vh10ISEA8I5DzInQwycvGadQiKXzhe2Q+NuXRL0i5kTbK2VO990A
	 8uALYfMxfRZ3g6juLiHDmXJo5WIuJxkhdwtjWO+XOP1OQl6vNFjIbLfajijSMhno0UvTK
	 X0jRAHlCGT22kPXTImydtCkA6nh7xlYxeovlk5YxH85JnC6cgWgEU4cxUOBZf+COOzjjK
	 6arBYisc1v9DaF+owlUQKrth0mawYy+053tFQT+iACJT2fzhz2BkVx6lW/rdMqbpMrMuR
	 oCVtQdqD9BGX7n6cB8+uFgT1naIIk6HxDZDzr/mujKmg8BR1CBp3oXADtZUurqxDTmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872875;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
	b=vMPuD2EiVZe5rP641KoiDGlrHY+/x75/hgj+dmKX+McmCHTaWCX4fQTkGl/a4o3Mtap+
	 SGGkDvTvrd3It3oeBr9iNv2HfZ0Ih9SE/M7dQTH3AU+WD6Sbu9LYhlhLQzhaf6M+Q/w56
	 pBD+efu/JWTFGV9Hau1kBfLxsFbgxu+8N+aF1D9MuEgxc0TuBFrKAuIBAi13npdUAFQEI
	 dNaQZenQNCrckbvh/eiWbXAyC7xslSrZXPZgUcZVb4b+3K9Qyljadpat24BlTc4s6Gp2l
	 fER06hMoxYmRQKr2QslXhTnW1/6PmiziihDFv/Z2b5y7R9ea+CtbfC/D0HOHOySXt9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890CC606A328
	for <linux-fbdev@vger.kernel.org>; Thu,  5 Nov 2026 10:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 890CC606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53653e30353so22046191cf.2
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Nov 2026 02:01:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872874; x=1794477674;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
        b=a8JKwuGjsgQvlVnWrlwGDHuGopcqIiT+tw7u3kxxD+ia1yXBNRvGre9NoalZVFZgx5
         NvBMKvosBB0chCGBSzniJiz4sK9ZGOtKI08BUYVYpnaaxAD/5Gf7jCvI731Fqji4BuO6
         F6FGeQZNP4BtkFKJqjyf8qvNnppfcnxq+SzhTHvVfdJ5bGPFtZfqBsavw9EI55R0+TsB
         RNl0iVg9opFbjhtitfiTT1OzHPHWOHpV8Ii/XIqdCUq1WWOz8nfjdmZ3xmwMCGiM1K14
         b6W+EssI1APUDWvLz01+kDCJoVfCZ300IsCY1bz68nszzMmtJGL6H+XfAM5t7mmuNOoe
         +GMA==
X-Forwarded-Encrypted: i=1; AKwUvBz/zKMHbL09sD6IA+iAv/JyvhX370RHALYc3v/KYAisXyDPuX67fD7Xz58d3GWH06/AibZHDTaM6gJEuA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8L8jPULbXmwbENiCpDwavaZ7MGHW1NFM4WUEeWNVXP6yHiUSMn
	2UzS3CrNChOP1+IRw5psIrMYPS6spTc27N844aOHx3jw4JmkA3QPMj0Y7Qo0Vo2Wkjs=
X-Gm-Gg: AYBFou2EehIPHkvDT0tijHlRL6o2i9xc4Cixd1x1GOmU+lo7HNI+Hnt23KDa68CJ0tm
	Pduk59ieCd4qleJtGmKQ5r1BBZMGf3LZKW/M29cvUWxgoSY1jwJDofqFlrC2AM7K/4OlicOtRm5
	jT7zQyHN97GNaODENmDDEDBANVQrqUOR1AKXz0RPmw6Rg5gzOmYeriU2MOLcQfl1uRXGTTzebXz
	A/mzvnTCIaomItVEgZc4l2A7Yd3IBP7suZkJVjKNGRVqX3a6mW5ootCsg7vY3EOG/fBJmLh6/uK
	rYkDj558JcqCLt31RwcKdpHEWDL7Yd6icJQCbR3RtORj5yYwCIpHs5T72vi0kxEv8Uxgg16QTnE
	7T03+qCKWI9iDqiUYjQmZxPxTV6dly4bZv+My7uQ4xEYJUD3QfWXWm1s5ce6/A5DRFrR6X+W8PK
	c1PG/1e9A9hHGYovLNRLvZcjbqc5xOMl71PpUjDaze2N+WKASdWOiNXMBpKNULEUXNq+Fo5/0GG
	gGtY3Rp8xH/YoHZuiEaThmLpK9m5bHqGq0Tj4MBoRWzwVpMEEmalu6+R2SJUibZ21HPrBj0RR/O
	J2gKUhcB3S+Iv8g50Pyx45MS90gPPs56dbRFd7cmoTUNS70DVmsmmu1/qwFTF4zSnA==
X-Received: by 2002:a05:622a:180b:b0:538:684:448b with SMTP id d75a77b69052e-542b7b09d22mr323740391cf.60.1793872873262;
        Thu, 05 Nov 2026 02:01:13 -0800 (PST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b100af507sm48142251cf.6.2026.11.05.02.01.12
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:01:12 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91c7a0c1617so23369146d6.0
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Nov 2026 02:01:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBx2+k6+Nux1g/KaWSKZgbQpSWQLVcpHu1qLEgY7uYrTAwBGsCWNzSFuHlGE2RV7yR9HxWc5RWjoABy5VQ==@vger.kernel.org
X-Received: by 2002:a05:6102:6449:b0:7cb:bc5e:7dad with SMTP id
 ada2fe7eead31-7d072baa450mr7614890137.10.1793872492413; Thu, 05 Nov 2026
 01:54:52 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org> <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:54:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
X-Gm-Features: AclHuK_RsrcE7hVRjmpZezBV5tMd490Mza2XAQiqUTgUNqAiHAzRP5z7NIbtMh8
Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 04/23] m68k/bootinfo: let procfs copy out reads
 of /proc/bootinfo
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
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
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 20:36, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read to userspace
> after it unpinned the entry.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
