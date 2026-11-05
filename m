Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872210;
	b=FompUJAJP/2JeRtTtLUCTIKqoOb2NkB2CIc2EzmQID6mX2PAgOJ46Ii1LqygylEDEjz6
	 77aZ/m/jBTPorOuqcL5cteDUKgy4nMlP2gpLH+jRke5dxgZ/wBGgkiu9ixZIR0EIKUTlr
	 JnCRpwoqaItsiinczfMcqZyBSdbHTQseNTPANQCL7SbxUdSlfpOxk4tY6SyXN8/8PTUrA
	 rEW9F8FWyCS4R595AR1GIhmbqQQGt0lm1SmYqUymUkHbWXM5dH42Xw2XzxyiuWb7rPyjR
	 9QlM3Kpts0245sO3F2DLnzJqXS3LG8dKk2+4ieUFGT7RRBfbmZcvumNKSDDjoOi0Vlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872210;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
	b=PmWSoGgVuB0qcZhva/dh3u4pLJVCypcHaE+6c+Ywu8f2+zI8hiTaVn6WJQuoPxiBra7M
	 Ip2AC6k73JK+SwMskZ+PoD0b9EdINyNwTSk73vai1g6vu2QyH55hniFkcDt8SBFxCyx45
	 HkArDjw/xJN/gM+eCGElltz903wrltDJQtyUUMcpSONBcA4aoS/p5/41N+UV44j/EHkMN
	 zMXjyl3B1R2KK3k2r+xQmfq0P/ULzccDwFuSELl+3izsTpiu37rkxY3SqNy06db6Gr2le
	 nl+BuAT2VOYopR3bw//DtY4sIfvyWu1HMsiJDN6UZ4qqVHJa2oCv2HHF28cStGdnUIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEF4606D83F
	for <linux-fbdev@vger.kernel.org>; Thu,  5 Nov 2026 09:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FEF4606D83F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53c4b82919fso20989091cf.0
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Nov 2026 01:50:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872209; x=1794477009;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
        b=OtpY7ei/eTWotKhYGk74J51bnten8Dd2WP6hVCoEpwzRiocSIcfOtXlhIJq11R9s28
         +tZOchlO2mrazBH4wyU2JBMSWuqW3/9rCifMSLOrvYJsF3rNr2BnwaIkIjzljx2FjyNv
         TKOTqRVDZV1bRlOEudPjRsHutvpuN+s0yKvKcuv49M73CUxRFShtNUDF5QvdMXXRFOdR
         vlerIdCS5vYsaEHvZyVti5/tvTLY1CNO/YCMkPWGiw09cd+hcDbgF4ISO3Hp4h+LajCC
         nu+zuo+D96RulSREvsrMaO0H//gE6IbDXrBmF5hmjOViGLSbAUxa59GT9zNB9/1aLKup
         G9jA==
X-Forwarded-Encrypted: i=1; AKwUvBz6AyXZFfiQcaTVsqH+dO9Cl9wrTc50VZFpSl5AbjSzhxdPmLrQMyfLSeDdO4YCKNbQntk9VNX31hxo4g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/dvjc/aE1P4Ng5J4wrmeOTKAa7m0sWtk9e5cpWVHbHHl1OQtrq
	c19DQghCzoMpJcfyalLlqtXhRzauCy0mrI6YmzcEQKnU71txVdL+6wKxRCBlmvfIMOo=
X-Gm-Gg: AYBFou2engcbiZz7ak6n6WnVQ+KO+TSff1+ZHHyIhA8SULkeDU6oIkMHovLgo8mYp7F
	Rn+cc2Mg3Vkf84s5gD94BslXhkaE3yQXTXGZSKXeJBPHgcTzVhRWvLUuDCNRWFrxwi90WPxjE2+
	NUgCOvmXYxR7bDK0SNEe53UlTEEcUa2FV544gQ618YeZgmwhY7uAmJjtbn71xISH17FxYYhrjEZ
	a8fqx+cTKrdLiCHPBXUZ+b7z+A/1O5nUNS+r5ij2Eut5iP7QpwUixt2w9K8tJL2fIbWcgAOex7t
	VBWhyV+uUuD5fKfzbItqhmgvDQHm3sXKoFQF7DJG5ivwmOuKWSnN6vyLWKLaRFJ6F9pq3wyc2Da
	KnavWqEUVd088jlbKcpUvkUhKC4ztKxhYoxC6GRnVAuko3MxLaCnSIpPLd8kUkxMR/5z+WX/J1R
	jFd/B8bkUAWlnT36np4bpyxlYARe+0Yj58o0QZIPhtXDA3TW1ZqU1EcSrKGWxzy7yCs3pEhaTiA
	l+DGySdF/yyokFm4JfCZ4+mTsHBlDbYqZgwHbpxvmMKrV6bqdRCpgPRCJNuPrJv+D34CJHBKQxv
	wyaJcVAKMuuLJs5aw7lkPer1w6j0AnqOsWzBGLeUwq6uwW1WFxVWIeZKOEr/JzztAB+vnA==
X-Received: by 2002:a05:622a:5d0:b0:536:6abc:54b1 with SMTP id d75a77b69052e-542b6a6c6ccmr331265801cf.28.1793872209142;
        Thu, 05 Nov 2026 01:50:09 -0800 (PST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfb3aadsm43011446d6.8.2026.11.05.01.50.08
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:50:08 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53c4b82919fso20988941cf.0
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Nov 2026 01:50:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxn3cR/Syfu1DteQsNPoSV5250RDXcuNeJyhNtFVpA61Dy8aIBgicSSdHxvM0Xs1wtMYPWwMgWYtJxZRA==@vger.kernel.org
X-Received: by 2002:a05:6102:3ec5:b0:7cc:2bb7:131d with SMTP id
 ada2fe7eead31-7d072baa484mr7324212137.9.1793871885062; Thu, 05 Nov 2026
 01:44:45 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org> <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:44:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
X-Gm-Features: AclHuK9D-nB8icBns0zdoQH8fV1cfUPJ6LOey8o_VlUZpDIGqKC4cFf8-j5-HdE
Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 10/51] zorro: size the proc files like what they serve
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

On Wed, 4 Nov 2026 at 20:18, Christian Brauner <brauner@kernel.org> wrote:
> The files under /proc/bus/zorro hand out a struct ConfigDev and seek
> within that, but their size says sizeof(struct zorro_dev). Say
> sizeof(struct ConfigDev).
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
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
