Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B02DE703;
	Thu,  1 Jan 2026 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767281162; cv=none; b=k0f7LOd9qdEN8vfdjO0FsKbM8RITmjzx+9hBgXfU9MgXwGR7yB6T3fNu95DYdzb438TL6CpkjC5zJB/cnvY4wiz3gqw9ugt8Knsd39qf8QkffJE/4ckjjcsJtPePK/KvCzzqewtGlbXGXLjz2G1wRpS6sh46DmpAR4QmY647FKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767281162; c=relaxed/simple;
	bh=DavTlH0i9MWegO1iqCZhDEQs4kTEOYsr1j0ik1iUucI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dXCocqBKwZyMdG4If93G5r+jc8nITtTtgPVGIKV9Zef6a2NUwe9Ce6g4WLKYtZgcC2hABj3UCxxqOQVwpkWx0XrZ56hqlTWuz5ubF0I0jtpQQH/TfSxGWBynTj61yg20g7cR2MQjXPi+tVMQBwDZCylgPGcOeeGESIwo0zOMUBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INc/V7iI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INc/V7iI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC566C16AAE;
	Thu,  1 Jan 2026 15:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767281161;
	bh=DavTlH0i9MWegO1iqCZhDEQs4kTEOYsr1j0ik1iUucI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=INc/V7iIyFxHMxq3DVYPQ0wfABOKnmNuMRBJx3qFcam1sPuVHc6h12n4bCOt5oX9Q
	 0PIq05cyfqUzmhQgrSSTkvhrW7HASy7krE3OMjGLFuVA6+5EdHJ2MCUHgzQlV/kPT3
	 YhH8o3AxYyTty5ctPmvUCvTUMHGS+b5Svmd0i3/GCcAoBy2kQgW6VQDwGx0ndUDdpL
	 BxbOeQqF2Zdkq+V/HpzxheCaHVizWonZLAmZ6dTKvXHDCa/QWqLRW8JaLQHJFkip9b
	 877gfJLLzq7BZvGMMogAgRm4FLc/KTqIf8QWqvRv/5NR9FgsLW9y+XOjC9hzxxQNMY
	 dhL5cv9wMU/Ow==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 01 Jan 2026 16:25:18 +0100
Subject: [PATCH v2 4/6] newport_con: depend on LOGO_LINUX_CLUT224 instead
 of LOGO_SGI_CLUT224
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-custom-logo-v2-4-8eec06dfbf85@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=DavTlH0i9MWegO1iqCZhDEQs4kTEOYsr1j0ik1iUucI=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJlhEz9cjl3OeEkz/9eu7TazfnUwHDTm7Gh/pcstWL7V9
 saGDWI2HRNZGMS4GCzFFFmWlXNyK3QUeocd+msJM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GuoAmQxcnAIw1VcSGRlaIg+Y96rZNBhzqV299lfK7XZn0cxvnxhfOMzUPhXIrZHEyHBTOeSu69F
 A6eXOytuu9Xd2W9kZyS9V/Wj7af5WV7XCzzwA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

newport_show_logo() is only activated if CONFIG_LOGO_LINUX_CLUT224 is
set (otherwise it is a NOP). This configuration value will be removed
in an upcoming change so instead, make it depend on LOGO_LINUX_CLUT224.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/video/console/newport_con.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 242415366074..337e04236d6d 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -95,7 +95,7 @@ static inline void newport_init_cmap(void)
 
 static const struct linux_logo *newport_show_logo(void)
 {
-#ifdef CONFIG_LOGO_SGI_CLUT224
+#ifdef CONFIG_LOGO_LINUX_CLUT224
 	const struct linux_logo *logo = fb_find_logo(8);
 	const unsigned char *clut;
 	const unsigned char *data;
@@ -127,7 +127,7 @@ static const struct linux_logo *newport_show_logo(void)
 	return logo;
 #else
 	return NULL;
-#endif /* CONFIG_LOGO_SGI_CLUT224 */
+#endif /* CONFIG_LOGO_LINUX_CLUT224 */
 }
 
 static inline void newport_clear_screen(int xstart, int ystart, int xend,

-- 
2.52.0

