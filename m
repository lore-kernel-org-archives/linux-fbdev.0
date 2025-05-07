Received: from sonic315-23.consmr.mail.ne1.yahoo.com (sonic315-23.consmr.mail.ne1.yahoo.com [66.163.190.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB78A1EA7DD
	for <linux-fbdev@vger.kernel.org>; Wed,  7 May 2025 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746640854; cv=none; b=Ik1gO2Y8tB/2ODImwtlvXZ9K3MKIOZTX0f/OK68KZCBsg9VekBfqT/hxoQ63vpXZbiWsqSoU4DBPuNrL9jsQp56h7ZVDHDRhtJVlR3B2zCJ1HcNcTEk9hBHFgJbl6biLn5JxN1j8n0Gc4FYjoOcNB+PvX5TzDsYB/SSs+uiC2pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746640854; c=relaxed/simple;
	bh=Ou86VlMKYUCA96WTLJTxvy6z2AwSpg2EQr7+SUFgHZg=;
	h=Date:From:Subject:To:Message-Id:MIME-Version:Content-Type:
	 References; b=TOv3okyD0MD5ia3APw8b7Th/FOmGg6GtLkqB7ANZit3uKAmDJTmw6W4BciDoaUgbc1ToiwnC1bactuUi3oFXsqE/ZBMcxZUY3VAY2Id999ESKNmigAClemlSGX0c0H2/optponD90xZv8XSyaAEPo9RuCP9nVvnGquB0R/KBnXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=att.net; spf=pass smtp.mailfrom=att.net; dkim=pass (1024-bit key) header.d=att.net header.i=@att.net header.b=kww4K8fB; arc=none smtp.client-ip=66.163.190.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=att.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=att.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=att.net header.i=@att.net header.b="kww4K8fB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1746640846; bh=oMWtpE2i9jutGCHihtpUTvLdgFDadMRFLFK0rUde3nQ=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=kww4K8fBfiginenyuc99u2RHgPfvgcZWaIh9uZlI7oROZJNlMB0zV7u8laSgid+EIORU4FzSl5VnQGnstXpp2bswdW2/+UV2txWAJeHdr0+uyWnp7lttdnojlLkx1MQrPFKqcK5idVqaQW7kC7XrmAJCWB63pNHJXK9+vrQLoW0=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746640846; bh=jOJJxnF0/5SxcWP44pvy26b2pOc59kqAc6FlzaiVExt=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=YAs/b1xGxk5tNPB2tYC7lsAoHNvZ2CLUT9Zmebz41W4r32yUkBhSCDZ5i2hFBf7xRNjGwFWLpr7IgQSYpKitlm1rRe98dn65KdRMD4RqP/rW+OZ1zDTdZrrmJzHU5gY/xI0imCeR2qcR2dQIt8co4mAQf80uOvj+CmJ1+U5Hnrp5rTAe7EDLvUhIGEgxyGbisX031a8LyhPS5nZSNijJMhOf63cys1GGFBtS6zgYPC3OACqk72wqNSNvTwTfKzRSx38+tTMWEheNbs7OzeTxNWspRIhI3ELFXY6ROJ6eQRq0q9eEmIFG8MoNTPOoMfd6DZiTeA4/OScpXlZsw7i1dA==
X-YMail-OSG: j6v6Yt8VM1kag5x5hOfuzXCa9XomqnHoptoQuk.nt9SOcMuJIn5UdMpvDSa37R1
 lK4C81LmnoOVRv2_.sG.HXCju4XWVIAHJItcK6tbXmmNhAZRQ7aHCrK9kEuew0Lqg_Ita0ghcsQr
 p3OPdoOH_RJyhRNcqWlIFKwX19Psm6sq1a4Hvo.VQAgh4y5Q6unzFENiboPebzshKLyaAMbzZ02V
 AzoZfpyV_NQmty1ttAkjRCwg6bbKhb4XeluefBsBfP9TLrgCPZVDSIWqvgQDsqeupQxTVqSSHuQI
 V1IiRDZ7fIdyU9WM7jKei24bhdnWCGo.JT5Zsjzj9sRdF3fsa_oMRsLj2JXo6R9_MLuJg1YtozY4
 OgmkZND6HX7hyaXfNbn8O0fcDZUmeQQQAxA6jajp_pI3.0p8Ao3Llk0QNZoZ7URZnIpeLW0mnQW.
 YJapeVSJk7cejQlJrNB5PkGDSH3u2ZRZ7gCDEKV3AK52iI1B.bXQHwI4.kQ5J5n_D9ZfwEuOP9MX
 mw6yTAKP1jt01SduQlujqld8wO3DObQR8M6iA_jlHvcRcucMArniMK9MZ7W6vJ95Pw2tDYqdA8nN
 ZooK7hcUcmFQ1suVz5uUKhOcc7FfT5aHBrD3qv4SbZpb8FzATzDmfX66VLvTf1eGMVuadWhb4_Fm
 Rx20o4RglqDw3OSDee2mwXYpj5anLqah3fzoKazCc6AqHPlqQX4C33lfVq0PyB4BMKaDssl6iuvL
 wc9MVPUxsN_4UHjAhksl7XP.cZFrx4QOXRK8Gw86fI.bffkV23RM6AxVL.1YJXpKBLSMmgWeqJz3
 dUlGWWuw1yJ9a3TcOtkdi1woC.H.PlL3pdNFA3IIpptjSdWTBxtNFOYzCx25Bm2W.GefcfeqXBfx
 w6T0TX3LPeH4BOVrZh5QWKBFkGKqCDdF1adw8SzonhKmukNrLMQB7701GHB0giIteaGa9tJqPwc7
 PfPIQJhqbSRvzxQ3h8NL7PHaYp4oHtp67vZjZyKvXWZImry24vXju_G6xJQ8U_5vy.wo1ynCqviw
 IgdccM3K4EcJxwq26sjgCYP5KvQjTcWHvt8COC7xKuLVnpFF2MBVV75XoqCeoJOG9G0wgwzfqBmn
 7.d4lK0.W1zJ.hhCtIkLiB3xs3vv8pjsnOcXRX1gjaDAJaWjS93ScNLl9RKyc4OoyKD4LlvW1oFP
 Z.95b2gWEmPjyBXRnAvRc8LbLECnLfqJWTKISjDVmfyXvRs2_sQ.TkVxdgHvTpIGSmmHYRFKCaMH
 6S281lDJiX9Z19x0lqmSovxCo5FFkVBHx1SmYWqmBiUOS35CEs7TardT7guu.UT76dLF3GN1T4hY
 M4uHkvayGDCCZfY57VewgvHxeYJXuXNvDc_utCI01cHAt6ixbqueSWQ2.bAVl5_6Kjz_AcN4wJkJ
 yKao6yHjp_EbTMNZNN1ycMt8L22E4LPTDrCfaWQydWrxv8pVlC8hCC0f2AVk3zPHF_5IELLaBidU
 rOBrcOJ3Cgg6rf52nM6grry7tXla2wBD.BfV6vnZ0v6UTSxeRzUmot0s5cy0CbReBGhJEvoe4ggg
 48so4o9cSrhl1qarjb7NRqxTfhT7RkVAqu_KcnN3eliare8vomoJPeRzT6DoKDC2NSUFtf0lxYfd
 HAU6DtgFaC1EmNLoEotSpS9F630g7_qBE2sGBvMAVnI9NaZ3MyP.pKeatLYRH7eHI1XMpJe3GvWQ
 Gj6kkqtHw7FMrv4mGDZHpts_WrFCSb5mjbIk6S_GiUi4MVbx791EM2ku4Pd7jEcA51igoc3UJEFC
 xyyO0m5BJkmYcEIuwH3A3J0QCRMMvwfHg9Xde.CnmGFN5_ECXu.Jh44R8tgdRQ_RbOjLCLMQr5m_
 hgxLqIVmGwg13PpfB._u3JiWY8G2TDK7VGr7je.VbGFzZEnB7oeGQg0g..5bVg0EeGNy9nG9i9yY
 yKx3wEV9E_bK2uON_BhKcTVLEnRW1CyV9To05CfG_0Cif5FYVOdzt3BZdRKUEAm6BdH724vWRThW
 oRzXgzaCyWsDmH2c9T7tQoGQ7Y2ohSgR_abwnpZ5gYVyFEUOSOz18sq0EW5in6XI6QiJCBB4Ymoh
 SHJgJO3t7iIgBceFAp9QW34H3aoYXCKQr7eZWRvftSxSrg3wh3ze.vKT_WlI0Nhzo13aF.6JJJvU
 9KKKHc_TEMZL_HNy5Jvc5BYVWNELuagKEQrj3UZkC90T7P91YA4COliTig0x1r7ccSxQuvVQMuDu
 jEGQXK0RiQ483n6F6MIYMUg--
X-Sonic-MF: <pheonix.sja@att.net>
X-Sonic-ID: 7e1a7d8b-ca4a-4a83-8ba5-8932e6076e0e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 May 2025 18:00:46 +0000
Received: by hermes--production-ne1-9495dc4d7-27szc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 24dff9354d3b945d32dd066ac331a57d;
          Wed, 07 May 2025 18:00:44 +0000 (UTC)
Date: Wed, 07 May 2025 14:00:36 -0400
From: Steven J Abner <pheonix.sja@att.net>
Subject: Kernels >= 6.3 disable video output
To: linux-fbdev@vger.kernel.org
Message-Id: <0PKWVS.1URW9ZPYBULQ2@att.net>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
References: <0PKWVS.1URW9ZPYBULQ2.ref@att.net>

 Not sure if this place to post but no response from main list. Tracked 
beginning of kernel bug to version 6.3. 6.2 builds work with some 
modification to build files to pass on warning errors. Less than and 
equal to 6.1 works.
 The problem is approximately 70% of boot-ups disable the video output, 
allowing me to memorize sequence login to reboot with a disabled 
monitor. I can say that I can reduce that to about 50% once you learn 
that they altered PState and set a default later to 3, instead of 1. 
(Not sure why this works, cause always was enabled before).
 I'm running a AMD 2400g Zen1 cpu. Even my Debian/Ubuntu based OS's 
mainline distribution of kernels includes this bug. There are too many 
changes from 6.2.16 to 6.3 for me to know what to revert. Can you 
please help? Get me to people that can?
 Please cc me, as I'm not on lists.
Steve


