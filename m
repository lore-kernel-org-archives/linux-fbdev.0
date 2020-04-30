From: Matej Dujava <mdujava@kocurkovo.cz>
Date: Thu, 30 Apr 2020 20:09:23 +0000
Subject: [PATCH 0/3] Refactor reused code for updating fb_info
Message-Id: <1588277366-19354-1-git-send-email-mdujava@kocurkovo.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

This patch set will unify reused switch statement updating fb_info by
creating inline functions.

Tested only by compilation.

Matej Dujava (3):
  staging: sm750fb: add missing case while setting FB_VISUAL
  staging: sm750fb: add common function to set color offsets and visual
    mode
  staging: sm750fb: print error message with actual value

 drivers/staging/sm750fb/sm750.c | 150 +++++++++++++++-----------------
 1 file changed, 68 insertions(+), 82 deletions(-)

-- 
2.26.2
