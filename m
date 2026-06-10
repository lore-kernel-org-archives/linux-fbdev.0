Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D312BEC45
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Jun 2026 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102332; cv=pass; b=o0PMKCT4V8JMSdpexfIvqJ0bTBjb4/7J+WTGNJVAEgzmQWBmzGzOmEei8lO2KnAYfAkt//f/UMmgmgWchCODrkaHtLsw1XBcVGzu6mMM+EMlXWIXIwdNYKcgQAW2WnzwaEOoGY1j6s9CWciYvcMsbBfcd7FZR54E9zqooP1W1Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102332; c=relaxed/simple;
	bh=TsD6fqLbjN+M4IH/+2UyPBVix65pbcDAr/qNumQhZuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWjIMQhB+Zv9VTXsbiyKkJ2YNobI3VJ/l3rbXA3YlU0rmWN5f0hwAN4Pn0xcpRJNEbL4+BBXTTOP6L4eGg/WlF12vHkAGjBaBnh4/6gyDpfbRROclTEmB3s0IkBf+TvYgRMwgadWCF8gkDinW89UQV3v+PZf480VnmLmDV7ZNXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ir2P8Lpp; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir2P8Lpp"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-304ddfcf72cso7218891eec.0
        for <linux-fbdev@vger.kernel.org>; Wed, 10 Jun 2026 07:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781102330; cv=none;
        d=google.com; s=arc-20240605;
        b=Rb/rhXYPsKfGTvaF1NGMR/cIqtZZYi2M/NNP8Kg7ZI/n3goLmzBkpEpLtvlofMBz/u
         R3xyL9JyMMF7A8X7fJLXgxhteW6BMMNUZRNKt2zbZ70tnMuEgqOJFy0oVVVy11Pvwq8H
         wST3txU979XfU3GC1th6NQWjz+0K/neDJzh3uXFB9m/HqmC8217BaqtiQz48ZSt6vto7
         ScgKEprp47eAnzoy1Nkf30Us/5qLp8dTIoOh0szvIiQ/wZwP+QXZRW3xhaPMLDEmHf32
         MYQNs3xAP0fBP6zOJXfm2pC0OawXyEd5trUSs7mcLq+8rOCCXTh15zTglIoOmGIod0yo
         9GcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xEmfQD66YljQgfpm6pWxKEM84AHfr3eAJ9XCpH6lBeM=;
        fh=IJdp7BS0P+S7ufvfmi/K0CSXpPniI6aeOsWCccD3q70=;
        b=iHQNEGYO+CEG6OkTwP1s75pPsuqWEhJaiDYczugxdUYy5ck2VpuL9mDt1CS0p7l0Ms
         yjipmALd+9cqTlQTQhquaYaKW3ZpsWClb7MmfBRoVS21jcVL7dSqMvu61I6v0RyWbzrJ
         nlbxI3LcjFJyrD5uqT/ZpotWs1kJyJRLZp38Fs67qA0RxbBHr5pOb9sDWRkl62Fdszys
         bMuey+JyyyrgeHY1qp0K3OGQZC/WktgSMs64VAj/PvnVQakN4Se3IL60naGw2Tz8/myZ
         Mb3ara87f54uXFt3cHqZZnaHW1zs13Ox8efJ1UqlOoq1L38A97TaUWDU/c+KBZ3NpbGB
         wUIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781102330; x=1781707130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEmfQD66YljQgfpm6pWxKEM84AHfr3eAJ9XCpH6lBeM=;
        b=Ir2P8LppCaNu8VO02fs6YRWeB3T/yRaOZNBvh5K3RY9ngGcc0JwhMi6GJO1txObdo9
         ueYjNMIUYdcQQyO3oDNzqBzhK0UAIGhHOaeley5PmLvz5/EGYezU0CmnA5WdZbkd8sUs
         tW+WdEE7cwZ+cTYL+ntvXVHPZlUbV8EENMNUNfoyLEVNK2XxLflzxhcVWgT6jhBy2/ZJ
         xF8D49TGlNDIZGVKW42urV0GzjFKtOZksfQ8yZXgXq9hzHCWSuOZqNi9lPvIYBLgdU0/
         pY9qIbDWl5qpGKRKZrb5KqWSUlxnJrAPcf3j14+DnwQPkXvZbQ/7smhYQZuELJ+t/dO0
         PfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781102330; x=1781707130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xEmfQD66YljQgfpm6pWxKEM84AHfr3eAJ9XCpH6lBeM=;
        b=HkZK2VihzstNXbhCfEjB5i6yh8vvccjxG/azPn8kRiu/SMX8Yg57IQkid5wspY9Jom
         FUESNdzTsPFO3+tS36e0uJLXGqr2Z/dulkVmT9zP4zeGZ7vCsKHVLcqXUJo6QwFrdDvM
         oGsInwkKCAIz0T9B59XgJL0XhIKO6BjNTOjWMzGG5Yf4ZSZQNvM6nNW4MBIw+4qZqCMd
         dUHnACQDo3rKI030oRt4nGEHRVYsGtajbm8U4xMk0igFCmmPPOGH5BAPNjev3nlBszLO
         WzgDfwCb0ieF5HQLGBeoU50bxWKonqgCSKQmlM2M+jsTzYyqTKAVomwRqkCn7aG01fWf
         H13A==
