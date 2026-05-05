Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E3730BB9B
	for <linux-fbdev@vger.kernel.org>; Tue,  5 May 2026 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980188; cv=pass; b=GSrSpUpjR8Za/OXShFdwZF92ZQbcSDUeKLoKbQSC46dqkLlmLm/EuLW76Zt9GUOd9HdQvSISzSLqDnuzM9fYzUJwTRHGeBEeOdCle+TAgPY7DMBsfRyMedZM4eKMyLJR6quiZvXFQokk/ZXP/Vwm+zQI+uenKzFuO0psCXANC1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980188; c=relaxed/simple;
	bh=axlZf04eFZVnPGKiWOTNXf6FhugAQGt8Ph+b3ZFJZEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBS6oMVbxKtBTz+CobOB6f9OOeM24cR0CKfbu/4th9Me9lGfDcGSNQ/wcMcitho4diP8myjZnz7GMgZHtQz50ZtQQ190RuznmOelYLNN7ISG8bZkk88FjeoPZs7J1SB9YBt2Tx+hKXkataYmj3+5ryBWboN4SZ4kr60mq4r5Mxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZL4nYdNk; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL4nYdNk"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bad54961385so856035166b.2
        for <linux-fbdev@vger.kernel.org>; Tue, 05 May 2026 04:23:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777980185; cv=none;
        d=google.com; s=arc-20240605;
        b=PZTQu4CN88XqCYY/MwKJtQNhHmTz5I6Hf3LULDNWZF2oHHbTet/5LErlYGy9Yr6DQc
         rLJF7WLytmm9fK/uHtSeRGhf84j61JT8Hg1PbfUOaOAejY4t7AIVsqaGL1+U+YzvM9+H
         AszLlN5Kry4myT+gN0qOHOHnhH9KyCf/qndWw/F8LLI1FHJYlkZ2LtiIelSFtBmaPdop
         7uM+Js68H24iRo6LwN0rGBBN3jj/Qv0sggHzCt3UtXwN5ApgsJPj/VK22TylcqqQcJ6f
         YOVOfPACMz0is0aAfWvTsG769vFrJ9ImIclwAlCrRlnGqC9JyiTPgwVP2s/6rY5DzB5K
         6d+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=axlZf04eFZVnPGKiWOTNXf6FhugAQGt8Ph+b3ZFJZEI=;
        fh=SNDJQwSXr7Yew0RTzlU0LOszze9c39JsVrS4G9UP+m8=;
        b=af+QmD5ImwjDxVdhCFO9IyoGYd/hOLFmraEr1W88NuReOUYqWmKlLGfyCVsUjRNn0c
         Yt0gTOPWSIRjmFtSfkzw0Pz2ct+1pbofXyUiHa2QONMlFCzXYku9YUiW5a44D7V2+eL0
         /vny3sZr0NwiPntoKYaatQwcAs+EeSIB0judXZ5WuZmGMPQWJ24w6WD/1BsOQZr6438I
         NslrLgfT4UH7SOplPtLo5Yc9Si+2b7ekjNat0p6zVAxmifyrb1CUEkRZNhhqm+J49B3t
         g7gn6GKejCKBzrrqeXx3tecDV+wbeR0Ro+3f6t/+g3xn2x/c3A7JtpGWZqt5gBaIdx0r
         nrfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777980185; x=1778584985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=axlZf04eFZVnPGKiWOTNXf6FhugAQGt8Ph+b3ZFJZEI=;
        b=ZL4nYdNkeYQIiPHxGEyjbzQLJ8lWtmIOm7OE9e9GF0Y7umHR8LjWjlSBUG0YqOteHu
         t6CAODez550S8S7n4pMOLJqm3zDC/a2ngSKUFEOGNDfGyY2x/vzuefnwjN3697FQCzth
         qZj6b18U0AH7SoHAn2Fg51vB/xg1Zjhmhlzf6iOz/VZrMs3h8+nWXz0y0PrIoSq9FB4W
         XxfLcU2KN2uUyn6PVWEzHtxn2E9LQIPPdyZWPtXWoU0pfVBHix9rFt2vIzjE4r1WZqjx
         94WygAo5PUyl2CqXwT/FgOmchtnXuuB5BrYLZFH6CKw5xYadpYUsth+7mtqufu+EW+Fc
         GRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777980185; x=1778584985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axlZf04eFZVnPGKiWOTNXf6FhugAQGt8Ph+b3ZFJZEI=;
        b=X6AWL3NaMlIJZKP711CCnJTnhep+w00YmyvTFaHWA1yvm2rNslc9MeaN6n7xM2heyN
         suMxL1sjn1o8mH0LlwiJWtD1/aEv6X7iAjuUlA+Rqx+vB4jz5GZrp/8nLY6LNa0MZPjZ
         /mCAntCH1YDvxm/hgXwsisTHFEyIkv+WPsC32RWBvHLZwWiVQVkNLN0daXYfyK328cTc
         5pn8szzxPHqq2R06yxJOv/I2oVH5e1Oe9VviLDozf9v1onWid6d+sV9UZD+9LVTNmgML
         UucP9KSmNHOmRCr2227pthI80rxMYMxqniMK8HOL+XhfkFC/Ozko/VybGfH2ltepaZsP
         bgtw==
