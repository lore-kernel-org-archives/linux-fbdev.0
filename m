Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348582;
	b=dTcjiC18c/MQIi0nviJP4YsAx/Kk2Br8Qyfp/JV2TOSGAjbmuuqtyrkPpNA0uWJgwD5X
	 S4nYtMYW5GjHMdYqC8+8plAIGnxnaeEK13Uwoi9lO6wpcx3/8qdJsxB24aUA9imh0gxfG
	 7IVALNL7roBPWCnGyuvQnYHnIwdOhmeG7u9gbRA+14YnLn2h3qr/iz7T4sQ4SVLfo67ZF
	 I4mZFQwRmkdP9+r4PXbPx+PWXjt6CXF9x1vdN5kSmBbZxyxf+4ET6Mg5rjRBLsY7y8nyv
	 3ABseA16NmDAxKJqmQ6hG+PKI/TN5NpLR/YphFuLmudfENImngX+WjXHKPQGXq3yjlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type;
	bh=ukt8Gk4DLOLYIyt4G+IT9Thvj+8TqIkl+QNbsvaRca4=;
	b=CO5iv0lxyjNc+LdlzMkcjycNs6BgujoFXy2qO+K2LCevqMNnpfQOATdDZ1TCi4P3DAQE
	 AzQed6csK66+G6KjV7z5wL1jojRsaKfprok6PO77zDW2cxYohUL7VYR+/opb3GxFEkqBW
	 xJPvR3Ea7hAgRsy3FFIzmNHaALFHa+C+bktWTBIIDFbCBIrbp/6WUFRz+1yYtJMmn55v8
	 O0x6bHhpqQM7R4cMqpdE7FdatILVctGTPFgjHYULAd+vUfLqUxXi6MUPBywCglt64+JUx
	 sD6n4Icgmt9x7z2huKgb7duigQeFfH4Su2JPvBS+A6f/C/gkJF6Gx8/VNtZRjoBBwYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=f+VRP2Wm;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B817606A33C
	for <linux-fbdev@vger.kernel.org>; Sun, 22 Nov 2026 11:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B817606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=f+VRP2Wm
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so3768574a12.2
        for <linux-fbdev@vger.kernel.org>; Sun, 22 Nov 2026 03:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795348580; x=1795953380; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ukt8Gk4DLOLYIyt4G+IT9Thvj+8TqIkl+QNbsvaRca4=;
        b=f+VRP2Wm7iSaE3D4Pz4X34YYrxV8EkxwbUe2DZQe5XRn9j4lYGNPJxLK7VL3JkPzOF
         zthR+ALThzhE+LTzEYXpeiZGIqjm50XYF4C3xqOMwFuNrK73e3LAp+npA2Nqq24CS1sl
         v+pFV3zOmozO3a+XHumB3THeH8p2e5DHgeGgWdJn+LDLpHl1EGTfBc/bkAmsvTRYvkZU
         ahR0YT6tE+VhlmcJmReDk/tRyERrxz0QYQCiSpytgvTwgP4FSKQSP1fqdnAkH5D6O0ei
         OdsR4XhniYb4fR7i4PVJ+k/n1z3f7ZEnN7bcRbT7ZNmB1UqkxHdFkx4WqKpdjEyVLBlw
         sspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348580; x=1795953380;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ukt8Gk4DLOLYIyt4G+IT9Thvj+8TqIkl+QNbsvaRca4=;
        b=Hxl62KJT9SJqoQoXYB+UDmtGYznA5LyYS6pupeabXnRazI+2Tg4iRFMcZlJ8T74xD+
         bgnhE5z3Oayi3jWnUkyfd5N+FH41PDNeZNDnDz4RgTURrlds5apo1HMs2/Fo9fNzsGWb
         QecNB3Qy7IA0ASmM0kuLAzUbQJJEABI5V0ZPcw6PhhP+FPlTV0QdGZ67Kfl4MNmfv3hc
         btRNQPBdEcWhRo0X5rzSv1jboY74Qti/kPnLWimapHZPkocC/o63pbOdld5e7KD/R9jl
         PqWfhw646rjJtaT36CzPE1S/87TnhDxRWZ3uBSads2Z7paDnYXp3mTjswvAsGu18U/mP
         xGtQ==
X-Forwarded-Encrypted: i=1; AL+hErHD4c5LtWxYHn74w8D6KOIJacIYgFhvdvCP1C2fgtY9OhXDTO+dFy8ZTd7+LPokDWoy8vSwnHFth+as0g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Cnwj9tvAIFI+3h+4rxQz+76bgnuWIUyrZi48hhXX7bmEQ5vOO
	VcXKNRvRiNgKn80okDu3jf7vqjUrBeJEJTh9uGz8eMDp5zS2JdlnJ7/nR4d/ZxPSz/E=
