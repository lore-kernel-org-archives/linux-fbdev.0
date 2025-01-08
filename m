Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB51C1AB537
	for <linux-fbdev@vger.kernel.org>; Wed,  8 Jan 2025 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736324559; cv=none; b=FFba3IUzjV37qmAKPQ8MBv09MPFpiEcKG32I+qdIU/SJrGbXiIiSIItaKv01L/USUeAneMN0fg7chZ851HvSYd+28/HRctrZ5ZzZbEIoWnbZyx/tEEKDtfsG9bKq/JCD2yWHJgMX2NCUrU3Z21vvp1YHJFd4j0zulRnza1x650E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736324559; c=relaxed/simple;
	bh=EYI/maJ+3O4ZQqWB7dnb9bL9p2Cv51yYY68SguEA1ms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OMZbHunCbjuJqNoIC2Ll1s2/mUBUnZSTj/tFyCMprr0Qi8OZgwUI422N0vkZ2xEXIy1lMd74gLRRz4T3d5wz746EEu5sswV+v9kZhsKEYV1g2gRWJUKDIQc2TEvWBapRrOKzsKvEsD9qXsLNetjDQ1BGjc7IcaHC59zOr3OoL0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WeToHCcz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WeToHCcz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736324555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7yxk95csKi3GHDYbhdAxJnZiLS3KhEFUJYd2VqIlbrc=;
	b=WeToHCczYWAJPih1H0RvYMW9AZMrJfarVuyhnoabxn56VxEOqIuKLrVCrtySajR2+cPfOP
	f4pG5R1pO+twpcGTc86QuCnhWcuaPx5HZxBRaO7V2RH+mrG9FEekXYGDVBVTQcy+PhN3XL
	gnsWDUORzbh6TgrxLqd5hp6FAl0IMAc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-RpjBUAgZOcOl5XAFfEYJhw-1; Wed, 08 Jan 2025 03:22:33 -0500
X-MC-Unique: RpjBUAgZOcOl5XAFfEYJhw-1
X-Mimecast-MFC-AGG-ID: RpjBUAgZOcOl5XAFfEYJhw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-436225d4389so2294625e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 08 Jan 2025 00:22:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736324552; x=1736929352;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yxk95csKi3GHDYbhdAxJnZiLS3KhEFUJYd2VqIlbrc=;
        b=wvfdiwnGiDYaiPaYXAxVy4caCfhT8RSLnB1MLgyr4UX3EK3PtzH1j2wVd/haxXZayF
         08cP9LVi3IrkV1KauwZkmkjMCTRzftJB7bPj7NwICgzZt1QubKOXEjyZ1TNd6JGQS245
         aq7O99gF9bN6gUxtHahzMsh+uTjl1X2If4r0TVRUihk1M6UWqUQtwjrLOKhm/qVAQjeQ
         R1F9S1qinDGV0NAlIyqwIgc3qAJfwHMD4fAGQc3IYg/Ha3/DJJFpVNDU6MGvcDlhW6K/
         HBipc40XSVkw/ddGUU77R2pmgUB/vr4q5F9pk07iPKdBAhTcp0m+r1sz6InpZXDCLhF/
         AUSA==
X-Forwarded-Encrypted: i=1; AJvYcCUlDOVB79xn0eqWoJ3ObQef2NNAbxJSLEIb7Eww2T9uIFuCSl7ow8NPVk6/lU7IhPc4G0r0Y+ywrNNFoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Vr+fYA9edKKKNlhVdLjCYjwZoTTW0kgL7srp281EqudfcKMO
	lIkETps+a/y3u2YjdknGQ7uTe3LjlBFxi+g/CinPnvEia+QWqk9tpdmycSCMCcClwdiDTD8U/LL
	J+QTtzLYBDHcqNweDgS0jffR5x7yxc/PQf/UpeiJ0lIKb8N1f3SHDBm8NABRV
X-Gm-Gg: ASbGncuYRgNUWj0kxLpOdteA6ql5H31M7ebJkjCHrDfITaGRPG9FDibCVFi+WE0S0D9
	3MfcXl+DKbDOGC3lquIgdLgptv7PMQAs32oCLob1SmzHqzZlYbM3UvzHOeovzAAX1B7koJiHUp7
	WLIWPsOofEzYsxd5qUXAya0AV6vaj5H1R5OeqHeNR1Q3vJeqRiMYq1p6qewOAjxJJEWCJZKa2bR
	2GNkN92Y/ewQtsp13vGJdncvhEgMvKTvauQRtF9W3irNsXYUpaz6dM3KaOiLlq53eqHICt3OKyM
	TkbflWqDG0hSkqcbJ64BUEAkxWlPD+kyk2i8/AE=
X-Received: by 2002:a05:600c:1caa:b0:434:f1bd:1e40 with SMTP id 5b1f17b1804b1-436e1dd3e30mr15578065e9.6.1736324552431;
        Wed, 08 Jan 2025 00:22:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH20Ygyhkb90BgF9irfpy0bwgtbzLNJyWLCMxf0zeohTP1yADRiBhQRdLSC2kN/1ghiJa5czQ==
X-Received: by 2002:a05:600c:1caa:b0:434:f1bd:1e40 with SMTP id 5b1f17b1804b1-436e1dd3e30mr15577815e9.6.1736324552055;
        Wed, 08 Jan 2025 00:22:32 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddd013sm12507845e9.24.2025.01.08.00.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 00:22:31 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>,
 David Rheinsberg <david@readahead.eu>, Hans de Goede
 <hdegoede@redhat.com>, Peter Jones <pjones@redhat.com>, Simona Vetter
 <simona@ffwll.ch>, linux-fbdev@vger.kernel.org, Ard Biesheuvel
 <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: Re: [PATCH] efi: sysfb_efi: fix W=1 warnings when EFI is not set
In-Reply-To: <20250107235312.236247-1-rdunlap@infradead.org>
References: <20250107235312.236247-1-rdunlap@infradead.org>
Date: Wed, 08 Jan 2025 09:22:30 +0100
Message-ID: <87zfk1iuk9.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Randy Dunlap <rdunlap@infradead.org> writes:

Hello Randy,

> A build with W=3D1 fails because there are code and data that are not
> needed or used when CONFIG_EFI is not set. Move the "#ifdef CONFIG_EFI"
> block to earlier in the source file so that the unused code/data are
> not built.
>
> drivers/firmware/efi/sysfb_efi.c:345:39: warning: =E2=80=98efifb_fwnode_o=
ps=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>   345 | static const struct fwnode_operations efifb_fwnode_ops =3D {
>       |                                       ^~~~~~~~~~~~~~~~
> drivers/firmware/efi/sysfb_efi.c:238:35: warning: =E2=80=98efifb_dmi_swap=
_width_height=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>   238 | static const struct dmi_system_id efifb_dmi_swap_width_height[] _=
_initconst =3D {
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/firmware/efi/sysfb_efi.c:188:35: warning: =E2=80=98efifb_dmi_syst=
em_table=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>   188 | static const struct dmi_system_id efifb_dmi_system_table[] __init=
const =3D {
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: 15d27b15de96 ("efi: sysfb_efi: fix build when EFI is not set")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501071933.20nlmJJt-lkp@i=
ntel.com/
> Cc: David Rheinsberg <david@readahead.eu>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org
> ---
>  drivers/firmware/efi/sysfb_efi.c |    2 +-

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

