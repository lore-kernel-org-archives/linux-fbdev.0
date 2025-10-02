Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027123208
	for <linux-fbdev@vger.kernel.org>; Thu,  2 Oct 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759395143; cv=none; b=O7XM/uSsq22Gf5QuUSg1Q9QvsISl1orhz5zyMHupyh6qzH9ndFq2VonsbAP1MszMijJ4ji3yQVrzy0h+cHauhCDq5Utzo7Lwlcm9s+LjV/E8hXhY7H4D+2biAc3CjZfyyaN2T8ax+A09jY+o+YWZ7AbFzgsx1wXaBLqcC+mNg0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759395143; c=relaxed/simple;
	bh=/3CBBohhudqwobpwQbqaecim4CFxAcA3g3wvz0iNtsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrVFV+6z8t33T5MGzUIAs3eswRQSCcK55zoEw0xU1Fo6uYup1P67YieHwKuX5X1EzolO5pmz6ZLbjLXnmxO359+SYeoftw6fI9vLsYiPWzUTprMUdQV1TBeGlx8icYHVSpU6sOFaBZORU+KSckeygqUmvSr7iesMiNuniHZpvl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VB2HS0ec; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB2HS0ec"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-854585036e8so81731685a.1
        for <linux-fbdev@vger.kernel.org>; Thu, 02 Oct 2025 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759395141; x=1759999941; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LgjCC+E53eFNAF26kVzyJsHWp/hhdY5/q/808WvxLT8=;
        b=VB2HS0ecQdBVqySejgZigILF7O21n4fZIqYLuNcHS2O1qRxIY5mf55/V6wO7HF2/3G
         4rtPp4eDfMkEttZhp6TE6hBK+GcFcm0lDJPmKsZ3khloscU7kIXvPH14GQX9rcwkjkiu
         ZdoO2mRsHLpUAthe86Lg8M4yJASfgQwmJOyeBgbq69QQisB3WRlxNaLumOn2uIR444Vo
         LJCmQtSX2qmlEujh0SSRk25dJ9/D/K3aOpQH40uyF5cUkjxS/jS6/m+dVIsWH6UJyJxe
         DSsyK1/jwkDJNTMQfdwzG/MbPYj3KPCfcjbQ5ZpXswdwTYRWbozb6bhnAx0SsXiMaNyt
         Fwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759395141; x=1759999941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgjCC+E53eFNAF26kVzyJsHWp/hhdY5/q/808WvxLT8=;
        b=w4LoZzGDVnNMwvFnr1qPaSa/IWx82vOX2pex1myVtHZvt9O/5FvxvJdbPYbOnCqwjO
         MYkgmeT3oZ7JxjnX7ncz4hHGbFNcYoGldm5Fv/mep09hhe7B/TIYWz4HU421kL9Q5SEA
         rFeN16gxKSK/B0tPIQDypIcU882J1eGnavL+a7+Co2y5uLwjwVP2YeHfNOkjPTN55hse
         OvLgXiP0IQqqfgD6kY8xGb66k46ANGD0u4LW9Iy+D/2sVqrhOUMaqrFf1ZsoaOTQnTYb
         qZP2uGqjtHNT6pYRbBSKIcVe8kJBstc4cUtq8DDgsC4U98zMtOiWeCiUwtT418DchDeq
         33Ug==
X-Forwarded-Encrypted: i=1; AJvYcCU2o7IPiAQN4A5EcibIsf7TPeKK5W5LH31RGCUju8YoEgPB8LWxGUJIR3hRvICUJoFlmxb5d9pL2qHllA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfB7q6o3g2aeSLOvaZR9+5Pzf4mtSXt2DNSV+MJmZKR8og4tQL
	PzOSvdR/UnZx1fjtHadaLarDa06Zj7HdDpwe62fLQTs2ln3sAqVZNo6p
X-Gm-Gg: ASbGncs+ccUU2eHvTkgzb9Lff7SpgIrxcrTzzaqH3RNWqCiSLsoKKQa9Jg+vFSqNWpd
	Nc/OuAFbNaaT14rcUOfyoyU1aMuoatWWEV7sJPEQud3e0njgYz46BohvFPATdk1KEBELANTb00z
	bZ6F7ta+5nctZLxUPBaLfCbC58q91lmqXqHbuxLggEplbbskFyevYHp4CnclXPcYn6rIf5Uqhk7
	5gmbV8wl+BUiWKCfbBsHTxqsPRoNmVzQ4b+yyYqGKr0zH2zTYxQVD+EYsJAch0KVhesx/5SmCXR
	UdLBLj2ILcCp2U1hNAuoSDwK0F12iDdNp/dv43JQN5l7xb953GRXen99HfOV2lknYdrGj09YTPS
	SOcRf6McomteHGELhkMzpLj08kT1RiKKzi8ws3iBhYgfpyUlTL++q
X-Google-Smtp-Source: AGHT+IGU7k3Fz4qxQt++XAUKwlyZTB7u2GlUklYCxfSZL0C3TLIQlcsJhzUzzlXGLVOPwzgjISzYGQ==
X-Received: by 2002:a05:620a:454b:b0:7e8:46ff:baac with SMTP id af79cd13be357-873705ee565mr853440685a.1.1759395140765;
        Thu, 02 Oct 2025 01:52:20 -0700 (PDT)
Received: from arch-box ([2607:fea8:54de:2200::9c5c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55a34c6e5sm15894671cf.6.2025.10.02.01.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 01:52:20 -0700 (PDT)
Date: Thu, 2 Oct 2025 04:52:18 -0400
From: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Simona Vetter <simona@ffwll.ch>,
	syzbot+48b0652a95834717f190@syzkaller.appspotmail.com,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: Add bounds checking in bit_putcs to fix
 vmalloc-out-of-bounds
Message-ID: <aN49Qt4dezOqAmoo@arch-box>
References: <20250927075010.119671-1-albinbabuvarghese20@gmail.com>
 <cb00a5e2-6e50-4b01-bcd7-33eeae57ed63@gmx.de>
 <aN1ihRfB-GHTEt_4@arch-box>
 <5ab00319-e43e-4000-8814-c7d67f384c53@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ab00319-e43e-4000-8814-c7d67f384c53@gmx.de>

Hi Helge, I tested your suggestions and they seem to work well.

> Do you know if this affects the selection?
> If so, would modifying (reducing/shortening) the selection maybe fix it?

The syzkaller reproducer uses really weird values where xs > xe and ys > ye
(xs=0xa00, xe=0x101, ys=0xc7e, ye=0x100) and set_selection() already swaps them
if needed and clamps the values.

I added debug prints to check what's happening and the clamping in
set_selection() is working and the values coming through are within bounds. But
the crash still happens when you remap the framebuffer because of a slight
overflow.

I also discovered that when image.width is clipped on the X-axis, the character
count (cnt) must also be updated to match, otherwise bit_putcs_aligned()
	receives mismatched buffer size and character count parameters, causing
	out-of-bounds writes.

So I changed it to something like this:

+	if (image.dx >= info->var.xres)
+		break;
+	if (image.dx + image.width > info->var.xres) {
+		image.width = info->var.xres - image.dx;
+		cnt = image.width / vc->vc_font.width;
+		if (cnt == 0)
+			break;
+		image.width = cnt * vc->vc_font.width;
+	}

I tested it in syzbot, with the syzkaller reproducer, and also manually in QEMU
and verified that the buffer switches from tty1 to tty2 work correctly.

I couldn’t find a dedicated fbdev/fbcon test suite. Beyond kselftests, do you
recommend anything specific before sending v2?

Thanks,
Albin
