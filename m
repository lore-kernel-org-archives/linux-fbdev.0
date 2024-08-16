Received: from mail.hotelshavens.com (mail.hotelshavens.com [217.156.64.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D771B9B46
	for <linux-fbdev@vger.kernel.org>; Fri, 16 Aug 2024 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.156.64.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723814470; cv=none; b=No/SfWR6PFn7kZqWXheLHr4xl5yUd43sXV56Sq5uAXS0bzlyt9I5EODYytYZrBOO3+HspqtQi3/dUNtnqI+PNKrHIZr2WhkHFP/fr9uGDPuJudhNb/xUrgjFI0lsDcroXxOE/gHt5/tqf9wZrVmD0ix26O/xV7DjtOdUHPBrwZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723814470; c=relaxed/simple;
	bh=xosHSxIvNyVoVU9etbtSkcwA5m2W62k5cFb0LRlWoVk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cR90MQtZpTIoB9oTmJeOT8gOtVMIg9C2PPgWM65FZrjamv12PJU70va66ylQ8J1EqEUR+39pJTxU+Jf6ptnDeQhvz9vMLKJmW7httcJ15VaxRPEvr64IwPfuRvAVTLsTHzg+cvEXGhq/yR4vdFDZtjh9KIyljGedBrkg4rmZQfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotelshavens.com; spf=pass smtp.mailfrom=hotelshavens.com; dkim=pass (4096-bit key) header.d=hotelshavens.com header.i=admin@hotelshavens.com header.b=M4jwbu4R; arc=none smtp.client-ip=217.156.64.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotelshavens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotelshavens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=hotelshavens.com header.i=admin@hotelshavens.com header.b="M4jwbu4R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=dkim; d=hotelshavens.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=admin@hotelshavens.com;
 bh=xosHSxIvNyVoVU9etbtSkcwA5m2W62k5cFb0LRlWoVk=;
 b=M4jwbu4RBUhSaJb68kqDwJisCz6Parh0+lDe+QKzKNN/eoT75RTWOpUD1Kt8HE+Gy827zWQd+92q
   uGbQBvUtKQm6hZpnKl/PDbGljXbBzcWphJALFQd1PMUigAq9tGh4wtA1svu4QcMPc4Ft2xD1tal2
   Xo8WjGLHkDUuQF9/gsOAFe88i9y5SrFhoRGC8iipz3SNzu1OGh/RDVsSMCivFiHWfjhw+fkqFadG
   6BrRpJdHP+RmNugsZVVykZNYjt/kzQDFsUYAReY/s/SKGfwD3OyMAxpLSAWjF2cJbSLSXCKCs8mo
   rWErp2L3mnvFTkv/aBEUbbCxyMcizfSuFAjdAXuzSUKKdPOssYBzU7WVpBt0grs2QiiDgZ740Rce
   4OPLq8BfSuOkVXD+Gz6BvK6moJzmM+VEUFasqEVqJ5mQyAdqr/ll0KDpCvJib2FNfQHZIDF6BKOK
   vU56KVglZbCTL9zvQ4LntySZUY4oSaW8J8a4G2ryJsJ6bSGnKdA0G0Il0TLBFbL2/IRlyGUDrPj4
   jEA2RKH0jHE86ew1DhAOUP6Rt0NZu2FrK0yQCbmtY/W+CGVHgnTatDoc3Z4MXBsr+6ZUZcESYZ3G
   ZAhpOXF6oPO7zlN1w0GHQzYgRVB8dLgMcWy+5upkYZEbrO8HBhXXa1/xr6sVLuK7WLM7jKmLNpU=
Reply-To: boris@undpkh.com
From: Boris Soroka <admin@hotelshavens.com>
To: linux-fbdev@vger.kernel.org
Subject: HI DEAR !
Date: 16 Aug 2024 15:15:45 +0200
Message-ID: <20240816134828.ECC26ACAE46171FC@hotelshavens.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Greetings,

Did you receive my last email message I sent to this Email=20
address: ( linux-fbdev@vger.kernel.org ) concerning relocating my=20
investment to your country due to the on going war in my country=20
Russia.

Best Regards,
Mr.Boris Soroka.
