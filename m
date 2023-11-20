Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="A8C6XWEn"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA80BC7;
	Mon, 20 Nov 2023 15:42:39 -0800 (PST)
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id 59E2020B74C0;
	Mon, 20 Nov 2023 15:42:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 59E2020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700523759;
	bh=7L+TOsdX+tZkVHKWORc7I4/cc04Er/+p3FqDJzAROJw=;
	h=Subject:From:To:Date:From;
	b=A8C6XWEn7vVZ6AbgF1p5O0/7OzH6a9ONdOP2k0oKBDb0/fVJEasAtzXqzVzqEqfPr
	 Wzw1H5M0X9XtzuzI9TGWi53kh2mho3zuT+IKOH9eDPhQ31FjNoGM6Mx37rQazyc8Xh
	 7+NMw3g2aLRU0bldqlQNMzaCFGIBmeCpiAnvm8bY=
Subject: [PATCH] fbdev/fsl-diu-fb: Fix srapse warning due to virt_to_phys()
 prototype change
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: timur@kernel.org, deller@gmx.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 20 Nov 2023 15:42:38 -0800
Message-ID: <170052375352.21405.5715750058235741780.stgit@skinsburskii.>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Explicitly cast __iomem pointer to const void* with __force to fix the
following warning:

   incorrect type in argument 1 (different address spaces)
      expected void const volatile *address
      got char [noderef] __iomem *screen_base

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/video/fbdev/fsl-diu-fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index 7fbd9f069ac2..b0fda5bd1964 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -877,7 +877,7 @@ static int map_video_memory(struct fb_info *info)
 	}
 	mutex_lock(&info->mm_lock);
 	info->screen_base = p;
-	info->fix.smem_start = virt_to_phys(info->screen_base);
+	info->fix.smem_start = virt_to_phys((__force const void *)info->screen_base);
 	info->fix.smem_len = smem_len;
 	mutex_unlock(&info->mm_lock);
 	info->screen_size = info->fix.smem_len;


