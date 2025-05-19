Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5560526C3B2
	for <linux-fbdev@vger.kernel.org>; Mon, 19 May 2025 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645484; cv=none; b=dewXu5PSEP5hC/EWCL3VhHW9Sb9iJ8FRM6KIA6U0gTGqwTQG0/uE+lBwY0TNz2ZOWbcuWnV2TxHkDbpBoPX/V/pYM5dgWVuQj2BXrHbSaN4x5zTRSwtNuqkz4H8JEaOk6sHO5IndWNIU0gCWXHFtKuhCMZevvIj0aHQ4zbA3lSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645484; c=relaxed/simple;
	bh=s3ZF/R71XbQ2Wv8UWMHptS1RGAgFwyxTx7aSnB/lvm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AoTobwX5OUbw8KLa4cCrUvMhkn98MMpeWEwVhsEreLIuHPEQP+eJYhXmjNcIOaWV2GB7Q3G3Xc1rJjCGsckAkVa/0V1eVVpRJrZFmuCoMx6ePG9YH+FJf5uIsKI5LXNkEFFdPcwHPK8I113VCYBl2RF0Noo+jPLJnmdL/wz0XQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWkHHEUR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWkHHEUR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747645482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b+x4vTIQvSf2FWpLg3QbvkOR5KW8aweHD+AVnGY/4x4=;
	b=SWkHHEUReS3/wzqhhdzM/qZ8ikzkMJxlChELE0Ha9VnjVY2/sW7G54SgFhn5SYnIe7cA35
	mwxBOKlhHA4aatUCqzSHXbasPTTz/KjbLkilBpHqux4XS5cQCC1aooEV6etW9THK1D8DcC
	vjjEFd2z7xYXI9VmERZc0wxwYqSxxxk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-UbsEN-VXNia9wCTJWqZPbw-1; Mon, 19 May 2025 05:04:40 -0400
X-MC-Unique: UbsEN-VXNia9wCTJWqZPbw-1
X-Mimecast-MFC-AGG-ID: UbsEN-VXNia9wCTJWqZPbw_1747645479
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ea256f039so33760025e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 19 May 2025 02:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747645479; x=1748250279;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+x4vTIQvSf2FWpLg3QbvkOR5KW8aweHD+AVnGY/4x4=;
        b=QxWX5T0vyZ9hyN9A39/3qh6txUkqActnBC1zQNgHZ7MSzsmjpJEgLev74injKGm6/2
         Vx86KDVbNKAnsXlcLU/zjhwIKQEj9DpBgdD7K0Atb4OeTkv3tC9fS3nEP4HpYwQIzGj4
         l2Ki3uaDOyalgfK7wPmUfwMkoAzIR61jklV4BWmUlnDA/zolFk3KQJ7wr4DPvm3cUA3k
         Cv6ZDop7jpvRfmQrFSxtAaIgQdE0PSKs39D3/PPpAn566LBy5rJF/4+zY7GjPHjMDT1W
         8XPeMBlnpmmBcF0GmVV84rsQO9+VEBmjj+fLf/fZiJXjSWy3E+ncOM0nkMHmh6um4NDf
         jAcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUszt+aK1e5EMZKILc/lfOiU9S+UONemo1qd7ShOCZtxk8EQKl0EUFfhkDxzM/HqA+xL1z4Qc1MpGjuRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOgFWIlA95iAMo7xih+b13fEbmFxnF7XxNgQ0TMshkk5pbG6i/
	rE4tL6VQGmMrh2NXHledIj4T8X1AAN3PbfJMvkLmaUuZ+LzBRO6+PwDhcUrbRjU/R25Nkt9rtt9
	CDYOr+7i2Q2ipdM9oCltDfiDcUQXDboF0MuYvHd3d4inDMYkl66aovazVZfljqPmF
