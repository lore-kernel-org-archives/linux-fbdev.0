Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443339;
	b=HH/IxBaBzELlEFJbME8EchiHxxGjEjUXA3AFGeQOEyKllJGMCO4dUbMrtWTTtO5xnbiU
	 aXJk5dASQIlUO9xgkoV4zN0jtM9fBAKwaWLQIZ8DVVDSNdzaYnvuzyEBy2eAv1IgOCn/I
	 5TyD/+vgn5PE3paTLFbginyKy2rMobh1FGBDkFkg5Af1xoI/OqfjU2wzSTkNnJn+SlhlY
	 3OTDYX2UuRznYKC+YB3mFK0ExYg8lQQQPERcpttc+BKRThfR0vE4/TWpZWn7GB2R9n2IH
	 +XHqSIZuPoWv6acUspv/13PBEiZhbPuveLE7JHnqVbn7zpPtHzOzjdPQLdSCqU3atgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=NrSzbFzhb/48pQwefucbagWYjcsLjKvWanQjAidltxQ=;
	b=rgFvWJD+AhMNkDeoiH8KQ3p6YMZde/TD7AGIXNCS9ZJC38HuS1kV0iXpqDdaxfcaMf8c
	 +hBSRPbQnuJtlyNhHgU+BbVhcdeB/NeSGmHfOgUtVLtT/VEjYW1oKgbWhEhYRJoglWFR8
	 8/1xG4oRkB0TlUUYZP+r8NT9IO04Pmx0GxIscI8SSU0YYBeRF/iVdBGpeBABfIxuKbLNA
	 b9Zu4xU3c74qYU0fRrKIpvL8q4S5teR/duwUd64KBNTjmoPJKWUPpYC0J73kvfxIhSJIe
	 HmMMWBnP8Ejod0zekILnUyKOOU46gEHvifbyE91bCaiy2YW0hAKPxvFcyAyPm7unFfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PAFYordc;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B160606A327
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Nov 2026 00:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B160606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PAFYordc
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b32b2e691aso4008977b3.0
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Nov 2026 16:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794443338; x=1795048138; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NrSzbFzhb/48pQwefucbagWYjcsLjKvWanQjAidltxQ=;
        b=PAFYordcAlFwxsujOd7fSn/4PQJ6fa3zPVS6mw55aYy5QF43dixpt3/3X0PUtkRqzq
         Un0sHWSZJcdTv2azHZrdTifJBVehAMUfZTakao+ijmw9SiJ4wy4CF+IXYI/JBLEBGQzZ
         PGDmzt8yGq+e3VAqiMx3dgyeWoGZRnUyCyWJmu0RPIvQEMkt0KVjs8V4AtRcd3aFbrqo
         HnqvhDjnevub0HGIGBNQ6wq2w9w/4T1ny09gndrXUK/+NyFrJh+ofxlhZyh9xMY7FWNg
         ffnW5N2qqx6jsey4o9v1NtDC0B030Obxowvm99m3FQbkALcAJS5yePSk21EEhikrmkPz
         AiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794443338; x=1795048138;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NrSzbFzhb/48pQwefucbagWYjcsLjKvWanQjAidltxQ=;
        b=PF3loZ0c2QZuqJWSbuD8aQbjyzMkgf3o/YNEJgY+rRItiYz+aXRs9uvge0wpshj3Xj
         iNuAHxY9GZmDAJ/vtr77KmsCi4pBEmtGDRxnNysRxtASIQ1CCSuNqp+PAF0mxyTPhVW8
         CoK6tPX2GMxcCae8FgrxnIgW/ibBcW60klPJJdDGh2RI4n8ZG572d5jtU/F3ix2U5Bpw
         Nwo93stvYJMjqLXTgdUx45KZOrQUciWJHuGamvwegt0pNqhUPcGpdZ8J2T1IlFG2ZS9r
         6n9u3Lx6IBQrfD6Y251BofmWpC55YxcNDyZOPtqeiNJ/3CVYT87rMy5apYRKW9VL1zbC
         tglw==
X-Gm-Message-State: APuU4Z/5OHzjcz7YcMPgVEFS/o+oTeQ3k/JKy1tR+dk6wWLUaG9bl2ma
	BESxBzDImTOk3V0jCR7gHCuYlOvc++nNyDNxs7i62B7N9RbbRA5Tf2DO