X-Gm-Gg: AZFdTZcrSRyAgAol6iM0/ZZOIJsb9nhF3ziBqkZ8aYZKGI8PefGS8Tl8txNbdsK83Fe
	YuSLWcxoFLmDmzqfQwTkTAfKSTwnL56dAF0+j0DbanKqz0qdj1bOBPquC9KM8i88iWU3Wg5uc+r
	lyfbpa44Iyj4gvyAciWc7nMUVDBYVa3lna0eKsLFGATpG+gM2DIEmQ2vYNxHZ4s0vJ4xxpzGrM+
	L+XHwp6LLGzn4XoUBgilENeVbanwchEo9HmlMhmN/hHIBEJi0wcdD/rfBeeGfpF/xhMgOjNOdzp
	s6RfVSJZdO0Uj3xL98zrHq1Cg88PftPgsxRBPkY9RGl8ez2pOXqk6zzvlIUk9n6CFREW3MdyRWs
	ryVhFwcJDD+04KdAOEdrLEJ0hiEw5INaI34lCkmCYd8I/2p18ts5UJI/nlgvO0PEOWa0+E7VPKU
	063PAr/HqdOnBXocr8OBep+dp2LP1JcKD7EPOS4KsbOGQUBp8ZlIs9dyX1wjaFEznPWWAQ/n3ss
	igGJRDF3x1xiLVgF4rbN+RqF6Clv3M+fe6OVnLE0bo16KOTuwDLl9SUAJfjMKSEOx9//dpqq5Z/
	ull/EL1JOQ4O+VKirR7nZAadjRxGQgjB4hGC3WjxPWEh0IeWZLpng/fKm1P0/RvrQH5cUps0zTt
	xZaIBdInR4ZEKZJijL8xMBveFKZ3V6IK7WWR2VsEgtXWZ7Tk+JG4=
X-Received: by 2002:a05:6402:51d4:b0:6b5:8cb3:5e19 with SMTP id 4fb4d7f45d1cf-6ba37e8826emr6733045a12.38.1795348580410;
        Sun, 22 Nov 2026 03:56:20 -0800 (PST)
