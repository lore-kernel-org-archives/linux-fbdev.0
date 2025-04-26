Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F704414;
	Sat, 26 Apr 2025 06:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745648590; cv=none; b=S4cq9WL9SgRSzDmU4Nne6TwQ+0JNjPUVYLobAp/0CEcpvXfEEP8f8f/5vnpNUjXCaCHtkhbkcIRLIowtIPJxs0Whw71zNuBoKZ8F2S4mnmAsQe2rHnC9+pc0bicDWY0ztAlXVY1vgW6S/5CgSmu5Hse/XDeZTxG6oVOJth9AM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745648590; c=relaxed/simple;
	bh=27+zMyxeObnY+2ZctN5Kd1JdUG7p8OUHfohFohgaffs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UQVIutxqLq16pdfWL0VUtGCHR/YRxjQZlVC/2EQJgXTcb2xQuvZ0xmaW+2tu3S2UOwVIMQQBJ7aE+Sw51xDm50cu+MqRbLcCDi2zZL8fAmlF9nPfnI2TAX8ZoVAgwWjvywZfnun/DL06Sv84sQwI7ukU89smsPD03eH6dfq7kxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHo9/Fab; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHo9/Fab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455B5C4CEE2;
	Sat, 26 Apr 2025 06:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745648590;
	bh=27+zMyxeObnY+2ZctN5Kd1JdUG7p8OUHfohFohgaffs=;
	h=From:To:Cc:Subject:Date:From;
	b=aHo9/FabE7ZQa+vos7KsSZ4IJeQlktU6shV39qpD4mWsp2zFVhGZs6e02/MoMZtSB
	 jH3fwcdHt9avgFrD0P9elk2pPCYbhJdzeaEmIEYpHBnL21CNLVxOkwfTDimBSJKj3F
	 kFXpHC7K6HfNgKtrbkcPZ6cP8MH+S/5/xMfvJlB/4i2u/cY11YIdxsYszcP1uE7Ep7
	 +sPhzEVBw1U3+A7FRptQLwD2zx7Z/jkVlT//0lPYwJvgQln4EUELfSATEp2yKrOD7S
	 yS22uIeTcf02PyK2V1rnfWuHLFQ4yjv/J8PV7wNzPzr95PzN/TrugIv+nCr5lc5FH2
	 ASxErqEnFUjHA==
From: Kees Cook <kees@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: Kees Cook <kees@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Zheyu Ma <zheyuma97@gmail.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] video: fbdev: arkfb: Cast ics5342_init() allocation type
Date: Fri, 25 Apr 2025 23:23:06 -0700
Message-Id: <20250426062305.work.819-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1621; i=kees@kernel.org; h=from:subject:message-id; bh=27+zMyxeObnY+2ZctN5Kd1JdUG7p8OUHfohFohgaffs=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk81ac+X1l5T0tgY5HOHT/tEy84W2w//dh8pP/bOpule SF5y/av7ihlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZiIfDYjwz6/cN0C0apLb6pZ YvsP2eewrMh87lYp8vPjNr81aWorMhkZNvU6MrntOe/1YgJ7WvbOUAeX9K1zPI2/8z3TLD4x41c LDwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The assigned type is "struct dac_info *" but the returned type will be
"struct ics5342_info *", which has a larger allocation size. This is
by design, as struct ics5342_info contains struct dac_info as its first
member. Cast the allocation type to match the assignment.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Helge Deller <deller@gmx.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Zheyu Ma <zheyuma97@gmail.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: <linux-fbdev@vger.kernel.org>
Cc: <dri-devel@lists.freedesktop.org>
---
 drivers/video/fbdev/arkfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
index 082501feceb9..7d131e3d159a 100644
--- a/drivers/video/fbdev/arkfb.c
+++ b/drivers/video/fbdev/arkfb.c
@@ -431,7 +431,7 @@ static struct dac_ops ics5342_ops = {
 
 static struct dac_info * ics5342_init(dac_read_regs_t drr, dac_write_regs_t dwr, void *data)
 {
-	struct dac_info *info = kzalloc(sizeof(struct ics5342_info), GFP_KERNEL);
+	struct dac_info *info = (struct dac_info *)kzalloc(sizeof(struct ics5342_info), GFP_KERNEL);
 
 	if (! info)
 		return NULL;
-- 
2.34.1

