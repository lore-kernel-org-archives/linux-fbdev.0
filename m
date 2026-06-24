Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D73955EC;
	Wed, 24 Jun 2026 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292778; cv=none; b=ov9NRn0He3xthKnZTaZEoQZM4zZVp98gruwP0h8gvw5B/EZFkVxwirOHKtCd3riIK3GFTvfbjmsV1jEEHUBDh9btK9tPh8AcsVbRJUONM3STbQYtmcZfnEP64aEkrMh17+gN/7COeoe7i6U2ow1I8p2hbTuYlBMplMj43Jiu+qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292778; c=relaxed/simple;
	bh=L1BDgyrbaBIk0q0GjexggCLY/p+AURs/1fKrIrX/Uk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=jwxlm70OqGP3jS11TJMKVRBe7lwxaCQ3DnrchHfWVDAS+sxcA7dYvyIOjqrNa888oLhR6fUiyP+rlIAIP85BTMkkRiWVQYfGWzDBfa/tsOnDWajycGsKw+jQa6LFoG0V53oNrO61vqN6amzeH5aI4Wh2+Cjic3NO24G4cu7SuCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dNydEEfk; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dNydEEfk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=L1BDgyrbaBIk0q0GjexggCLY/p+AURs/1fKrIrX/Uk4=; b=d
	NydEEfk/f6YHfxScXsjcS4+6cJOsJF9A7yq2Ttdvwrt2G0rblTrx9T/9yuvRMMXl
	Tj1fCb9+9cg5NDBwGhNndLhb7fvqHPnEk5fSB1gQEHTWILV+ILS1Sh4KySnHV8W5
	EEb68q11F5m4qNVslWFchZhnsXAuu0wzDq5KBVnW5I=
Received: from haoxiang_li2024$163.com ( [36.112.3.223] ) by
 ajax-webmail-wmsvr-40-108 (Coremail) ; Wed, 24 Jun 2026 17:18:44 +0800
 (CST)
Date: Wed, 24 Jun 2026 17:18:44 +0800 (CST)
From: haoxiang_li2024  <haoxiang_li2024@163.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: deller@gmx.de, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	"Philip Blundell" <philb@gnu.org>,
	"Kars de Jong" <jongk@linux-m68k.org>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re:Re: [PATCH] video: hpfb: Unregister DIO driver on init failure
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <CAMuHMdUSVacMR2Lb-VwkeZMrS=wKz9y+XtF=nAOCuSLbDs-HdQ@mail.gmail.com>
References: <20260622064915.767194-1-haoxiang_li2024@163.com>
 <CAMuHMdUSVacMR2Lb-VwkeZMrS=wKz9y+XtF=nAOCuSLbDs-HdQ@mail.gmail.com>
X-NTES-SC: AL_Qu2TAP6SvU8p4iSaYOkfmUwSj+s8WsO0vf4i245fO5B+jCLpyzEDYXpkLHTOzeC2LxuSuwqcbydQy+9XTK1GRYskqBOo6GyuEBdF3rm8s9BhGQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <a5a64f9.8403.19ef8ecbad4.Coremail.haoxiang_li2024@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bCgvCgDnx_v0oDtqYwkQAA--.969W
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7RTOPWo7oPSwRQAA36
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI2LTA2LTI0IDE2OjUxOjAyLCAiR2VlcnQgVXl0dGVyaG9ldmVuIiA8Z2VlcnRAbGlu
dXgtbTY4ay5vcmc+IHdyb3RlOgo+SGVuY2UgaWYgdGhlIGRldGVjdGlvbiBvciBpbml0aWFsaXph
dGlvbiBvbiB0aGUgaW50ZXJuYWwgYnVzIGZhaWxzLAo+b3RoZXIgZGV2aWNlcyBvbiB0aGUgRElP
IGJ1cyBtdXN0IG5vdCBiZSBmb3JjZS11bmJvdW5kLgo+Cj5UaGlzIGlzIGFsc28gdGhlIHJlYXNv
biB3aHkgYW55IGVycm9yIHJldHVybmVkIGJ5Cj5jb3B5X2Zyb21fa2VybmVsX25vZmF1bHQoKSBp
cyBub3QgY29uc2lkZXJlZCBmYXRhbC4KCj4KClRoYW5rcyBmb3IgeW91ciBndWlkYW5jZSEgVW5k
ZXJzdGFuZCB0aGF0IG5vdy4KCgpUaGFua3MsCkhhb3hpYW5n
