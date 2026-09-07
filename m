Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37363DC4B6
	for <linux-fbdev@vger.kernel.org>; Mon,  7 Sep 2026 20:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812315; cv=none; b=JqaB0xrgrIWLANGbAEq9FANkHeU/OQuNci3V/Yhl8WKnY+9s1aRzrNwE2RgQlupglbAJXjwkNkX3fSW/pIw2NNThY7WNVltS5/UreFZeKjESl9fGW/m0cK5W0RwNFLLOcxDzN2Z9YnYjmHxtwhmf8lXcmUak4s4Eao3AlewT8a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812315; c=relaxed/simple;
	bh=GP4LFAA+FEgEVuj9LBZm57dq1DGvQZhZyu8+UTZXZbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9gt5HdJNAU4Dpb1U8gjGeePojIDxkUoZZyytS9CaGc9NghVCIbWljroCPF1L7t0pqPvKoCwkB7P+AH4UR5lTn111Jo2TPnugbGn/hr0plrh3oL1FI3IBA4QgLM7tGtIoxSRT9gk3fKvSjGAzEt3QrCiUvP6yM2njbnBwWka5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9yhTTft; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9yhTTft"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbe827e3cb4so4086733a12.3
        for <linux-fbdev@vger.kernel.org>; Mon, 07 Sep 2026 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788812313; x=1789417113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MkTk6U8Hsd5NK/nm/H/rlcc7sKnrtC8ko7vuxkMvp9s=;
        b=h9yhTTftXTWLyZsEcB0gd2omCuef9iANidzKpO5EhD72dR7mE8aZG6wNpd2E5PNf4J
         DEnv5lgzjskhPt6wqBLAIcBxfBu+hYd+oZV7W6ul+HEcVk0TmFG55ZxEeO1VdxmWsWK2
         pIqnStJYYv+FQmnvgqzZ/C2+SWZ1Bm1aatH/1wVrAdTMJKmvrtASEHMJHFdcj0cH8wgO
         HkLQ7Ao5etnc9+/SllylQ1ovsEv/uDLaxgU+WDsp6DjtaIqvH2TVqRJXpa+Q8gv8WzU9
         LzEv2iMY5XBau3WwD2W+IzwZmghIDcA49UefmQsB1ffiamDmQ2y/j5ug8OliZx1IroEh
         ekUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788812313; x=1789417113;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MkTk6U8Hsd5NK/nm/H/rlcc7sKnrtC8ko7vuxkMvp9s=;
        b=KzF+wNFvGZ2LQc/dQnhbmPNgpqBSBl9UYcwEnTJEOPLzKjkh355vlO8aAWCzCc3NX/
         X3Cgjz5ToV1PRZuPs2AyB3vOa4gOAWkRZulMOL0BVaDjXBR2a50pJHkMHixQUoT/Etdp
         k7Mb6x4/Df28BBVux+Izne7YFAioi/GxTk3+MBy7pmO6eTWoCzedovx08wLTV2iJ1AU3
         dGPQHlzS/S147poOlK5w3M5M3op1QwemiOvSztb73AXsVNqHaanf3XUCW5yySmCg5oXU
         RQAJ89NqdiEz4kf7zr70jfCVEDFWwVtsM26+fTIEehNMtcJ3QL7gFCVVZ94fm6OVTrR2
         CWzA==
X-Forwarded-Encrypted: i=1; AKwUvBx4vr2jfalxzU6dZMClHRorEsOm2xpTkv9BNMM+2634a43abf4jHEf/LS80wjpzEZi39TOyO/pYB8SI4g==@vger.kernel.org
X-Gm-Message-State: AFuF++l5U1TerKv5/42vKb7qI1BxnRiG5G1J/nb+YYTY9udG5pGsY4uI
	X81crgUpIHHmSveL+f3mTsIbB8rX+j/0YFzBi6n7NKzfFe2xL2RVn+zU
X-Gm-Gg: AYBFou1T+oMyBj18lnll8+870wLRoVSuHWi1tlZRatpfv+j7NPNXUCrErjQ6X9W4X3w
	dDXfFPRb00n3jaJn9iQ8ic4dgly8wevszE5FlJwRIL87K0snqeDnTSeBkPu57CwXqjaetdoN2mx
	DBU9rH+ciCkbvrUEt6dbTNzgiwmbH7Sv0oaYsSYqa4cRY0aAbjCX96v/uETVrQkpl+e/i22Jju3
	sMMOBH/XXAD5X6XJlhIh0YUvRsIqZeVb94aLDyVXogZ6R3HPtggNCcQF4R09g0Pfe4wnBEeg5Fp
	Mrtf72eWIzvgguivU4tZjTHgyfcJBw5ll0QoAiuK5FXAsN5rQx1iI1U+ciVH8HZ0e98FJSVLOag
	QTIkJrT85dcHK3h4v4B6RfTwh+WtysPDAY9kI4c0qyUEhykdqWZzGaWlRL986wSzEMmGa2TZ+hI
	iO2jvUCuMYwf0lKNKhZKVkvYLzHv7zUFWR1g+//VTEjJSKXWErvPU3I74grwhRWFzuB2GfhXP0g
	Jy5lVcb7ymWvvR4PtkTGFVPpKwLX8wBNM4Ejt++FoLRqMl6DfZqZ8zBiyZ92SKvhDG2jdhY2+jZ
