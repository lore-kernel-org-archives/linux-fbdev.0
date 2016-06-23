From: wolzstefan@web.de
Date: Thu, 23 Jun 2016 12:00:09 +0000
Subject: [PATCH] sm750fb/sm750_hw.c: fixed various style problems
Message-Id: <1466683213-17477-1-git-send-email-wolzstefan@web.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@i4.cs.fau.de

Hello,

we made some style fixes for the file drivers/staging/sm750fb/sm750_hw.
There are 4 patches included:
Patch 1 corrects alignment of multiline statements,
patch 2 deletes some newlines and adds whitespaces around operators,
patch 3 fixes some typos and style problems in comments and
patch 4 copes with leftover things.

After applying the patch series, checkpatch will only show camelcase occurances 
and propose the usage of an u32.

Best regards,
Stefan Wolz

