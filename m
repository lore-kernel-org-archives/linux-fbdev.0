From: Andrey Volkov <avolkov@varma-el.com>
Subject: Re: framebuffer-driver-for-mq11xx-graphics-chip.patch
 added to -mm tree
Date: Fri, 05 Aug 2005 13:47:53 +0400
Message-ID: <42F335C9.5010009@varma-el.com>
References: <200508050719.j757JZ5J032664@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E0yoD-0005wF-UF
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Aug 2005 02:48:09 -0700
Received: from [195.144.244.147] (helo=amanaus.varma-el.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E0yoC-00089e-Gx
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Aug 2005 02:48:10 -0700
In-Reply-To: <200508050719.j757JZ5J032664@shell0.pdx.osdl.net>
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: jamey@handhelds.org, anpaza@mail.ru, mm-commits@vger.kernel.org

akpm@osdl.org wrote:
> + *
> + *	keithp@keithp.com
> + *
> + * ChangeLog
> + *
> + * 2003-12-06: Andrew Zabolotny <zap@homelink.ru>
> + *      - Modified to use the MediaQ SoC base driver to allow
> + *        sharing of other MediaQ subdevices with other drivers.
> + * 2003-05-18: <keithp@keithp.com>
> + *	- Ported from PCI development board to ARM H5400
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/fb.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/notifier.h>
> +#include <../drivers/platform/mq11xx.h>
	       ^^^^^^^^^^^^^^^^^
Andrey, Jamey, please, move platform driver
from drivers/platform to drivers/mfd.

-- 
Regards
Andrey Volkov


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
