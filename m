Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F7E4C97;
	Tue, 30 Dec 2025 23:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767136960; cv=none; b=ZoYi6vtb8DmrFPcOXsuu+3Hg311Bm8PRxDsHIONIu9kvynbFvkbExPlNf+aaj59XQ2Br7XKiIN3o9ipklIQw2iyXd5yXugNN/1phkYDUedEvi3Xg6aE6CP8/OB4SCoScqQw92yprLq6PYjWt4xdzlfGVTe5j3hi4urn29vY+OZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767136960; c=relaxed/simple;
	bh=r2cz9tw4jBKd82ar26gz02zPgXIBNjbzzIJP69Pfj0g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iehFrNl0A+tSYn/iBTgYIwJmaenutJ/dIQlqDE94OyMMNyx7wA/FiuB7lsMTEZ+rGgpTcYAi1+cPaqwr3CUUq1X40c8TCBUSbTo3dqzxYtkOeBkzN63v6STOQjC39fEfkstFo3T8hBpSvMBvtlikU8RFWcz9eK5NvknN14atd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=TCzUVSDa; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="TCzUVSDa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=rkYEIdat85qyx72JG9RDCYxdwTBwQbQUb/q775rwPoQ=; t=1767136958;
	x=1767741758; b=TCzUVSDa6/2E4Cr97E4gKkLN1Z6xAm9PEJ72J/PGTom1Gn5Oi9HSIXNaJH0FS
	R2hXUOtAJ3QZ/2967VWH1w73mkVn6MXlULCURMvjEIiOGejAgRyOUO9Fz/bk/0RIfqU8qaf3zyEwo
	sNr6kq/VamZRIt8SuIDMoXb9/wgVGVKc5kS14+26bK0KEV5mEE2AlHikDWmc5Xg2Ih5/mZwA9gTuX
	gSMi5n570lHZjXEVtmMu1BCZcDR3c0wS3YRknRalM9Sn0FS6d501AgTYtHuHGxsjRG10regwwb5go
	/JmjrIA14C+9HyMcWSrKl1cg7/sVSFDlIkaf7xaKlDYX8VS/Qg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vaize-00000002bJi-0GXQ; Wed, 31 Dec 2025 00:19:10 +0100
Received: from dynamic-093-128-019-094.93.128.pool.telefonica.de ([93.128.19.94] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vaizd-00000002yoB-3X8A; Wed, 31 Dec 2025 00:19:09 +0100
Message-ID: <12a2ee5ca1a085fe0bd0c1b2d6e08589445cbf66.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/6] video/logo: allow custom boot logo and simplify
 logic
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Vincent Mailhol <mailhol@kernel.org>, Helge Deller <deller@gmx.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker	 <dalias@libc.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Date: Wed, 31 Dec 2025 00:19:08 +0100
In-Reply-To: <20251230-custom-logo-v1-0-4736374569ee@kernel.org>
References: <20251230-custom-logo-v1-0-4736374569ee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Vincent,

On Tue, 2025-12-30 at 23:19 +0100, Vincent Mailhol wrote:
> This series allows the user to replace the default kernel boot logo by
> a custom one directly in the kernel configuration. This makes it
> easier to customise the boot logo without the need to modify the
> sources and allows such customisation to remain persistent after
> applying the configuration to another version of the kernel.

Wouldn't it make more sense to make the boot logo to be configurable
at runtime so that users don't have to rebuild their kernel at all
to change their boot logo?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
