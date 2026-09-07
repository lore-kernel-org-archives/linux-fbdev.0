Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AA245DF47
	for <linux-fbdev@vger.kernel.org>; Mon,  7 Sep 2026 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812056; cv=none; b=FxkmasPE2bRXxClMg1zQP72x4n533sSAOWRQTQlhLi92893UnAzLQlswM/l356oVzK1x39Dy9NyiqXl76dMnrOWNenzThcoULJmYqDLCAD2oApgVSAXPsj+sCLWCR7wn8QksSUllAj3lG0Rrc74zsV6TppllUNGtMnxj0QUY5JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812056; c=relaxed/simple;
	bh=JdYM+UJ0B56bSrUUIISGmCCYJRuSXUMR7i0SnqkLauA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U79+y3uO2LjdnRyZpYU26bqsab3Du9jpvUO3zszlv5VCSdkLICJ+O2VEqmMcl3GH3Sv3ce2vDmDZ8cNapJTVoXIRnZD/C0afgK7/p2b7y9xmHb//xt1uDEuPC2+SthwLS2+td/RQjtUJQC9gnRSGFNc/ptLutcNrpQxazm4JvUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFPuj26K; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFPuj26K"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1a4c62804so2895843a12.3
        for <linux-fbdev@vger.kernel.org>; Mon, 07 Sep 2026 13:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788812053; x=1789416853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MhNwMmgT5IoqPKbTajdZzif3txtKsi05HtP3StDpTm4=;
        b=KFPuj26Kse0cFbiDqsg4/h8KgHrxVxgUPfAFkmmBfq0CDc3Nb1yh7O4U++4JkEG1xg
         49GR7lGeJ9nA/1IbAH9VQIJ8gCDup/2wfcIH/tm55Y82i+3UQo28tc5PWpzl1xB8q9VE
         u/3NlHiSQjqIt1IJiHpPuQSHZ/ceHL5IkbqWHI8lJ63QsNTTmp6tsRRfzM89M2y1KdZ1
         lX6JWTg+N2YeYB6bnJrxO1q3ZN/kGS4HwAHZzFmMZYdR+9ZRnTZJpTq5f1IBkRJTl2xE
         tnW1oOOZG5yKXjUtgvJ8E0XoMC2sXk1VE4snmOk53xEh0Y3SbNMn+BaTwBPf7wuV0G63
         fy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788812053; x=1789416853;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MhNwMmgT5IoqPKbTajdZzif3txtKsi05HtP3StDpTm4=;
        b=RJjkIy9NPOS6gAelCOoLuuNb5+YahbErc6m2xZzEAfy5xfcdhzmG9z25/MQZwGpoHe
         KWwth6MB30sP5vn0Ks8v/V+7XeecO8CzSp0ZcfzmYpVcCv/xj6SuMLk58C+T0NIJdyHg
         Mc9SYmjMSgh4OzIwD568E1wVK1Kf3wwmKWaOR6QX7Jy9OmFKSh0KGiz00jYaL5QQLf0/
         QXSZ6iAH0hVJz7KHpOA3n2GLKr6dTAW8xAxNh4ojWxEt2NLt1oAhnKNTPSCR/x1sMy9A
         FT5Pg4YM4IkHg+5QK2YnbSuQSh7AKfuP/tVtcEzBtRrhCcWpOdsokN/evI8erOQv19dN
         jg/w==
X-Forwarded-Encrypted: i=1; AKwUvByf6hlzPJCdqa/5ajpwocXQR6JGAI/F4poMb4X7lbxoHfmE/uTUp5ZG8d457LNR7I82rqI1V+2eswYSXA==@vger.kernel.org
X-Gm-Message-State: AFuF++n4MCU8Fz11U1JS6x9Gl1JxHXohpl3RZGKRc+/0LqXwTp3Ce6SL
	Sb8gDXol9wXrkfZYSTyZB38imeJ6/hvXANDAZ6Pvio1gQfvb0+OSXX+V
