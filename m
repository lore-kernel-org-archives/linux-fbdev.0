Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAD228FFCF;
	Wed,  9 Jul 2025 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058225; cv=none; b=SWXqJYEIEwXeg0TV8+rNyuGKNu9hok8qw5ZsVmoRYsekLR98LG68JyjbfgkrbNUPDhUj5JN5PB17DzLUanSpUOQyylYNjX7WjPx66Xn1IpiMs7WidOxN+CX3CQd+yH+JDgrmrnJrgfrQiYKcpjeG+0ITBaEHl2XppF7zHL3I6ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058225; c=relaxed/simple;
	bh=FpOBHbqxNPaRyuzoso35Bw5NmFuK5VKTTeQfVm72Vqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N3MA+vCKoCcgarFupnR5qeKpITY8B3Rf8oz1RQmqJ8CABx03qLa9z1z0NRdFXodtYTosqoQyfc6+nz8KchWbDrRJnBzIXoX2R6cwp3iSHNAzVGw148Vto7XwbPtXV6ftwCUSEH1Vt226XYJhgWmSLHbfhmOLpC3kprQIokDzf1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NWvypW9s; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NWvypW9s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=YT
	7+Q5/NWqu7pnKZyZQ2XSSZQm25QtlIaACuyvOyxGA=; b=NWvypW9spgpPozS5n6
	jzJYk+xncOLnC/t8gU+nUY5ukpuOjIjRI1V1RRHwIB79lYsxHJ8MJj1T99aodS1T
	cB7Uxc5YNbDJdDxRoouy+nbQcCQ5TzRxWOdznpAIYC+IW8/Id2aBujhL56bahims
	FyVhnHvR4U5D1FqWbvSObluZI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wB3hDbARW5oKB04Dg--.12748S2;
	Wed, 09 Jul 2025 18:34:42 +0800 (CST)
From: oushixiong1025@163.com
To: Simona Vetter <simona@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] fbcon: Fix outdated registered_fb reference in comment
Date: Wed,  9 Jul 2025 18:34:38 +0800
Message-Id: <20250709103438.572309-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3hDbARW5oKB04Dg--.12748S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWDtF47uryDKryDGFyrtFb_yoWkCFc_Ca
	sYv34DJ34DGrWfKrn3CFsxZ34FvayjvrWfu3WDtFyrta4UJ3y5Wr42vr1jqrWrKF1Ivrs0
	gw17Kr4fuw1fCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8vD73UUUUU==
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXQSED2hsYPeT9wACsn

From: Shixiong Ou <oushixiong@kylinos.cn>

The variable was renamed to fbcon_registered_fb, but this comment was
not updated along with the change. Correct it to avoid confusion.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/core/fbcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 25684f5d6523..d8eab4859fd4 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -953,13 +953,13 @@ static const char *fbcon_startup(void)
 	int rows, cols;
 
 	/*
-	 *  If num_registered_fb is zero, this is a call for the dummy part.
+	 *  If fbcon_num_registered_fb is zero, this is a call for the dummy part.
 	 *  The frame buffer devices weren't initialized yet.
 	 */
 	if (!fbcon_num_registered_fb || info_idx == -1)
 		return display_desc;
 	/*
-	 * Instead of blindly using registered_fb[0], we use info_idx, set by
+	 * Instead of blindly using fbcon_registered_fb[0], we use info_idx, set by
 	 * fbcon_fb_registered();
 	 */
 	info = fbcon_registered_fb[info_idx];
-- 
2.25.1

