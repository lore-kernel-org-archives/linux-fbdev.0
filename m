From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 03/33] s3c2410fb: fix s3c2410
	compilation
Date: Thu, 26 Jul 2007 13:02:53 -0700
Message-ID: <20070726130253.1b847edc.akpm@linux-foundation.org>
References: <46A889ED.1020304@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE9Yu-0005ZR-A4 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 13:03:52 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IE9Ys-0002X9-Tn
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 13:03:52 -0700
In-Reply-To: <46A889ED.1020304@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, Ben Dooks <ben-linux@fluff.org>

On Thu, 26 Jul 2007 19:47:57 +0800 "Antonino A. Daplas" <adaplas@gmail.com> wrote:

> @@ -680,6 +681,7 @@ static inline void modify_gpio(void __io
>  static int s3c2410fb_init_registers(struct s3c2410fb_info *fbi)
>  {
>  	unsigned long flags;
> +	void __iomem *regs = fbi->io;
>  
>  	/* Initialise LCD with values from haret */
>  
> @@ -694,25 +696,25 @@ static int s3c2410fb_init_registers(stru
>  
>  	local_irq_restore(flags);

What are the local_irq_save/restore calls in this driver doing?

Either something subtle is happening, or it is wrong on SMP.  If it's an
only-ever-on-UP driver then spin_lock_irqsave() would be better: it'll
deveolve to local_irq_save() anyway.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
