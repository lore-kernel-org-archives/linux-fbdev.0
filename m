From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Tue, 18 Feb 2014 20:20:36 +0000
Subject: [PATCH 0/2] Re-sending two patches for hyperv_fb
Message-Id: <1392757891-28680-1-git-send-email-haiyangz@microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, akpm@linux-foundation.org, linux-fbdev@vger.kernel.org
Cc: olaf@aepfle.de, jasowang@redhat.com, driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, haiyangz@microsoft.com

They were sent out during tree closing, I'm re-sending them now.

Haiyang Zhang (2):
  hyperv_fb: Add screen refresh after pause/resume operation
  hyperv_fb: Add support for Gen2 VM

 drivers/video/hyperv_fb.c |   70 ++++++++++++++++++++++++++++++++-------------
 1 files changed, 50 insertions(+), 20 deletions(-)

-- 
1.7.4.1

