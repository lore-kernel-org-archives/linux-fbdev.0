Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772302;
	b=adGhi5Azs8Ya+T/UkPs+VJphGM0QYL0Qqas6nQP+Otmwr+yCdyGIxQa5M28LHhZ0tjuz
	 GFOKY388tUWzuvX/sJcgzAY7gjwsMRsh+1AknhctHKb+oUfD+hc/ZpEOvhytJlPXXDXn1
	 YungE5+LkS6d4qHab+vVk5qDF7sVZjgh+SLLB8zm4nhB/jHRTeSVxYcmPi8oQucgbjRd7
	 g/y7hZmxCzdE40wwNpMujDx/l+/ptMhpceaKhwKqClQU2McuLT8/He3LXgJekfStdsug5
	 j4USzXTfpAbBScL8hWEqxeH/r3+nwGFYjOxJYmj7WmWZe5ikKt/86LYyKmJAlA3I3kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=QP7Z5nq9f3M+wzua4Vt0AE8lDl1n5BDSlA4IpFM8kg0=;
	b=qXC6nzQYPiHpo3kcUXEuTTZdD5oq5PMqVaf11mWXb038Ney+S50Goxw+0qT5Qh5CguoK
	 et3uewp1rTecby8mYYeBS15jRItvudsU6gw0hSSYMmx8P9BqWTWRZgm4aAZmEch3CgMTP
	 PDhnULKEpw0domBq2Ukk39sOeHTtbW4a5PQkYFGLNWl+k9kRqgKOgPunXtBTxtLAl9XUw
	 8D1+bQ4a6ql/BhmVxrLqTjo0uyxQkLR3sP6Sl7aegADpiQ0hwcMi/ze1HbmVbUh9Dtq5/
	 Jkxrvycr7wnYq8wijQaoiKoKBjo5wHDnHLiIvl02YkMVP+Veo573Qw3YjxJoPOB+Abw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jJqspCSO;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78481606A31D
	for <linux-fbdev@vger.kernel.org>; Fri, 23 Oct 2026 16:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78481606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jJqspCSO
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48b042c0759so745551f8f.2
        for <linux-fbdev@vger.kernel.org>; Fri, 23 Oct 2026 09:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792772301; x=1793377101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QP7Z5nq9f3M+wzua4Vt0AE8lDl1n5BDSlA4IpFM8kg0=;
        b=jJqspCSOzBGAQlcvubxG20AZvgx1ZnB85D3mbTWBg7EXiCUhLxM1XDskyy2fEgGdV3
         X5RDz3Qa8o13wLdKOoJ6WRmx0kuvikveEyLGFE8RaRHVg6q8v+f4YQAw4TDwfOKpBVD3
         nAdjj3ZczkFAGjLRTs2hINVdJs9kFPb/yHqHx20CpmqfdnBGFm55snNd18Kkpy1oC2bv
         5QmzYvIC7e794jecEnZr16sYju1oR5OOB7Rceucq+k3w314AEB2295n37MvcF8dL1XZP
         Az8T1Cq4LvkhOvbQR9JUkJxty2Cjd71jJRI4ZT0sDi78rKOEGTuf1lHWhL4sBr8pZOs+
         sAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792772301; x=1793377101;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QP7Z5nq9f3M+wzua4Vt0AE8lDl1n5BDSlA4IpFM8kg0=;
        b=jorPzx+wrb6vkOjJwU5vxm540TIki21iZ6t2JXcpt7uQXlIBiXTeP09OIUbZiTeJDM
         uEY6iya94vqotTnFAZK5XCENq50deY6d77vtZc/vCEpFoey5jy8NdCTUuOh8zQKsvlYF
         lNyHkXRrNJELdhLQk1RdvQLHR2IltHt8D497oMpFpiSU7+lFBcwm4YnRBysHtbVu27c6
         PLifloPM6GGIxkX9TkkOoNzVUTdjnnmbA7z9yKpjYb/dOiLD0d5D9HZPMdOZO6Phcth2
         EON5ZpkDy49+Hi9IJYU5C2ZepA71qeK9VygagycUMa2oC3PhqeQ9fMCRhc81FZs7CWrT
         lV5w==
X-Forwarded-Encrypted: i=1; AKwUvBxbFPBXXxFeTJY7AowQAU+GHy53qR6CytCiwsWt/eClrW6d2Yc8xhkm8X4fpsjm7fpED+X5Fi0yKRSEWA==@vger.kernel.org
X-Gm-Message-State: AFq9FYK38m2A3rxK9W4v/HiF3IepjHTUCPd2JKxWsTs6IKUCV/mYYVE+
	Y6a2VFHo6yMggpaxOiq/dEspvvLST9W7Nr7J+iY97BdZRiETDfjp3iyq
X-Gm-Gg: AYBFou0k2lPZlmnTdCXDiMWCFNTqrDu4Mx45fX0AgzySGPJkdI8taySVKWt4c4+amz3
	HjoDZW+8ju+yt0HaSayTHRRJSPvWwiIpoTfshpc7VLSnRjW32ith3h3Aa85W0Nxx1NKZHyBiAe+
	db16aJp6qfT5cK8j/nYzA9JAQaNBn8P1C06uEPK/pZZopwtjuM8nklyxzCinb4tBA0vB9Cbh4jg
	Nm93X8vtwbyJXAWTPNKgsLFTk0ohPYGf4ScU+5X5Vb7dXVFK6SqOuYzV6bHNwqk49Z/tz+Xra6q
	IXA8tjjx4v3YdQdgD5ohxK/3+T61okPKf2Jhzp2C/nQLMKg6VzzDvRG/Vqef534hYIwP3KRySrs
	l1Eous3qyrfhdx2T3YRNjOi6WLfo0GZ0lwycXPdHx4qE7EPggaYBwcix/2oXC2KrGpFPTOplkk/
	ji1ZlBxppWlfYt7Xs5FoW0F81ZghrC+rEhM7KZctqdVqd8IBuPnXv53sRG0SlBw7EoKDBPjch8P
	vzPqioVEUrHCaoQsti9JeRbOELA33IUEpwRBMoY4v1g8NG3F23H
X-Received: by 2002:a05:6000:2005:b0:48e:a13:7c8d with SMTP id ffacd0b85a97d-48e385ae732mr5020513f8f.49.1792772300560;
        Fri, 23 Oct 2026 09:18:20 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d421f65sm738672f8f.48.2026.10.23.09.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:18:19 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:18:15 +0300
From: Dan Carpenter <error27@gmail.com>
To: Shuai Liu <847807867@qq.com>
Cc: SudipMukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: sm750fb: remove unused macros in
 sm750_accel.h
Message-ID: <atuIxyy427lxFwag@stanley.mountain>
References: <20261023141143.183061-1-847807867@qq.com>
 <tencent_6CA7B248C9B3374DE2DA88094C98BB5F4B0A@qq.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6CA7B248C9B3374DE2DA88094C98BB5F4B0A@qq.com>

On Fri, Oct 23, 2026 at 10:11:42PM +0800, Shuai Liu wrote:
> These macros are not referenced anywhere in the tree. This is part of
> the TODO item 'refine the code and remove unused code'.
> 
> Signed-off-by: Shuai Liu <847807867@qq.com>
> ---

These are macros which describe the hardware and they're useful as
documentation.

regards,
dan carpenter

