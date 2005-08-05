From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: framebuffer-driver-for-mq11xx-graphics-chip.patch added to -mm tree
Date: Fri, 5 Aug 2005 18:08:34 +0400
Message-ID: <20050805140834.GC3852@mipter.zuzino.mipt.ru>
References: <200508050719.j757JZ5J032664@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E12kQ-0007eh-4v
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Aug 2005 07:00:30 -0700
Received: from wproxy.gmail.com ([64.233.184.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E12kP-0000kM-27
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Aug 2005 07:00:30 -0700
Received: by wproxy.gmail.com with SMTP id i17so137748wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 05 Aug 2005 07:00:23 -0700 (PDT)
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: jamey@handhelds.org
Cc: anpaza@mail.ru, linux-fbdev-devel@lists.sourceforge.net, akpm@osdl.org

On Fri, Aug 05, 2005 at 12:18:29AM -0700, akpm@osdl.org wrote:
> This patch adds a framebuffer driver for MQ11xx system-on-chip graphics
> chip.  This chip is used in several non-PCI ARM and MIPS platforms such as
> the iPAQ H5550.  This driver depends on the overall platform_device driver
> for the chip.

> --- /dev/null
> +++ devel-akpm/drivers/video/mq1100fb.c

> + * linux/drivers/mq1100fb.c

Not true.

> +static int mq1100fb_probe (struct device *dev, struct mediaq11xx_base *base)
> +{

> +	info = kmalloc (sizeof (struct mq1100fb_info), GFP_KERNEL);
> +	memset (info, 0, sizeof (struct mq1100fb_info));

Unchecked kmalloc().



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
