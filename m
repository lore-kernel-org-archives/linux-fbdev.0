Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1628913FE0
	for <linux-fbdev@vger.kernel.org>; Tue,  5 Mar 2024 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658453; cv=none; b=PHdB/R9MVryq4eQcl+fML6KANVeVNGMJzCL70+OcdC3QbEe29++5UHniictBp7cR2JLyjbb8Tu4E6ROm1izkvJa//7EO9/BCIon2cHHO/olkoohmQ7ER3QjQT+DiMwjBmR5uqaOkP6RCm2KoShjjwMTbVe606FQmWMs+Ab2aYcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658453; c=relaxed/simple;
	bh=kDL0bKC/FdnbM5PFR+QeX7Z2TzJVZvMq9rDwAGIujaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/9Cw4ds9VhrxaLRqvql6xr8v/QZfny0GxJcaRLUKGDnt5iLY8MBiJBs4pvZ7sKH+0qD2vJ6EvFTTP6eWJk2DUWhqjj0HNafTERn5RGAAQ1uZh/nKrd79S1qAE/PO0xj1vh4Exmzjk1Uf5B2+ujuHi3McK0LYU8pm4UNjkGGYB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHwSCCqs; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHwSCCqs"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so6320474276.3
        for <linux-fbdev@vger.kernel.org>; Tue, 05 Mar 2024 09:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709658450; x=1710263250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xf8U/YCUFimTwrJwKD9PvTi4VYclikCpHMhYCrDyA6M=;
        b=rHwSCCqs4KLSmTY1OsJmwcSvHVgRs0RtiIoeBzIH0+xT72IIQ9VepeT5xNjuJGXpYe
         pc1ao8M6axHpD25NK6oahNuk2tJek9N5kFfVcjaaUXxO8bRv8H4rKyWasrV8zC6Ypnb/
         SHz3GnQeXwVWmH38M8OK+b4n3rYVGAmRvkxI6fnJcoMUo0HVfvdjhq1yeY0p+mIt6Q8d
         cYvJbmjlJXvcee75M4HQWs7MvJeEtgtAHcrHPmw+BaH0Pn8+yk95vmPESfPVyPQeMJdg
         TjwGJKKpXMCe7pX7nkshV0OCHYtcpO1JNvqZ1cNjCNjKYdRD6pySeYPi56g2hcIHJYrD
         m/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709658450; x=1710263250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xf8U/YCUFimTwrJwKD9PvTi4VYclikCpHMhYCrDyA6M=;
        b=iKU01Evi/kxrNcmL15if/iSdqnqrO+TMJiAWccHr3Ex/rARx90z4RvbPR9ADwfJtPk
         Ht+UaWAP1adOoG21abMNZ+k+eisdV0W+1E1iwlVuW0GhH4nvHbcNE+KwCtG9piebCtmE
         FvlWN7LzDzu1Tt49iJXjFixaJmrlz6jw7xx36aIr1A7vWXNQfo8OUjvBmzxTZz2Qy1wO
         6AVSxe6zBEWjDJnNdwNWXOZQhuK5YSS/C6pa3vGeROgywmYIlys6BCUVILv/ldW7lChd
         gyDTSwkN46+uWgEfzpkFuRNo2IC4ePAtdHmJ6PJlKQ8nDLzPQ/JcxBQiVK4KDREUQKx7
         wEAA==
X-Forwarded-Encrypted: i=1; AJvYcCUYba+WQJTxYPxn74E8yrEWOCtpdMZN6EbWj83Hz8wYWDqKf6tJojjglExElVSbBg4WX99FnZN32DKGffPPPVPOf1WHw2qXHyomfbI=
X-Gm-Message-State: AOJu0YyvKYobP7S3zOTKF2QAnKxoMXaGzVw9d1dYXoG0YCvmbgXW23Su
	uGvTtVIvtyFnSFmjH95EkWyF+qOGNchP0vLks7VoCMTHRS0/wIP/pv+NhxBZXl3VDhcxJ0S1rki
	umjswUCKnTjYq/wFJSGP+tBDDwAXsknckHL+i
