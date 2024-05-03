Received: from sonic304-21.consmr.mail.ne1.yahoo.com (sonic304-21.consmr.mail.ne1.yahoo.com [66.163.191.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863B2156C52
	for <linux-fbdev@vger.kernel.org>; Fri,  3 May 2024 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714755047; cv=none; b=qh6OA8Chi3FVkJ2jZibqxzYmRMfVgOOijVGDyf20McLwUYPLcwLb6h1kHtgr0ioz5gg8XMogwKDABO7N9OgQIxXAAvx4z8p6pkNxNmq4dHiw9yQ6/+AsenXKueg66p0nbd9uskQ6RzunSnMrLeoPFOoirc1ueuo81kdEfrEKdhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714755047; c=relaxed/simple;
	bh=OpuBHTwhnfArlf2PsQ6g2wnS/DKkhtNrSqNbd0Cd8cY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=E8Yo1BkFXxphRc3aVfbnhEng03jmfgcKcMZ23ko9RiO6e5KJbvxEAo1nKbKkY7z7TbwXZmmsE+3U+GF0yOaAUEOjzri3B5VPE7olQUEASmE/fryBsxOhmHc0YyF+667bmrumJ9ckYJY5YQ55n49rFA+MuR8ixT9f59gwBxwb7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=kPZy6Sj2; arc=none smtp.client-ip=66.163.191.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kPZy6Sj2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1714755044; bh=OpuBHTwhnfArlf2PsQ6g2wnS/DKkhtNrSqNbd0Cd8cY=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=kPZy6Sj2+mu+YJ/leZPNjcmKEDE0pl2P8drWNUnqlYQsFR3xFHFNNIOqIwE53i3aq6OhZyhq+OlbO1Vay+5KLzi3k/u4HOuaBw68zEW0xcKQrGB4y5QEVUjQ3hF7Gzd1Ys9Kp1FbrPdjpL+/wSPaXRLZZ1NhJP03SMY1uEVdJde+sPpz0J3oPjegcI3AZ8rhnRcrHSywYy3Blt1lbFDlvLUzMDDS8FT3KW8/hvLlnuuMCXZ9SwNlmOBqABAjx7Ylhwm+KwubLCYXxXUsPg9Vn1iAVJIM5ROangUNfRO+rca3bExxjm8YP5aVO5iFV9xOaErM+ZsPjzB36LSKrw+kmA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1714755044; bh=RMWEDaYeZhcrS7Bi1gxI2B6M21JtD11WSt65H1rSUiJ=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=SZNYFTb11uy6HlOqMqwxdIA0ug4OiLp4TE4w9UIsJuq7A1/ohJyJOGKdfMQx2sQm49QoW3aljOKS8nYd3uRWF5nIbnMJHanNwXvbMFDxwgsr8luq5B+I1I82BIDEKENO5vABx7CEIxpyfTrPRWzJ2ADAAnQgEXElfHEBYqPOyJkoZQhT7K50xpCXqp0UPe9+4NQkjc+ECnLQkjtex2KCqqjV7VoydnhKyhfEfTR9E/mAk230KGGFgI42e+ekEPb0uJk7kuVrZbA9zTLg1uh+byyZZH5uEIXH0+yKfyqO/sUOzpXQjMD3AhXtIczZJt+UUszGaqgIXWxNqJ72BkeyAg==
X-YMail-OSG: u7CikhkVM1mEMBJgRhgeFfykAxEVELBK2D8SuCjgxXEHVfhg2Mh1jCun.7euP4n
 YuKTaefJTFGNeHA6y0GKN8r5o3pt6uZ4L7fJsdR9huBW4xI._HbSxGmtwL7Q.r.q2HNLUhrxNcqJ
 iQk0clfL4rJB7emk22t.djOQDkv.3brzpvxYm7mD76etPxjsHtjznB4tUyLYzXFO.6IDvqV7cuVU
 s7YU8V1I5QXnD2RY954jhO_zWBG1FHHEhnmc2lafLzGClMxUD1sSeuRmEUnPzd9UJb1XvnNuPzoR
 HDhGIP5Qbmk9vsiiNBfzez4x4g8KFg3M.G5Uk5n2WX7L_k6B9_ZGCVtrDh348xQOjY1Y_1Cd81b4
 noQswoJiZsryvGYbOrdRyqJAQrn1NxglYFDVVQ8ihsj3JFsAg8idJ57wbS4lW1zJR0z2hwX0D5L8
 Ah9_5UWH5vGNxPLESZLBXSsL8X91UjsCxu6TnFw7uhzNds6_ofPqhWISo6wokWtoHo4s5i_Dd1g1
 pgusS5pHJ1PX8KPBpv1fMxnUGbma5Mq06lphYU_SSXY4i5qCBUK37DNnJIV5AgXDEbpreAvPY5KN
 vR8Tb6Q2yF6axmhLYw2qwsfnAUr0vA_Jzc2pUUzAeDxF6I0UPkjLA7a7yiaDIczakKX6dwdSJ.mG
 58OM_lkjw52d71AdkfrDJUX2MksGHq1K63WSXuFurdzA3S18AlusvV.5PFProfYCIRztn0BDISD2
 Qa0GpFEiFwlzby4x0fgGxV8dJZ7Xq5ugd4xBCV.6.A2dnjy26PjzG0jwSLH9GPjFaJGaVk9uUasX
 Ix6sSXmG_K_jm3KYote_PDn6JLIa0hbq_HNpR__3cjgTP1plr_6Akyd1GFihjkHF_mscqbk6S76Q
 jpIhhLUmyHcsZ.NWMfj678JphFYyxPaOOxLXXAMfL_zhiEjNUJvyW4VexTTgNZ3xy4unuIoacAoJ
 i65ljO1IAGxShzOLanEqKFAMguiVBBN84wbYDBpr0kbG1lU32E1cGTIczqgW2w82DRV0zMHp7_sk
 RkIuj5k_JzxlnN5zNfGNQ27h3I4gVCCP9gOc5wekqRwLV8ifLYRb0bPkd8tD7JmD2LZ4W42b5344
 HsLeoU48IJJDVr0YJZVirumWrxsKvF2I3o7_KXaVyliAP25U_deLjmT.BBE1UONAftNh2kNMOZhG
 ak5IKdiwLyK6_12ip8oazaBJj_0W2q_gqrvjiq4bKG6iI._HycRHunW22uHeF9wvQrk5tc_APutn
 ySnbWQ9ziXxvaBWtboypHwNZUDPR.1KsQgcqJSY2RL3r9XfaUo845YNVfdFuXJRnWkIvdttDKler
 fyJKbvSmeSCJKhNzvxBHRQYh5n.3NYvEikv_TsZJacJhbUnWXZUvXasP37MGyoQ7GLT5da687ovE
 MPDnTVH5iJuFgVqg.nx3oyRUA1nTBGBfvFZYSiKFVAvWHa4stTt3NH3SSaTDdTBWfIGRsYGhkvLA
 dGy3Z7XijAEEDsjVV7IcaVpLVWIbJ5jIIBJ13eYMxWVJ5f4A4lIZrv_SZBpvByB1sfv.DS7gSonq
 1VNOutIuK8hijTa9otiRaFsP5_Q0XVFGUteywvHokJuiKc9VgRr3JHFzTPQ4VicD_5wUtc5IFJ1G
 Whv.16lmZ496l.ekC09_B7nK3cP4JcBG1bvLevBfXuZGDgqGnk69NAcG7XfInLZXd.siTtH_j2Hu
 Um8ryul1Tv18C0USqxm8iwpFTlN8Nnzyfmboy0o0wiQplgRXpa.HUUaRAp_Q1evqftIW2KXhIQd.
 PgvidYsIBtF.XIaFWMsLdcMg1GvBlnp_6PRqwXVoLM2PAqh5VqVkQQTOfaBeMPEn8jtbd6qNLLqP
 0LUJpjXA1La1EIPftMu6oPuaNY5s2vCt4KwXJcivqOm8eJpB7YSB6SjubeIV9IqXdILqqdTIJ5I1
 loXhSfvkPvTocCDcdoz7FvbKaejGqeAjQjG8RIM0v82Pdtw0DCF.8aCwGPn7CiVmUwVA3AB8L30S
 N_n9FCd6TcDBPoK5HwRSX..z0kdfVosVSs6SS2qsrOs3jY06vlXP0PhNz2EG_YmgI7YvRoqKxbY7
 PKcwpvJsXvM7YBuftOiseBjk3I_KzychmFW.f.Ls34I5eM8XzWMW0LfYeBAwTIprJKhvL6V_Vrms
 tgESrkIU7v9UtaRwWh7DKRHDJUDHgqExo6lBS0mqHPrUKy.hVNgkJlB2PDa_Qv4JSP3Rf1VmTgvH
 Fcv96CSp4tjyCAXFkI47vWUo4VCWan1qd7NG.JaBVJ1kVaf_Z0uiLr9CVPVJD6A.o_UxUDqo-
X-Sonic-MF: <ashokemailat@yahoo.com>
X-Sonic-ID: b20f7dc0-ce88-4f67-8215-c25d657d58b6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Fri, 3 May 2024 16:50:44 +0000
Date: Fri, 3 May 2024 16:20:24 +0000 (UTC)
From: Ashok Kumar <ashokemailat@yahoo.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, 
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"outreachy@lists.linux.dev" <outreachy@lists.linux.dev>
Message-ID: <1389558595.6771301.1714753224419@mail.yahoo.com>
In-Reply-To: <c8d24241-1763-f7b7-4491-2e5aa3ea3be@inria.fr>
References: <ZjRDUO6/M+RDCcQJ.ref@c> <ZjRDUO6/M+RDCcQJ@c> <c8d24241-1763-f7b7-4491-2e5aa3ea3be@inria.fr>
Subject: Re: [PATCH] staging: fb_tinylcd Alignment to open parenthesis
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22256 YMailNorrin


On Thursday, May 2, 2024 at 11:54:58 PM PDT, Julia Lawall <julia.lawall@inr=
ia.fr> wrote:=20







On Thu, 2 May 2024, Ashok Kumar wrote:

> Corrected coding style CHECK: Alignment should match open parenthesis

Ashok, I think the code is nicer as is, because it has all the constant
numbers lined up.

julia

Thanks for the update I will ignore this change.=C2=A0

Is there a list of exceptions to the checkpatch information that we can ign=
ore in general.


>
> Signed-off-by: Ashok Kumar <ashokemailat@yahoo.com>
> ---
>=C2=A0 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
>=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/f=
b_tinylcd.c
> index 9469248f2c50..60cda57bcb33 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
>=C2=A0 =C2=A0=C2=A0=C2=A0 write_reg(par, 0xE5, 0x00);
>=C2=A0 =C2=A0=C2=A0=C2=A0 write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
>=C2=A0 =C2=A0=C2=A0=C2=A0 write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x0=
0, 0x00,
> -=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00, 0x35, 0=
x33, 0x00, 0x00, 0x00);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 0x00, 0x35, 0x33, 0x00, 0x0=
0, 0x00);
>=C2=A0 =C2=A0=C2=A0=C2=A0 write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
>=C2=A0 =C2=A0=C2=A0=C2=A0 write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
>=C2=A0 =C2=A0=C2=A0=C2=A0 udelay(250);
> --
> 2.34.1
>
>
>
