Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795010853;
	b=VyL0Xg26/40/KXDY7mYMHRWES96wS7ceHed7tL+hfYOvQGQovAaXAu5F+7MrmoU4BuHn
	 1WqOpAv4O+OMDETRS/fW7px5ZxEt638dTLUvKE7+uHs/pSsQ8NWgI6pdHTatDHvw006JH
	 ZdUuODix6anobvsVtwTKIHeurO4xI7HEEldluonHReGZOW1gALHUvEszjLc+PATsE/e4N
	 nsuYiQADnAbnLxpnHHnhKi3dQtHNvRB9VHQZNC/ZPxAYPvmvR82eGzn7xPvChl9umynz4
	 BXwndOFJ43YntTvxWYqb/uBFZOJUuM/Pdp98DPPJdjHwiHrEtlrvkutMK6zJar14baA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010853;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=BALlw79+ejk6OgRMXVcg+vLCGJGFEnxxun1tGkBqdDI=;
	b=VSw3Ii/yHwzowYGb86zdI41YFtHnr6vRkHmUalxJ9GYwJX66GHjApIU+ItqfPMlCJMxx
	 zwzVOkFKd7myrw2b6f12cwo+Jiycq+10lxiaUGbJGqMthyrGDWLrFapRcve20Z8xKnB3b
	 L6Fw2zRlbcTxiTkyXBxv4mrPjnEZVbigcg5mZ2Rvk1mWNxO9bMEbvyL7wq1RA1hzqTH3E
	 EjwoRapgAl9cC2vuL4GF8j3oJ3wB/0qpy41jHBGwJQDmg5en/oy339w6FVLl/WxcRNwx9
	 NZypqMT0ezaEgxL7WH+3trm3DATswJmMqI/KHkRgoDOHyanGJREknvi/9cTRj1XjLYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RCtlncK/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261E606A31C;
	Wed, 18 Nov 2026 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RCtlncK/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795010852;
	b=r8Kk1HK7IFiMhTDnh5rGB8+hObuTvpx1A54v0saIH38ixCuh5nMYmd3z3ytb1ttkfL1L
	 yFKNBNQk61Ch0oy/jY0q912qg10EPc3mYNDbEZx2D7qN2K6Dc6Rx96ZpdxWTTROj4hgIL
	 J5jbsN0AB7MyGzaBRN2VJxzQSCjgzbdmyiymbakjHFePC1omXcsYm1dhutL9wQjh61VF1
	 CuB0Qs3kLOG4zW6Ta+xxWeCt6vp2Az+JvMOezXC5rliGDf1VcTmnpAuAYBiAG6erG9/Ei
	 6fRSO1+VpKi3gfAY5bfOOiunWwKPzYoUjlDN4TMgkr4jpWp7NDB+8ecL27z1t8rgCIw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795010852;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=BALlw79+ejk6OgRMXVcg+vLCGJGFEnxxun1tGkBqdDI=;
	b=CZU3nNyYgB+WrLON0uoxMSGWqKi8JvrP+P+tRfzIHzpR8L0EXQ1nT/D5EV9lB6VxA8Oi
	 yhEigvObxbUk5H9AAS2naToHvwC43gNgHbc9r+ogO1nY0Gg8wt2OD9sVjAoVcC3W4kHSO
	 rdibFcJrbS9xDBjJH2qlOcBiPLzedefyT7KX6ru5if3ZTni8cinwnzEYYh3WgYbkTqU6k
	 DTXuBkTqaLRVgY2Hhyam6IrZxqaPqqv00H6JA8ObdndjWfB5aiwRfotzhQw/WroQEXgA5
	 9I9xubevDTCg7fmhq5xqAzp5khGj/6IgR5touJhgNFYtyVICUs4Aj63yPJ0dJxMIITA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 72A631F000C6;
	Wed, 18 Nov 2026 14:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795010852;
	bh=BALlw79+ejk6OgRMXVcg+vLCGJGFEnxxun1tGkBqdDI=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=RCtlncK/MIpvG8BkVF+Ccdy+Aa5kympTpJX6kKMYiHAAnF1XAqMqEDUlJoGUB+QQY
	 nJWLNgove0eDScGUJ6oAjcWOTXVjH0RtJl6YGHOjGWQVW3WPWwWn0kNxpWPu4G8P2q
	 YZXn4wU5yjXQ7e5wQ0zl+SAur1FFGFigRvfzMz14GKjuV2p3XaG+iTGtHmtR5jnZ1j
	 /Ofzk7HSOdcBGdaVXqMgKjT9LD/nVSlzBUdRtOHaE/pkfMWIuRY6ls2lXjWGGkeWtj
	 8miFSfw6ex035rDZlcV1jXSvMFmNyEiB9QlxW+A9fDAX6mzbrrPA+Ufr+RjvniNTxF
	 OqC5WAgWy9bug==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C50544ADC4;
	Wed, 18 Nov 2026 14:07:31 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Wed, 18 Nov 2026 14:07:31 +0000
