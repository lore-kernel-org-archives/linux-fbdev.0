Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009F29B8FE;
	Thu,  8 Jan 2026 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899184; cv=none; b=EM9WMuvQTs8QAWWgoN3ukFVEcZw2LIGzHtv9+d+WBJJ3ECPPF5jPDZlxZ/ZIIG9+Lam0hYMNSNhIuecZqWD6AKVzFrBjN9iuaCXO1WrSRGcKP4Jh4KOmun0gP1TR4PMbLrZWp2TTEh3L2DbaFtNqn1q9Jc0JWNJ2l3iZucaymK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899184; c=relaxed/simple;
	bh=fijsGqE9CnSJQ1VoVakwrwO9lmzv42xMh3DZyoM14fI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eVDcCuLMeufifjppAY1Xbh3wu5FN54VLhSMGXKNYYc8UKLKG7QQsrrFfGG5cSxPgk4F3wI7wJVW5I1AU0TF3cgts8jh44dqPIJKsTZTihtiEQ2ZZdV70AHcSpU6rDP6E2agMB2s7MRXqDQaKSaIg4vkbi7KQuXeSpTUuUT2YGHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOiAzfNA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOiAzfNA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F55C19423;
	Thu,  8 Jan 2026 19:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767899181;
	bh=fijsGqE9CnSJQ1VoVakwrwO9lmzv42xMh3DZyoM14fI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tOiAzfNAiaOBjWEo8cGz1p0576Uopou9/CvdhYtsv666IYwcOhyluM2S/tg2kyzbn
	 rn0PJ/x0XPyk4i4DfA3yZ08vxfn0daJvlGDlQw17aZ25Gt7phaNiOe8pweLk8lcsFT
	 7pxH3APSUbGDhsPJlEhuMoliLKrTfB6tUt8Hrp6V/GrnpImRdiJCTtsza1vH0kVd07
	 IIw0f73VShPN+YZbGPmYNd2g4gpQ4skkMAFkZri66Fx80dJF105kvicgJUvd0F2GlJ
	 OqanB7d8An3eJ9DcF1Tu6wGj5iv3cKMjmdCxFGfo17QZlfrsjnIM7WYEXZh4sgE16q
	 W7al2NexjyQkg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 08 Jan 2026 20:04:50 +0100
Subject: [PATCH v3 2/7] video/logo: add a type parameter to the logo
 makefile function
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-custom-logo-v3-2-5a7aada7a6d4@kernel.org>
References: <20260108-custom-logo-v3-0-5a7aada7a6d4@kernel.org>
In-Reply-To: <20260108-custom-logo-v3-0-5a7aada7a6d4@kernel.org>
To: Helge Deller <deller@gmx.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=fijsGqE9CnSJQ1VoVakwrwO9lmzv42xMh3DZyoM14fI=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJkJDPxVge6J9rLvAvSrNe/1lDnPkp8srRj0vmF+j9vaS
 ufNa+Q7JrIwiHExWIopsiwr5+RW6Cj0Djv01xJmDisTyBBpkQYGIGBh4MtNzCs10jHSM9U21DM0
 1AEyGbg4BWCqZRUY/ifJ/vljuuu82d26T8ecxBOtb840fLIlOl3eaE6NwSF7vu0MfzjbXCYfOV2
 m+aL/fvYhkQcB+/Pvm07w4uQu0+tZZWdRygMA
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

