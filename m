Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B69221719;
	Tue, 29 Apr 2025 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745958361; cv=none; b=gncfZoIiP6DMyMCVtVyQzgJzEXd/kuunAdHxNOSCbXofhFB/X0wVoIaZVZlB2XOKfHmk6ZBnU5ihqWDOV8p1RgH+LqsT6DA+Bhn7780pX+C5wCvHD6y7pilIWmV5IBKJyA+dWVPOu6Rp8wEpV4Vh7rvzRVNP1L+Z32WASW5z5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745958361; c=relaxed/simple;
	bh=xDKKPU38K/wiLt6/Nx7DJ3Nw8x9KGNWOyymEkjs8yFE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=a5nra3nobTcCTWWTpisfchJVIWz0nAY26SoldKZ4CL7rNGrcVHOiRVWMDFMFxm43TpoWWaKLlOlYxewEgw49VirKC/NcXEmLL681O0Fs0V/F8M9ImOnNZkvlJEJavJIKOh7BYT7QUD7I5NJzmoPSH1TrrRpFUy4Tle0Fqdp3yv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HucJEa4F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HucJEa4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A052CC4CEE3;
	Tue, 29 Apr 2025 20:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745958360;
	bh=xDKKPU38K/wiLt6/Nx7DJ3Nw8x9KGNWOyymEkjs8yFE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=HucJEa4FIFgvQJupmc8K6x97yZOvM3Egz+9GpWwCWvaNSCgp9l6Zer2iIQvuJLew9
	 yLn/SQ2DIm6WWDJlGZcCA8LawRzF5vKJT2lHEs1iT4+v/VxLhe/DD84IvEqu0VZYQi
	 ZTyhkFrj0hsdd3PcoM6xD152uAxy5+//J0aeQRonf5AHR1LAeThayw8kELJyogK79N
	 Gwd5LCg03XAStTqPqSdRuzxoJk28+cscajD2RdC8f1Egx3VeXknHOAr4h6uYvlcd8A
	 Ov359TSd2h5Bxjb7yylUW2qFmpug5rMMRBQs5aTLcgYAB5ML0I9vj5SnunWJZ95jCi
	 gcDcaawrtGhyQ==
Date: Tue, 29 Apr 2025 13:25:55 -0700
From: Kees Cook <kees@kernel.org>
To: Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>
CC: Javier Martinez Canillas <javierm@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Zheyu Ma <zheyuma97@gmail.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: arkfb: Cast ics5342_init() allocation type
User-Agent: K-9 Mail for Android
In-Reply-To: <e68c6218-6055-45a6-b96e-9c8381a4b409@gmx.de>
References: <20250426062305.work.819-kees@kernel.org> <b982d4f1-6ed8-490b-8d47-6dc5231913e7@gmx.de> <CAMuHMdVY1_gEqULGD0BzdTd05OAkodhk+RXKRAy-T-0+RJt7yQ@mail.gmail.com> <e68c6218-6055-45a6-b96e-9c8381a4b409@gmx.de>
Message-ID: <002CF88F-6023-4A1F-A436-EE3720BD7B7B@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On April 29, 2025 1:17:26 PM PDT, Helge Deller <deller@gmx=2Ede> wrote:
>On 4/28/25 08:36, Geert Uytterhoeven wrote:
>> Hi Kees,
>>=20
>> On Sat, 26 Apr 2025 at 13:33, Helge Deller <deller@gmx=2Ede> wrote:
>>> On 4/26/25 08:23, Kees Cook wrote:
>>>> In preparation for making the kmalloc family of allocators type aware=
,
>>>> we need to make sure that the returned type from the allocation match=
es
>>>> the type of the variable being assigned=2E (Before, the allocator wou=
ld
>>>> always return "void *", which can be implicitly cast to any pointer t=
ype=2E)
>>>>=20
>>>> The assigned type is "struct dac_info *" but the returned type will b=
e
>>>> "struct ics5342_info *", which has a larger allocation size=2E This i=
s
>>>> by design, as struct ics5342_info contains struct dac_info as its fir=
st
>>>> member=2E Cast the allocation type to match the assignment=2E
>>>>=20
>>>> Signed-off-by: Kees Cook <kees@kernel=2Eorg>
>>=20
>> Thanks for your patch, which is now commit 8d2f0f5bbac87b9d ("fbdev:
>> arkfb: Cast ics5342_init() allocation type") in fbdev/for-next=2E
>>=20
>>> I applied your patch, but wouldn't this untested patch be cleaner and =
fulfill the
>>> same purpose to match a kzalloc return type?
>>>=20
>>> diff --git a/drivers/video/fbdev/arkfb=2Ec b/drivers/video/fbdev/arkfb=
=2Ec
>>> index 7d131e3d159a=2E=2Ea57c8a992e11 100644
>>> --- a/drivers/video/fbdev/arkfb=2Ec
>>> +++ b/drivers/video/fbdev/arkfb=2Ec
>>> @@ -431,7 +431,8 @@ static struct dac_ops ics5342_ops =3D {
>>>=20
>>>    static struct dac_info * ics5342_init(dac_read_regs_t drr, dac_writ=
e_regs_t dwr, void *data)
>>>    {
>>> -       struct dac_info *info =3D (struct dac_info *)kzalloc(sizeof(st=
ruct ics5342_info), GFP_KERNEL);
>>> +       struct ics5342_info *ics_info =3D kzalloc(sizeof(struct ics534=
2_info), GFP_KERNEL);
>>=20
>> sizeof(*ics_info)?
>>=20
>>> +       struct dac_info *info =3D &ics_info->dac;
>>=20
>> Exactly my thought when I noticed this commit=2E  Adding casts makes
>> it harder to notice any future discrepancies=2E
>
>I've changed it accordingly=2E

Thanks! Yeah, that's a much nicer solution=2E

--=20
Kees Cook
