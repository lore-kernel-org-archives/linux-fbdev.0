Received: from sonic304-24.consmr.mail.gq1.yahoo.com (sonic304-24.consmr.mail.gq1.yahoo.com [98.137.68.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02271ADC83
	for <linux-fbdev@vger.kernel.org>; Fri, 18 Apr 2025 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.68.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744976736; cv=none; b=mEFI+L5c4zzDZt51PTggtC3HLnfMmjPNwyFdpG3bthz5dq38FiDUqFSa+lUmrB50VePXEyLXVbsP/6OyXaWi8kou7RtIMIvawbukb1zXtjZZxYHy7gp7auhXOavQPed/qmlJiNuk2FxwypGilUghjTA7IDnLsilqcFgjlx3VzN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744976736; c=relaxed/simple;
	bh=gBq+R+8N1IjVS76IW5YuqbbBWzqT0h4z0pp5Trbn3xM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oLygxxw3ncTgnmlDc0jVYwHGR8fKAtbBNUR3Mudm83HH+5GxIW9s/VWHavSlQTZd7LLxsMch1OneB//FG92ZYQLR1SktzpLccw5oYDfGqWZnvH9/nJRrSu9Fa4lIsAznPIi0M68HGGzhmKPTl9Pt1NGvGCEHq2+uB+WUMzTzxKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=Sh4Ly1P8; arc=none smtp.client-ip=98.137.68.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="Sh4Ly1P8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1744976734; bh=gBq+R+8N1IjVS76IW5YuqbbBWzqT0h4z0pp5Trbn3xM=; h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To; b=Sh4Ly1P8tYST5h793F4eW9gDl7FXPkCX5KSSIQaBfwUQi/GC3uMU9+V1Q2sigpaMlriUCT7puJjxpbFrkg6iNE8CoGzTDjHy1ZiXfz7HpmhGXn7gjG+jA8z1XLI3kWm7ugmb7jwniVSuOHZNAjF6n/z/PqYY68oWD+rUR5c7RHmyWttj4xsE4/WL35lWaeoAY9cu1gD21nu9/QxFwtCm4yomrSFsiR3vhDdZXxMqDuF1WGf8bp2juYiRG7gtZElsNFZl9M6MiddcB/CM1QPz2zG457EUSBiaVP0zN4iwh6PQHAdrOp34GS3uy0/cJm75r7IHdaDgdBljQOsOhY3Epg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744976734; bh=NSnGKm2N3rBo4I7vB9OYxBiosPs1BoUQxegxjazh/9f=; h=X-Sonic-MF:Subject:From:To:Date:From:Subject; b=b+skrwTl9dZt5U10tvEX1tEzmJMYXUCenc8PPcRkUdXZwvCXfn5hY9pEW1OAusD1qqekJvlCjXUlS7lyJu9Mol7a0MNb8Upcn817vRK1Qb3wH/vPzRqugkQFfEdmD8/zMre4Q3pf1PiU415SR8snlRUYmOrJEAjseF8SkU96+yg4KxEScESpNP3y+XlYfZQF73Iouv1pJPNrodPkMxQrOmvEAHWlSMqF9HuMzpsRKJ1Mn9sR2G8zEUvhTzFWED9SKbodgowYbehWB+gctXaEVuCFiviJMPN5fJFYLYQD2TUQFgzhdr25hmS2GJ7TP3vYahwzMqO+SiimRyxBWVkmkQ==
X-YMail-OSG: OUOvC4gVM1kTrEw9sF2KZUIarwjsbPEiaYz1SkXVTi7kkdo03gjVvUfzZuHTCBj
 5fOVXjsjKA8oYQChBoV2IvC5LCANNhF6L9AtF4CVrCoGttiR83wb6zjBzpY9CIfFXK6CkOEwNXpy
 SCtVMg6AWOpg3QIQtBuvflaGse3mQ88IXR0LVdFmAoBuuzyHUG3mWHLplEpnDkBVBs1R4poiRsFL
 ZEwoU086DpixY4FJO0j9FTJ4Izx15nY2jOwIYEKOKZSby318z9WsRGxYF.Gknhhi.N_paojIGd81
 nmL04auYiXYgiO01anrF3z1TgiJh10NJtevcqZZQjgYhTtWCfXKu0mF8QdyJFatrfHJ6QAkB1ceM
 T11Mozg5DSjTomXdddrL2xRV4iZwT2MX3CmDOE8wKzS4KCTP6.DyBIqyFtsZfj0SF_vUwnrj4PWS
 PtG9x2WobBGdlRZP5cXY963g8KoYpus1Zey8r0nQDcEpJzl79P0g8VOHAMC_3uYIfXk5Yp5z1QUr
 nrRi45umfN6PtZfrGLwdJ1FQzMUpeka.h5d5YABkXvlKiM1IR_QzBZg43FlnBbNFe3pck55bNgah
 mxz5rnbjub4amEquNYyg9JZIjxhaME7ntg6ANmEKyGdbJFcltIPejOwn_9FII4os9RpcK_JgQ5gS
 OhK.UoDCCJGdWJ5kyacZFo7GfgdOFk9MtHzety.NJ8JzSkZ2byV0nvASpWbU.vRMunhGLFrm8YDk
 bmDnExPu5hISLLtzHUGBRKgIiCGBLNgz8PlqGY9cK2LefINEIf0rD8If9Zc_YM62fuPgXOoAJ0n9
 QT67NafQxqe8dDCiP2HZdRjwYJslxS.Frq_wxaQmlx.7wka5obYzKCt3.W9UUaosOL1_OED9A7bt
 ysAL1mGzb2eLZ_C1HQKAmmToo_jmGwdfTBVB.uAgobZ4e9TN3Y4cjjf_JoaAjAAjiWbLF9BHrTuO
 o7Fx0ITrx8IhaNvAox3xe1ytEVN7zOn7GVWQ4ElBAIFa9LuvLDJjR0VZeuQFfW2KZ9FQ4lSt2kVx
 hrgDIHk0tQcMSTm_H9GKKqLRn7hYlpPVzrqOTgHILMFKMI5E84AQIS1VDlY3tLTbta28hEszl.QH
 W4TBvW82laqsll6YiTREA6B7Zfwpdh0ATa4w83r3ItVIeQFMUhqAGGUKJKuxYkpg7KcfG2NtUxBf
 r8kU.IMSVPMwOGNtF70W0WmfsG6017Tuq5kzr3RbWZe0HAnvFQthilaPg1Bl4mpG7Qn6wpOz_ROi
 LuUprxPh09v2zMql_RsJaWTYxmLvCL9gYWKTBNKAt2JdDzvRd0J0s0nBE7BwT909VkMuMi6wqPRm
 bPcWIIv.xFlDbq9JoV2O7n_e5cgxrFeMdsqZnAb6JPQDnJGUzU0cEydkMoqPmJ3TJ_hAsK8LRIaw
 ezSWkuc3Q9ynFBxdmC6aAJ0nWs0VLUpxucrtgNJch3vVHKYKxxBwb0qWiN0wF5qz5upwgNjjYFQM
 a2npcR.1cKgXJQWqIc8OOfLyHxzBVGc0akJvodf1ukzvmOGcH1VBeRrgCz3KJvieFoRHTpuGVcl0
 MbS603O66NLs6_PYYAjmS3HK6QKWiNr.l7gpBSAKkXHQXrMQLOr7n.eTKagtSiDQozXzzxk7xcSn
 caT5AlXYwQWC5P3W35cwdKh6y8anCE8muIgqe.SdWTOcj7iNBnYKFA1XWlCFzevMQOleLDRLrgT4
 J2x0_Un4ubk2MvzHl3QzGCzVcGJyBQBp8xahp41J8DmFnHjMotaVApZqRQXISpwd_zK9dyO6cWKE
 X48kE8GiNu9f9Uu1JKwvezfESEwN.PP4sl5Kz8hP.BP.YHGL8cr149JlkxlXfYdQxqyVAanfnPlp
 AdVYQFFkqAxBmZWOPgSnOkN04KTKxmCiNlq7NyzDIK5sKz0HEutHT41MkjUQKDb0Og12uNkj3Ugf
 8RKpsyV4bdvG16FC9odvzg253pZ_Lv1SHEutoySv4W7wUb6Rav0fR9XFXFf3gP8kTYZ11CQzsTxM
 eMRMbiGfKV9d4eMPG3RHwn7Ot9Kv7ybhBkvhYu75PcW.HegKFsCp5Hn1gqAqWn6Ze14Ipg0q5VJf
 FUM92rAY6MWQoShXXL.DVTRfzBkGu7FgSp7MgmI5dsb1RK5slsKAtX0XMmphO3uY7i7cIKpqXfWO
 CLzdfFX3nbNbMJLEVRfWzKG.TtfDnYcZTvRrCr0_EtdsiZiJvvosDrrNSffoHltGn_sFDIrbk7sx
 Xhk23g9ksxELSYhoMLxoa1_vUYLgMoUSH6c1dupOoUsxXqJ9Vgmwzx1NDAG2x.w--
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: e775a7aa-df62-4f26-9cda-67aa9cae9525
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Fri, 18 Apr 2025 11:45:34 +0000
Received: by hermes--production-ir2-858bd4ff7b-86wkp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2f95b63d88c313d13b5f62c399ed8ff3;
          Fri, 18 Apr 2025 11:45:30 +0000 (UTC)
Message-ID: <6a47dc48a803b6a07a7fcd33eec8df9e60e86144.camel@aol.com>
Subject: Re: [PATCH 2/8] staging: sm750fb: rename gDviCtrlChipName
From: Ruben Wauters <rubenru09@aol.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang
	 <teddy.wang@siliconmotion.com>, Sudip Mukherjee
	 <sudip.mukherjee@codethink.co.uk>, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Fri, 18 Apr 2025 12:45:28 +0100
In-Reply-To: <2025041803-clutter-harmonica-7047@gregkh>
References: <20250417190302.13811-1-rubenru09@aol.com>
	 <20250417190302.13811-3-rubenru09@aol.com>
	 <2025041803-clutter-harmonica-7047@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: WebService/1.1.23665 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On Fri, 2025-04-18 at 12:36 +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 17, 2025 at 08:02:50PM +0100, Ruben Wauters wrote:
> > Renames gDviCtrlChipName to dvi_controller_chip_name
> > This fixes checkpatch.pl's camel case check.
> >=20
> > Signed-off-by: Ruben Wauters <rubenru09@aol.com>
> >=20
> > ---
> >=20
> > I changed the name to dvi_controller_chip_name as I
> > believe it is somewhat more descriptive than
> > g_dvi_ctrl_chip_name. If the second one is wanted instead
> > please let me know and I will change it
> > ---
> > =C2=A0drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/staging/sm750fb/ddk750_sii164.c
> > b/drivers/staging/sm750fb/ddk750_sii164.c
> > index dd7811b18bf6..d4309e0d807f 100644
> > --- a/drivers/staging/sm750fb/ddk750_sii164.c
> > +++ b/drivers/staging/sm750fb/ddk750_sii164.c
> > @@ -14,7 +14,7 @@
> > =C2=A0
> > =C2=A0#ifdef SII164_FULL_FUNCTIONS
>=20
> This is never defined, so instead of papering over variable names
> that
> are crazy, why not just remove all of the code in the blocks for this
> define entirely?

Given the amount of code that is never used and the time went into
writing this, it does make me wonder whether this code *should* be used
instead of being removed. I don't know exactly how it would be
integrated however, removal as of now might be the easiest option, but
I'm not entirely sure whether it would be the best option in terms of
functionality.

> thanks,
>=20
> greg k-h
