Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWYYCUH8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6011A7
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 05:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700140382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xleHXMOYndgy/0SzjJt8wqPeBlWoOdp4DyJVoMu5fsw=;
	b=fWYYCUH8whwPp4sSm9hklgVr5ge0VKV0HBHBmu4d6gFcEHztMPfZ1C6zBDC8JU1A5oQkMx
	U96V0pbEvhKbP3uZ6/9vLTEqIGafA6Purw27nX2niGpFI62mGjgXIX4IIvv8DdiGUNlIpD
	xM+y67zjKRb22pK3kSZP0BOGJfXGszE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-saxPiW1xP46M0nOxrfGB5Q-1; Thu, 16 Nov 2023 08:13:01 -0500
X-MC-Unique: saxPiW1xP46M0nOxrfGB5Q-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c52cbb64c9so6646851fa.1
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 05:13:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700140380; x=1700745180;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xleHXMOYndgy/0SzjJt8wqPeBlWoOdp4DyJVoMu5fsw=;
        b=EgQ5ntm4ln3mzmJyQ50gkCYaVpfjeN7PrPUTvnFlCOMbW0+N78MrXofc3Fy/PPXP4J
         ntSverkU+PGFsyKyJHOlpFv44lHGgn3Qtn1fnQeJVUhDdZwJ1b3t0U20RoGrs9XnvCn/
         /r3VKV2l0ijpqVny1zwT78WCA5XOPUTlFeqxoYrRFMXEfme+j9nOCIfcYh7t2pe/iLy0
         WHchBxaIrUplfA9FCWCJvagSaitxbqj0MvykOivoY/88PUzHiJ1eOrZ6Vv1FPjKlFkHq
         u27ZeXFt/utho1hsD/QzTU4ZJNjSa7NHcOqXvjxXEQQTPGGLziLSf0MP0Xsfx3PCWpR8
         ic6g==
X-Gm-Message-State: AOJu0YyEQTx9EOYX9kzoEW8vSnuIK4FR3XgBIXqkcLGk55UQpyL7ZVrh
	ngYzwETTbS+YpZtwPOuQE936Ihw469xGYNcrOGpjyFHEsyoR7inLzSfbFSC1Ju7bxKB5NwPddr1
	XMT55A8D3XVPww64jRlF1Moo=
X-Received: by 2002:a2e:8018:0:b0:2c5:70f:614a with SMTP id j24-20020a2e8018000000b002c5070f614amr5915548ljg.17.1700140379860;
        Thu, 16 Nov 2023 05:12:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZq8VMxo51xXvQF1h4C7TgM5Rtss1R7wyZzjAWJgcFAJspMD3HirntEI6zKgyIlaPaGVn0jQ==
X-Received: by 2002:a2e:8018:0:b0:2c5:70f:614a with SMTP id j24-20020a2e8018000000b002c5070f614amr5915535ljg.17.1700140379560;
        Thu, 16 Nov 2023 05:12:59 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c4f9400b004060f0a0fd5sm3657213wmq.13.2023.11.16.05.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 05:12:59 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 31/32] fbdev: Warn on incorrect framebuffer access
In-Reply-To: <20231115102954.7102-32-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-32-tzimmermann@suse.de>
Date: Thu, 16 Nov 2023 14:12:57 +0100
Message-ID: <8734x53kpy.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Test in framebuffer read, write and drawing helpers if FBINFO_VIRTFB
> has been set correctly. Framebuffers in I/O memory should only be
> accessed with the architecture's respective helpers. Framebuffers
> in system memory should be accessed with the regular load and
> store operations. Presumably not all drivers get this right, so we
> now warn about it.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

