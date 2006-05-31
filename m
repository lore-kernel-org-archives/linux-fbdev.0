From: Terence Soh <gopher@singnet.com.sg>
Subject: printk on framebuffer console
Date: Wed, 31 May 2006 08:45:48 +0800
Message-ID: <447CE73C.2060807@singnet.com.sg>
References: <447C03C6.3000805@singnet.com.sg> <447C37F5.8000008@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlErT-0005rw-Nn
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 17:46:59 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FlErT-0005PV-Rk
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 17:46:59 -0700
Received: from smtp18.singnet.com.sg ([165.21.6.38])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FlErR-000567-6K
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 17:46:59 -0700
In-Reply-To: <447C37F5.8000008@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

> You're better off sending this to linux-fbdev-devel, so I'm adding
> this to the CC list.
Thanks for the tip!

> 
> Yes, the monochrome bitmap are expanded to the current foreground and
> background colors of the console.
Would I be better off using vgacon?

> 
> First, make sure that writing directly to the framebuffer memory displays
> something properly on your monitor.
> 
Yes, I've got the fbcon_logo working and the fb0 working with 
QT-embedded. The problem is that printk doesn't work in fb console only 
in serial console.

> Then make sure that your driver has a working xxxfb_setcolreg function()
> and that info->pseudo_palette is properly filled up.
> 
Are xxxfb_setcolreg function() and info->pseudo_palette necessary for 
FB_VISUAL_TRUECOLOR? I thought it's required for FB_VISUAL_PSEUDOCOLOR.

Terence.


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
