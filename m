Received: from sonic311-28.consmr.mail.ne1.yahoo.com (sonic311-28.consmr.mail.ne1.yahoo.com [66.163.188.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0043E28373
	for <linux-fbdev@vger.kernel.org>; Thu,  8 May 2025 23:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746746617; cv=none; b=ZIwbfGibeVWVEVOXKH2TeIoyF7CL/H9aNxbS9D704c/vB/97RrlwRfag/Klq8S9jpF9JWLtgyvIYP2YsQdtriSweWa8phE3GwOAUiSCbouXcqzGCktoNdxXNc4td5wzXZhQEN6/o621AV/uk+BmgrUqc0V7Z9NfFM/2QnOc6o3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746746617; c=relaxed/simple;
	bh=OJlKv0wEKixT5BduJT56upmiVPhxHrP+sUAts9OMcRk=;
	h=Date:From:Subject:To:Cc:Message-Id:MIME-Version:Content-Type:
	 References; b=I1I6C5lXjZUgvJJNO0cbGPo+LloLKFop1VLYEOMIQY8vGSe1r/QShgK1crS1FzHUAoNYH24C65hyc+uVWQ4lXoBP/6KRXk7FCIdXZUi/gQv0JnLuHlOhCaxndqOvWeI4ZqfPVSjZ9dDx+zgaWoowkWKM3HhvEgoJysz1RmMYkUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=att.net; spf=pass smtp.mailfrom=att.net; dkim=pass (1024-bit key) header.d=att.net header.i=@att.net header.b=ET8sbT6I; arc=none smtp.client-ip=66.163.188.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=att.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=att.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=att.net header.i=@att.net header.b="ET8sbT6I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1746746609; bh=fu0kH3UNF2gK+c5q/9U5pxvU3EgHIB/GGSpUDXVmTAk=; h=Date:From:Subject:To:Cc:References:From:Subject:Reply-To; b=ET8sbT6Ik4A7kLejLkI7FXtzaSCkXJlxw5k7vkYzbeRLB5C24Rj6Wnz46M3RhBfYIUzS2ek1sZJPkI01cKMnuv6wHo4rJYwC8e6bVWk0It+EQraVtq3DlwkZnwHLxp+d23BozufkW6eB/rMzvEPGqA3IQfExH/gWIkPA3FhbsTY=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746746609; bh=dDpQK1ZL6WUYbUlk0jT3Y/Sj/UZeZBRTcQb6ijxmvar=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=sh1CRFEWxj3fkinslVJjDzhvGrFF6eFKtEcvyRkEVFUn7D5ePjq7xrWdFHqMHI3yZy4UKlTM4e/omn8LYM4bTyu9T3gVAjeRaZDjEKrVWDNjTxo3F8zKx/HR1xfdaNYYWl45joybdwTCxCDhra7gWM5aqRSbGAeB4ote988rdsSO03iKFpHfsGgNGaUOXc3DB42PZFlBo2oebTwav6GOwkDJNtCYMI6qGZAQhY1PSHjWpMNf04QKZqPp2nzEPTIrTOovr9J1R/NHNH8edfqXgvXuD6+e5t5FwXCggPXhNNVVxE6Wn62TLPGy0V099m3XbfTnv3GxSPtv57rp8H41mQ==
X-YMail-OSG: 5p_Ygu4VM1mrKVbiY1qPQgfxqpwGHWp2Re.tYtM2bRSQZ9eMg.dargGkxXzuhnr
 l8J0BX1N2u5INkQ3UoKOweM2_g9M8X.ynR0ni5uuqgM1roxwcEaY_vaLoEh_1ob2YeyS3LpW09yu
 J3GrZgtIS3Ix_tj3zacVt45z0qdn4kmiLWsk.qioRKxNQRcvHuXuOI6JDFKXQUw03u3yUzZXOFhK
 A8RDgvPFMbwvHrUn2CboLEMYMwpQ7_TV50kwEo1Fiwc5ZVTpHTfFBQFFH5qcGkvLX6HrpwmnA3hL
 y6Hn74INP7MFVxYPCLublm7Vb1p5YDR2eReaR0cVDg7q7cAov3e43uh0TZRPf1fTHADrj24UIF2i
 NMecD_6QsJOF4Ne7_KI85ZptvXXxNR6JVWBIv_Z.33jRINy21Hvmxdhs87OEh9y2DOnB7200rN3e
 f_OjevfZsnAOlpqklGEOsA7rUpOI6veyAtuhz8Eq2BKISUt7My7slZmQRAPyhLxVFT6xPXCJ1Th.
 3VK.NpK922U6CvOkWYnQ7l6TfX10OnWx8gZythD8SOj_FtD.mbB1e8xuqoviDsbpD1nTwMEph.xr
 IuddZ5aHwDP5UISxJy.9WzPhzqaLdlLpHswTAWXjEqUySKrzZ1Sauyqn3i8LOLieKitNKjg99HIx
 uQiz_k6BYA1kZA3nRImVUOFygEhE53IGJ47FeOTnplyedeTWMJTXbLBAmVvflIA_MjlJhGUWMo.Y
 YTqXzB2MnsDmyYpLx86WklKMd4h4cgF9hAUkzqUP.cPcExhsdhKwYVHERwm0QOk5oWVqmArGH1vs
 NqsT.Cr4I7hGFWmxljFK_GL9VERlvLhukyrWaYdDuYsZaDmgr_ZukZp_m.A.kBf6kmjNifIcr4jH
 n_zP_HFl2ycCKGh0v3PbLLjidZ4WcfL8a5fSS18PU7o2jynaqH5JOttKMnyTwFyKhn6bLK4Tt0eg
 vmS05uBlrJALdmunigDPTyrayFXWwVWQrek1Ul3FOoukC_PXK1iowtZ9_EhSqiw8MvjdtJ065qfF
 6rY0CeQA84zW6eL9WEgfa5dplPMC63mxCyutlsFqeMU7G9snkEBxIs5x1uZnfyjEZBAvpAv8I6K0
 oUeY.aL3Ck1rQFvmQ5BDu5pWjxVLJgzy5.HbeaLpsyM5gpLo3Q5mGTwGU3yb0Nmaz48UItdER9jy
 WqPPrEH2nCsjlAQiAZKIRYZFmUqMaWconqmE4mROAF.tIG7oaTttNntPgCwTUTqx0jkmk1dxgUAr
 RQ2Q8F8nsNSPTaXMNXuv.AvWpnvL6hZOesG.IFheLziVYWt.h_mMkwWU6SgauZZG54CCKQu7ekOj
 N4f1awJfn.VIETL9SPEQYIUl2b1qoaOlYjHyqZHgSJ1a5pPLN3n4oQPdWOmW5isn8Thy76cnxSG9
 54knqsYQ2AIRZOqvKMWx40muV.2G1l_ExMiX34UNO3Qnaw0reACqYcD8XItQK92_Oa7eBLYpeem9
 9DS6fL1mmmxkdrMMCp7AOUYnuYWf8fHbqkRLZJkiHvpS9.s7p8u4nTrWf8iAy_Yx05uj1cQr__ww
 DAWvi1warOqQjGyOtdSGmh3lmjnYeu6ClNjSvtMcfQOa0I7IxQzjxi9.qmZCiqrz0yQTp7JeeiPO
 JcktIppI5rs9GsuVVgRpKA4Lr8_3do3Fg75ZeqdxaqncqybPhbhe15ZG.VAmkg0cNaoFvPy3wrHh
 0Bb32QP2WwPCbhxiqk__oFRKcmrhODSD8jaIZmYR6r3wl0RC0c.OGQnaBEa1wSWg7zKM6yLIYd1U
 3QuFsVqkjLWYH9ui8zcVd89RUjWMf0GLYMeZkg1BSJvmoR8Ni2Oa8xX0wO3dy.1tERloEhBl67Rv
 .CUwodBy6IHXafjjyzz1jGpM08DZyDm6hzNLxzmUHyjR3zFOaMlAAroVs1bT4n7lyYYp7xKsmWTB
 uR4WyzhWtIQUXVlKmg6_qtreY0XLTuxlr3cALstfDHwF65DKOSp0Jm2WIi91pZ.L6shjSZiqQvHY
 AEpo0QIrIcHRX9SkwavoNpSYL1PfMLXMbpzFB1S6zRI2TaYckXKSgP8cYNr_ubhsrh6zeasAfrn_
 MpcNNIUL5j_39s7Q6DvgKyF8VE9uCkXLJOEpEAaNjvSQQejRqzUQj8WqOO9KEpOtOFfKH3b3B9fH
 SZ7lKxNNWx809cuZO4CNp8fDapLGY4ctMAYrAqH0ywhc4hCV6.fdahC5xjdr2wBzE9OC7IagRCVx
 5T08Df3MictLu4djo..EJWA8jiCdlyfQhaOxpvUlhrwvnyg--
X-Sonic-MF: <pheonix.sja@att.net>
X-Sonic-ID: e7d5872f-7a08-4624-b3f2-32a66dc2e25f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 8 May 2025 23:23:29 +0000
Received: by hermes--production-bf1-689c4795f-t7r8f (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d3d5ff78aa8107f14ed08ea5f425e2e1;
          Thu, 08 May 2025 23:23:24 +0000 (UTC)
Date: Thu, 08 May 2025 19:23:17 -0400
From: Steven J Abner <pheonix.sja@att.net>
Subject: Re: Kernels >= 6.3 disable video output
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org
Message-Id: <TAUYVS.CG2JM4H6L6SG2@att.net>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
References: <TAUYVS.CG2JM4H6L6SG2.ref@att.net>

 > You are using the DRM graphics drivers, and not the fbdev drivers.

Great! Heading in right direction. Verified with:
[ 0.308883] amdgpu 0000:0e:00.0: Direct firmware load for 
amdgpu/raven_gpu_info.bin failed with error -2
[ 0.308892] amdgpu 0000:0e:00.0: amdgpu: Failed to get gpu_info 
firmware "raven_gpu_info.bin"
[ 0.308899] amdgpu 0000:0e:00.0: amdgpu: Fatal error during GPU init
[ 0.308905] amdgpu 0000:0e:00.0: amdgpu: amdgpu: finishing device.
Shut off the driver and eureka 100% monitor or 13 times in a row (more 
than 4) it worked.
  At least now with the who to contact, progress :)
Thank you and God bless!
Steve



