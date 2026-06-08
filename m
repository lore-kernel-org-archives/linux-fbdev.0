Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569083B961F
	for <linux-fbdev@vger.kernel.org>; Mon,  8 Jun 2026 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912547; cv=none; b=gF1jRKAA5HVJY2ljL0RuB+++qecX23mitsCbIjmBnGJXwYxocez7/X8AHnwcepC8hL3NsesawiK6JLTtiurHDTDixxmKYaGF0R350koss/GzpVRR8dRxWgFxrB7GmZtEwWsmZOU57tyCOteDfk5BpmMLLsvmIn40Qrruipcn9A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912547; c=relaxed/simple;
	bh=lG+l0nz/ofB6PBeznJSwBYG0oHFN3QzTOtQ++iVjL58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k8UWae4IOFQ7u+JW53KapRv9ZJcXMVSeHt9r0Pt0toj08+7EnC/2g7HOHFUZ5tBRg7HX958Wlqa8n7XiXhmm86Ny6fFAo9kqoDCBgcpTznn+8HZc4aXFe9TAef1ioFjcF+h8Bv+kPjuEvlp9tgq6+W5o87AODrHr08kfoxTdsIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=ss2jFuUo; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="ss2jFuUo"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhn-00BRwV-76; Mon, 08 Jun 2026 11:55:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=xVqIb0lvImaOng2149ntOf4c24J0oVttsRUjwn998OA=; b=ss2jFu
	UoSPCSfsvNjOtKrKuBsaSmNNXpZzPLZ1OPg3SSZn90OQzIZHR1k6Ho5AYn895gXTd37Wvao53SUTT
	1eSo+QKS8hk1QzJs6ZfLPrudDBjavGd8aiRLyYOe23MtifvfbiV0IMXimPno8HsfSIq93c9Y4+bJ/
	lnjaudWvPqENSfYuMShPZxJ6WdW5xV4bbhIuDq0StU0O8bLnEDlT6DYyjRJNoF9NhnMVUA6UDKApe
	ym6cQige3cy9e1tMqlUO3aYRv29xx2YG7iPCqaOrE0CuxuLpsZb/HCcYp8Nfid18FDMthzqRliaR2
	QBdKueAJOD4HfFOZvuRePAzxWDJA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhm-0000Cn-HZ; Mon, 08 Jun 2026 11:55:38 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhd-00Ag6G-RJ;
	Mon, 08 Jun 2026 11:55:29 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Helge Deller <deller@gmx.de>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/video/fbdev/s3fb: Use strscpy() to copy strings into arrays
Date: Mon,  8 Jun 2026 10:54:55 +0100
Message-Id: <20260608095523.2606-11-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Replacing strcpy() with strscpy() ensures that overflow of the target
buffer cannot happen.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/video/fbdev/s3fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
index ba30e5568cab..b679ccdb38e2 100644
--- a/drivers/video/fbdev/s3fb.c
+++ b/drivers/video/fbdev/s3fb.c
@@ -1333,7 +1333,7 @@ static int s3_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	vga_wcrt(par->state.vgabase, 0x38, cr38);
 	vga_wcrt(par->state.vgabase, 0x39, cr39);
 
-	strcpy(info->fix.id, s3_names [par->chip]);
+	strscpy(info->fix.id, s3_names[par->chip]);
 	info->fix.mmio_start = 0;
 	info->fix.mmio_len = 0;
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
-- 
2.39.5

