From: James Simmons <jsimmons@infradead.org>
Subject: Re: framebuffer-driver-for-mq11xx-graphics-chip.patch
 added to -mm tree
Date: Fri, 5 Aug 2005 21:06:17 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508052103390.19722@pentafluge.infradead.org>
References: <200508050719.j757JZ5J032664@shell0.pdx.osdl.net>
 <42F335C9.5010009@varma-el.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E18Sa-0007wJ-7X
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Aug 2005 13:06:28 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E18SY-0004z0-Tq
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Aug 2005 13:06:28 -0700
In-Reply-To: <42F335C9.5010009@varma-el.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: jamey@handhelds.org, anpaza@mail.ru, mm-commits@vger.kernel.org


> > + *	keithp@keithp.com
> > + *
> > + * ChangeLog
> > + *
> > + * 2003-12-06: Andrew Zabolotny <zap@homelink.ru>
> > + *      - Modified to use the MediaQ SoC base driver to allow
> > + *        sharing of other MediaQ subdevices with other drivers.
> > + * 2003-05-18: <keithp@keithp.com>
> > + *	- Ported from PCI development board to ARM H5400
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/errno.h>
> > +#include <linux/string.h>
> > +#include <linux/fb.h>
> > +#include <linux/init.h>
> > +#include <linux/device.h>
> > +#include <linux/notifier.h>
> > +#include <../drivers/platform/mq11xx.h>
> 	       ^^^^^^^^^^^^^^^^^
> Andrey, Jamey, please, move platform driver
> from drivers/platform to drivers/mfd.

I don't see the mq11xx.h. If it contains graphics related 
information like register names I would recommend 
it being placed into include/video. 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