X-Gm-Gg: AYBFou3gPvAAtVWn3q4pWgdgcG3nNsHe/JpAmUGkLHGJQTUCYp5XbIPMoMPj7rUGtNh
	4+ROlY9Z0CmL8KcCgf5fUrdeN4uez0KuOboEud6lBBgyDP6H2Zb+Ygk3Z1rucEioYmUMbYD4pbN
	B8MtXAjmdBihF+2f2hZV9/Bsb27wVVDlQddhH3Ja3BrZyQbsJn3g/iIaIdnr2Doi6q7HD2X1eg7
	9ZBr//bvt8ySMgrjexXJArRh04xMeQvKfH3OizJ/rTVGvMknw+uYy+dy6BuaZ6n6s7AVVNvY8zL
	d/JpfZIa4YB8n3JJ2kvJxiEvTUiQzS18dNBMrl00w3KeqXGhZg5sv0rXoSCS5qXo0ZntIQ7w/mF
	yvrppOg3WW+3lBTcxZMgMKIG0FDFGErHArS+xidMM5GteXprE+DiK2D6o/hzGxbx19HtAdwzZXO
	Dk84HwItH8ZKF/sPahTgaRKjU501ub+L7aeeLCV2esrgCa8FDX1GY/HT3noYtJ8B62/nJiB3+ls
	HHR8pnb0oVf6T4CTuypn/FVIGosQ93vtWON/la6IfoXC0cWpv1qUuYCiBQ8rYerr3L9W49uCPCl
X-Received: by 2002:a05:6a20:c896:b0:3cc:9618:f51a with SMTP id adf61e73a8af0-3da39f47dd4mr42511514637.8.1788812052990;
        Mon, 07 Sep 2026 13:14:12 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:e5ea:1a30:7c29:cd76? ([2001:df0:0:200c:e5ea:1a30:7c29:cd76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa31b24sm29604849eec.13.2026.09.07.13.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 13:14:12 -0700 (PDT)
Message-ID: <4f3c7184-1b5c-4074-b8a1-49261833df8f@gmail.com>
Date: Tue, 8 Sep 2026 08:14:05 +1200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
To: =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?= <miro.kropacek@gmail.com>
Cc: Linmao Li <lilinmao@kylinos.cn>, deller@gmx.de,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
References: <20260827093948.2825531-1-lilinmao@kylinos.cn>
 <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
 <CAN5rfbSh9ZoUkReAqv9rHYowqKcZFa-Svy6LP-MHvqfBVhjdBQ@mail.gmail.com>
Content-Language: en-US
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAN5rfbSh9ZoUkReAqv9rHYowqKcZFa-Svy6LP-MHvqfBVhjdBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Miro,

On 7/09/26 23:14, Miro Kropáček wrote:
> Hi Linmao, hi Michael,
>
> On Sun, 6 Sept 2026 at 11:49, Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Hi Linmao,
>>
>> thanks for your patch!
>>
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
>> +               break;
>>           default:
>>                   memset32((u32 *)line, pix, rect->width);
>>                   break;
>>
>> Can't test this on hardware, and would need Miro to confirm it works as
>> intended.
> Linmao's patch: I ran it on a Falcon with SuperVidel at
> 1920x1080x32bpp, all good.
>
> Michael's 24bpp fill: I cannot test it because the SuperVidel has no
> 24bpp video mode. It was planned but never implemented. Its mode
> register offers 1/2/4/8-bit bitplane, 8-bit chunky, 16-bit highcolor
> and 32-bit truecolor (24-bit RGB plus an alpha byte), with the
> remaining code reserved - and TOS offers no 24bpp mode to set.
Without a 24 bpp mode, the 24 bpp fill is pointless, so no point trying 
to keep that mode alive.
> Unless I overlooked something, the fill also looks wrong on paper: the
> first line is filled with a repeated byte and then with repeated
> 32-bit words of the same value, which cannot reproduce a 3-byte pixel
> pattern unless all three bytes are equal.

You're correct - we'd need a memset24() to account for that. Without 
hardware support this is an academic exercise that I don't have time for :-)

> On the fbset question: no, the pixel format, depth and geometry of an
> external framebuffer cannot be changed at runtime here. fbset -depth
> 16 and fbset -xres 1024 -yres 768 both return success and change
> nothing, because ext_decode_var() only validates against the values
> from the boot argument, ext_encode_var() re-derives every field from
> the external_* globals and ext_set_par() is empty. Only a reboot with
> a different atafb:external: argument changes the mode.

All good then - do you need my Acked-by for Linmao's patch, Helge?

Cheers,

Michael

