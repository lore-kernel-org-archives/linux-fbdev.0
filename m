Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795205409;
	b=dGZqM/jEquexZ501q99B2R8200UsLUCdLymc5YrdjsUrVLDqbGm9WYppuVOU9GUe3vRO
	 0wfr31IzMP7Tgx2ig1GPT3u6LpShvBiX2ZwO5LJikAh960ppNEO1dPM7nF3zuJeE4ApcX
	 YgIzNfrvmmipuq2V5IkabLGyuIeVYMo0imlB/t/IN6BDtoZ58u3lcg3l8yGcDNu4w7E4C
	 9f9a4j0uMMH3qmLwvYEuKuljYOuzCjgX+G8yXJIahtjmsNeEaQ5HsuFUABOTLKFKhpdZk
	 L7mPTB2hvfeOLjU0X9HnNyKEVYX4ecM1oqkubwif36CImvaezWArOKtsCe7j5tfRc1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795205409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=M68LbjcTJ3E++0vyBdIVrjiqmT6srx4BEI+V4obs4pE=;
	b=lAWTS46OOXbPUpRRkPeEFuu5byvDc2EIT1xefXUOqKJekzgvLErTS1oXlaPBO4z6HGdZ
	 4ZzRM+fwbhTYAktKBu0qeauxvCH7Lw1lMvxTAtk+4rnuEXMPoOGTTmvR6QTvhftik3xqW
	 zAV2wHavo8RvcaxxBgyb55ipee0KNpQrdPCnUW0thbk+wO4ovuYtI9bVnw9HFtgulF39W
	 2bo8uccZ6obcNYtEBUvFbj2kCsdudNxAp9z1LQCWQTWyqSuVBjdGRct9yfkkGJfRoqtop
	 /hwhxivWoCGVP7mwAdxZ138RvDLy2+nF5U7qfQkbM563K3bxG80d/4juvuVP6DJbr3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=Gg5LX1qX;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02789606A6DF
	for <linux-fbdev@vger.kernel.org>; Fri, 20 Nov 2026 20:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02789606A6DF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=Gg5LX1qX
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3866a784546so1011423eec.0
        for <linux-fbdev@vger.kernel.org>; Fri, 20 Nov 2026 12:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1795205407; x=1795810207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M68LbjcTJ3E++0vyBdIVrjiqmT6srx4BEI+V4obs4pE=;
        b=Gg5LX1qX17VWmImDXwcPSGRir+9pe3muYHdBXXn2TQZBLaax2P5BdibC66jKqm8gXj
         wPaxIl7kqPOBeGHU41R9p9i4a8Vko4bRLscP3RcRlM8AP79jbI/epFFZKM9YeqtMcKfP
         ep9AaCBVX+senmrCXWT5t/PVACubiiShEmjkVFxMK1EIqnWdMQqJPGdsPdYI14SwXEED
         SkcrTKBu+2jku7MZxtBytLDxWEWhCEBjaYULCLysORczlS0sgw6kLKnjOjS7OjPH6Ub8
         zPxjODqEY5YKdEpT9gfUveoR7keIfRLvgKwas334lsYQ8ciBqybX9euPEl+qxVwi2qxK
         VlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795205407; x=1795810207;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M68LbjcTJ3E++0vyBdIVrjiqmT6srx4BEI+V4obs4pE=;
        b=iJyNPR5jxTuyuFWA5ChMqJ7I5ufTpk+RC1Mr84W6q0rbENtZus6KxkEkxqWNRJdqit
         XuYMqhiI9HGCWWAawhgtHwO9UD8rUEmya86hgPZg5vPmKP1+wRHiNGXemJiBo/gBPxur
         sk2Tdt/l7HzZ/pGpbaiHHwb6pVDHubTquV8KudFc9BBCFVJx9TC590M1w2rWlt7uL1zs
         O4BDHbBdJQ226Luz31qz9S2RHC8D/ITyk1SgBO5+Stsb0rVgPYNWKnYy1XOIwazf5zpk
         IO1vAUNeBGQ1H7RLywVjue2ld5oUSQm90zHVxjJMIpvOPwK8SgZYG5w4LRD/SBUOAAjb
         NPdw==
X-Forwarded-Encrypted: i=1; AL+hErEFzadd2IFqv2If/1hXHDJqmJTQ6d5EqfnaChRShB6Sys02p+wHlRTWVBWqKMuDYj4zinwrfAXZnCeGvw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+yrE2gorELsUcOzG+jK38YM+5+w/0kuiyfEFbB+S2rsFnUwmpS
	NGngAiDpW7u11N5M4LpTiXlzJd8Ws/zt2pfWC+g7JBpFXnb0T8YoqUko3w4ToQjpGxSCMdJGSXR
	d4e8Q
