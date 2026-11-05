Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872928;
	b=JUxrha9mw7dsf29IVZfUJj3fO+8tP03k0tijeTVS6IvMw+xpaLq0Gf6DT4UxWpo+WtOk
	 VMuPsMo7u7t0IceI4HCZOuRr+sOxC7NOomKcTRHVUMfO6DXbg5MrJniMarlRJ759uXjX1
	 m4cRsSGASQCrbA4jgFlY1Ps+fmbH+a46Z3ZCLZmnLS0xQCr8eTJkZy6aJwai60U2f8KEG
	 bNYVh3YulPEWyo1p4hY2c+ir9DTf2bbSkyXcWmHsZe02MuVMfOjKBxoCIZkiLzj7lA9rP
	 v9PgSdAjMpzdm2owTuxR2d+S+/0g2ZhasP8bxAXV/1T4siXwlSO85/EjTXFBO77OQnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872928;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=;
	b=kcgFMZ+rfTs96xFizJLZ+BY22SbOzzI58HSi1m9mGqs7xx2kCz5zjlaBqTHN4j9SpUha
	 CWHnxq7Jl4pyCUve2dP8PFK3xsKQxdnyJPFgO+KBnlxKSK/KFy6u29RNDi9fKYXZ1cw74
	 s0D4EUULFRBqxEIUcIvjDwvEkq8V4ueIexal1nwBW0U3QBIK3cT75D1qqwFKEEEJFYnbK
	 BqLsO5AF48sQE5ufdfPpEiBJstjRu+c2L8oel1WELMBGmZVG43mrwh2sp2qBbr/qbiWxt
	 Zx1/+1ILHv3iCJmPMbQ7MOg33YwBxCGuNX1ouK69dx8ECK2fTTKOYam0I/WNkShm62w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA0D606A31B
	for <linux-fbdev@vger.kernel.org>; Thu,  5 Nov 2026 10:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FA0D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-945ae2daa3eso203292585a.0
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Nov 2026 02:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872927; x=1794477727;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=;
        b=zzqLj+mZI5uF6x51f1SXklQPWaiJmZsjsadgbz8tDquI3NAoe2FHHSWb1GywWi6UPC
         2DNUC07vkYQMQ1aJV4myv5D6k/WrCtrSJzc2+lClBU8+jwdLWTCSW7h7R0HRlGrldA9T
         Vgg7+GxAF4gyJDUGOf2+Cc+bB1ULiwul/+Rk7xoNcNLsivWWj8vOZ7PT7Kqg6fGYmQ0G
         CDBeegEq+2IkjdWn6HGU5C5U8XRmvrEEAU2uGbOF5UcZ4ZBtIBnHjo6dtSm+fP5Y5KoZ
         4b+SUI+D8PoeDyYft7ER35cDQPecLgzOotapPRFsXAJzhBREvyUAeVrEjPeZusunjRnk
         Fatg==
X-Forwarded-Encrypted: i=1; AKwUvBwxyqMZmnJn9HmJ/ye4k0zJgRu7YZPImYRcBenjl747zdMzlifVUuxYKDpGIL4jtDj40eeA5iZ0cO0oUA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+5VIk0c2RgGyuYKhmiJhwX/NNNKIGwMsFQkfzlhc2eHEwIRYEH
	oHGPxC0bMfNxqSH5PQtyR5uedcZEWtMA0/nDdTMvJ+m0bH/T1IZPMg1fnLs7tbPpQhg=
X-Gm-Gg: AYBFou0jQwLmzM/6qdRmYzWKYaYnJOZRwp5nJmHSamqkBx4OfrOYE6pK4q9fJ8IMmeg
	MeYA25F5DoP6mSRWXzdvZ1O1qnthhyClXJv6Ba3Nm3CDqPsZ1MSPsROyQf9xW4NnTha4YTEzCI+
	s/FIgFzGBG47/HN9vuckaQe9jYXvDXEFP2++8vsYzIEcEuDkLxVZrafAMnTMvFYcptcNs2Y9QZ1
	pvwYJXgwXnaXeLtOKZZAcZkwu9i0x2kKQCIZuFab+p8b51HMzYxGcfUXaoZvLglB5rT03Iylnbh
	yvU9W34Og5LaD8QZ4cuRF7EVCgCqZ81AdGueSM2sB24ENd1i4a/y0AbttrltEXAUT5E4GAHvfMK
	+5rkvHTbfL4Joku1lsS9EQKMbELhq9QWUqCZZ6lRes9RYd1WMWMN+ZE5n0o6T+7A11BKBQn7+uB
	S/A2xlddbz38572sCZwezqKUWSkal2hhmz37iiWvSnKZ4Gn+d8UCzj9WLukBVnoIR9cDzg7prkr
	RM08weNJbJTkIhTtZNY4yGDp6fEw88ziRVVVKcMXnwdzx8lNrnW2gSuuZO93SmFZ4Edfog0Hebq
	UGvc9sqcYACGOXo7tdcEFznyhueVfJ3BcMvaWhcw+9bE5T2g+LRp1tls1Nz983ix7hP93mc=
X-Received: by 2002:a05:620a:258f:b0:93f:24d4:ecf0 with SMTP id af79cd13be357-9442178c93amr3045545785a.47.1793872927297;
        Thu, 05 Nov 2026 02:02:07 -0800 (PST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4813a6fsm427193785a.21.2026.11.05.02.02.05
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:02:05 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5364d86f7f0so19476831cf.1
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Nov 2026 02:02:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwz1MT/+0lLYJB7oHIGyRVHnsaH+wkBb79IdHvAGUgirTALukLtpSqLMME5hL48iNKk+U5+L2ACRaBjrQ==@vger.kernel.org
X-Received: by 2002:a05:6102:5108:b0:7cc:56a:58e5 with SMTP id
 ada2fe7eead31-7d072d84a58mr8269567137.37.1793872526219; Thu, 05 Nov 2026
 01:55:26 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org> <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:55:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
X-Gm-Features: AclHuK_UsJ1nGicdWEWcMLQAICTi1A7pGF3yhNkxXkXRPqohle17eXAHHNBsR6k
Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 02/26] zorro: let procfs copy out reads
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

On Wed, 4 Nov 2026 at 20:43, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read from
> /proc/bus/zorro/<slot> to userspace after it unpinned the entry.
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
