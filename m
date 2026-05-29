Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67D53D47AD
	for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054126; cv=pass; b=gl8g2oS2OJuvTh/H6AihWiPDPepnVnZGBPfSQhCxwZS98FcZHv+ZRJLwqsX8UX4ZoMKqCxH3MwFpCVX5Ml60/943AGAWS1r1Zt8na6uMGMwghLhwqW10famnGEZNa3X781UEDdWFIr12LghptQuI0iRBxFj4k4O78bWoHD0F3tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054126; c=relaxed/simple;
	bh=YLuCS2DFe5V+x47d8AH61ocL9lcs9DIgq8X0szPcftg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZAXxIb2qMBqECjKSScs1hrql7ozxLy+uFBg5gGc8ul6PIX9rNgd+ZRLppwzyAfDotvH44hIOCvV2Rspr27SsQEyOeb6GzW4+WBV+TXdTF8igOzN611iUTRITtQL4n1pfl0xTL8QwGE5kb6ZQzC1j/Kro12gbZHgisVU+ldqfG98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qUb4BLmg; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUb4BLmg"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dcdaf06498so8924432a34.2
        for <linux-fbdev@vger.kernel.org>; Fri, 29 May 2026 04:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780054125; cv=none;
        d=google.com; s=arc-20240605;
        b=GogK7iQuv4dTxht/uUgdGc/0dvUn/LQ/aGyxYkhuL8jQcZxyOqMn5OZd38pdmMZ7cB
         brodf3cp+vvmP8ivjy43R5cOI9NBOp5rEAR2olgme1AJnPMXLOWR4ciKQ5Jo9dW95SiA
         PweaSXVkRaeqLiN7ECg0b9ADlu/HB1jwMxCUN/j/89ancKu8+GS6OPke/0S+Ovlfw5GP
         NPzZGNBdJMIKVcNPLrt2tfpGuaDIJwNjZ4csvCfC+S2TOAD6piXqs9Ben19GiLxJ6dZ7
         tV6AsgYfUiMXUUTCTZRngBJ8v5Dcm1IEKxXVfAAS2IebDFnAnoBfUeV3RcW6+0ATaA9q
         e90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JdvHq9PjjMTKUjtaudMigffX446OF+4GXKTZS3wR1Lg=;
        fh=g4mIIpEPTT9QUqZ5AURX3aMBwVYHID7RFRt4nrtna14=;
        b=MMOINekYoHPtf0L3hNrNEt25VBWIJ7aMRVdYxZ/uR83/0joXZ5NUhWLnyjBZQ2TlUr
         mhKpS/WjmNqXrVus0bzXgX7bjvbZl9lxIe6mpEQaCUTp3zp+Roln11U+PiZmijeI9gQh
         2qVxH2Tou/a+t/0Arg/MC15NCVDNcZW9FhEwMNdNaPqHuL1OBEhm2eNdSwSwjCQH3dKA
         H9YDpZETli0BlPT75sYA6QVtKdetT6yHNaOaYET5RLu1YmXZUXtkGAKiLNGT7UWsLQLc
         19LE7wQlD/Sqv4PWESD4dg5W4rQkd7dciipzZVnPniS/Gm4mUsC3Bv21OlaCpCmxvaE5
         ySpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780054125; x=1780658925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdvHq9PjjMTKUjtaudMigffX446OF+4GXKTZS3wR1Lg=;
        b=qUb4BLmgwdWA5c85FpxwXY5aSK9Tx5AqyZbYIeHRnQAoWnoEG0jwdyIwg9sRKZ3Gwl
         NtuIO8HDRjCS0f1+j/Dwmc0XIP4QDzRn9U57205FPIOtXpZFe56t1yhdA9u2FQXEAHcH
         gCfcnNc9P7gsukSjeupEbpPktxXjNFT5QOK+3NowlvvXxb29sdj6ZV68GfQr8t836taq
         ev53BxhiplnTviAy5kuafSAJwe1nslQC9FAjmEGwaouGxQmL1vfwI/pBIgttrjv+3J10
         B3dV1+dC95QJ9CHsg6Cml/R0XVlOfUIcJKW6ob0irYFXlsnoET18XstL1f16J6V+6U1r
         l2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780054125; x=1780658925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JdvHq9PjjMTKUjtaudMigffX446OF+4GXKTZS3wR1Lg=;
        b=APXyj4nwFhdBbacWJZ97fetpE+D7GL3qVK9dcivr2+c/jez7FYt/bMN3GpcEdQuvtO
         0pE1E9J1BKPJ6pz6Jnkf3OkGEItRrlA/s8cnVBn6vT2f1Huo8w1FxB0/oD7j3kTzfS6Q
         HAgI/8Zn/cCV8NcstWYbEHKOcEGXUD4nT+rf981brQEswQYobcV0hh14m+hEOLjIBPvP
         7519X1hcheRsAzFDLNP86vmBwES8dsK2nPVZQVKRXm6zu9e0Bw5Emmc7PjzSKkK2n7Jo
         /xXb9uJOcoCH1cF7Fhfl2TwvOxAYKZ7gR0/Qg2lxNJXaaOGO/VK5dnZ9WSfeXZxbAF2v
         mHzg==
