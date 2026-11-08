Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164398;
	b=VhKhpC0WaccLpyatnZaRKJaU4AKkOTTgVBZihCylK5Ycz+26ucMAmViXOjIqZvy6oIEG
	 oONJk3TIkktyCZ23W2ox0aFA6yX2jigm0aNNac1asuHApq10zRrIXAQ9hcb2JQY8pzav8
	 KnO1B1ttdnTKbyTT3qZDcd7YosJ7ZLaB+eRqCwRPyRuFxUYwtb3ShV68llfusTpBoUu1O
	 p6QADXc3JSKzb31pzuGFWBMiMYQz+Ksi02+IsHj8xL3mcxWI117aSXTBsH8fPB4Ynxu12
	 Ces8UcLUsmAlgGI1Y6CmmURaBAdGf63ofUXV/9v+udt9rDUhNtz9S4D4Akq/9qp3aeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
	b=pGEt1KS/FGw/4djX1RWqOz4d3UfjJrCitglLTnvQsS02DT/1oB3WzlPeZYnNQSrmdUtU
	 9u2JGCwg8ahsQFPdk2rx37B7cqOCRKrFZhRE2+8nTdqg7NJSrrMwTMfFUPW3m2OnFgbWD
	 wojzJps+jyAuFz+CkCca8+cmRSDblQlENeVfpNTp/ZgXju5MUaRo8qPCgyEESRIAwXQzO
	 Twqo/3AdbBLMOdADjk6Tsl0zoz4I6GoPP+hwYU+6Y+nIXcbLYFmoaCSgfhXN83XIcWD1j
	 WaEJ+AVp8KBnvTuh1AfZvHRqBpq9T/gOVfA5jAfVCOLcBpVUNKACRVmczaYfCjqTK9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A4A606A322
	for <linux-fbdev@vger.kernel.org>; Sun,  8 Nov 2026 18:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28A4A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so1416355e9.0
        for <linux-fbdev@vger.kernel.org>; Sun, 08 Nov 2026 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794164397; x=1794769197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=XrEUEgHUwv+lt2Z0T4RzlOQuYT1yMbnY/MJrtF5HY2pc8m0ujKE+1IGJbqc3A1SsPJ
         Pz+po0Wh7ECcrOl1hyNdZBme+OsO/r11IeCA1lW9KMbstFhlOkC0Hm7Ef+TTavGsfrDk
         7T2AE8nlcorDhYFpLo0KTCt4xOv09AacMRilfH2h4PS2mZ0iBReAF8XAcgtI3iT+qlRY
         EJQPYUIUlDRCCjadf1+24R8V0flZyhCZpLCroCVsidoQ510350k4POOaAcSXgGRrBTWF
         rbpUnz5O6K0TOR8uz/zwLHiObwDAqnCJFWP0+ssCNYCBYnXJwQ2yMfUqdKkv6ro/lp/q
         XMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794164397; x=1794769197;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=A+XCc4Q555iHphtPa0Ebq1M36n8U/GQxRMLyoUfKr+D747xPE9hg1a0b+1jBc0/DSn
         uDhzdHOTNkCq8LmuuwQ7lanPvWEEbPpIoNmKzrGcVgkuOTzkUsq5QNnq+88Y1DdcVUAV
         obhDpGRloJFHODZPJ73cgWHafUg9yxT9V2goSPabp1hLuB4EkwU4J0mdkbAwfT+9Hyz+
         iI+1FD6vDp4llaqaGnyKlh+K+Z1LhWBPWYosJMTSur8erVzDLCwafK6eARwzK4T16xj5
         GrmIzSIZYKis2BrmZZlvtwGYwn4dLu8gKF5Qjqq9dow8Ripc92g9kZCzSIo/CbnRj93I
         6cUg==
X-Forwarded-Encrypted: i=1; AL+hErF5mpc0ogNyWg+zyBOONtvbPTg0lMs4tXCu9BDHsxMxeaxzXtd51h5oK9depoi9QNgj6bJJDCrNsp1V4w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8m8LpWwe7/wf4ENjU34wSd6BK14VBHL7KFweh7eu9ZDBe2wZKl
	qSI2cRtqvVYtG3tcGFtcQh6MpfF4KoTYydHIbjlv0FFLAYPV0B8ezVbZ
X-Gm-Gg: AYBFou1gAQq22/3wUWh9Er8LUsGlTVvtDB2jEYmNu0P2vgeiDgDtAab3iNmNaHYfLa/
	ab1RIyan3udLEz/QCmYh1m5V4wkpYqB7GbcvfzcTo+9TV2KEMs0D+XdJnmDHHEsaZuLeri5cSOC
	kehUSoXwxeH0Qgv3ITh9F48VpfQztefXrTSeAQub99TlxlG+YNddwA1Yt3U8iZDF2og/QiurG20
	spMxo54q1TriU4MQgujUYsFedB6CqNzhK5WaiNcJKbruZOL6+mnxJ1HeoMZlBK9FBaLkhxja5oR
	lKh2aDPnwCrpYly+I1rp9LQfK8Ai+rxwexDTnS/NR4ZJSyqPh/OsYWuGp6zhV17rz/Aoswhj72J
	CbmzwQ84vpxfAfuJbe7idRKkldSuT59KRyw6ASLf7lVf8/amnN+mlwCtWf27GAdGUClA6MQbgaQ
	bsxioAaRg6xI8O88OmSswYoI9/cNdD0RKeO+SxJhqbJ6wzXoYaakG+cz8BkDH8akj3l6yCKKcyS
	Pry7clVjWW5aLQG6eOv9c48DHQBdz8c82siAmf9/ZfbZuAtjnmIYqQxRLHQGFOuVKa2e+xL/rxo
	7gwWtkG+w61pQwHaGXZEdSR7ItANclXl5kXiCfAt0gXd9gwj/yIJaRS6ozpLtA6l
X-Received: by 2002:a05:600c:468f:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4b960d9b170mr35982125e9.5.1794164396406;
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1f3acsm185228445e9.14.2026.11.08.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Date: Sun, 8 Nov 2026 18:59:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik
 <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet
 <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph
 Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados
 <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara
 <jack@suse.cz>, Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-um@lists.infradead.org,
 linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ntfs3@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mm@kvack.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, Chuck Lever
 <cel@kernel.org>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
Message-ID: <20261108185953.28054fb3@pumpkin>
In-Reply-To: <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Nov 2026 10:48:35 +0100
Christian Brauner <brauner@kernel.org> wrote:

> > While at it, I think it would be good to use this conversion as an
> > opportunity to replace "char *" by "void *", which will probably let
> > you drop several casts from users.  
> 
> So I tried that too. The thing is it drops exactly one u8 * cast in
> ntfs3's label write. 

Since char is now unsigned that one isn't even needed...

David
