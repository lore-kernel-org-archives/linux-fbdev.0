From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: printk on framebuffer console
Date: Wed, 31 May 2006 12:16:28 +0800
Message-ID: <447D189C.1010100@gmail.com>
References: <447C03C6.3000805@singnet.com.sg> <447C37F5.8000008@gmail.com> <447CE73C.2060807@singnet.com.sg> <447CE95C.2080603@gmail.com> <447CF5BF.5080507@singnet.com.sg>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlI8R-0006GW-TW
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 21:16:43 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FlI8R-0006NN-SL
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 21:16:43 -0700
Received: from wx-out-0102.google.com ([66.249.82.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FlI8R-0006nW-AR
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 21:16:43 -0700
Received: by wx-out-0102.google.com with SMTP id t14so419102wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 30 May 2006 21:16:41 -0700 (PDT)
In-Reply-To: <447CF5BF.5080507@singnet.com.sg>
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
To: Terence Soh <gopher@singnet.com.sg>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Terence Soh wrote:
>>> Are xxxfb_setcolreg function() and info->pseudo_palette necessary for
>>> FB_VISUAL_TRUECOLOR? I thought it's required for FB_VISUAL_PSEUDOCOLOR.
>>>
>>
>>
>> Other way around, the info->pseudo_palette is needed for truecolor and
>> directcolor.  So fill this array properly, and you should be good to go.
>> Look at any driver (ie vesafb.c) on how it's done.
>>
> Thanks Tony,
> 
> Turned out that I was missing the xxxfb_setcolreg function() and
> info->pseudo_palette. Once that's done, the console is appearing on the
> framebuffer.
> 
> Another question. The console only prints starting from the scripts in
> /etc/init.d/rcS , the printk messages from the various drivers are
> missing. My kernel command line is "console=ttyS0 root=/dev/mtdblock3
> rootfstype=jffs2". Is there any reason why?

Remove the console=ttyS0 from your boot parameter (or change it to tty0)
and the system messages should go to the framebuffer console.

Tony


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