X-Gm-Gg: AYBFou3wrrj/mStWE+Wx9JCAmAMhJz0edi+Hk80YLTEWXk6BQXzJ0/r260gc4QU1WuG
	iO8qr38Qhg+Nme+HFAX9f/c7W0fBGWUzLI7RxOlZxwekG5dfNrEWAezSEGnnVWxPYtBVNUd5Skz
	2cYZg41sB2Nbot0B5WvIPZAo/tq1+n/bJ88n1N4NWTI40rGugUK5CzcJA08PpxJezfJKOLdbERd
	wGcTIpfgs8LVfFKSZuh5VM/TwHRP0no5NVZbVdZZNZnSuiSiFT4YZ/kuV4NOibdl9iEaNv0V7zF
	RJrPOHeK4FkxLdlK5LSCXhYj0hgqIugh40Mxr1XBksQuKLWj0+/KYaOsS6pxfZUKe9iknbfJKX3
	gjJyVBDEWC/1Zs4IoPqgpOr97G+xN01oXDtoq870RCiUZg1qoNt1EPKS7xvpAP1Ddy3rtJf+Dz1
	DWHHYfQO60Ln1kJRYEeQy837U2heM9UYCKXQjrXM5M1p8gSQtXkGS7lGVdvOg+bJcgEZgsjpqb+
	VEO1rOqdGocfdMnL7m5sYAOn58Zh3hBCnA0tos9GbM6U6QYImmLVQ1nsrbDEBlZy0eUnGy7wksX
	k8aGpGT1gOZq7uopI44MB56UkmzeVSsnW0Y8q1wzDzweOLSQg2XvVqI4jtUYSVZ0jcAlvNL6LYD
	SrK4UYhghHdyREjFrzUI9q8U=
X-Received: by 2002:a05:7300:88:b0:386:959c:11ac with SMTP id 5a478bee46e88-386959c141bmr1391312eec.6.1795205406871;
        Fri, 20 Nov 2026 12:10:06 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:dd51:675:4b81:7ba])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm8771267eec.25.2026.11.20.12.10.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 12:10:06 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: deller@gmx.de,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	mlbnkm1@gmail.com,
	simona@ffwll.ch
Subject: [6.18.y] Please pick three fbdev mode-sysfs fixes
Date: Fri, 20 Nov 2026 15:10:03 -0500
Message-ID: <20261120201003.42046-1-artem@trailofbits.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi,

Please pick these fbdev fixes for 6.18.y, in this order:

  d15d51fb26e830af58f3f21964f1c09c239077ea (CVE-2026-80580)
  ("fbdev: bound mode sysfs output to the sysfs buffer")
  95e647d2a5304a8fd11f1ba3c8502de700650131 (CVE-2026-80579)
  ("fbdev: clear fb_info->mode before deleting a videomode")
  061db6b7a910b8378f3b2df64f8c0a3ddc6e85f2 (CVE-2026-80785)
  ("fbdev: serialize mode sysfs access with lock_fb_info()")

They bound the modes output to the sysfs buffer, clear fb_info->mode
before its modelist entry is freed, and serialize the mode sysfs readers
and writers with modelist replacement in store_modes().

The fixes were tagged "Cc: stable@vger.kernel.org # v7.1+" and are so
far only in 7.1.10/7.1.11 and in mainline since 7.2. The affected code
is older: the CVE records list all three bugs as present since 2.6.12,
and 6.18.64 has the same unlocked show_mode(), show_modes() and
store_mode() paths. If the v7.1+ limit was intentional, please let me
know and disregard this request.

The prerequisite, upstream commit 6f611e5e5f33 ("fbdev: Wrap
user-invoked calls to fb_set_var() in helper"), has been in 6.18.y since
6.18.57. All three fixes apply unchanged, in order, on 6.18.64, and no
patch currently in queue-6.18 touches the same files. 6.12.y and older
stable series lack these fixes as well; this request covers only 6.18.y.

Compiled drivers/video/fbdev/core/fbmem.o and fbsysfs.o on 6.18.64 from
a cumulative x86_64 tree using allmodconfig. No kernel boot or runtime
test was performed.

An LLM was used to check applicability and stable-queue history and to
draft this request; I reviewed the result.

Thanks,
Artem Dinaburg