X-Gm-Gg: AYBFou1KzyOhOD1gel/QgBtBYt6p2iSYkx+zgwO08NjUpPbqf/vsR/wORHs+HwWqu0S
	TyaO2PPN0EN9ku5Fpg5FVaXD5rcJboaD13g5nFXNZZ2RMyZPnrAl4QZsQhB9WFOSLoRbUjbrMJU
	dgmZLgT7QB4n+IRWHj0C2+4PM9LzNOMr8IkA9eYeZfYNIdgaFsXsEW3RAqr5wAaeRTRCi28Vf3e
	NV7bdVM+IZOUfp/ayl98ti5pDs+/U8mf/NnWi0eCFYv1E+wXUCApy5mjFlxpz6BzKUCjpJrZmCy
	/EyjhWkGeG8O2UNik6CI+12N7GGD1u+nXtfVPbmPxll4eJqtBADxd9Qf3gaigjCaz46YDw6wagi
	L/UYwlN3fVm3BUEMpLhVhiGdFrUZ3W96A1FFJXtSAyEsOdrYX/etmjbBz3yysah+/hYAxwWGNWh
	aQujvBT/EN45Fs4VSa+ncz76LpoPXxxOEh8nnPHCyc8BEYpz6PqdCXyKsgiohKw4BHPcV+G///9
	Wb7EvYc4y38PiAABnB0uDy8W5yjKn1cDV/LBZOd0vCIwwyee0XMxOWuzNtbMKMlN15kSDr0v0OH
	j5dWhzG1gYvmOjiG13gHqHj8a+qFfVj6f0otH7coDNvj+nfiq1GTXQ9TedrCW4+lfpOHgIal1Qs
	pjJ9gxTyFjEojDxosIA2zp8Rsby0DnVqCGsEBKotI+v2sJ9aIQnkMpwXaUYaeQw==
X-Received: by 2002:a05:690c:c0c3:b0:8b0:6722:6734 with SMTP id 00721157ae682-8b3bb155926mr6839747b3.34.1794443338082;
        Wed, 11 Nov 2026 16:28:58 -0800 (PST)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net. [107.220.129.194])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b3933a6554sm57571227b3.12.2026.11.11.16.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:28:56 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 11 Nov 2026 19:28:56 -0500
Subject: [PATCH] vgacon: Fall back to the dummy console if mapping VGA
 memory fails
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-vgacon-ioremap-null-v1-1-6dd05bf390ef@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrE2iIoiriEW1gxFaaRFJ4+6Kt
 /sW7w/gyTF5aJIAjk72bE2ESBNQkzQjIetoyLO8FHF4jlJZg2wdrXJDcywLSl2oStRFX2cVxOf
 maODrq7bdb3/0M6n9TcF9P4NsHx93AAAA
X-Change-ID: 20261111-vgacon-ioremap-null-ad4c7184b807
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
 stable@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=br3GFCtz3RXFRK3DsA4LkWP9fcwbxa8J0zn4MRkuUF4=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLK+criL7v37qOiykO8rawfHuuk+WyP0ikzsHuj9nsVwQ
 sin7fCvjo8sDGJcDDPFFFni1iuyzGrbsdTntPQvmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 EMjQMYqHyOkxaGQWF5emFummFRQ55OWXJJZk5ucV6+UXpOYVpBfopWWmlWRk5BcVpwKN0MtLLTF
 1dXQzMjQwsXS0MHOycDQ1cXZ2MnRyc3R0dnUysjQ3MXC2dDRxtTRn4OIUgLnmUTAjQ9v1oF3ZfR
 8OxC4xawm0WOOg2hj571rb9g/LopWvnRE9dpPhnybXhpaPzH/zz0vn7L19vfNZ3UWnSt4l31dM5
 BKapXb7CDMA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

On Alpha, setup_arch() registers vgacon whenever CONFIG_VGA_CONSOLE is
enabled. On Marvel (EV7) systems whose SRM console is serial, no VGA
hose is set, so marvel_ioremap() finds no hose for 0xb8000 and returns
NULL. vgacon_startup() then probes video memory through that NULL
pointer and oopses in console_init():

  Unable to handle kernel paging request at virtual address 0000000000000000
  pc is at vgacon_startup+0x174/0x910

VGA_MAP_MEM() is ioremap() on Alpha and powerpc and can fail. Treat
failure like a failed probe and fall back to the dummy console. If a
VGA card is present, locate_and_init_vga() still switches to vgacon
once PCI is up.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 drivers/video/console/vgacon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index e7e6750f1f87..09f7c376b468 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -324,6 +324,8 @@ static const char *vgacon_startup(void)
 	}
 
 	vga_vram_base = VGA_MAP_MEM(vga_vram_base, vga_vram_size);
+	if (!vga_vram_base)
+		goto no_vga;
 	vga_vram_end = vga_vram_base + vga_vram_size;
 
 	/*

---
base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
change-id: 20261111-vgacon-ioremap-null-ad4c7184b807

Best regards,
--  
Matt Turner <mattst88@gmail.com>

