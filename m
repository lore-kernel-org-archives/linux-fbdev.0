Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793010176;
	b=Ys6vnJCGVaKQmkJbTw8QGjaBUBBTzZlG6l1M7fVAdX/MGBFGxcCDGAoVoZ45ipsJdSqR
	 0Ccy/tyHh6/du//oygsg8bVIscKEyIRLUy/XeZKL7zBhWlyg7HLrBoHpcqlSLY0jRvX8B
	 wEw0NVjutOHM+J7eBTCCTMC0jw1qBb/N54o++sxZ4AOMzGPyXDhNtmfnXNJXa9dL31c2D
	 Z0RKY/1aAQoPJLMObCw1hMc6nWpzjrtc5uB8NcwLPHn8We/j5mHn7RyJrFMU3HXtsMBJ/
	 XpeCuY7Z7yT0vG5+ofFi2OAGaNM5BA1loGFGTD8AQGvS5J6im5bkcedzUSmTPJ7+PMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4JFuCCDMVlFwxbA66iE/GNag0HLFCOElpF7r10IAp8Q=;
	b=JSQeh2Mi//SuOtrk0hz97A1J8r1U8MIDGtnmmcTOfxD4SdFUNf/Q0OuBZUlFk4pBtIJM
	 /o6dCDPtRX4NnlenGsA0xne8omsju3puynQDE2KqF+iWLasFyHvTJgBfzG3cCjMfsfB2I
	 nPt6wS2oFKdL/AxmbzLyo1F/DKxadOZMI+lWu3Ir6o0XbukWPDWgcGXlqal14M1D/gsp4
	 p20gjxDKoKtw1OujYifnkfGiDn8m4B6Z4GxmUQSEXOXBgqdAsujxX8TppqMMuimbeop3x
	 L78Fukagloa8w4STroyqgrYLW9JA8OADdpOq1b9sAjT1hp30RIUAyP2ZyjFAAq5DOsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DvfbcZ7G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30852606A325
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 10:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30852606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DvfbcZ7G
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-81ae6aefdceso2343560a34.0
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 03:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793010175; cv=none;
        d=google.com; s=arc-20260327;
        b=hfX/DreD3mpgmJSBYwq9x5/sZyG38iRdHvwJZd125vAjh2yymypytErba7RBtq07Nv
         MDHhacvhZZz/VPMBpr5OWoQ85fPAGcQtRr30vCipqPxdbhwL4YPtSV3Y4/eVzjELP0B6
         4XMiJUO47L4ggYZSYnbQ9ixBNVQDfQLO67Xqufp6DGxUQPzxEpdx9zARVQdqa+GORUY4
         W95EloOlWTp9E4wgUNSrARGZfn7xLgWvxRUJ3lSn0lcFaSZQ2Qa+Vcu0hAvNBaQuy0cf
         uSygXGcqtGpf4zjpTvzIlEdkG8CsfE03HTbH7+MDpDSWlFrM6BR4VhpSlGGXUMU1RFsm
         ZmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4JFuCCDMVlFwxbA66iE/GNag0HLFCOElpF7r10IAp8Q=;
        fh=pIVYF2DyRBBl/e8ZxxMGzJ936uhntiRQY4i7Pv07p7U=;
        b=EmytFVKO00WwHoRFTxs40MmyazuSXl3QI6KNnc+7Wfjb9TJTo1kENn+DoOO+jccGuD
         GBGJWNP4bYhFfcfvY+hZW7svWHfcNJThxDadqQC6lek3nHIfMCrB+VggrOAcvVrUdvbc
         Ye5jn5Ihx4msbIee3GHfwZSVRgGpVsLi8taMiKVRlDXYFphm0RAMhNQTzGS6Cf6IqY1Q
         TgDAeaJ2QdWLYJhYSb++oFSgiAL00YsauDX4XYDFTdu+1fn/qtwrbX6anGjPwZY+ysVN
         wc3JJWG4ttqxIQCDxIOcOT3BE2jP6oGODa/O4Sr1lxLL/QoBG3dVk0pFI3BfOCPgp0xq
         0/dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793010175; x=1793614975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4JFuCCDMVlFwxbA66iE/GNag0HLFCOElpF7r10IAp8Q=;
        b=DvfbcZ7GoJswKjfDzCLmyPuNPlvoFsBClDaWBrErUCcTfvAsYuxE7U6Ros7TVip1Hm
         /9eYEe1aR6YakS7iUIdPwhdw45N756eSKF9M/Rc9AozmIt2L5HfMoUx/rtEVSsdepFFl
         DXDbzktWToPxurv4eOkVHQFRISgv5yUf0b4qzwtTPBCB53Z7kDq4aQmtKGaNdWuVzwN7
         iw/wQQAJ76xV3KgUA7gIIxyLazHw1TpjsjvcFPGu9DstNhGzHjm+5JimxW9NR42C+1g3
         tIcQUJCejidL+1ulGLOtkhXAAlH0emQfjivJRGr/UdCz5VT4iwXqCLJAHOsMUV0eGa+i
         /ORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010175; x=1793614975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4JFuCCDMVlFwxbA66iE/GNag0HLFCOElpF7r10IAp8Q=;
        b=UbQ4IYOeVpuYKf2JmQnCUBvoSkMQFOfirqU4phgiAjIQYhMBYYq77cVSJxLQgqiZVv
         w0tRg9kSViEiXvLKXRKmXQ8BiGgGMEyPnBJi/VnPMtpBxd/rBBWADxm2vjWMx1ebDQY9
         IK7mfoEyQLbkC2bSRKXLTjzuK0FO7d2tJo11Mms6rgHf9AEWqz3LWO2jOi0vC6952K8D
         IexXczXoeoPByBCxC+tCPum8oVAoVgEbcan2kzwz06m9suau3tRimCdKFj07u7zqnfmU
         GBETkxecWRf377DZFFePyIGFlO24l/OVL6ICCkuhF6CeHocbfnDpuxfDq8kZW7bGYLDY
         vfOA==
