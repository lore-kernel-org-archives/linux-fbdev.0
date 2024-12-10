Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983021AAA13;
	Tue, 10 Dec 2024 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840982; cv=none; b=XgjDGMj+rzI+UU4eOP7Zh8azhAlRM2H/qqoPqkFD02RIYnq7oMr4ts2utadj9lYIWeZ5t8eJZzZqf23mbhGrhF0b5gtrkN3GjzMrGR9FdsPYNuIX9djON3yQnAcyb4w2GrLWKOTHQg4TAXaGlj3VXM5u2nzpZldBuln8FF0hspI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840982; c=relaxed/simple;
	bh=S+uXpZiO2NDNHS6ig47wKdA1o4ntQnukhyin2Qy+l4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WV8t3zxYBPD22jA1WM2d9O2ZmwuHt4aTxsaeVeulAUt7/i6p0ZMzMF0TaiGMGKZNPM2e4++Aa/7GRPkzWiS91W+Qbsav5aMu9gEA/FeZEpDKKd+FRurpTRqwAn+gnovmxqg7RLju9Iu7bGDfE103FI1gVBJLbJPbcIArbTb57a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=pkl1LhYu; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="pkl1LhYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733840966; x=1734445766; i=deller@gmx.de;
	bh=IkRFleL1RhPz6osM3/97DFxqCKISORIBpc9mnMdaSuw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pkl1LhYufBoH2sMdZseanvXIgjcBvQGQ1H5lzCLgX5xqaCfbiFr3yoZMCSuO1Mxu
	 fYPGZGOwfl2rwYHe9nAXE4tch5VxVIgH9DxFk+MCp5fh6sTLOEmpXQTnwFckTW+Jw
	 uXTnOCUeetf/JzSocFyXak7CXU2xyLO7Uk3R4rX4rNf7wVvlfvUz1duSacpLdCsbp
	 r7VePK52mwySZQ9JAeTGCUrUI0hATULkt/IaGZR8ze38eSbJNRBs/eU9k84VxeAqX
	 IvQaX7MdApMXddYr55i3cCRbCZ/azyIhs8edSH1ogjInWGwD1Pq5izGpOR/wSRsDx
	 3kCXa814Di//xVufqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.155]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJZO-1trau817dG-00ebC6; Tue, 10
 Dec 2024 15:29:26 +0100
Message-ID: <b5136312-e18c-46cb-9a01-3efc61d6fd9a@gmx.de>
Date: Tue, 10 Dec 2024 15:29:24 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] fbdev: Fix recursive dependencies wrt
 BACKLIGHT_CLASS_DEVICE
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 arnd@arndb.de, simona@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
References: <20241210142329.660801-1-tzimmermann@suse.de>
 <20241210142329.660801-2-tzimmermann@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20241210142329.660801-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wPrIP1DELKObh5rF1FfYVzwnJRUZ0Oh2boaV0kCoQN153AOPId8
 0XuRXbhJk3JqwpcjlvYydynvqeXQbT974KIKyD6YubMHJa0tlR2aA7X7CNWWfEqKHarVjEL
 GLKHVoAu6lfP1abNjtaCz/u+frRzY0dlGfN70d5Js8DfojLE3ptL7bXe+sdnqJ/xVFFmDJB
 WNoE5E5XnW32HttBO//WA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8dyzI5IXaow=;i3ZR5VXDBhp1wL/CDiRtlO/ISMW
 hb4FP9K/wFmszPd12LorhK0HGAJv4TqpVD4TqSAHyJJPRW1XBobJ3bZ/m772W8toa6WZW/rHm
 iIulgq1N89aqxuVfewgzpKkdKHaOdyJDCqftgXbOgh1ZeYiLQFPewAN92e5iBi/obTe+C9d7h
 Os65syIQl8i7BMIDpE2bsupNf570L/uouTUQS6W8iMlIcj2dTHARMPfrAn6fTWt4Gox2EVQFH
 w4gfSlfR5nZRvV3waDDbv1oBOMfNtaoBGm8QT4bsSwOTSX34YKW+LWN2KDvtLr5hW3mOx/2h/
 VD6ofRyfXwJ+ovI9CD3HjybSix5RB6ELAdOYRilJakNeLzj1PBXsi8RrCqIPIzf9QR+fJ93jX
 EOpfk4VMWX6WZ9nchUaYAH+tlIkdel4BYXyn2uqHrWejsk40sFey209nzSTxiHKXF/8HQy5k6
 Jz4I5ejd4/FkcmM15L0sr4YBXtD+5BM+3V6qUDSwEeuMF5eRAMR8/826wMQkGpD21tIkpctLL
 qikhVbJZjGLX7WpdbvfG92MpenpHttUWmSCPCTZlFk7Iq0j7NCBh0Ofz8MLvC7cxXaga2x+yf
 AFmzIiZ4/RpXNL/Qc1Z074l8q5BGiCLAqT5xFU2VFJs2y0HSzFFr5QZHJidK2rI3UswQaoQkD
 PRmPDtg7uG5TWvktnq6bcrr/pW7Ygb9iEpf8dFb0blDN565RyEgbcN/oxPSBvJFU8SQGoUK8J
 RVVoBrT7I4rZWpw/KseU5zrN+SpkZqCCVhsYhDaU3Iyk9B3qhKFl9/5pPfR1mmvrUspuz7ksi
 2uyAFzkd0rrjY7ldBx/Xjv2CkOQjO2GEghGv/TxYlgzACkE0plPTXLX2exF25Iaurz9FJwgYP
 xWnolBu/n9MCOzemzBNMuF7PX/ThOkkRe81+OHkyBv+noyniOTqwSQZ7bOTayHpVUGeQAVL5o
 UmmlhXs/u+2CP0ZDDouZmCx1Ih05w7LAx7pOothO4N5KhlyVmRd1z7YctWIjGRiOPKZpCjWRB
 XbD5najU8v7KqVj/WXs27imBBZIEkn88JjGRTjRtW4VafDJ1eyESX7M6IP0fsz0N4VtdyYLVg
 CEhg9fOssbof/OZXydmJZRSxRNjFY5

On 12/10/24 15:09, Thomas Zimmermann wrote:
> diff --git a/drivers/staging/fbtft/Kconfig b/drivers/staging/fbtft/Kconfig
> index 77ab44362f16..577e91ff7bf6 100644
> --- a/drivers/staging/fbtft/Kconfig
> +++ b/drivers/staging/fbtft/Kconfig
> @@ -3,6 +3,7 @@ menuconfig FB_TFT
>   	tristate "Support for small TFT LCD display modules"
>   	depends on FB && SPI
>   	depends on FB_DEVICE
> +	depends on BACKLIGHT_DEVICE_CLASS

Typo. Should be BACKLIGHT_CLASS_DEVICE...

Helge
