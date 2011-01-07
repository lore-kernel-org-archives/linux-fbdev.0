From: Joe Jin <joe.jin@oracle.com>
Date: Fri, 07 Jan 2011 06:50:12 +0000
Subject: [patch] xen-event: validate irq before get evtchn by irq
Message-Id: <4D26B7A4.9000209@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jeremy@goop.org, ian.campbell@citrix.com, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, xen-devel@lists.xensource.com, gurudas.pai@oracle.com, guru.anbalagane@oracle.com, greg.marsden@oracle.com, joe.jin@oracle.com, linux-kernel@vger.kernel.org

Hi,

When get event channel by irq by irq, may irq is not a valid one under
some condition -- so far we found irq is -1 during suspend/resume, so
worth to validate it rather than return incorrect data.

Please review and comment.

Signed-off-by: Joe Jin <joe.jin@oracle.com>
Tested-by: Gurudas Pai <gurudas.pai@oracle.com>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>

---
 events.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/xen/events.c b/drivers/xen/events.c
index ac7b42f..006dd7b 100644
--- a/drivers/xen/events.c
+++ b/drivers/xen/events.c
@@ -175,6 +175,9 @@ static struct irq_info *info_for_irq(unsigned irq)
 
 static unsigned int evtchn_from_irq(unsigned irq)
 {
+	if (WARN(irq < 0 || irq >= nr_irqs, "Invalid irq %d!\n", irq))
+		return 0;
+
 	return info_for_irq(irq)->evtchn;
 }
 