X-Gm-Gg: ASbGncvEIsZoAEjEmf1QREiPD6kgshfWtMEqvzgsUKDld8DqNbKVYs+O3bkudE7WgoT
	8ILVZI3YdyIkn1ncuANkTfrEDEsEsbH1BCfZCMh54O3sB4NkW2u9WttiHQ7Ph4JIzjIBAor7eT3
	FD8uGGcXW8fX6TKbw+DUN72eVQBdtr667TC7MQYpUzHWz5CqyJYZn7o2nKTYzYtGTBfTivLEoRJ
	GBvG6+4FHDZ6V754A7YwLtqaYGxd7xH0uJJeARKRiZG0ZF4+4m721rdoNFbdbihQwXbEK8I6C4R
	Zywy74QZf1H0QXOazH0jqNwSlgbBOicYcUO0XUO5LQ==
X-Received: by 2002:a05:600c:524d:b0:442:e109:3027 with SMTP id 5b1f17b1804b1-442fd6649bdmr105814955e9.24.1747645478941;
        Mon, 19 May 2025 02:04:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBHT37+a7uQLiNF7xXa9+Pq3Q8b9W3F1Dvt9NV0dg1vkagGrtK9lGqM9kuxuBv+sLOTByRBg==
X-Received: by 2002:a05:600c:524d:b0:442:e109:3027 with SMTP id 5b1f17b1804b1-442fd6649bdmr105814645e9.24.1747645478524;
        Mon, 19 May 2025 02:04:38 -0700 (PDT)
Received: from localhost ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3369293sm207128905e9.6.2025.05.19.02.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:04:37 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, gregkh@linuxfoundation.org,
 hdegoede@redhat.com, arvidjaar@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 stable@vger.kernel.org
Subject: Re: [PATCH] dummycon: Trigger redraw when switching consoles with
 deferred takeover
In-Reply-To: <20250519071026.11133-1-tzimmermann@suse.de>
References: <20250519071026.11133-1-tzimmermann@suse.de>
Date: Mon, 19 May 2025 11:04:35 +0200
Message-ID: <874ixhotss.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Signal vt subsystem to redraw console when switching to dummycon
> with deferred takeover enabled. Makes the console switch to fbcon
> and displays the available output.
>
> With deferred takeover enabled, dummycon acts as the placeholder
> until the first output to the console happens. At that point, fbcon
> takes over. If the output happens while dummycon is not active, it
> cannot inform fbcon. This is the case if the vt subsystem runs in
> graphics mode.
>
> A typical graphical boot starts plymouth, a display manager and a
> compositor; all while leaving out dummycon. Switching to a text-mode
> console leaves the console with dummycon even if a getty terminal
> has been started.
>
> Returning true from dummycon's con_switch helper signals the vt
> subsystem to redraw the screen. If there's output available dummycon's
> con_putc{s} helpers trigger deferred takeover of fbcon, which sets a
> display mode and displays the output. If no output is available,
> dummycon remains active.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reported-by: Andrei Borzenkov <arvidjaar@gmail.com>
> Closes: https://bugzilla.suse.com/show_bug.cgi?id=1242191
> Tested-by: Andrei Borzenkov <arvidjaar@gmail.com>
> Fixes: 83d83bebf401 ("console/fbcon: Add support for deferred console takeover")
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v4.19+
> ---
>  drivers/video/console/dummycon.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
> index 139049368fdc..afb8e4d2fc34 100644
> --- a/drivers/video/console/dummycon.c
> +++ b/drivers/video/console/dummycon.c
> @@ -85,6 +85,12 @@ static bool dummycon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
>  	/* Redraw, so that we get putc(s) for output done while blanked */
>  	return true;
>  }
> +
> +static bool dummycon_switch(struct vc_data *vc)
> +{
> +	/* Redraw, so that we get putc(s) for output done while switched away */

Maybe this comment could be a little bit more verbose about why this is needed
for the framebuffer console deferred takeover case? It doesn't have to be as
elaborated as how you have it in the commit message, but more information would
be nice IMO.

> +	return true;
> +}

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