Subject: [PATCH] fbdev: cobalt_lcdfb: Don't read info after
 framebuffer_release()
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
Message-Id: <20261118-cobalt-lcdfb-v1-1-214062966e2c@gmail.com>
X-B4-Tracking: v=1; b=H4sIACKx/WoC/yXMQQ5AMBBA0avIrDUxldC4iljoGIwI0iKSxt0Vy
 7f4P4BnJ+yhSgI4PsXLukRgmgCN7TKwki4adKYLRDSKVtvOu5qp663SJrdcErHBHGKyOe7l+nZ
 189sfdmLa3wfc9wPr0o8gcAAAAA==
X-Change-ID: 20261118-cobalt-lcdfb-283be7cce813
To: deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, yoichi_yuasa@tripeaks.co.jp, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795010851; l=1575;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=er7rtpx/jSXL/nx1TsKPyrqeGvkHFZOhjOCGFfe5dcs=;
 b=fDeky12W0HSacB2idTO/VQw34vgDHz88wZN1XKObbv8DHVGPEgYDlyRl4h+ntdPtDy2om7L8f
 L1nwjqbkygJCOebbQvpOheCZriZQh4ZqHGwZ4OXpw4h7ZwdsJH4UdHJ
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com

From: Suyuan Wang <stevewong@hust.edu.cn>

When devm_platform_get_and_ioremap_resource() fails, cobalt_lcdfb_probe()
releases the framebuffer and then dereferences it for the return value:

	framebuffer_release(info);
	return PTR_ERR(info->screen_base);

framebuffer_release() frees info, so info->screen_base is read from freed
memory. Save the error code before releasing info.

Found with a static analysis tool and checked by hand.

Fixes: d2386d9e3eb4 ("fbdev: cobalt_lcdfb: Request memory region")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
The change only moves the error-code read before framebuffer_release().
Checked by inspection; I couldn't build it here (MIPS, and my MIPS cross
toolchain fails at an unrelated host step), and I don't have the
hardware.
---
 drivers/video/fbdev/cobalt_lcdfb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/cobalt_lcdfb.c b/drivers/video/fbdev/cobalt_lcdfb.c
index f7faa95fefd3..e90f45c91725 100644
--- a/drivers/video/fbdev/cobalt_lcdfb.c
+++ b/drivers/video/fbdev/cobalt_lcdfb.c
@@ -297,8 +297,9 @@ static int cobalt_lcdfb_probe(struct platform_device *dev)
 
 	info->screen_base = devm_platform_get_and_ioremap_resource(dev, 0, &res);
 	if (IS_ERR(info->screen_base)) {
+		retval = PTR_ERR(info->screen_base);
 		framebuffer_release(info);
-		return PTR_ERR(info->screen_base);
+		return retval;
 	}
 
 	info->screen_size = resource_size(res);




