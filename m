Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823112;
	b=2Xo14r2VQjTHBjuSNY/L0vCD5S8s41nOXtfzVdXp+0rmByj6fHjG/41E22Jo0sqTipGa
	 TLkkSvjv61YeCpTgPi0KF0tDXKIhb+tp2740CZyewxtAd5Wx2tr48Rpd9ayX+n1YjCHMD
	 mUgPQkj+LZW+vLV3Teawyj+N2jI+iF5FcP1niKpTTVw+vJTJITVAJ467e1H9ycjPzayPq
	 cHjRfxoM8wYYcty6fTiNNbkWQuYNZzsNsMb8hfCDl54xsOMQt1ETMaHZNmw+OqhKvKhBB
	 vKUbXdpJ34C7zp4n99Hq9A5Vlvj62GMJU/TGMPeEKxSlszizctMKD2ZisTH2xo7lxrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
	b=ZwQQ8K4GuBMowlsd2O+yuKFINuMVaUMIAnxDbaFgG6afN9lWGlJUSEc5yr0Vm0FBLcWK
	 1+nhld5ZarAhvlGEv+Qc+Qbbsl+JyS3e34OHqE4yLp6263jv6+UxuIrMQh9/5h6Mne3v3
	 maSBjLfzVYvrocZq8TUA1XiHBP9BmF0WA8xMdmmqXubmYgvMTV8tP5Gsh8h/sb6bqh6WB
	 /f48strV3stTdGIFBb3EqG3G1kOD38mOcPVf00Q5IMXtLrs3bRqbZsCS36UAsiVib3Rq1
	 Ap30iqCyU2Kz8WRUIkdeqzCQbsdWnHrk7zJ055zGLnhv50PUgbJKBWSy/iZPDMuRGzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=h+SFpZ1x;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DFA607F293
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Nov 2026 20:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81DFA607F293
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=h+SFpZ1x
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c423b145922so163057966b.3
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Nov 2026 12:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793823110; x=1794427910; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=h+SFpZ1xeFehE7QvvYB03Aiy7lBgLa4/54sYQoI6b3gYLabcKDfwbDeaDulKqQhQe0
         hhb0VNbnH9fsOvw/JTgmtwWu8HHX8gG/0I17M1ADL1fwuVfYH/PTeQEWkUQnvJx1Dx/C
         rB1GBsxL0K4O71CoRWyuk+aLHCrKMr18ra7x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823110; x=1794427910;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=mPPXzT7jihPhN87H7/HXc84m8UjwRsROFYwYwmQPjztUwlMRQVOaCh1iKKlSbSwvgD
         rD2jyKI4AJSaKEOHiMRGAKUxX2P2fITe9M88XZa31SURzKWEBJ9aXGJLTFll9BZx8QmV
         aqU/MnKO9rLM786uiBLhXFyhDR64HbxPMVabx0s2dNO5Ktg3Gc9akSFaio40GDCRgulH
         yCXFYEP9px8XPMzkrmeye0l925ydYzXxY7gwPdRgJ8heIVO+1Bc9JHNmobNkn1pjpJJI
         H3ZwpCmUymwKgnjQzd0ybmJ42e+bHmHfOhJ3P0jj6YZ5UMT0MKSL2SIDJ2UL4ck9+Unh
         DKlQ==
X-Forwarded-Encrypted: i=1; AKwUvByhqCyTiVL0XkADmj3WefPqrz+TANWZKrQlAZmW4aqe8VEK7L/ex54cOZXrO9yvnfreerFqJEGq5atu1w==@vger.kernel.org
X-Gm-Message-State: APuU4Z856OzfSlRu4rMdlz7fiQt0af5lcIi8O3XwHvsQ6jxOe3iGdlWl
	hLMxaxz9D+MzywS73PCJ2QKIcz65hsuTzxPYIgQuBB4+4MoUazfR5iNn3UTu+Hq3I1YlWlfsOBq
	/GeKWJc+a6Q==
X-Gm-Gg: AYBFou1uFhowlGJcbOJPgZJaZySUPB9ouBcvKTzQtO1guPOEuPTj1yL6508TTvFSuIE
	fbKSDR6zoKbadvtzfLcxO/0A4URVn7c08wwPDviQIZX0Bb8gROqF2AAVst6/HFJP3HOMU3GNuIy
	nipZlP9iq8acB8uxp+d9irmJRS8100enZQcVrBPw/Q0SAwn25Ouwqq7hRvmY2J73dY0bFjh9Mxh
	3EygzgbM8QLLgIN/jn8RcwaIPkUZrTcB3rZcavECBLpagHMgKZYXiPwnfV5vbCABoP9I8LpM2ll
	CBLyEwG9wfjuUjrUwpom0uNHTTZ9ceyIcSrs77xVc7tv2s3W0eSPTFynQHMjQ+PBGD59j+P8KcE
	fpW8E8c1NIQCsFjDCfsJduxtnNlalPv4IZyJf8eGTsDa+S9noiVLdeekukacoLpfeOM+6kRYLmX
	r3P5eCHJSzCDN5dHFMZkIIZGFqXBN9/amhn7YBg83QkeiKe4JonJa4aAmDy1bAsfrw9euXC4usa
	2dbw8f8JEXQRD/1Aip4qbGN3D5A98r2o+bKwxDEgM2eLG7c2JAvRzj+T02dE+8UorC0WwCNbcjS
	wqjhJvhmlQQP9EF9Lh/bERrZHsmtNrFoQu6dfk8venRqLMWT2ilhHjKiNFmU2r6Nj0ZyMhnBQ5/
	dLw==
X-Received: by 2002:a17:906:eec8:b0:c2e:317e:d711 with SMTP id a640c23a62f3a-c4ca7aac250mr1582980566b.27.1793823109866;
        Wed, 04 Nov 2026 12:11:49 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e140fa1sm105487366b.7.2026.11.04.12.11.49
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 12:11:49 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4550d8ab15so176880166b.2
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Nov 2026 12:11:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByzPgB0A7Jg5Qsi3ZecyMrC5D4p8XdBpACvYeSzu+TLiwDJAh9CdHMft66s0GiYRcEtr3ZkmwJ4Dd1dtQ==@vger.kernel.org
X-Received: by 2002:a17:907:60c8:b0:c49:a4b1:9cb1 with SMTP id
 a640c23a62f3a-c4ca795fa50mr1973235866b.3.1793822725121; Wed, 04 Nov 2026
 12:05:25 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-v2-0-b45cd5789ac5@brauner> <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Nov 2026 12:05:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
X-Gm-Features: AclHuK9j_YIgrwhhpWOlnull6heAULBd4dgTqoOhUQQjFm_MgoIgrL1vgPfefvI
Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
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
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 11:49, Christian Brauner <brauner@kernel.org> wrote:
>
> Part 5/7 of "proc: move procfs to what kernfs does", on top of part 2

Christian - way too many patches, re-sent much too often, cc'd to way
too many people.

Nobody is going to read these repeated resends, and all you are doing
is clogging up peoples mailboxes.

             Linus
