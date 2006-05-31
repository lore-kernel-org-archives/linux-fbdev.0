From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: printk on framebuffer console
Date: Wed, 31 May 2006 08:54:52 +0800
Message-ID: <447CE95C.2080603@gmail.com>
References: <447C03C6.3000805@singnet.com.sg> <447C37F5.8000008@gmail.com> <447CE73C.2060807@singnet.com.sg>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlEzH-0007N9-BH
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 17:55:03 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FlEzG-0006CB-Gm
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 17:55:02 -0700
Received: from wx-out-0102.google.com ([66.249.82.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FlEzE-000881-SV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 30 May 2006 17:55:02 -0700
Received: by wx-out-0102.google.com with SMTP id t14so400439wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 30 May 2006 17:54:59 -0700 (PDT)
In-Reply-To: <447CE73C.2060807@singnet.com.sg>
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
>> You're better off sending this to linux-fbdev-devel, so I'm adding
>> this to the CC list.
> Thanks for the tip!
> 
>>
>> Yes, the monochrome bitmap are expanded to the current foreground and
>> background colors of the console.
> Would I be better off using vgacon?

Well, depends on what you want.  If you just want pure text, then
vgacon should suit your needs just fine.

> 
>>
>> First, make sure that writing directly to the framebuffer memory displays
>> something properly on your monitor.
>>
> Yes, I've got the fbcon_logo working and the fb0 working with
> QT-embedded. The problem is that printk doesn't work in fb console only
> in serial console.

If you can display the logo, then you're very nearly done.

> 
>> Then make sure that your driver has a working xxxfb_setcolreg function()
>> and that info->pseudo_palette is properly filled up.
>>
> Are xxxfb_setcolreg function() and info->pseudo_palette necessary for
> FB_VISUAL_TRUECOLOR? I thought it's required for FB_VISUAL_PSEUDOCOLOR.
> 

Other way around, the info->pseudo_palette is needed for truecolor and
directcolor.  So fill this array properly, and you should be good to go.
Look at any driver (ie vesafb.c) on how it's done.

Tony 


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
