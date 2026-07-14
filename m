Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8118946AF2B
	for <linux-fbdev@vger.kernel.org>; Tue, 14 Jul 2026 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035974; cv=pass; b=Dc+FA+6owG3X7kwtzl78mnzBt0PiNL1gTcfngIUpYGdf82e1hBuKNWATzqY80cUqTcvHVUzyCcHR6OPEchqosubcexCYZXqpi/BcdodOH6wwms1+Wdc5mHPae0iCWbK32ywgV4vmktiDRuuAEdoVnyFJsvQc6QeOdWFjNobTl+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035974; c=relaxed/simple;
	bh=xMYgbeZWEkYZKWpJP/1b9kbmlPmh5Bba+PqXdvA1L9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3qh8Ui8nG9boFu/Llx3SAEiXiObRy7lf0I0JK88VYnG0ytgDeZVZjdxts+IZ14kVXX+MFK9CT4q+s/lr8G0WHkX8e0IPveEj9tOvpx2jeJHAkrc7PJfjKK+VC12E1rtlzfiSTHhIs47CdsFn71NrRNyEgp0iyFFbrKJAM5lq3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1KybUSF; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1KybUSF"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca12086c06eso3615638a12.0
        for <linux-fbdev@vger.kernel.org>; Tue, 14 Jul 2026 06:32:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035972; cv=none;
        d=google.com; s=arc-20260327;
        b=mDOfS2wwyvSWdUmzDenH/q76WqGLfVwcM/2CUtYWC0+xu1fmpdc4qGXXJGBv7fajQR
         KfOFSLwlVPZhNjf97FPMpZ+PormETRfKwBb4KtbdAF/CgiuguTeaWHSlxxp8WHN5GQia
         NJBt8jXiEVrXX6s0y0wFjkj/TjMzW0r625v+30ZNgut/dnsme5kmMrWCLvoQG5hR9edR
         DEFpLoxPqNvb2jjp/BPLSvPlP7a5WnFw/5lFhYJz/rGUGz1/251z3J1cwMRSaMsz4phL
         QnO2RupvzNsH6DGSXRbWYcBWN6Nap1GiENzcj9tbyoXgesdxBtn7VS0c/UEmeW6z9nmU
         9Lqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xMYgbeZWEkYZKWpJP/1b9kbmlPmh5Bba+PqXdvA1L9g=;
        fh=T7xA+FmCOfhE8u6ATbZB7WntqiDUGAaioMClBSWqoxY=;
        b=Pet/0YxfrqKezNacmBjGMq+vYAbOCcCYcGdRfEpRxodeKNUx1/rg/wVP7pf5CkMAHB
         IlhDFIQT96yV9+09kfZcvVIMvx62yeWM624ZYQ7xrWlE+EnY3qFFbBuHQwSYaS6/MvOj
         JNckMMBXnbQ6LVucYFqw+7KGJtw4CB5BEFpyf4twzA+uSlavPiDYz14ZNRkrqg0oJhrQ
         mwMhi0m5tH/QLZdbldrqNpiQdb4m7gaFTo8KIXxVFQT5XIV2R57DwlWafCzMGpH6nU76
         gVBwGfubQlqW2o4fEZrHCOSHtdDpmodmlC/7pZj2MNK4SRIoNJLSomQtVM9tPIOfIg8G
         GDBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035972; x=1784640772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xMYgbeZWEkYZKWpJP/1b9kbmlPmh5Bba+PqXdvA1L9g=;
        b=O1KybUSFHz0QdVul2k4o9VEGyKBL6uHP//tdT0Mdcmjy4tIEXxbFxE7c2P00asfBky
         TsnK2HZDQKGxxWs5geoIR9LboD6ul49LJsuU/H9Nf6Y2gVnXejBUBylq14ZHO3g1LNM+
         qCPApxKO1IGmye51vZWYLuoY4PLjFvA/xxcf0N36UoWRCmo/Tk2UwHa8EOcIXENrY132
         Ko1C1T11oYkzeIOg2//cJYwGAA0agX6SGKP9l44NvPtFCO37sS38zYusILJd2w+Aa1aw
         bt8Fs8AZ1FceZqcRsxIrLbmSJEFY4jxT+KU49vyaO9p1MxuEQyJUf4Lioew2GIMLcuef
         s8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035972; x=1784640772;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xMYgbeZWEkYZKWpJP/1b9kbmlPmh5Bba+PqXdvA1L9g=;
        b=T1RK7oua/2VSYfzyLSig6PGA1vmcc/ALxW7sf2Q7TTVyPz1rHoVpZO5ZJlcI03FN+k
         hLav/5Lpr69RUnTi+RvjCSln4kcZL1rw+S0fN2VV9F5acGmMoKON7Ia3gQIdJLccQ6Ct
         d84FEhOsdnKG33SbwPCgFnpx97/Fxy4QxvuzqXwbtQqsBVRxxETY9m0khI7X7+aCezZE
         s3y7DKV/b8mJCqA+kE44J6yQdq/zQv+6cNzSTxPvM9MTQ5kqvqPe25FDu4UUyY/9029R
         fp/dKlaLn0FwrF37TtdaA9Zdr5z0qbqdICLwWJC5Uq+tV7crcqj9D55Vh+You7H6RtLq
         /qcg==