X-Received: by 2002:a05:6a20:7350:b0:3d3:aec2:4dc8 with SMTP id adf61e73a8af0-3da3a0c510dmr36997103637.20.1788812313022;
        Mon, 07 Sep 2026 13:18:33 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:e5ea:1a30:7c29:cd76? ([2001:df0:0:200c:e5ea:1a30:7c29:cd76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-338778fb926sm4986048eec.31.2026.09.07.13.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 13:18:32 -0700 (PDT)
Message-ID: <93ffe3ec-bb45-4c10-8d78-0cd23c9bb61e@gmail.com>
Date: Tue, 8 Sep 2026 08:18:25 +1200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linmao Li <lilinmao@kylinos.cn>, deller@gmx.de,
 linux-fbdev@vger.kernel.org, miro.kropacek@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20260827093948.2825531-1-lilinmao@kylinos.cn>
 <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
 <CAMuHMdVOc-_hgWvu84EW7tyQx6WzPtabnBUJ1T0uoxa1QZA94Q@mail.gmail.com>
Content-Language: en-US
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAMuHMdVOc-_hgWvu84EW7tyQx6WzPtabnBUJ1T0uoxa1QZA94Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Geert,

On 7/09/26 20:38, Geert Uytterhoeven wrote:
> Hi Michael,
>
> CC linux-m68k
>
> On Sun, 6 Sept 2026 at 03:49, Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Am 27.08.2026 um 21:39 schrieb Linmao Li:
>>> The SuperBlitter operations derive an integer byte count per pixel.  The
>>> accelerated fill path handles only one-, two- and four-byte pixels.
>>> However, the operations are currently installed for every external
>>> framebuffer in SuperVidel RAM, including planar 1/2/4/8-bpp and 24-bpp
>>> truecolor modes accepted by the external video parser.
>>>
>>> For 1/2/4-bpp modes, the byte count becomes zero, so accelerated copies do
>>> nothing and fills fall through to 32-bit stores.  Planar 8-bpp uses an
>>> incompatible memory layout.  For 24-bpp modes, fills also use 32-bit stores
>>> despite advancing addresses by three bytes per pixel.  These cases can
>>> corrupt the framebuffer beyond the requested rectangle.
>> I believe 24 bpp mode can be rescued using something like this (entirely
>> untested):
>>
>> --- a/drivers/video/fbdev/atafb.c
>> +++ b/drivers/video/fbdev/atafb.c
>> @@ -2463,6 +2463,11 @@ static void svblit_fillrect(struct fb_info *info,
>>           case 2:
>>                   memset16((u16 *)line, pix, rect->width);
>>                   break;
>> +       case 3:
>> +               memset(line, pix, ((rect->width * bytespp) % 4));
>> +               line += ((rect->width * bytespp) % 4);
>> +               memset32((u32 *)line, pix, (rect->width * bytespp) / 4);
> This uses unaligned writes for the largest part.
> You can avoid that by doing the memset32() first.

True enough (iff line happens to be aligned, which is only true if 
rect->dx is even).

But as Miro pointed out, 24 bpp can't actually be used (and without TOS 
setting such a mode before Linux boot, it can't ever happen).

Cheers,

     Michael


>
>> +               break;
>>           default:
>>                   memset32((u32 *)line, pix, rect->width);
>>                   break;
>>
>> Can't test this on hardware, and would need Miro to confirm it works as
>> intended.
>>
>>> Enable the SuperBlitter operations only for the layouts they implement:
>>> 8-bpp packed pixels and 16/32-bpp truecolor.  Keep the existing software
>>> operations for all other external formats.
>>>
>>> Fixes: d463633d63e6 ("fbdev: atafb: Add support for SuperVidel's SuperBlitter")
>>> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
>>> ---
>>>   drivers/video/fbdev/atafb.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
>>> index 5bca34c45cef3..c3011b61a94b9 100644
>>> --- a/drivers/video/fbdev/atafb.c
>>> +++ b/drivers/video/fbdev/atafb.c
>>> @@ -3360,7 +3360,11 @@ static int __init atafb_probe(struct platform_device *pdev)
>>>                memset (screen_base, 0, external_len);
>>>
>>>                /* framebuffer in SV RAM: enable the SuperBlitter */
>>> -             if (external_addr >= 0xa0000000) {
>>> +             if (external_addr >= 0xa0000000 &&
>>> +                 ((external_pmode == FB_TYPE_PACKED_PIXELS &&
>>> +                   external_depth == 8) ||
>>> +                  (external_pmode == -1 &&
>>> +                   (external_depth == 16 || external_depth == 32)))) {
>>>                        svblit_regs = ioremap(SVBLIT_REGS_PHYS, 0x100);
>>>                        if (svblit_regs) {
>>>                                svblit_fw = svblit_rd(SVBLIT_VERSION) & 0x1ff;
>>>
>> Otherwise, LGTM.
>>
>> @Geert: can you remember if pixel format or bit depth of an external
>> framebuffer can be changed at runtime using fbset??
> I am no Atari expert, but IIRC all external framebuffers rely on
> being fully set-up before Linux boots?
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