X-Forwarded-Encrypted: i=1; AFNElJ8TkFZn4dsEphRVb6zBBsRne5D/dp+DWdHRrs2Yo/Vb4p3Tq76RTeltZzpezKLJupdeiv5DLbBKKPDQdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUtMjPgYCba5o+VPbYg2EhHMluxL0vyPX/Z2ajbaXikx0fZkZ9
	d0Yzj6Caehs6V7t1KchApCnHw4n+dunbFhVrlOV+BpCZL/X8UvYqNZH7VFyRHNkpzYtOASS278i
	4dfBqIkSJK2XT9yGPCLH0ziH96zTBJwI=
X-Gm-Gg: AeBDieubv5cXsDGrjlu8nlRPfgyoDQd3BsNMdY0TCXZFb1qUZ/orXQbfFPNw1WCwb2d
	U9DYyaZIovusQW6a7+JB6SfccAKN8IDtnBLri0Sx5zF9DFbDArC5hDPJVSOXtZ25sPC9ZEXdntZ
	QOZ0F7SBIH57eRqeycr94qKEnsnHDcEF6ukJNT1tSY1GLfD3fkcU2+m0SjlfocmYslrd1UJAVK5
	5YTWRukxfPotpa7rKRBv8uxgutVrWH2QhWj583OQUmK+5Ij6VbjuI3dcPscO2I2hXuKdaDwrdVx
	dixJ4YHDnZp6XXn+
X-Received: by 2002:a17:907:7ba4:b0:bc1:36dd:c6cb with SMTP id
 a640c23a62f3a-bc41111d10dmr135147766b.20.1777980185375; Tue, 05 May 2026
 04:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420010118.17960-1-dbgh9129@gmail.com> <CACrCO_VZg_2PXG011qQ7NWo3iz-u2HE6DdHZWQdQ_UnRk4A0Eg@mail.gmail.com>
 <2bf485cd-0c6d-4f0e-99d6-7b592b949a1f@gmx.de>
In-Reply-To: <2bf485cd-0c6d-4f0e-99d6-7b592b949a1f@gmx.de>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Tue, 5 May 2026 07:22:54 -0400
X-Gm-Features: AVHnY4KGIseGzQJ6YPebo9l-gxUHaibdM3sX7SGH34uGZHlvXl6i7jaTP7IScU8
Message-ID: <CACrCO_UFOLqwmSvZzQ6pOxihTEngCOMshws0UTCee5DSt4BvuA@mail.gmail.com>
Subject: Re: [PATCH v1] fbdev/offb: fix PCI device reference leak on probe failure
To: Helge Deller <deller@gmx.de>
Cc: Jason@zx2c4.com, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	mhun512@gmail.com, ae878000@gmail.com, tmk5904@psu.edu
Content-Type: text/plain; charset="UTF-8"

Dear Helge,

Thanks for letting me know that the patches were merged.

Best regards,
Yuho Choi

On Tue, 5 May 2026 at 06:10, Helge Deller <deller@gmx.de> wrote:
>
> On 5/5/26 03:39, dbgh9129@gmail.com wrote:
> > I am sending a gentle ping on this patch. Please let me know if you
> > have any feedback or if any changes are required.
>
> Both of your patches (offb and savagefb) were merged upstream 13 days ago:
> https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/log/?h=fbdev-7.1-2
>
> Usually I send "patch applied" messages, but in this case I probably forgot.
>
> Helge
