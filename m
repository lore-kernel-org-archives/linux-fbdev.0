From: Manousaridis Angelos <amanous@inaccessnetworks.com>
Subject: Re: FB device without console support
Date: Thu, 30 Oct 2003 13:36:12 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FA0F7AC.2000600@inaccessnetworks.com>
References: <Pine.GSO.4.21.0310301034440.15545-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFB68-0003Mx-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 03:36:16 -0800
Received: from node3.inaccessnetworks.com ([212.205.200.118] helo=inaccessnetworks.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AFB67-00052O-07
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Oct 2003 03:36:15 -0800
Received: from inaccessnetworks.com (firewall [212.205.200.117])
	by inaccessnetworks.com (8.12.1/8.12.1) with ESMTP id h9UBaCMJ021172
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 13:36:12 +0200
In-Reply-To: <Pine.GSO.4.21.0310301034440.15545-100000@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:
> On Thu, 30 Oct 2003, Manousaridis Angelos wrote:
 >
>>Is it possible with a 2.4.xx kernel?
>>Upgrading would be a nighmare fom me, I am targeting an embedded platform.
>  
> Disable CONFIG_VT_CONSOLE, and the console messages will no longer be printed
> to the frame buffer. You still have a console though, i.e. you can still print
> to /dev/ttyX if you want.
> 
> If you don't want to provide console drawing operations, just set
> display->dispsw to &dispsw_dummy.
> 
> Gr{oetje,eeting}s,

I found no dispsw_dummy, do you mean fbcon_dummy?

Thanks foy the reply, that seems to be the solution I was looking for.

--
Angelos Manousaridis



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
