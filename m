From: Sasha Levin <sashal@kernel.org>
Date: Sat, 01 Jun 2019 13:25:46 +0000
Subject: [PATCH AUTOSEL 4.4 42/56] fbdev: sm712fb: fix boot screen glitch when sm712fb replaces VGA
Message-Id: <20190601132600.27427-42-sashal@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190601132600.27427-1-sashal@kernel.org>
In-Reply-To: <20190601132600.27427-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Yifeng Li <tomli@tomli.me>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

From: Yifeng Li <tomli@tomli.me>

[ Upstream commit ec1587d5073f29820e358f3a383850d61601d981 ]

When the machine is booted in VGA mode, loading sm712fb would cause
a glitch of random pixels shown on the screen. To prevent it from
happening, we first clear the entire framebuffer, and we also need
to stop calling smtcfb_setmode() during initialization, the fbdev
layer will call it for us later when it's ready.

Signed-off-by: Yifeng Li <tomli@tomli.me>
Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: <stable@vger.kernel.org>  # v4.4+
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/sm712fb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 2539c1e6facb4..6a30714a18632 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1498,7 +1498,11 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 	if (err)
 		goto failed;
 
-	smtcfb_setmode(sfb);
+	/*
+	 * The screen would be temporarily garbled when sm712fb takes over
+	 * vesafb or VGA text mode. Zero the framebuffer.
+	 */
+	memset_io(sfb->lfb, 0, sfb->fb->fix.smem_len);
 
 	err = register_framebuffer(info);
 	if (err < 0)
-- 
2.20.1
