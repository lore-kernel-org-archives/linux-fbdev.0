Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8495FEED
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420776; cv=none; b=Xb67wMPBer5U2+6/hJYMioGS+YscvyO+CZZqa/XPc4wiJ8W0mNJN6lilpWYKSQbHflY0CvQ+b+hZdLEaQeg91H9iS8LRJiPQQU8/BK5pnoSueIFTGsflGDzrXX1IFqTa7lBz29As61iptmkOJ5PGaE+VO4r59PvKFMRZTN6V7Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420776; c=relaxed/simple;
	bh=QSKI5DJWNWiQUQy8PSHe+VdPXu7WJOu5tx0cx/gLfpc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NlZw7oPrM9gsZjHkL5I74pjVUqNHWTjZ45VGDyZlslVM5X8wy62qpFj4uEyw7UjSKmcaTiZnJuNAqimGO2Pb5qdSeyXLJz6k6pX0y8nJheRXaUc41FL+bfwHNWr7dkuPLelGppsX0XHg+6fqWecduf/Cv+8sr9tWWwWE7JO8NOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZMkmLF+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZMkmLF+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708420769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSKI5DJWNWiQUQy8PSHe+VdPXu7WJOu5tx0cx/gLfpc=;
	b=GZMkmLF+XXP/JcDRw4m4XKQPkvbOVzQ6RrgRA6dcuVOd6XjUPdy1vEwk4ZoYnZMmwZTn6H
	ydnlnWO62acFeMYwsxC79soUC6wJYD914K+FUigWxA0ZPxfe66mUSlbyoFTxfmxFWjFWQV
	sGi+Rn3ITUje0yNWgnWaTsgIRdHp620=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-BzAtZN40OZ-k2dq4ibbllg-1; Tue, 20 Feb 2024 04:19:28 -0500
X-MC-Unique: BzAtZN40OZ-k2dq4ibbllg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d60ac6781so502909f8f.0
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Feb 2024 01:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708420767; x=1709025567;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSKI5DJWNWiQUQy8PSHe+VdPXu7WJOu5tx0cx/gLfpc=;
        b=qQ+phyIJy/qo59MA62XFrz5IpQrnucfQ0E5x4S+SY8bBmd7WbYmRfX76FFv+/Xtq8z
         Vm7DVC/QfhtxpCejuJd56zEDPuS7ML6fWYpK/q1WhU6JuXQoBE/EnaeNd7aOD2WVk/Tm
         BkProK0q81zLrbpX5wRHOdJ1gwqica1bbI+hK5wPFHQBjSht7nRD/TWc3pC6IwzTxk/7
         Ewrd7fKidNzLv0x/7IlFd4G1ahKyCDkFCeem3gAmBZ+XqVnM5Uxw9FPiiCYeKeEprhdR
         S5TMlhqhKtXImSPordFMTidryEIFAo4M6ykWudyzm5JzbGmjXPMlcJnLFr3A+JqjhZWB
         ijPg==
X-Forwarded-Encrypted: i=1; AJvYcCWxgF4EGkLpK/m85gI+PerjuGu8FYu0eo50HZoHku1I8vgrED5U1YdqhJ6JUxubN8iFe/dazwIOUTjvFUNyyWKBPx4owxvhkNh/LgE=
X-Gm-Message-State: AOJu0YzQsJAPjpmxc5W2uVeSdQKrZTg4pcBcb45nSEU+2hW6AuWmHMJj
	fxXqcfq56I2UFAdXYnFOjUnAEHzvSvryvAvj8LPYcaxMV9f3G2Gl/Mo05bf8xBe+T+o9eWe5yOF
	lL3CXE18IF20Q/6Fp27xC20YvqYifbe9cjMVUwc/vGrcnKFex3iKM2AEz3e2R
X-Received: by 2002:a5d:6786:0:b0:33d:211a:7916 with SMTP id v6-20020a5d6786000000b0033d211a7916mr5926226wru.44.1708420766991;
        Tue, 20 Feb 2024 01:19:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTe50tTS4pbmxQYTMjD2j/YAzqOczhi1muOVjjeiUkN0RVGhBVXraWyeGB4LGC9gqQftjerg==
X-Received: by 2002:a5d:6786:0:b0:33d:211a:7916 with SMTP id v6-20020a5d6786000000b0033d211a7916mr5926210wru.44.1708420766657;
        Tue, 20 Feb 2024 01:19:26 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ay3-20020a5d6f03000000b0033d1b760125sm13186512wrb.92.2024.02.20.01.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:19:26 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, lee@kernel.org,
 daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, Thomas Zimmermann
 <tzimmermann@suse.de>, Bruno =?utf-8?Q?Pr=C3=A9mont?=
 <bonbons@linux-vserver.org>
Subject: Re: [PATCH 03/10] hid/hid-picolcd: Fix initialization order
In-Reply-To: <20240212162645.5661-4-tzimmermann@suse.de>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-4-tzimmermann@suse.de>
Date: Tue, 20 Feb 2024 10:19:25 +0100
Message-ID: <875xyjjxwi.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Zimmermann <tzimmermann@suse.de> writes:

> For drivers that support backlight, LCD and fbdev devices, fbdev has
> to be initialized last. See documentation for struct fbinfo.bl_dev.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "Bruno Pr=C3=A9mont" <bonbons@linux-vserver.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

