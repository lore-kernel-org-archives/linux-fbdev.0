Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A8D156C69
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Jun 2025 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749763268; cv=none; b=LREFHKmR1OU+9nNTRfbDtj/67EZ+o1MuZcZHcuW/HmsT2PXzpw+xzwy3yC6ZGADAFln7Eomnn4owgID2O93qJitCFTfykM4OZRDFHtJYxfjUG8FFuOK3rcMEhxz4BKzDNb0indL4CIeEHUc4yO2dPQ/ikgUqC/kswcbGBCb6+nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749763268; c=relaxed/simple;
	bh=lk1H4xmnkQdgAKm8tH8eYKPNdgwJLA6aUJxNF0kakRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEg9WD7s0LhDIbWpYvdkKzrLo9kHIAf+jm6RcT1xP5JD+sDPb900qdgWOXbPnXQNeQn8omfTwC9X1lHHn8KNkTjpVjnfz3XXvAPoAyLm8yLGmj9W4qDqh3erxhZRte6z5ae77h/qrBhqeUuPd/FdNROKFHv4n17Y6HMZLvEeTJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=KPgtuc+P; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="KPgtuc+P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1749763263; x=1750368063; i=deller@gmx.de;
	bh=dkR21A2P/IJD89ehmKdEGZf8yF7alXTFi+OecnYILyU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KPgtuc+PCybDTs7y4A2Wf50CxXRvLwHwtygWMa4Tv+2bdLMDDry7AuiAST+klcGL
	 y5zRe1cwaf+wi9hIAyoKqCNsGuFMTfLPXMiA0SSYGs9aDCjXtmqkq4JeLgEPVu8JT
	 S2/V3/Zvq/eWA3K8mEm9MLp0H1M13cP6nta42M/nBEmGIKZPoH3pM3AtYAUvCGdJn
	 xc58F8FIheN+Oa9rAhBbXCN07mr3fJOl8f4HPahNtlo0qrhYlthtmjZrefOH7gkFf
	 RwF8yu4O8RcFFcrHkTXCfbzzGnemf4XppsKSpTf+H2DyIyyarY1ZmZOSTvlM+tZ8w
	 xLSPiCCKh0KhKyI7TQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.171]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mz9Ux-1ul5cz41Sd-016fjZ; Thu, 12
 Jun 2025 23:21:03 +0200
Message-ID: <91f80e4c-d797-40ef-aa0b-c03fb5ff0c11@gmx.de>
Date: Thu, 12 Jun 2025 23:21:02 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] fbdev/omap2: Include <linux/export.h>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20250612081738.197826-1-tzimmermann@suse.de>
 <20250612081738.197826-9-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250612081738.197826-9-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8SdB/CSBb6Fq5jRYcDND0i69qpEW5QPMQjmc8anJbdhelfzQw8b
 Mhdlu0pR+oGUwJyn7fISOJBL9H4Vqc9EQNwBO7tQPrIVxuB/oxtar7Kdh+QIlVSnhw3oETd
 1RI+6+OfLldzcrGbHaO9+NrDGjDR+Ez+2uFxLcQztaDKhEU0W/5f+dDDhiJt+HCIFp69LPv
 9IbygWrjncbeZo6I3752Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ETRDOM4IxDg=;SzJjNclvjQtMmnMspf/dgtnITHA
 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

On 6/12/25 10:16, Thomas Zimmermann wrote:
> Fix the compile-time warnings
>=20
>    drivers/video/fbdev/omap2/omapfb/dss/apply.c: warning: EXPORT_SYMBOL(=
) is used, but #include <linux/export.h> is missing
>    drivers/video/fbdev/omap2/omapfb/dss/core.c: warning: EXPORT_SYMBOL()=
 is used, but #include <linux/export.h> is missing
>    drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c: warning: EXPORT_=
SYMBOL() is used, but #include <linux/export.h> is missing
>    drivers/video/fbdev/omap2/omapfb/dss/display.c: warning: EXPORT_SYMBO=
L() is used, but #include <linux/export.h> is missing
>    drivers/video/fbdev/omap2/omapfb/dss/dss-of.c: warning: EXPORT_SYMBOL=
() is used, but #include <linux/export.h> is missing
>    drivers/video/fbdev/omap2/omapfb/dss/dss_features.c: warning: EXPORT_=
SYMBOL() is used, but #include <linux/export.h> is missing
>    drivers/video/fbdev/omap2/omapfb/dss/manager.c: warning: EXPORT_SYMBO=
L() is used, but #include <linux/export.h> is missing
>    drivers/video/fbdev/omap2/omapfb/dss/output.c: warning: EXPORT_SYMBOL=
() is used, but #include <linux/export.h> is missing
>    drivers/video/fbdev/omap2/omapfb/dss/overlay.c: warning: EXPORT_SYMBO=
L() is used, but #include <linux/export.h> is missing
>    drivers/video/fbdev/omap2/omapfb/dss/venc.c: warning: EXPORT_SYMBOL()=
 is used, but #include <linux/export.h> is missing
>    drivers/video/fbdev/omap2/omapfb/vrfb.c: warning: EXPORT_SYMBOL() is =
used, but #include <linux/export.h> is missing
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/video/fbdev/omap2/omapfb/dss/apply.c        | 1 +
>   drivers/video/fbdev/omap2/omapfb/dss/core.c         | 1 +
>   drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c | 1 +
>   drivers/video/fbdev/omap2/omapfb/dss/display.c      | 1 +
>   drivers/video/fbdev/omap2/omapfb/dss/dss-of.c       | 1 +
>   drivers/video/fbdev/omap2/omapfb/dss/dss_features.c | 1 +
>   drivers/video/fbdev/omap2/omapfb/dss/manager.c      | 1 +
>   drivers/video/fbdev/omap2/omapfb/dss/output.c       | 1 +
>   drivers/video/fbdev/omap2/omapfb/dss/overlay.c      | 1 +
>   drivers/video/fbdev/omap2/omapfb/dss/venc.c         | 1 +
>   drivers/video/fbdev/omap2/omapfb/vrfb.c             | 1 +
>   11 files changed, 11 insertions(+)

Reviewed-by: Helge Deller <deller@gmx.de>