X-Forwarded-Encrypted: i=1; AKwUvBy7/pxbyuK8BEEVj0G1A1zPzRClxBB/MxJ4/D2nTS7XvjAyCOKH/95h+uSbfrirwcRZnlehYKzrCsNGew==@vger.kernel.org
X-Gm-Message-State: AFq9FYKudRN4meVLiMzdsvYrnT1MOkeO6z4XV2FVZRFwn4v1T6RAm7Zs
	9UcMOpZHbHtLSdmkn+2THG/R2tpw/fg7rHIIxdAW/R5Ism8MLKgruRDUzpHOqD2iN2FuIzJ/DoM
	he9021oYnGB8qYElF+jWEv4Mw35OVLr8=
X-Gm-Gg: AYBFou0Chw/rsjvd1LF0zS1CCYL6UUR1iGoZquvE4BMq1WWdPofDHV/dofMeFhUuTBk
	eETuaFvkvu9L+gnixp8maPz+K+LCKV4W+eOJgLH3JAZJChLj0VQU98cOqhg+Xu1+shvjIL1UW57
	fuzgARH900ctCeGj6bZDGWDccA5TnWqtLaqDrqRnDtyhB0WEqCjJ5QIsNUR0zPjuWvpY2OvAooP
	tnx25dQW42sTaMz04fTIcN6w+zkf8nzXH6gJTC6vpFH5fvu9S/6ZqzDZ+9vr1/GxfAzhTyaXPAS
	bzQsBzbaanVWft2MTepbiIjIqSLR8QIMrF06EjiCPz1N+po5HlpJa63xLvizJajQAXPvb7BN1GV
	tHAdTEGlgZpkmqZ3Ax8A8DRzgoXiS/xBJMl/4Bq/7EeeyGczSs/yIl4Rc7zRT9NNmLL95soc=
X-Received: by 2002:a05:6830:43a2:b0:806:ab05:c1dd with SMTP id
 46e09a7af769-850fbd152cdmr5102659a34.4.1793010175125; Mon, 26 Oct 2026
 03:22:55 -0700 (PDT)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026092423.66168-1-himanshu.bakshi478@gmail.com> <at8lztOr7xpvHEdo@stanley.mountain>
In-Reply-To: <at8lztOr7xpvHEdo@stanley.mountain>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Mon, 26 Oct 2026 15:52:43 +0530
X-Gm-Features: AclHuK-LrngTyM9fVjS8n0vJ2sFwVm_Ut-1pAzzYtokYdGgpWPQQI0AOYQG4gS4
Message-ID: <CAGLmz9KAs7oKnmLv8NK6Z8yBQyrdV41oiouoRrNBY-j-p_H2+g@mail.gmail.com>
Subject: Re: [PATCH v2] staging: fbtft: Remove unused fbtft_init_dbg()
To: Dan Carpenter <error27@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com, 
	cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Thanks for letting me know. I have already
sent the v3 patch, so I apologize for not waiting for
a day. I will keep it in mind.

Thanks and Regards,
Himanshu Bakshi

On Mon, Oct 26, 2026 at 3:35=E2=80=AFPM Dan Carpenter <error27@gmail.com> w=
rote:
>
> On Mon, Oct 26, 2026 at 02:54:23PM +0530, himanshu bakshi wrote:
> > From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> >
> > The fbtft_init_dbg() macro is not being used, so delete it.
> >
> > Reviewed-by: Dan Carpenter error27@gmail.com
>
> This is formatted incorrectly.
>
> >
>
> Don't add a blank line in the middle of the Tag block.
> Tags are supposed to be in chronological order.  So Acks come
> after the S-o-by tag.
>
> > Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> > ---
>
> No v2 text.
>
> Please, wait a day between resends, even for small things.
>
> https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
>
> regards,
> dan carpenter
>
