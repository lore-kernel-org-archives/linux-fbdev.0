Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394223D88F6
	for <linux-fbdev@vger.kernel.org>; Mon, 11 May 2026 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496861; cv=none; b=S9QpPXJ1T95TVJMtUobvn/OfEzAqumtraUPLGNmHmB1X+uTT3Cdx3VDNu0YSD2FIkcoDi2jSQsdXMzIUGYt5EHMxp+clPLU5iNZzL0PaAH/iSf+nSy6mbM2qd5soslnBB+kmCYFxSAgZrq+LXmiL3t0Z09Wba5UYWU27LfUnhRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496861; c=relaxed/simple;
	bh=PwfY0i3BFfV9KUXe7iT2+DB8xtqjImxj6JXUepkb7VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NiMaITv0KXqufeKQ4kZA43kBVu6D0Zgf1SUeQ7xZ/TSJpGPrUG1l2T0W6nKs/h1VyKqO3hYYovvrNGdBPTn05XhRjpVM1N/5o/pRpwINGwp1C2QhIgnt4/IxOiVy5p6eBmu1oDaEJz/DV1Ui9puQ9Hpblk20k/xT9PIOXgg2R6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzT0+Kju; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzT0+Kju"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2baef9f5ecdso21793035ad.1
        for <linux-fbdev@vger.kernel.org>; Mon, 11 May 2026 03:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778496858; x=1779101658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PwfY0i3BFfV9KUXe7iT2+DB8xtqjImxj6JXUepkb7VQ=;
        b=MzT0+KjulBzPAcATIZTuWETT1Uk4La8zjSjnlcQaFmrR70FCm1RrylD0FE82obVBuk
         9FNNcOJyMfWZf3tzQ8jw3WL7MuI7qZurQJWk9J+oNNyHL1JQcLJTerIOFQrgnNrzN5ww
         2Wg63uicE/SpVo+UBf9GrvcfaqYGvZd/0D0znF0vAFeZwxmG8mz7iG03TZNqp1GHl0kq
         GuWOiNJXY17kqAzDU46sDlxdwYKSRaiHgbycDKmqpOtt6/5sUERVnW1bHb9xFckxU2ES
         veStilgbeunyzus0bN6o3MT7X2xpdSAkddNSg5xfzse7e53NFV/lmiMUe9NVcM6u9FQO
         uDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778496858; x=1779101658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwfY0i3BFfV9KUXe7iT2+DB8xtqjImxj6JXUepkb7VQ=;
        b=OIUFoW/8E+m8EjReBDMkIkMZvI+glVsF35Qag6c+awx14Zh8UV/R6Py/Gnx8/mXF+w
         q0V+tkc0uO9EXeflSdKx8jdof4byYbTtNlRYBJ+dGWXICSE/SoB37EaHw50S/W1da1s4
         D4hQ1ZgWoBBD8Up3qC8eV+ylHoz/FhbWheszbcUnr0bYN7UXQohmNy0PxC6GIrG5wRJF
         sNI7bTGlsbvIcooY1xvYJ1jPc3UqDKbANJmfwPuuGiZdgMuw1gK5YR5Vrp86HdyId070
         vRj1TBNJmW5gDNFqmA+OW72OGpMdK+eW81+BIEtpWHmqSFQImpqtT3+n5/qjy/4gnqct
         mNxw==
X-Forwarded-Encrypted: i=1; AFNElJ/oFaIIy0fjJdinnmaKqDWurr5qCF3/TbLxZwBsAsNxZiXMXDySqUp9Wd+2A5K0loNGchjSE0+DUM/7kA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmAwfOz0vZGJAL4FxBtmmshz02YKtoJFMYq0dxrxypu+04PWQY
	zIO4M4C+g6OMbkAqAAUiX+LjMVvzbCBzNvcbu92iDFz0dbyvw6fYxioH
X-Gm-Gg: Acq92OFdGr7G1xnjT5peUKHdUrsjMhU9YjvgohkH4DvI8KtYjAai0CA9YsaXsBDJTlJ
	zUREVC76g6iiAcHHr0CiVcWmgsqHc4eHiDEMMiyLrafB+UDY+YV8KA/7pw1LRXFB8pk7MdAhUHJ
	1QFGdkPR6KniICb8qbJMDBNzxkrTiF5qA66TVwwySXC0TF3X8wEHU7xhjtkjO23moJavZYvcDde
	8qjXvJoApYDhKTXiWn/Gn+lMDSKmQM14VyPONvnQ78zCj16Lf2Uu6T8Z2fOTmyoENXdKamjdTsD
	rRXBkai0rb0xzuMSq+I8H60xCslE9ezAyF6fWkLbTZoghCZpZ1n61GZFLd7kSIHAYmNP/NVnIEL
	XM2SWldwynteLwMkp0fd2eNAKME4ShY28xp3PvTj4/JWlrRt9PiZT5/C+zS+zT2cOh7aVjle2Uq
	ntakv/KhHKg7KQ44pHXsIWFV6gmX8dG1YMR8lPfFXIkjNxiNdBOGXpv8hDo59BHma9Sduy0fDZW
	WsSH6JtBze9lPg=
X-Received: by 2002:a17:902:d382:b0:2bc:dca9:f0ef with SMTP id d9443c01a7336-2bcdcaa055amr14395945ad.36.1778496858131;
        Mon, 11 May 2026 03:54:18 -0700 (PDT)
Received: from localhost.localdomain ([2404:7c00:52:d485:aae2:91ff:fe57:5e15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2709bsm105696375ad.5.2026.05.11.03.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 03:54:17 -0700 (PDT)
From: Chhabilal Dangal <yogeshdangal66@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Add const to g_fbmode array
Date: Mon, 11 May 2026 16:37:55 +0545
Message-ID: <20260511105255.99641-1-yogeshdangal66@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for catching that! I've now properly configured the kernel:

CONFIG_FB_SM750=m
CONFIG_STAGING=y
CONFIG_FB=y

Ran: make oldconfig
Verified configuration with: cat .config | grep CONFIG_FB_SM750

The patch should compile with these settings enabled. The changes are
minimal (adding const to g_fbmode array) and don't require additional
setup beyond proper kernel configuration.

Thanks for the guidance!

Chhabilal Dangal
