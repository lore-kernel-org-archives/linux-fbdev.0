Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3C61419B3;
	Tue, 18 Jun 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718712157; cv=none; b=sOTj1eZNI3Pp3i+eHrTj7HaDlMyryEUn2DyHcNpJ5dqVffTPAbsVN1aYJTys/3/hpZszNBkgb5A0jrlodzDCOSxRrAhMoYEdQW641B86Hw242aiAyoskZpQ8UcLVYqgflMTmcrp6FmYxC0lakQNaB7tDULmFqnwfHGEBRMV1x3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718712157; c=relaxed/simple;
	bh=/PDz/xpL0YIwagnMrBVoYHnF3YhYaTqwbvNs6CfbhnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmUJGC+NvZqzcMzlvjcyBKfxtfq77485Jvr2M3IRWdMER8+WT/z9fJr5CrsgKGeI2svE5BN7tvyeM9qyvp9IDJ3kkyQxIr/sjS03ZlQI+K4ohsP+saiOPE9h6isBIdzowrpg/sBpMWYS9IgJ0rUNUuv926NrH6vSN508FJoNYsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=J59HipBt; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="J59HipBt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1718712147; x=1719316947; i=deller@gmx.de;
	bh=KazL8lPyZjhl9SQQly3zXXFrIFGEDfdAjzeR5tlpaJk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=J59HipBtRPfyC8yFgvqH0LDo3UjFbdqWnvh77mR3Y8QNMTyyCgZWbB68WeLqllAH
	 oMHKaljZb9Cp73CKBPKswaPVcQbc3+CvSAGShjumoqoj/0+Ix5Rc22Jc23hDwnyxL
	 n0s80aGJSjdDQam8yYIrg4Tj0HXOx6c5In72n3fSdopi57djVYi3uo3GfH73LHXup
	 iZzNRpitCpDBQKuiBTdGCjG1aiMbLvOoYtch5udkF7xOpL5nEEuWVbdZ5GlO7AiaA
	 fhEcoqzVFm5jHc+8qRjQ8J2K5oWOeQV0r3OG+C8GGQj5zFXgGRsU18CflOpZ9lNNT
	 j/JfWRxBsSBwAKigig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mn2W5-1slPS008AR-00hJdM; Tue, 18
 Jun 2024 14:02:27 +0200
Message-ID: <edf45156-4ce4-4ab1-a3b8-32d1628feb66@gmx.de>
Date: Tue, 18 Jun 2024 14:02:25 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: amifb: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20240617-md-m68k-drivers-video-fbdev-amifb-v1-1-85f74746ecd4@quicinc.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240617-md-m68k-drivers-video-fbdev-amifb-v1-1-85f74746ecd4@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nzU49krb0P0srJ9sw/bU4rEepCemcESpPIGap0VolZSYs0A5kns
 ITa1oudBheWDHYSOTYWouEQ76Pr0A7Ql24A5LY2lo/QSLhb2lmqjmFVBB9/g2D+yyJD2x2Q
 K+oocN03dL3OqfAoX6baAMKe+glAgES6csWq9NWiwWX/nozz4j2Jc6+J1muBRd2/x6MM5hQ
 r7LFf8WTUd8EhtjI30IBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9mnA1uuzbmQ=;iLHqUU7bXPbWF/ysGPJ9+ymH6SA
 akJxYli97gjGeOv3eR4lsKTHjRwwRvdjrzEiAlWvVQJZ/2xRn2xylmOe7jERUT7T0UZ1nDs8v
 gjXwQ+KbrNu+n80/I71Tv8AV1p0kezK0mlPw7Iz84n2nEbm0s1FUOP3JROqNyCz/aU693Szng
 frSm1eae6nN7bJyo4XM/LnR5/MQ7mCT8iI30KuYBtfe4q08HST1eMJJTLoUcdhZ38sJFO5C8O
 rTZkmhaILJbNcZncan7uhksv7KkzJ+gXeO9l1QGKkUjpxeJ+Cpe+VvdB8jPy7pyPYVdMoRNKg
 41p7VLAH3Bx4Dz4gWmxWLS1Od3OZ2WvUvHDF8lVi3rVifOz7YvsTULevVrvjq4AV4yt3V94+c
 nuVfbtqfGzxx0L+tvtR/4qMQqS7kv1LjfMfXVxHnTxVyw6BR6fvttldO0QKfatbp8Bywg7FB0
 Xboez7nUvbKStCF5YwROqrlJbjBylZh6brMM0rQeL3sBdymvdJip1b91o8HSDyTBYv7jCgJrE
 74mz76DMngivFotLyicuXespSmc7/kIj3gF8Z2WIN7yYuGbJe2DZ12hfrLgjLvf4UiX0vBrYH
 /QoYwKRK8AYzCXLd4sehl3Zd12dmzXqiARzJq48lZNjt6/VqcHd/erUgms5odIXDzkRau0oGC
 yPR5IaHeeE0EKZkx1Iqcq8qaEVPJen39V40kXzZo2WWPforM59B6ImZJk6XCfk05mxeoigrll
 y5+jE2/DchfC4hvpvZw07HuRYQLar9c5J9M8269Lq2nVdftfSd8Ryi/64/J8enfsmwqbbV9tT
 rUrEYSEKGUBrH2/FKggR2CCYfQ8iAmN/BSvaxHzM3fd/I=

On 6/18/24 05:14, Jeff Johnson wrote:
> With ARCH=3Dm68k, make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/am=
ifb.o
>
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

both patches applied.

Thanks!
Helge

> ---
>   drivers/video/fbdev/amifb.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/video/fbdev/amifb.c b/drivers/video/fbdev/amifb.c
> index 305f396c764c..132638240521 100644
> --- a/drivers/video/fbdev/amifb.c
> +++ b/drivers/video/fbdev/amifb.c
> @@ -3782,5 +3782,6 @@ static struct platform_driver amifb_driver __refda=
ta =3D {
>
>   module_platform_driver_probe(amifb_driver, amifb_probe);
>
> +MODULE_DESCRIPTION("Amiga builtin chipset frame buffer driver");
>   MODULE_LICENSE("GPL");
>   MODULE_ALIAS("platform:amiga-video");
>
> ---
> base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
> change-id: 20240617-md-m68k-drivers-video-fbdev-amifb-3f65d4a6ed79
>

