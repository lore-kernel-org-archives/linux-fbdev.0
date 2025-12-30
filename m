Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA05223B63F;
	Tue, 30 Dec 2025 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767133234; cv=none; b=E5cwS/CwtnIazRdHmsEG4dANP+JLVQc6XSsR9yo7+c6XJhXCt56SDFsdAZvjeXRj/yx4Ks0iHSoOlSiRlKJAUoADeCRaN7Zj4wM8SL3aCbYtG4hisAwQ0oCCxIJChvOi1EMSgCTkPixFaEwxafM3V/EWnfWHic1mLFt+WD6vs4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767133234; c=relaxed/simple;
	bh=oiaT6aLlR+Lw7QjGCokHCw+7kOpOxkIL1yAAgjdQAoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ehJhKGdMamE49wvk78xHPbnC25QNN5c/5BK0JzAKGbHaCgn5YzHhf/YgfrTv20ZiPk/4Alr7GMCeVpGfhGIrOl3UyX7nM2VJ55eCeo7iIKc/KSe0SVgP1hCOphBHghFv65GdC1XXpHuFiQR3duRAM8lTYfs6hgy5KHO569mZ6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAvcTXId; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAvcTXId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE644C4CEFB;
	Tue, 30 Dec 2025 22:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767133233;
	bh=oiaT6aLlR+Lw7QjGCokHCw+7kOpOxkIL1yAAgjdQAoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uAvcTXId1+g5SoDSBHxwipcS05pcotNbHjxY0/gUbt85pfEuo+DqBzQso++znZBvy
	 RDbJ901DGoC74xAsh+we+FSPRnbdkMWa4bYvrI3yITFXQ2PQFZ7Pv7mnAJQ2iseZ8W
	 lAB/cVUsQmkskCgEyP7IKbVXDZbi7EsjkDMt0r7q48DxLfng8X8wBBbTcYY8hGqVky
	 G5hxHGcSbIjrazxelbyAQ4JsHzyMHdizIFsFOJTF99uZ2ill1rA5RfMC3kBEP7rP+9
	 AL+Zx6KjSzX7VGMODH/jU3h/xAKHoG1Wm9xSiFYGnf2vMe9vyQuZ2pAJEgmCyDwkNS
	 0HZ0gsUYjX5cA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 30 Dec 2025 23:20:01 +0100
Subject: [PATCH 2/6] video/logo: add a type parameter to the logo makefile
 function
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251230-custom-logo-v1-2-4736374569ee@kernel.org>
References: <20251230-custom-logo-v1-0-4736374569ee@kernel.org>
In-Reply-To: <20251230-custom-logo-v1-0-4736374569ee@kernel.org>
To: Helge Deller <deller@gmx.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=oiaT6aLlR+Lw7QjGCokHCw+7kOpOxkIL1yAAgjdQAoU=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJkhAZLRHmGmG87kxcWFZWvMZ/ycbma37f8Ji3dZKbbHu
 vwflV/vmMjCIMbFYCmmyLKsnJNboaPQO+zQX0uYOaxMIEOkRRoYgICFgS83Ma/USMdIz1TbUM/Q
 UAfIZODiFICpdp/MyHC5qZ99WXhttc6c14G70w6UfzS4s++PNJ/gu1lzz0ntqZ7GyNDiYTvh16x
 rHzRfnlD8xxL9ZG2S1pnnjE5iBpNX+diUnOQEAA==
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

Update all the individual targets to provide this new argument. Note
that this transitional: all those targets will be removed in an
upcoming clean-up change.

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
2.51.2