Received: from ?IPV6:2a00:12d0:afa3:c01:92cc:e257:77ba:97a1? (2a00-12d0-afa3-c01-92cc-e257-77ba-97a1.ip.tng.de. [2a00:12d0:afa3:c01:92cc:e257:77ba:97a1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370fc020sm3845321a12.25.2026.11.22.03.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 03:56:19 -0800 (PST)
Message-ID: <9f0278ed-70d2-44e6-b897-dc7a968782ed@suse.com>
Date: Sun, 22 Nov 2026 12:56:18 +0100
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: treewide: Re: [PATCH v6 00/12] msr: Drop 32-bit MSR interfaces
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, linux-ide@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, linux-edac@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 David Airlie <airlied@redhat.com>, Helge Deller <deller@gmx.de>,
 linux-geode@lists.infradead.org, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Pu Wen <puwen@hygon.cn>,
 Tony Luck <tony.luck@intel.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Ben Horgan <ben.horgan@arm.com>,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Babu Moger <babu.moger@amd.com>, Drew Fustini <fustini@kernel.org>,
 Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Huang Rui <ray.huang@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Artem Bityutskiy <dedekind1@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Ashok Raj <ashok.raj.linux@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 Xi Pardee <xi.pardee@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, xen-devel@lists.xenproject.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20261116150208.1572254-1-jgross@suse.com>
 <awLVzKJWWfC3eJsH@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <awLVzKJWWfC3eJsH@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AaknyoBFimMKchSGvZQ4WGjM"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------AaknyoBFimMKchSGvZQ4WGjM
Content-Type: multipart/mixed; boundary="------------hSBst9k3JSozt0eq4tpFbjs8";
 protected-headers="v1"; hp="clear"
Message-ID: <9f0278ed-70d2-44e6-b897-dc7a968782ed@suse.com>
Date: Sun, 22 Nov 2026 12:56:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: treewide: Re: [PATCH v6 00/12] msr: Drop 32-bit MSR interfaces
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, linux-ide@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org,
 kvm@vger.kernel.org, linux-edac@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 David Airlie <airlied@redhat.com>, Helge Deller <deller@gmx.de>,
 linux-geode@lists.infradead.org, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Pu Wen <puwen@hygon.cn>,
 Tony Luck <tony.luck@intel.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Ben Horgan <ben.horgan@arm.com>,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Babu Moger <babu.moger@amd.com>, Drew Fustini <fustini@kernel.org>,
 Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Huang Rui <ray.huang@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Artem Bityutskiy <dedekind1@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Ashok Raj <ashok.raj.linux@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 Xi Pardee <xi.pardee@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, xen-devel@lists.xenproject.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20261116150208.1572254-1-jgross@suse.com>
 <awLVzKJWWfC3eJsH@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <awLVzKJWWfC3eJsH@gmail.com>

--------------hSBst9k3JSozt0eq4tpFbjs8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjIuMTEuMjYgMTI6NDUsIEluZ28gTW9sbmFyIHdyb3RlOg0KPiANCj4gKiBKdWVyZ2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+IHdyb3RlOg0KPiANCj4+IEZvciBhY2Nlc3Npbmcg
dGhlIE1TUiByZWdpc3RlcnMgb24gdGhlIGxvY2FsIENQVSwgdGhlcmUgYXJlIDIgdHlwZXMg
b2YNCj4+IGludGVyZmFjZXM6IHRoZSAibW9kZXJuIiA2NC1iaXQgb25lcyAocmRtc3JxKCkg
ZXRjLikgYW5kIHRoZSAzMi1iaXQNCj4+IG9uZXMgKHJkbXNyKCkgZXRjLikgd2hpY2ggYXJl
IHVzaW5nIHRoZSB1cHBlciBhbmQgbG93ZXIgMzItYml0IGhhbHZlcw0KPj4gb2YgdGhlIDY0
LWJpdCB3aWRlIE1TUiByZWdpc3RlciB2YWx1ZXMuDQo+IA0KPj4gICAxNDAgZmlsZXMgY2hh
bmdlZCwgNTcyIGluc2VydGlvbnMoKyksIDY5MCBkZWxldGlvbnMoLSkNCj4gDQo+IFNvIEkn
dmUgYXBwbGllZCB0aGlzIHRvIGEgc2VwYXJhdGUgYnJhbmNoL3RyZWUgdW5kZXIgdGlwOmNv
cmUvbXNyLA0KPiBiZWNhdXNlIEkgdGhpbmsgdGhpcyBzZXJpZXMgaXMgbWF0dXJlIGVub3Vn
aCBhbmQgYWZ0ZXIgYWJvdXQgYSB5ZWFyDQo+IHdvcnRoIG9mICh2ZXJ5IHBhdGllbnQpIGl0
ZXJhdGlvbnMgYnkgeW91IHdlJ3ZlIHJlYWNoZWQgdGhlIGxpbWl0IG9mDQo+IHdoYXQgd2ls
bCBiZSBwaWNrZWQgdXAgYnkgbWFpbnRhaW5lcnMuDQo+IA0KPiBUaGUgY29tbWl0IHdpdGgg
dGhlIHdpZGVzdCBpbXBhY3QgaXMgYXV0b21hdGljYWxseSBnZW5lcmF0ZWQNCj4gdmlhIGEg
c2VtYW50aWMgcGF0Y2g6DQo+IA0KPiAgICB0cmVld2lkZTogQ29udmVydCByZG1zcnEoKSBm
cm9tIGEgbWFjcm8gdG8gYW4gaW5saW5lIGZ1bmN0aW9uDQo+IA0KPiAgICAxMzkgZmlsZXMg
Y2hhbmdlZCwgNDkzIGluc2VydGlvbnMoKyksIDQ5NSBkZWxldGlvbnMoLSkNCj4gDQo+IGFu
ZCBJJ20gcmVhc29uYWJseSBjZXJ0YWluIHRoYXQgd2hhdGV2ZXIgbWVyZ2UgaW1wYWN0IHRo
aXMgbWF5IGhhdmUNCj4gb24gLW5leHQgY2FuIGJlIGFkZHJlc3NlZCBxdWlja2x5IGFuZCBp
biBhIHNpbXBsZSBmYXNoaW9uLiBMZXQncyBzZWUNCj4gaG93IHRoaXMgZ29lcy4NCllheSEN
Cg0KVGhhbmtzLA0KDQoNCkp1ZXJnZW4NCg==

--------------hSBst9k3JSozt0eq4tpFbjs8--

--------------AaknyoBFimMKchSGvZQ4WGjM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmsC2GIFAwAAAAAACgkQsN6d1ii/Ey+U
/Qf/V7wsSss4hIhzlYSEbAn3m9hHxZeeL5FKmbgPgVrLfYK4nlHwa3EJ6R8VEbsBCrSAEDukOo+1
y+40nF5zk5Cd2x6ZzPoqHY51FPya4j+4EVDSl5V+nbl4SIiJvGDLi4ihESYNx1mvWW5gH6+Vuufs
OnzP6T4CmZFJXVONAuCrvQmcpuKCQ2grE/lndqutElRto4ptfTedEbY9e75ofBpzPdznr2II1ouD
tHveoDTySHC4GW3oe56/QxE/nsNs4UzA7yTyiXJKF8L7waOzxaNxh/HChdvWlA5MFcc8008Gc5fJ
dVj2v83uXCziMzSDhFA+P0ilK02fXgpsKkJqlb/r1A==
=ZBGv
-----END PGP SIGNATURE-----

--------------AaknyoBFimMKchSGvZQ4WGjM--
