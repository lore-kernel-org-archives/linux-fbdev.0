From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 31 Dec 2014 12:38:44 +0000
Subject: [PATCH 2/3] staging: sm7xxfb: update TODO file
Message-Id: <1420028805-30488-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1420028805-30488-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1420028805-30488-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Sudip Mukherjee <sudip@vectorindia.org>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org

update the email addresses in the TODO file, also update the final
destination of this driver. 

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm7xxfb/TODO | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm7xxfb/TODO b/drivers/staging/sm7xxfb/TODO
index 1fcead5..6377380 100644
--- a/drivers/staging/sm7xxfb/TODO
+++ b/drivers/staging/sm7xxfb/TODO
@@ -3,7 +3,10 @@ TODO:
 - 2D acceleration support
 - use kernel coding style
 - refine the code and remove unused code
-- move it to drivers/video/sm7xxfb.c
+- move it to drivers/video/fbdev/sm7xxfb.c
 
-Please send any patches to Greg Kroah-Hartman <greg@kroah.com> and
-Teddy Wang <teddy.wang@siliconmotion.com.cn>.
+Please send any patches to
+	Greg Kroah-Hartman <greg@kroah.com>
+	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
+	Teddy Wang <teddy.wang@siliconmotion.com>
+	Sudip Mukherjee <sudip@vectorindia.org>
-- 
1.9.1