X-Forwarded-Encrypted: i=1; AFNElJ+hplaEmsxVysuBi1l6OFp9p6ru0TlDnP6rQXRyZZnz//7cC3kENwxHL8hrOZYNk0LXf8w+ReyuPSpcpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIQaepSj/pw3+cA5mW3KyDnP7Bv8Op4+GwKq1dKr2aFhYGMDtQ
	f6Aa2hSX0Xc6GpwWGX97ySNlGDpKwvrf2ZzntujfPEWvyxDyUABkM5tNvN/flbvN6XEvN2Syn5j
	lVMvBHOaHNuppQyjxahIQhPb6DElqa/FCjPyAl5w=
X-Gm-Gg: Acq92OGfOOgOeuCrKFbNdo9BJMGsmSRUTScPFs7VXgNaoT9XjQsQVu0pExMuqduyIXa
	BI3A/hML1RfKDAmrHPJZiaiSB3/vyfn+GHNvi9zhKYvjDb1geTS6CPmjYquOigi+YhA5cuCYHnD
	+LeD+UFi9QQqMtAzGI0OmftIAgF9rHCfhfCb+y5+pZ1j/2c9Oql1PdpvZHUysAe5rTcpQbjP0fy
	u7FSb4IJy/SLKfUje4BViZLPNxVob11ScK8ANZ2GybX1ZOc/b0ccDziV7DGvAnlRL9bMxawrOu4
	GPUyJMxzHZNgdh0ackM=
X-Received: by 2002:a05:7300:cc0c:b0:304:e6f8:7cc9 with SMTP id
 5a478bee46e88-3077b1cc840mr15721596eec.20.1781102330361; Wed, 10 Jun 2026
 07:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com> <20260606045738.21050-8-clamor95@gmail.com>
 <aihl9yIqN3adKWLr@ashevche-desk.local>
In-Reply-To: <aihl9yIqN3adKWLr@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 10 Jun 2026 17:38:38 +0300
X-Gm-Features: AVVi8Cf09c5dRYmH0R9kJGLjsyEz3GTJujrRgluMHRMUhIaWopJLSUHlJiMgJFA
Message-ID: <CAPVz0n2+27QVeWNgPm3PH6V2Ceuym6sbMtUrh7hSHe9PcRmfMA@mail.gmail.com>
Subject: Re: [PATCH v4 07/14] mfd: lm3533: Switch sysfs_create_group() to device_add_group()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 22:14=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Jun 06, 2026 at 07:57:31AM +0300, Svyatoslav Ryhel wrote:
> > Switch from sysfs_create_group() to device_add_group() including device
> > managed where appropriate.
>
> This should use .dev_groups member of struct device_driver.
>

Specify pls, device_add_group literally uses dev_groups, I don't
understand what is wrong.

> ...
>
> > +     ret =3D devm_device_add_group(&bd->dev, &lm3533_bl_attribute_grou=
p);
>
> This will make Greg KH very grumpy. (For the record, original code as wel=
l
> but it already is in upstream. So, thanks for trying to address this, jus=
t
> needs a bit more of work.)
>

In the prev iteration YOU asked to me to adjust this. I have adjusted
and now you say that this is not appropriate. I will just drop this
commit altogether.

> > +     if (ret < 0)
> > +             return dev_err_probe(&pdev->dev, ret,
> > +                                  "failed to create sysfs attributes\n=
");
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
