Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793698363;
	b=ffpEnmCX7OOsPYfmBJXSJNIZ8AbIx1imXL4nWE9nunzbc+g2cGbfNM6bt6UfWsdpjIVP
	 3l7EvGGPA7RnLo4nZmjqFf84+BqmK03F323h0HTyIKFYzZ6KStgaXRvKLfvmFmN10juw1
	 u39g/hSubGy1kd+TsgLHRGU0ANSNRDZSd+QiHQMWkgZK2aqTUcQFjJ3vhgK7FVuffBUA7
	 U1m5kjIDDFlKh2NoZ124JyojBaqU3WVl/WGgdbX7uK7BSHXO87IKmWz1LtHLV2uwwMJ1/
	 m9zWJUL1YJESy/kFGrmrdPdgF8ysf2yfYgyWdrDS9A2+MrRGh+4lQelWXZpSLRIkUiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EyZKRdruJnIAj0M6vq8KCInmZjQrUNKMEcYKRcp5WjQ=;
	b=cZ5dJ7vPLgHpC0Q9hd70cOf69b1j34IbwIxBSqZUKVOf0+mFSj6VahQVYqtlw1bsxY9H
	 ODgY69H6MyBQjPbU5FO2rci/0sEJ4t2IBnZvJdg65u9VmO83J1dZ++Jo6mtutby+EXoW5
	 XLCBKMX5i65hS+fbZKVNfcsQBFATkgtmBeIkDRQ5D0nTkgagkI4uBnUWeoy/UWgqoVlMI
	 wQNNYlBBNwoqn5+Bu1nDtnfVnhLzus5UJlwBLDfpe7qYq5xVi2pDCI3Vq138GjoWDfBtn
	 KsV3mTNnVbiwURHgottS5l/BtS/hDyU65OV9ViEUrLYjBU4UOc+qz6FsMMJtdrekeDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qsYpiUGG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D582606A324
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Nov 2026 09:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D582606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qsYpiUGG
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4c9abc1824so603723966b.1
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Nov 2026 01:32:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793698361; cv=none;
        d=google.com; s=arc-20260327;
        b=s5jBx45u56fSNm7ZODoZ3mpI9Z5NtXPfmDPwILFBpN/1PjNpxZL/Ax9n8UVLGB3c8d
         IRDLh3kA4NU/UDLhKoe5+jmwllh779t3vrigLrcqU0gXwU73wYSsuQ3BHnyyU+cTwtXN
         xMnzjD9Ck4T7CMGKHsadp3sbOeyM4aBz+r1bao88oQkR3fdVmlnW+cO+mdZqoO4hi9xb
         8KX1yW9iI0TGrQ2ll3lLQ8FnxqK7lsCcZOwSBXoAlMPh2O/BLaMlv9+sgdw5KqinXqW/
         YeqJfXLnnO6upWggvUj4mfVO81FdmfTuOLxG9yeb4nMR1T8y7a/1JkkaqiFx79YukDJy
         wLjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EyZKRdruJnIAj0M6vq8KCInmZjQrUNKMEcYKRcp5WjQ=;
        fh=oRyOSSZC3K3e94rA3t2c3eY+RtFcxAMCz29J+s6ZwMI=;
        b=Y9mCtVt28nGeDd0tW0z4h9P9pCD8QbeHrFMQrGzgUWySNI+qubMYa2C5gCdE1OzNQV
         LaOgDUM6BHoklj94rEakWcSzjXuOuspFaoLSROUK5VRTsJ6af025tBKob9LuPovafnKg
         6h2hqK8UfjGf+AqAt2U2UOUi8Mef6MDboNTBHRNg0MzHRZrogbUri0Jfd5dwIwu4Fhuc
         vETtzFuJb16UWc1v+hUpqfVAG/E/dphQupOuv1dcyO7rB7BOE/TTIJQSYAaKggvuI3au
         sJDlRie2+zasFv7fQnMSn/qgh/376kZJJ+YthZ7j5COBQaM7ZkRfcQ9NBP+7ZUeQ842I
         O5Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793698361; x=1794303161; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EyZKRdruJnIAj0M6vq8KCInmZjQrUNKMEcYKRcp5WjQ=;
        b=qsYpiUGG7sAYQAMVPIwk/BTChPa2IzLmTOB+8Vc1AmXWsJfqQXGg1oXZlD1rNH/ypN
         4Hz9uuhKvGZbWqm2TAvP0v6+Yv+/8GkU6dlGQLouBQ+Gi7KmT86cqYEHCLZDLMR1b1qa
         6IjjPMtJELYwp5w9v/NVleUxEGHBk1PeKk6em3yh/vi8XVPPLt1kaJaT/1vDgKjAZb1A
         oMXM2TS2rjdTRhKIonzIlzZm+B1EFmRZEAQkNMztWeAf0N/0voJ4/M+NsvKTxTlhUFWm
         mF1RK+AqSK3SylbtVtPRNnaFFXcv28tPXV/DIZ8KELRx7i7N4IaET5KtwNychwkRrWOL
         48HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793698361; x=1794303161;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EyZKRdruJnIAj0M6vq8KCInmZjQrUNKMEcYKRcp5WjQ=;
        b=rwQthUHJP/sYByunZR93/GuBQoK3VoDW+EC94THheY20qCXtmvqiI3nk459+YD4WDd
         MnVmW49QColc/GELS7lZIC8o6amcJvznQwSZrA5oT/sv8+59zyhSTXN95vbunKxkRQUC
         Emi7Lk9YOe3PPnLyXy1RIhlVWMrAnFwewrrbb/eVB36rEqDBxSrZhp3rbhvBAsWdo3G8
         mpQ1vaVo0rzQxjjpej2OWoY8MGyY6821xC66V0aMfBbPNV6xAx1SA/eEDSq37PEc4sm5
         cO/VOtaZNyni5qnmgbx6m8A7MTBlehrAwTiWoxV4VpmmU4AOxu0ScLWmQj7iUBuDX7UJ
         tkQw==