X-Forwarded-Encrypted: i=1; AHgh+RreGB3SkXsqGpWFYzUNojcOJORL+/Zoh5ZeZGxJsRWDLVjsi02NfKjkJt47JHsKAAP7r/yUymL2GS8c5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFK3QDXKPvv6RatTHRZCTYsEOIBwUOqZEyNOrhfeeKTCwJUDzy
	dem/vH3gYEv9Nq/mVB5Vg8kFRXK5vVfrb6zeOCIpMiZUUDh1voepCWhbq1p//IiOTBxcQr6bSMr
	aGM9vluT+Y4yaW8fVPsYvnD8w808gYnA=
X-Gm-Gg: AfdE7clGgPgyJnoAad1qY9mwIE0v995iaHcdn4QTBETh0T5IqQUvyHZlP2t47WaTL7W
	L15KoNyhR1v+Fiwns6u7xHDKJhd1rjxKRY3lMTbPNv+M/N8F2gOb1EDzGwYeT4ecTRJm9TjW6am
	/UVsh3c5mqo6UMiA2Xk1F83fIqQUQUL7JxqQcPSi0TEpWb0NzpLQAdHonC3lmFn505I1xT7OF8X
	25ECMLJGS6wu4eGNQJ84ozz/gk3wYzlEd0+Ken4XIuIyCPVqgPu8VNRxDR+ifpGQpndHtgDGZpD
	qQr76lw8EQbW2t1wRr2Hjisp/+8rCQ==
X-Received: by 2002:a05:6a21:398d:b0:3c0:9c19:65c2 with SMTP id
 adf61e73a8af0-3c110a7780amr14294440637.74.1784035971780; Tue, 14 Jul 2026
 06:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com> <20260617080031.99156-7-clamor95@gmail.com>
 <akeHfV45fs_wabFl@hovoldconsulting.com>
In-Reply-To: <akeHfV45fs_wabFl@hovoldconsulting.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 16:32:40 +0300
X-Gm-Features: AUfX_mybrBIYYttKuc4kdlGjodzpsKD3b6Tkn0zZS6Q6ac4kDrP0-C3ai8FD94Q
Message-ID: <CAPVz0n1groC-4MxU-sjyPEDHYWqAweyBmVNC+iX4mVa_D3SnDA@mail.gmail.com>
Subject: Re: [PATCH v5 06/14] mfd: lm3533-core: Remove redundant pdata helpers
To: Johan Hovold <johan@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:57 Johan=
 Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 17, 2026 at 11:00:23AM +0300, Svyatoslav Ryhel wrote:
> > The lm3533_set_boost_freq() and lm3533_set_boost_ovp() functions are us=
ed
> > only in lm3533_device_setup(), which in turn is only called by
> > lm3533_device_init(). Incorporate their code directly into
> > lm3533_device_init() to simplify driver readability.
>
> Again, this isn't needed. Why are you removing abstraction that improve
> readability?
>

Adding helpers to wrap custom regmap wrappers seems redundant. Regmap
operations are pretty self explanatory without need in one-time-use
helpers.

> Johan
