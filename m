From: Terence Soh <gopher@singnet.com.sg>
Subject: Re: printk on framebuffer console
Date: Wed, 31 May 2006 19:32:51 +0800
Message-ID: <447D7EE3.1090600@singnet.com.sg>
References: <447C03C6.3000805@singnet.com.sg> <447C37F5.8000008@gmail.com> <447CE73C.2060807@singnet.com.sg> <447CE95C.2080603@gmail.com> <447CF5BF.5080507@singnet.com.sg> <447D189C.1010100@gmail.com> <447D5134.1090502@singnet.com.sg> <447D79E8.3090102@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlOxY-0000rg-VP
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 May 2006 04:33:56 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FlOxZ-0001qz-10
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 May 2006 04:33:57 -0700
Received: from smtp18.singnet.com.sg ([165.21.6.38])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FlOxX-0002yb-Co
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 May 2006 04:33:57 -0700
In-Reply-To: <447D79E8.3090102@gmail.com>
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

> The simplest solution is to write a utility that opens /dev/tty0
> for example, then do an ioctl,
> 
> ioctl(fd, KDSETMODE, KD_GRAPHICS);
> 
> where fd is the file descriptor of /dev/tty0 for instance.
> 
> To get back your console, do this:
> 
> ioctl(fd, KDSETMODE, KD_TEXT);
Tony,

Thanks for your help!

Terence


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
