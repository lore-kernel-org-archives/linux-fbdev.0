From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 18 Dec 2014 11:57:21 +0000
Subject: [PATCH] video/logo: prevent use of logos after they have been freed
Message-Id: <1418903842-22450-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

The fbdev logo seems to be rather messed up when deferred probing is happening.
This is a quick fix for the problem.

The code in the logo.c is quite scary, using __init_refok to silence warnings
about accessing __initdata from non-init context.

Another option would be to make the logos not __initdata, but I think that's
not acceptable.

Any ideas for a nicer way to fix this issue?

 Tomi

Tomi Valkeinen (1):
  video/logo: prevent use of logos after they have been freed

 drivers/video/logo/logo.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

-- 
2.2.0

