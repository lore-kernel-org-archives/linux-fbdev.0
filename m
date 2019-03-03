From: Yifeng Li <tomli@tomli.me>
Date: Sun, 03 Mar 2019 16:55:30 +0000
Subject: [RESEND][PATCH 0/2] staging: sm750fb: trivial style fixes.
Message-Id: <20190303165532.23727-1-tomli@tomli.me>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Kosina <trivial@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org
Cc: Yifeng Li <tomli@tomli.me>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org

Hello.

From January to February, there have been two trivial sm750fb patches
submitted to linux-fbdev, one by me, one by Jin Chen, but both without
any response. Further, it seems both maintainers, Sudip Mukherjee and
Teddy Wang, are currently unavailable, getting an "Ack-by" would be
unfeasible.

Since they're extremely trivial. Hereby, I picked them up, reworded
commit message, and now resubmit them as trivial patches, and send them
to trivial@kernel.org. I hope it could be directly applied by either a
fbdev, a staging maintainer or by Jiri Kosina.

Thanks for your time!

Yifeng Li (2):
  staging: sm750fb: trivial comment indention fix.
  staging: sm750fb: trivial Camel Case removal for setDisplayControl().

 drivers/staging/sm750fb/ddk750_display.c |  6 ++---
 drivers/staging/sm750fb/sm750_accel.c    | 32 ++++++++++++------------
 2 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.20.1
