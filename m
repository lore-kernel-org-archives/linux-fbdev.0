Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E744A29D291
	for <linux-fbdev@vger.kernel.org>; Sat, 30 May 2026 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780170738; cv=none; b=mKAfGemlAvf9DwE6uoKc85T+ZSlPWVkkEIGxv5AydYuiGEWNXlTI051/a3s1GTjdT838TjzEa457uE2DvR22YFCQ/cHvynhVgkAAZjizsgjVRwmvAfSPma1p/ZLZFYkmWVoB9yAjyoe0hHIoW3NDoe9PPe3b3nTwUS6SgN4umRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780170738; c=relaxed/simple;
	bh=RylDaD5hhxsd6PNZhB2ePBepn0s10Zl2UMRJoHTMqq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ak18vGl0wVBlWOLQ9RmmdpUoTBeybX9mOEJr+bfdki9Y9n/SMGSOTdUVM1tSyUpnJLIVEWDXuJRBmCeeQmAFzVLY4l2vVf1Dcrx5/KWso5zRhxaJD+oVxeL5fyC12v5f1AepzaxGylqBtvH+XGn2nbZ8t2gb6ew/4m1beBBDo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ag9l2vZT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ag9l2vZT"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ee1a56328so3228086f8f.3
        for <linux-fbdev@vger.kernel.org>; Sat, 30 May 2026 12:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780170735; x=1780775535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mG1r5W6r/pdjE2plwFQi75uU1JyttffvzikhmbVB9NI=;
        b=Ag9l2vZTc+xluTDwnRn36YbvgDl9BerJp2KF2VxdR4AeAlaMQI2g/8QJ3kd9wgn2I9
         E/xsCbHUeXIzLAeXUZrCqsynv8pJTheNhKPR+x/Fy7TndyLU/Sf7R9dUsvVmYu3Jau7k
         iDMzkK/68ylRInTu9AEtHypzY1TZnonpNSi8UKBNwzJehDl8qF5MCdpWlmuZPLFenFON
         0JtGuwi4lWyA9qpF3IhN5phXToRQHJ5pmT8mmKgCUmuOYKSOfVY6n0MqYr4NfJ+FsgVH
         c672s5hWSw4JC1CScRCKqDbB6T1WuPIJ2ZDjlb2/1xB4JEFkw1JmDWyamJHrum/vv6QM
         uulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780170735; x=1780775535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mG1r5W6r/pdjE2plwFQi75uU1JyttffvzikhmbVB9NI=;
        b=bWvvf00wZFcLcNHGIy+CXTNc3ExRO7h7vLer/TOeApVVCVwMPgcIgKDLvZXqTG1TmI
         ap/+A8o/LqoWSwNaAD0SYjJRwrncPe3RO2bC6VvGVuaCLKlUdHyunseSIxJadUECXCWu
         YyXteCg7/B1PqrsmIZMe8KDAzGnpX1D55qIZ9dPc1lLmTTlvLxjftMSfCtRl1lKCnw85
         USRNVux8h1gZ24CsOwWsAIU/CjNnLxP8Iq/WERbrjG38L3l7lUWzUatG9mw8pq9e3WrC
         CyO2iu9m4wLhTbFNHyMTbf2A77huUjSU65RjSizBRPn21EigDNRycNe5EdR9rbFn6BC+
         t82w==
X-Forwarded-Encrypted: i=1; AFNElJ9Ss3u2g04sy8wuYt/vrE0UfMAOVVzz41KV/EgchG9MTDXKJoUgh2yYEpabtetj7+q5U23xf46rxmMxSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhyfTb0PBmNdmz2kHKHXERaAllAwhhCCbbYyl+f5MgNdzQqp6T
	FLj0sOEWpPzCRc3zTglvGyC8bM8b9FvWHSHCwQ4p2stAjv4hvsimbDwiDFPn+g==
X-Gm-Gg: Acq92OHvMtQvRBIdqm2Yj4zg5GQBC89x2+zbAzMJr0n51BWq13pcAH+SBWSuPN9pdPL
	dSFOWa+3NvCpERo7RlKZj2389JstkZn5H5UeZPdLu6yxKSnKuBEE+yGybmCRBP6sD7qYEWW9Lc0
	o1RkQxjtjECQpnIeb0EoWugNCDj5lQ9pcclh4D5IgvIXrIWB2eYZ2Xsgpn9FYUWO/zc7O2YVo6b
	p6mvpXZGT3v5A1RwCoM5JNX/zkFFs9RFfBYE8VfwCLZU+TIyK4VC+eX/oGmX8qOBWQrnx83Opgs
	LOEQj2QTGLftJIGyZBPFlYZ5EAssZQQuvKesne9VKqQ4P8Swq+5EmrIDQnZNftzsy4lfSr7f0Vi
	I1wBMM8QB1dwf5fwO57x9Jo5EsvOLH9HRMD8foHhHg3zP2pdRKqy9bYeeiAGiSmxvZlfHo/HwIy
	ejU1qA3kfMr5A9gn3tCa10wDgm4sOsIrHZXjXgE69nR2FK
X-Received: by 2002:a05:600d:8654:20b0:488:9bf8:7f17 with SMTP id 5b1f17b1804b1-490a292111bmr65783815e9.14.1780170735382;
        Sat, 30 May 2026 12:52:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c103baesm40806935e9.17.2026.05.30.12.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 12:52:14 -0700 (PDT)
Date: Sat, 30 May 2026 22:52:11 +0300
From: Dan Carpenter <error27@gmail.com>
To: neha arora <neharora23587@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750fb: remove unused variable
Message-ID: <ahs_63SvPOK-pwTp@stanley.mountain>
References: <ahlXYIqzu4O5-u9J@stanley.mountain>
 <20260529101242.10189-1-neharora23587@gmail.com>
 <ahlszyY6Nd9ANz-X@stanley.mountain>
 <ahlt_3J9HQVz7Zby@stanley.mountain>
 <CAOWJOpt1ywtQFiazSBO5F7npLj6M4_tk7R4E8o0DVkHE5sWSvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWJOpt1ywtQFiazSBO5F7npLj6M4_tk7R4E8o0DVkHE5sWSvQ@mail.gmail.com>

On Fri, May 29, 2026 at 04:24:49PM +0530, neha arora wrote:
> Hi Dan,
> 
> After looking into the structural dependencies and the cross-casting
> between init_status and initchip_param, I've decided that this refactoring
> is outside the scope of what I want to work on at this time.
> Please feel free to drop my previous patch. I'm going to shift my focus to
> other areas.
> 

No stress.  I feel like we see this often where people sign up for
one project and then it turns out way more different from what they
imagined and it actually isn't fun for them at all...  It's fine to
move on.

Let's add this as a KTODO though, in case someone else wants to work on
it.

KTODO: remove the init_status or initchip_param struct.  (They are
       duplicates).

See this email for more details:
https://lore.kernel.org/all/ahlszyY6Nd9ANz-X@stanley.mountain/

regards,
dan carpenter

