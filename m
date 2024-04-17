Received: from e3i51.smtp2go.com (e3i51.smtp2go.com [158.120.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CCB147C68
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Apr 2024 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367881; cv=none; b=ITQRWaWavL9cyW2s6NkIctcGyiyUlJLiaEeUxlrT3Scu0ianQqSYpR5vjQ6Q1FBl+4hEcXKk2dKNcRAlvdebyqSK+XRnrlud/wxyQgX1Bsw7FGxgJxEL2zaZixdXUWTKD0umRPgk6hNqk+7W5qUK11JE3Z8cHFaQFaYJRdjW2d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367881; c=relaxed/simple;
	bh=dgCz2SWncqiO+Q6bWQmQ5trn7DREaGzNKuFcjXqMQKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tXFysn8Iv7rpBTp8V4zwMN+S3cx1RWwr4/3iDXa7NBnBrE1Md21goXiBaVHCYBIwa3ERtPgKkY8qFKIrzdWNxp1yGwM1vIie7fXVIu4Gbr72Jqkz09fQoSliBGR0zBxrXGdPznaJAuXThSukXvcWjHHvAjv/PkmXaKge6oE36Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=LeQsxAV4; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=SaZWuFhR; arc=none smtp.client-ip=158.120.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="LeQsxAV4";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="SaZWuFhR"
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1rx7Fg-Dv6PUh-0c;
	Wed, 17 Apr 2024 15:31:12 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
	 Wed, 17 Apr 2024 17:31:10 +0200
From: Flavio Suligoi <f.suligoi@asem.it>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v1 0/1] backlight: mp3309c: fix leds flickering in pwm mode
Date: Wed, 17 Apr 2024 17:31:04 +0200
Message-Id: <20240417153105.1794134-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Apr 2024 15:31:10.0467 (UTC) FILETIME=[4621B530:01DA90DC]
X-smtpcorp-track: 1rx7FgDv6elh0c.HztUDgdIOQXm6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1713367875; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=krcOgqXsGe7x+1M7PzgJWjOituJS8hooQQYOs5GAeeo=;
 b=LeQsxAV4FEJVXr0/X90DLNVSjjT9O+KK74/V2X7YihR6rcWUBQKuTuiCI35UidbhTEhUf
 ntp3VBWtabCByCvr01w2KTya+R7jxd2hzve+NWvbPMFL980ZlClqQoEYWEtL6My5KVRlqqs
 qXglu2n5Fhq8HEqVw/vBU8IFLHiETHi9EBPeuzpq8Kzrkwyn3gJcYL5MjIlLXBtebTZOdSc
 vpvuZpETlxV+u7ZZpI4kfFuYFYLe17F04mNmtDkiV2LdTqYTQi0sBW/FZw9d0RG48BDIRXj
 BHrO4fELPXgjIrUe3nXm9dY366xoRbPH3MMeiBt7ZRjo8QRDobrYOzrp2YrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713367875; h=from : subject : to
 : message-id : date; bh=krcOgqXsGe7x+1M7PzgJWjOituJS8hooQQYOs5GAeeo=;
 b=SaZWuFhRRDRQH7WyFm9OKqiEnaeAHC7T8yIk2sTX5X5rLjPFt2gwhcnNCmo/ug8bCj8/0
 rJVd1Ah1r5DqSqo2NG0GeFfiuKRijIFfAdBZKaXSKMIGb/oF1eY/TeZAi4IMRCKKrdtA+43
 WMmjI+Km5vHM8UbtJ2D1tGTbRATiPXJaSX34qNbCGFvWV8KaRfs0AtvL5NweKYO5u+kaGj0
 oDUQvozeMXF7TJn2nxDo7sFuD3VnCSFrVVEPfDXmxOVLJ5OK7XVn4ZHVlnu16yV7X2WLLP2
 ZeejHFetuezYk5vFfPh4Q97OTSD8S1CR3Dvf+bbsi3wI591unWzGqXbQBfAQ==

The mp3309 has two configuration registers, named according to their
address (0x00 and 0x01).
In the second register (0x01), the bit DIMS (Dimming Mode Select) must
be always 0 (zero), in both analog (via i2c commands) and pwm dimming
mode.

In the initial driver version, the DIMS bit was set in pwm mode and
reset in analog mode.
But if the DIMS bit is set in pwm dimming mode and other devices are
connected on the same i2c bus, every i2c commands on the bus generates a
flickering on the LEDs powered by the mp3309c.

This change concerns the chip initialization and does not impact any
existing device-tree configuration.

I created this device driver for one of our boards, where both dimming
modes (pwm and analog by i2c commands) can be used.
This board uses the same i2c bus for the mp3309c and for an at24cs32
eeprom.
During further tests, I realized that, when the mp3309c is used in pwm
mode, every read operation on the eeprom caused a backlight flickering.
This is why I made this device driver modification.

Flavio Suligoi (1):
  backlight: mp3309c: fix leds flickering in pwm mode

 drivers/video/backlight/mp3309c.c | 5 -----
 1 file changed, 5 deletions(-)

-- 
2.34.1

