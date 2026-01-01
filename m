Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8220C2DE6EF;
	Thu,  1 Jan 2026 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767281155; cv=none; b=rK9k4P1nokqjnB0Cm+Pi/++QcmgdvXj21ABdbqz0GOmWJp0xSiSvdA+Z8Xs4Nbur3XNZza8lB9sfuTly4zYU6UGHIQYYlSAOCGRtXGLGDvcrvRYfgntrLF8/CrDt8dYQhT5wgeBRxvax3DLtRinvn4h6tIRgIpyIpZhd6YSwJpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767281155; c=relaxed/simple;
	bh=fijsGqE9CnSJQ1VoVakwrwO9lmzv42xMh3DZyoM14fI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BfOWtgOqWWVHUGNi7JtnFEbvPogaGgkkWRo0swNwEQlZIXB6e/ck1nhoqAgJKswJ7iPrTR/HmEw9BETeK8itrzs0VEMMFSbhZMUcdS9FWFIRMRs+IxJ/+15BI826rafemyIod+yF7O+5zQ2AuW2Lv4D0/2j7Uy6qiTtWR1f3LI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHpt5GHv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHpt5GHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D26CC19421;
	Thu,  1 Jan 2026 15:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767281155;
	bh=fijsGqE9CnSJQ1VoVakwrwO9lmzv42xMh3DZyoM14fI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XHpt5GHvJM5qyOMGNvH8tFwBLclultMO+0e9mRiefgmeD2oRld8Mc2vrErss3UoPu
	 PPYy953ONhx2hrS7ifHOJ9SwBUU/eJo/q+v82ieqe6BuKdwcS3N07kOh/SFgUGV8wy
	 iOmAUs4X5UT703wn91pEaDq4H2G1qU2WocAPEgJ4a6EU278Pvvyz62hFEZXr14sZlh
	 UJgqeiFV5jFCIsuMJX+FqeQE556eL8Ja1YZtUc5CEaJrD1SWSbwSmIMm/Ydg+xXWvc
	 mXB2MNjF9Pv2P79ebnxX4ce6nDInnsVvIhtBBOJJeOIcdmba5Z4bvG55eTQtpbJBU8
	 7RextR4pm4HXw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 01 Jan 2026 16:25:16 +0100
Subject: [PATCH v2 2/6] video/logo: add a type parameter to the logo
 makefile function
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-custom-logo-v2-2-8eec06dfbf85@kernel.org>
References: <20260101-custom-logo-v2-0-8eec06dfbf85@kernel.org>
In-Reply-To: <20260101-custom-logo-v2-0-8eec06dfbf85@kernel.org>
To: Helge Deller <deller@gmx.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=fijsGqE9CnSJQ1VoVakwrwO9lmzv42xMh3DZyoM14fI=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJlhE1+Fm9nU2cT9XLwgRuHtadbvBxLyQrx1Mtt/SuxkO
 16nVMXcMZGFQYyLwVJMkWVZOSe3Qkehd9ihv5Ywc1iZQIZIizQwAAELA19uYl6pkY6Rnqm2oZ6h
 oQ6QycDFKQBTHXCb4X8Jz9zP1V3KPS9kDSLmPUu/6Bdr/E20sINR8NMuXu9NiisYGZqX+e+zcD3
 uvuL7icv/LL3lZ04MnLOov/zM15q3ni6fz3AAAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

When translating a portable pixmap file into a .c file, the pnmtologo
tool expects to receive the image type (either mono, vga16 or clut224)
as an argument under the -t option.

Currently, this information is stored in the file name. Because we
will allow for custom logo in an upcoming change, it is preferable to
decouple the image name from its type.

Add a new $2 parameter to the Makefile logo function which contains
the image type.

Update all the individual targets to provide this new argument.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/video/logo/Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index 8b67c4941a4c..3f249e9dcf37 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -22,13 +22,16 @@ hostprogs := pnmtologo
 
 # Create commands like "pnmtologo -t mono -n logo_mac_mono -o ..."
 quiet_cmd_logo = LOGO    $@
-      cmd_logo = $(obj)/pnmtologo -t $(lastword $(subst _, ,$*)) -n $* -o $@ $<
+      cmd_logo = $(obj)/pnmtologo -t $2 -n $* -o $@ $<
 
 $(obj)/%.c: $(src)/%.pbm $(obj)/pnmtologo FORCE
-	$(call if_changed,logo)
+	$(call if_changed,logo,mono)
 
-$(obj)/%.c: $(src)/%.ppm $(obj)/pnmtologo FORCE
-	$(call if_changed,logo)
+$(obj)/%_vga16.c: $(src)/%_vga16.ppm $(obj)/pnmtologo FORCE
+	$(call if_changed,logo,vga16)
+
+$(obj)/%_clut224.c: $(src)/%_clut224.ppm $(obj)/pnmtologo FORCE
+	$(call if_changed,logo,clut224)
 
 # generated C files
 targets += *_mono.c *_vga16.c *_clut224.c

-- 
2.52.0

