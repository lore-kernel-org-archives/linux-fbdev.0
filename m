Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795488583;
	b=4/4sEM9W5ffL7qpUAK41DZ6IIniUSl28bNFacnSxV1Awe3ffo4BfFF5rhHbinDxhOuf3
	 jqn+lGsbEaueAZ1QcqUOLIY9NYnfp+WfO/T/3PvaX9WAE4SCKjQE7lCzcswMo/xTHlmjc
	 gLxddzBlt+tsyAtii3ulLP93H5qhhXdMgIPh+CbFIBQ1/Fi1HBEh8sUCVgQkWRZGMUtvK
	 WFtHrQWiKrkENmDbsPapj9O9zpcip8Cfg6f5j/cEM7NrvnPupH7r32ri2aGBOSAh3bcWF
	 Kh/PS85nlXoeKBQz2aCAq+f5Twbyzhk2JmhbBYcAv8Kwj+I+YAWmWb1sGMv+eyc91Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795488583;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=r8hzljQmtnUVGIClS4ocvCxhHOhfEjCLk7hwkhWHSxQ=;
	b=IRzgu2pRwyukc9/1Swsm3XK0koxGdMkoP9DO0z2w7BsQubIcyI8Mgr67EJqNFBwWPYxb
	 lx9bwuc0J03txst/ULtfXWqHiF2Pfu/bJ7YMbwnWbR41fk+nggbZS6EJ1kgWM6W0rpnu7
	 mDJ+2jnUgz6F9d2SSfzzAdMXbE2xs9H5pHTScWraQlL0HZGw4fnSN9d4J92HYGWd8Lo6r
	 jHqyYCORhTPnPxX8D19ebfKamD6zYF0jjA/4URrUOc3TRBHqcrhJgxk5eXP50P3FRYmmv
	 qvBedt/2iN5bLB0DsgeWyNGu2YCfWMrpB5MstDBo8yUWCSVYDMDDsSOYiP6My67QVUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC4606A31E;
	Tue, 24 Nov 2026 02:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DCC4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: af993bf8e7b111f19a56ed5b684f684d-20261124
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:14aa8185-f1b9-414f-aaf8-86276cc4da59,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:1933bcb9f53dae1a15bdb69f78cd479b,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: af993bf8e7b111f19a56ed5b684f684d-20261124
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1360815085; Tue, 24 Nov 2026 10:49:36 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.cn>
Subject: [PATCH] vgacon: Update CRTC start address when turning scrollback off
Date: Tue, 24 Nov 2026 10:49:33 +0800
Message-ID: <20261124024933.306103-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 174657478cd8 ("vgacon: inline vc_scrolldelta_helper() into
vgacon_scrolldelta()") moved the early return for !lines into
vgacon_scrolldelta(), skipping vga_set_mem_top(c). This leaves the VGA
CRTC start address stuck at the old scrollback offset after
vgacon_restore_screen().

Call vga_set_mem_top(c) before returning when !lines.

Fixes: 174657478cd8 ("vgacon: inline vc_scrolldelta_helper() into vgacon_scrolldelta()")
Assisted-by: LLM
Signed-off-by: Yu Peng <pengyu@kylinos.cn>
---
 drivers/video/console/vgacon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 09f7c376b4689..a6b0223ca596d 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -147,6 +147,7 @@ static void vgacon_scrolldelta(struct vc_data *c, int lines)
 	/* Turn scrollback off */
 	if (!lines) {
 		c->vc_visible_origin = c->vc_origin;
+		vga_set_mem_top(c);
 		return;
 	}
 
-- 
2.43.0

