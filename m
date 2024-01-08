Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B50245BF0
	for <linux-fbdev@vger.kernel.org>; Mon,  8 Jan 2024 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5QuxNYH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704723349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YxB4hJGUskiSNKv+s1TrmZMXKolMvHe6Ob3/kfn7C0U=;
	b=P5QuxNYHhJLU3HIfzNVaEpyDPkTAAfWjFaisD96VD6PLrR8Q3wfCf4pinTrV2X9GbIJ2Ic
	Z5DZxAdp80w+F4+w7AdQmHo0lkW8WTM3VEimm5tdCnbk3Mk+ShaL8N700Ei9VHuKKhJ/wZ
	JwOzXLDMAQZ8vqMaIomvgxfcvD39k9A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-Ha66pxlKOgGFOck5bzbAFg-1; Mon, 08 Jan 2024 09:15:46 -0500
X-MC-Unique: Ha66pxlKOgGFOck5bzbAFg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33680148d24so1317723f8f.1
        for <linux-fbdev@vger.kernel.org>; Mon, 08 Jan 2024 06:15:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723345; x=1705328145;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxB4hJGUskiSNKv+s1TrmZMXKolMvHe6Ob3/kfn7C0U=;
        b=Zv6IxE70zQiB/pCXR+rdfPw/B0NrRbruYlvk4YVqoTUtouNvUWFn8IOQyd65Athm20
         B/OV6US3Q/FXLJcspdKx7dLxIXVMf2s9K6RNuVbIQI/ajT51OFn7gFJbR3P87UKIF7wK
         9Pv/NcsdzFwzZ/BSLsMykRFRanHmYgIX7jhaYNPISYDlhHuqyPXDPfHRU8NUJtNAFuVI
         06fQ4S4dxYj0wL3vzuwudbI4E5h6ufjYaheiN3eZ7Lv5+zNcTTu6urq8sSshrD/WvLCd
         SIVfL9ZTkL3CY2Ja8fmaZHHzxmOnKJkLxF4PDfHydwSmTmVBJW1DzXVneuF3ABSn3Lqw
         gtBQ==
X-Gm-Message-State: AOJu0YyDyfl6CoBV9ll4FdaXESPdS/BHQtLkCmY53GkI1ZSuz2PuXIeE
	UEcIFRRzwDqbQjLFqYX5ilCijPOXjUsMX/fZ6RGfI2WmeIapsyTTMKJ7AVlSz4htnUnq1wDoPW6
	Zbcwlx9covsO2T0QWN2ZZw928V9I2FKk=
X-Received: by 2002:a1c:4b10:0:b0:40e:48b5:3349 with SMTP id y16-20020a1c4b10000000b0040e48b53349mr432183wma.25.1704723345536;
        Mon, 08 Jan 2024 06:15:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6B2nGNQDVdFDm3USpj0QhZ27T8ggPZi0nN4hlsNXsc4GJ1RmAnYI10aMq5+7l7vGing5psw==
X-Received: by 2002:a1c:4b10:0:b0:40e:48b5:3349 with SMTP id y16-20020a1c4b10000000b0040e48b53349mr432170wma.25.1704723344860;
        Mon, 08 Jan 2024 06:15:44 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b0040d5c58c41dsm11210711wmo.24.2024.01.08.06.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:15:44 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>,
 linux-serial@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-input@vger.kernel.org, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] vt: remove superfluous CONFIG_HW_CONSOLE
In-Reply-To: <20240108134102.601-1-lukas.bulwahn@gmail.com>
References: <20240108134102.601-1-lukas.bulwahn@gmail.com>
Date: Mon, 08 Jan 2024 15:15:43 +0100
Message-ID: <87y1czdi7k.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

Hello Lukas,

> The config HW_CONSOLE is always identical to the config VT and is not
> visible in the kernel's build menuconfig. So, CONFIG_HW_CONSOLE is
> redundant.
>
> Replace all references to CONFIG_HW_CONSOLE with CONFIG_VT and remove
> CONFIG_HW_CONSOLE.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Makes sense to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

