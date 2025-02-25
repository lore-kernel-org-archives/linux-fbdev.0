Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D441A2C0B;
	Tue, 25 Feb 2025 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501894; cv=none; b=nUmzArNNdIvDqF1A6DP74nKhDAmADOl//SJad/RduHenT9f4b/OUQgAEHUUSgb+BIWGslwKlDGvA9LslgbLF0xnx2ocJwac+fIuOoYL66l3Mwtekkv0Ba9tdfSfw9bDjw9jFbGd3gBCRkNKlt3ndfRwBJnOP05xgpD7cs3aHNdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501894; c=relaxed/simple;
	bh=UYE7SvQD/nIFAX3j6zK9BtdqY4cgGf7VK4pQLi2P6ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vGGSnJIifHjbNK5f8VZZjknmWOzZHu4oRIINIb0aQM67JgZbaSkpyXwbga7M7wh4WTj+dVmr0KDCJ3U5T7yZTh+LJBNm3bE7dUlBFlLm2CD608ToPbUX5EsR9z0Uz7uEqgFFP+YrCOe9h0isRiIzogOyr1SvlB9XVoyPvCrGQ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bag9zb0Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bag9zb0Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738C5C4CEE6;
	Tue, 25 Feb 2025 16:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740501894;
	bh=UYE7SvQD/nIFAX3j6zK9BtdqY4cgGf7VK4pQLi2P6ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bag9zb0Zg01oG7D/DlGyb9g3yfYPFy42vrOxJqyYQb3xlDSkDTZJUooKtuGqVOUDM
	 GPUrviQ222kX/TL1gk97TI5SMaXAZALE+VNCj7NARsr15a03NVDh7stHEs1/rBEf1g
	 qo6YU8qADy+UzgMevlR4DjE7SfHEGPhOjoipANVNXnOEDIqF9QhKR79SP0wG5gdK1K
	 0k1UaQC3JfVa69e893o+Ic9zAQ4hZPM7wCtzfrCMp2qcucdBQdultYFU01rYfHSIiX
	 GW6Qc+4bALAszG97MLeM8TvII6oLwR87PLBMkaSxGjoO7s1gobmGwJL/2SQYkJ2N1g
	 FN3PRgLeWrCtQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>,
	Roland Kletzing <devzero@web.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mdacon: rework dependency list
Date: Tue, 25 Feb 2025 17:44:23 +0100
Message-Id: <20250225164436.56654-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225164436.56654-1-arnd@kernel.org>
References: <20250225164436.56654-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

mdacon has roughly the same dependencies as vgacon but expresses them
as a negative list instead of a positive list, with the only practical
difference being PowerPC/CHRP, which uses vga16fb instead of vgacon.

The CONFIG_MDA_CONSOLE description advises to only turn it on when vgacon
is also used because MDA/Hercules-only systems should be using vgacon
instead, so just change the list to enforce that directly for simplicity.

The probing was broken from 2002 to 2008, this improves on the fix
that was added then: If vgacon is a loadable module, then mdacon
cannot be built-in now, and the list of systems that support vgacon
is carried over.

Fixes: 0b9cf3aa6b1e ("mdacon messing up default vc's - set default to vc13-16 again")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I have no idea when the last time was that someone actually tried using
dualhead vgacon/mdacon with two ISA cards, or if it still works. We may
be better off removing the driver altogether, but I don't see anything
immediately wrong it with it.
---
 drivers/video/console/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index ea4863919eb9..12f54480f57f 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -24,7 +24,7 @@ config VGA_CONSOLE
 	  Say Y.
 
 config MDA_CONSOLE
-	depends on !M68K && !PARISC && ISA
+	depends on VGA_CONSOLE && ISA
 	tristate "MDA text console (dual-headed)"
 	help
 	  Say Y here if you have an old MDA or monochrome Hercules graphics
-- 
2.39.5