X-Google-Smtp-Source: AGHT+IFcqAf9bC17H0h/tfqRs3xLoCqraMHelviOyaD+ddhbqiDr1geTm3/Xp4CxcT44v3PUNnOU4ePnKKfLZOimpLI=
X-Received: by 2002:a05:6902:2012:b0:dc6:18d0:95b0 with SMTP id
 dh18-20020a056902201200b00dc618d095b0mr11090518ybb.8.1709658449653; Tue, 05
 Mar 2024 09:07:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305-class_cleanup-drm-v1-0-94f82740525a@marliere.net> <20240305-class_cleanup-drm-v1-4-94f82740525a@marliere.net>
In-Reply-To: <20240305-class_cleanup-drm-v1-4-94f82740525a@marliere.net>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 5 Mar 2024 09:07:17 -0800
Message-ID: <CABdmKX0VGyBdTo8gzEocyz2HFcqEtu_31PYVjWzioBdCbnXW6w@mail.gmail.com>
Subject: Re: [PATCH RESEND drm-misc 4/4] dma-buf: heaps: make dma_heap_class constant
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Hans de Goede <hdegoede@redhat.com>, Helge Deller <deller@gmx.de>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 3:34=E2=80=AFAM Ricardo B. Marliere <ricardo@marlier=
e.net> wrote:
>
> Since commit 43a7206b0963 ("driver core: class: make class_register() tak=
e
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the dma_heap_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/dma-buf/dma-heap.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 84ae708fafe7..bcca6a2bbce8 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -43,10 +43,18 @@ struct dma_heap {
>         struct cdev heap_cdev;
>  };
>
> +static char *dma_heap_devnode(const struct device *dev, umode_t *mode)
> +{
> +       return kasprintf(GFP_KERNEL, "dma_heap/%s", dev_name(dev));
> +}
> +
>  static LIST_HEAD(heap_list);
>  static DEFINE_MUTEX(heap_list_lock);
>  static dev_t dma_heap_devt;
> -static struct class *dma_heap_class;
> +static struct class dma_heap_class =3D {
> +       .name =3D DEVNAME,
> +       .devnode =3D dma_heap_devnode,
> +};
>  static DEFINE_XARRAY_ALLOC(dma_heap_minors);
>
>  static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> @@ -261,7 +269,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_e=
xport_info *exp_info)
>                 goto err1;
>         }
>
> -       dev_ret =3D device_create(dma_heap_class,
> +       dev_ret =3D device_create(&dma_heap_class,
>                                 NULL,
>                                 heap->heap_devt,
>                                 NULL,
> @@ -291,7 +299,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_e=
xport_info *exp_info)
>         return heap;
>
>  err3:
> -       device_destroy(dma_heap_class, heap->heap_devt);
> +       device_destroy(&dma_heap_class, heap->heap_devt);
>  err2:
>         cdev_del(&heap->heap_cdev);
>  err1:
> @@ -301,11 +309,6 @@ struct dma_heap *dma_heap_add(const struct dma_heap_=
export_info *exp_info)
>         return err_ret;
>  }
>
> -static char *dma_heap_devnode(const struct device *dev, umode_t *mode)
> -{
> -       return kasprintf(GFP_KERNEL, "dma_heap/%s", dev_name(dev));
> -}
> -
>  static int dma_heap_init(void)
>  {
>         int ret;
> @@ -314,12 +317,11 @@ static int dma_heap_init(void)
>         if (ret)
>                 return ret;
>
> -       dma_heap_class =3D class_create(DEVNAME);
> -       if (IS_ERR(dma_heap_class)) {
> +       ret =3D class_register(&dma_heap_class);
> +       if (ret) {
>                 unregister_chrdev_region(dma_heap_devt, NUM_HEAP_MINORS);
> -               return PTR_ERR(dma_heap_class);
> +               return ret;
>         }
> -       dma_heap_class->devnode =3D dma_heap_devnode;
>
>         return 0;
>  }
>
> --
> 2.43.0

Reviewed-by: T.J. Mercier <tjmercier@google.com>

Is this really a resend? I don't see anything on lore and I can't
recall seeing this patch in my inbox before.