X-Forwarded-Encrypted: i=1; AKwUvBwLsQzE+wjxvtP5uOqxmm/CSI1mD2wvioG95xXR1C4ilXq0rdLqHBYnP8NENpN+lsHRxSax5w8aCQeRKw==@vger.kernel.org
X-Gm-Message-State: APuU4Z915vKGgKOOtsboIq56SMunb4kr3B8BTzreEIIoK0ZtM4hHYNc9
	fXtqNWeyLDEHsqjTM0wBhiYcLblJcn7YIcwSgSLgPiXpSteOkZCjcUNSiRUfWLouV2y7i5NP8CR
	aDhjviHhEZqITdEHMPLtXB3iG63Cpvtk=
X-Gm-Gg: AYBFou2aG/tUi84vOQQiQsEScMGWDb9LZmhw340fQ43WxjsMfiC/g6VnZF3DN34dHi3
	Pci5zjj/3l/O1igdLUqPZm/ytumXeMvZprtQDaP3hc2PZZRoVFgfvJ1ZXL7xNc5Mz/3wwd4czfH
	vIeX99VisS9zs++dgkboVNE9bXY4MQOjqlCjvRZSvkLe+7MLGWckxsF46ico3/iqUHtms6EKUTD
	D6gJWBtPV2rwuDu3j3sQ5KPpMAJOexjetDYLqVUVcfyI66AvEwFA+xataYI7ChR2P2l5N6zJyOH
	V2QnurF/0YLgs9DKvlpsSNycsX8nUqLFc7dH04je/HnQjeV8q++EhbZfZU38rnDuhdkf7j05+HB
	dG44HqTV/CEGP+/Rx+U1gVEYdjznjiWhpmWw8MCO7swTKDEEa3SYrGOcnWb4gVfwP7cz8e0eLn0
	hZEeB2YonoqnsWe4lI8Zc5d5oktlOV7o9LQjC/ug0OEzoBlgcVdiD4RyCoKKzPZBQfQPHdj1ltD
	cU5qF/OL/L/I2fRt+ssae/0jw==
X-Received: by 2002:a17:907:6eaa:b0:c40:bbd2:62f6 with SMTP id
 a640c23a62f3a-c4ca7a730acmr1005018566b.19.1793698360533; Tue, 03 Nov 2026
 01:32:40 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101184915.33899-1-amittibi123@gmail.com>
In-Reply-To: <20261101184915.33899-1-amittibi123@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 3 Nov 2026 11:32:02 +0200
X-Gm-Features: AclHuK-RtmLK_Q39u8fbW3hnbONKklVvIvh3AUZDr2AgWSlxsUma7DTEWb_oDSM
Message-ID: <CAHp75VcnkufMDT-NV75jzR6qKH48KbPnUgFHUNrHMATZ9NQrMw@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: remove unused ssbuf member
To: amit <amittibi123@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 8:49=E2=80=AFPM amit <amittibi123@gmail.com> wrote:
>
> The ssbuf member is documented as unused and has no
> users in the FBTFT driver. Remove the unused member
> and its kerneldoc entry.

> Assisted-by: LLM

Drop this tag (it's outdated now), instead use comment block, after
'---' line to describe how you used AI.

> Signed-off-by: amit <amittibi123@gmail.com>
> ---

...

The problem is that Greg KH won't accept AI work against drivers/staging/.

--=20
With Best Regards,
Andy Shevchenko
