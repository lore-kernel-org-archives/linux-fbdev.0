From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 4/5] x86_64 EFI support -v3: EFI
	framebuffer driver
Date: Wed, 01 Aug 2007 13:55:12 +0800
Message-ID: <1185947712.4688.22.camel@daplas>
References: <1185851582.23149.29.camel@caritas-dev.intel.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IG7B5-0005qI-Uk for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 31 Jul 2007 22:55:24 -0700
Received: from wa-out-1112.google.com ([209.85.146.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IG7B4-0005kk-EB
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 31 Jul 2007 22:55:23 -0700
Received: by wa-out-1112.google.com with SMTP id k22so119507waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 31 Jul 2007 22:55:22 -0700 (PDT)
In-Reply-To: <1185851582.23149.29.camel@caritas-dev.intel.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Chandramouli Narayanan <mouli@linux.intel.com>, ak@suse.de, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, Yinghai Lu <yhlu.kernel@gmail.com>

On Tue, 2007-07-31 at 11:13 +0800, Huang, Ying wrote:

> +
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/fb.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/screen_info.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/dmi.h>
> +#include <linux/efi.h>
> +#include <linux/io.h>
> +
> +#include <video/vga.h>
> +

I don't see any problems with this driver, just a few minor nits.

Do you really need all the #include's?
I presume this driver only supports bpp 16 and above?

Tony




-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
