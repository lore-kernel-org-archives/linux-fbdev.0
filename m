Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A9782869
	for <linux-fbdev@vger.kernel.org>; Thu,  4 Apr 2024 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236560; cv=none; b=alOJP/3zfGGGYM+jWWq7jU7PEq3odCsmHan9knoirhV0+GWtLQ71vcf+es2Kpqbui7GTL5C2bCLUC7c3iqg2yRvjeqKjxjdhoqSMACWRBTGJgkZ6ZMSDjgXsz8oh7DKmB/F4ozR7u6CggDoyDKLi9E6CEaQf9e/HsoerJfaI9Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236560; c=relaxed/simple;
	bh=9BXbFd7Y7fGnkHUHFbKEo1vJVO4gSVMXelgkrFHfyCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBdfTPxdF4XTSdxQTi+nxd70tPiPG/yB32gy14xWiIpyXrcsTBDNNdNY4/AoLCE10F7nx0M6s6beDgsRBwVXhPLqP+MZhetqUqPocO2asbBe0jiEyKqjQcvOQw298EEVhnjj+h1m2PammOI+wfTdkcoRQf/4e7ixRM5/mVhnJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=LqBbYzsC; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="LqBbYzsC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712236548; x=1712841348; i=deller@gmx.de;
	bh=SpN15ZyMJMePE9qVU0bbP/ZeX3cdCU7WByAccVc62U4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=LqBbYzsCu2yJ4fHhK8NtTs4HsBBI9/u1oFiWYbmEN3WAZgVCcADho/PZ7sNXGtiA
	 lheV/8JRWV19A8yXMKg9gQ/ZtZS6Equ1NWv0Y84WKGhQIkH55U5Uw7fuAdBYlbzUC
	 +Jwc1mdpECfJXqVI+e9PHS7bHeua+wsU8wgMN2pgFJjhpcv4vCpZAwj+tufUEXei4
	 e/BFjxN1IIMN3eLp2HwdlQuKnB+R8JoUEbjtQuA0aie/5ODq/Kp/dGFiQFVzZWm4C
	 dK9YTFuC3ndBURx5pDG+fsseY7ab6kov8k3DCc1NKdQ9wPlTFMv873bfOVIW4kNZ8
	 kLtBM90pueOx3mIDYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.198.194] ([109.43.113.118]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHGCo-1s5YEm1Zi4-00DDVG; Thu, 04
 Apr 2024 15:15:48 +0200
Message-ID: <c3108939-9e6f-489d-9954-82bd6c2dd3b0@gmx.de>
Date: Thu, 4 Apr 2024 15:15:47 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: video: logo: Don't mention the full path of the
 input in output
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@pengutronix.de, patchwork-lst@pengutronix.de
References: <20240404121824.3330254-1-l.stach@pengutronix.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240404121824.3330254-1-l.stach@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vqw3sjLbMfWlclGk5Vj9pGEIZhcteKDwmAKvD1jNqjaerzJSa3h
 aPs709Sa+kvbU5pSKW1n+hW5bmsFwuEDkBoL2d/eAyqUxYCEDCtB5qJ/nWTh8bJUuWJAhp9
 VWFFNlQ3ckSQHJcArzindrroRtDLQoedXhqomCIrjG/l8TUTKvYkUKr8oE+4ZKoVVZYMaNa
 AUviH4QHb1bpm4o/IsJlQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GEiqIQ8wiuA=;11jKN6cUSXxOQiKRc8ci9qEFTBj
 wQ2n2ErLQ3/V8eW0mvCwMniJ1r1cKnxsarqF62deYWJKRcAcVlE81gBDYTpkr9PTk2Pi4WU6U
 YpXEb8RAZ94YAOHJ8kMeTz4AfTWX253vrIADhHf7v+na2ECldMo7I2Ij26ZpH/TmWyUO8hNdV
 MsAXvn1AxSXZolvAB770JQVKn1I3MmWRVnYBZKYQRuszBN+AX1rQhSJmO7sy6HmF+PMphD1Xs
 Vxb6FhsTtpi0sE17p04+eWtWqYAPPTEUQY7LglC3n0OQJMaNV2KqAABJZ/ydobnU+V0u2kNYQ
 gVq2fiuWq15C9ZQglaDLPtLsPatBA7U9a+FyI6EU1f7S7flmYSco9EyUErSKgdhLf5Gs1qBav
 L3krl/bE87dDjqvEqKY0hAWh8lZs8xOC10aNO6yNVxjMVbZTzaVRBGC+HVU4xX8CutSbHnkOw
 ZldBT/wShKhQj2xkLkXBy3h1+Iio9RHBLNMkO1ikjSePzkmaBxGiOihusEPbDFqI7Q2guYLD5
 ddpmbRHN4FtbuymaA8+6cxdK4Db1UlxwkI4Tus+PeQwQ31DzGD58cDQpHD5DlE3Tkfcb4F7Hu
 5+w3lR5r0wLR09m6EusoDuDKcXgDgU/HAz0tCI5FCfVeoLY9uQcLZf3lwEWTQOWvi8xlmseQL
 ewijzbFGr6dGSETlo7B0E/SUI803JJCZaYc7ZtVQ3F4zdbHJsbn5mrsANJBtQyU8Altq9bBg5
 sN3i80BGC/KIusaGwy6SgaXBW7HKYFabNBTQLE4YsiYlT1veWk7zvfz8AUmiH6vrthQsYexAs
 vimTXG1F7lNQXVtGQi7d5EvK8qYkcY60sFmvDknT7GbmU=

On 4/4/24 14:18, Lucas Stach wrote:
> This change strips $abs_srctree of the input file containing the
> PNM data in the generated output. The motivation for this change
> is Yocto emitting a build warning
>
>      WARNING: linux-foo-6.8-r0 do_package_qa: QA Issue:
>      File /usr/src/debug/linux-foo/6.8-r0/drivers/video/logo/logo_linux_=
clut224.c
>      in package linux-foo-src contains reference to TMPDIR
>
> So this change brings us one step closer to make the build result
> reproducible independent of the build path.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>   drivers/video/logo/pnmtologo.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/logo/pnmtologo.c b/drivers/video/logo/pnmtolo=
go.c
> index 2434a25afb64..59ccd721e8af 100644
> --- a/drivers/video/logo/pnmtologo.c
> +++ b/drivers/video/logo/pnmtologo.c
> @@ -223,6 +223,18 @@ static inline int is_equal(struct color c1, struct =
color c2)
>
>   static void write_header(void)
>   {
> +	const char *abs_srctree =3D getenv("abs_srctree");
> +	const char *rel_filename;
> +
> +	if (abs_srctree &&
> +	    !strncmp(abs_srctree, filename, strlen(abs_srctree))) {
> +		rel_filename =3D filename + strlen(abs_srctree);
> +		while (*rel_filename =3D=3D '/')
> +			++rel_filename;
> +	} else {
> +		rel_filename =3D filename;
> +	}
> +
>   	/* open logo file */
>   	if (outputname) {
>   		out =3D fopen(outputname, "w");
> @@ -235,7 +247,7 @@ static void write_header(void)
>   	fputs("/*\n", out);
>   	fputs(" *  DO NOT EDIT THIS FILE!\n", out);
>   	fputs(" *\n", out);
> -	fprintf(out, " *  It was automatically generated from %s\n", filename)=
;
> +	fprintf(out, " *  It was automatically generated from %s\n", rel_filen=
ame);

can't you use instead: ?
> +	fprintf(out, " *  It was automatically generated from %s\n", basename(=
filename));

Helge


>   	fputs(" *\n", out);
>   	fprintf(out, " *  Linux logo %s\n", logoname);
>   	fputs(" */\n\n", out);