X-Forwarded-Encrypted: i=1; AFNElJ+ASVgFi+kof+ytDkXdPKLuzR42W0HLhmAilopUtkUTn/Pw4uj1D+39tvVHjMJLIvnPW37lHXYMYsgIMg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0e8bpRouPWBr96z+APOIoodAWI3aq7ZrX6BHOpFRtK4bQH1wz
	J4Eo+F3LwjJvHye86bnpByQG1042hRDYnfyZ544/MH69S2WdqzBYI6aWmjEGqT+ahDixxqaXCPT
	4a6Uy8YQ1rxq+b/YVy4M1IwkQDHkTTX8=
X-Gm-Gg: Acq92OEnq4xMRmBpHwNgzXwD1q5rymbw84lz98fWhSEuz1Q4XlI/woxd9mTKXDRFUDr
	M161lnloFEfgtzuS/kNNffL/B1/GLd/YuoGCUULvr+bPSauA94TxwWaQLnSCmKa407a0lIAHkSs
	BpcbkxBXuEDxJCy+M3n0UyDopxP9RwwB2kDbwrSG/LTSo3fizasMeN7kMyneaDYVHaA91lpE3j4
	3D0vYMomY0ZFu9O4TW9dZ2NB2rGbDMLC71d+n4/b1B7waMnzIy0goJ1oQzYlzZZJF1Z+kDquctI
	UkjUBN17CPoASKPRXmOzZuglxhUNnVoWp/qk48mgX53j0PFfEQ==
X-Received: by 2002:a05:6830:4987:b0:7de:c6b8:2349 with SMTP id
 46e09a7af769-7e694d066e6mr1439290a34.14.1780054124742; Fri, 29 May 2026
 04:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahhN_kiSb-yRWfiI@stanley.mountain> <20260529095233.9015-1-neharora23587@gmail.com>
 <ahltRvVgehkgvDFx@stanley.mountain> <CAOWJOpvJnSeS=1sO2mujC9tNi9_cQGgJ6S0j6xvkAp8KRnudjg@mail.gmail.com>
In-Reply-To: <CAOWJOpvJnSeS=1sO2mujC9tNi9_cQGgJ6S0j6xvkAp8KRnudjg@mail.gmail.com>
From: neha arora <neharora23587@gmail.com>
Date: Fri, 29 May 2026 16:58:29 +0530
X-Gm-Features: AVHnY4L26WI4imWVSBVQ2vF5_Su2hMUx94PxBQHISNn4E2Y9nqWEApkSa6c5D0Q
Message-ID: <CAOWJOptq02wns-MznV+VA26W5Kq9jEnESmeT9y=n78dq-XpNdw@mail.gmail.com>
Subject: Re: [PATCH v2] staging: sm750fb: rename pv_reg to io_base
To: Dan Carpenter <error27@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have submitted patch v3 with note and Signed-off-by line

Regards,
Onish

On Fri, May 29, 2026 at 4:50=E2=80=AFPM neha arora <neharora23587@gmail.com=
> wrote:
>
> I have submitted patch v3 with note and Signed-off-by line.
>
> Regards,
> Onish
>
> On Fri, May 29, 2026 at 4:11=E2=80=AFPM Dan Carpenter <error27@gmail.com>=
 wrote:
>>
>> On Fri, May 29, 2026 at 03:22:33PM +0530, Onish Sharma wrote:
>> > Rename pv_reg to io_base to follow kernel naming style and improve
>> > readability.
>> >
>> > No functional changes intended.
>>
>> Run your patches through checkpatch.  Also v2 patches need to be sent
>> in a specific format.  This should be [PATCH v2 1/2]
>>
>> https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
>>
>> > ---
>>   ^^^
>> There needs to be a note here to say what changed.
>>
>> regards,
>> dan carpenter
>>
