From: Dennis Munsie <dmunsie@cecropia.com>
Subject: Re: [PATCH 1/1] New Framebuffer for Intel based
	Macs [try #2] (fwd)
Date: Thu, 22 Jun 2006 08:43:30 -0400
Message-ID: <269AA200-402D-4D9B-93AC-773C44F1AF50@cecropia.com>
References: <Pine.LNX.4.62.0606221038280.23155@pademelon.sonytel.be>
	<9D874D8E-7EF1-4C29-98F2-AEDFD78C6676@cecropia.com>
	<449A7FDC.2030304@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtOtO-0005uf-9T for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 06:06:42 -0700
Received: from mail6.sea5.speakeasy.net ([69.17.117.8])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FtOZw-0000SP-TZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 05:46:38 -0700
Received: from lex098.cecropia.com (HELO [192.168.3.25])
	(dmunsie@cecropia.com@[63.138.212.98])
	(envelope-sender <dmunsie@cecropia.com>)
	by mail6.sea5.speakeasy.net (qmail-ldap-1.03) with RC4-SHA encrypted
	SMTP for <linux-fbdev-devel@lists.sourceforge.net>;
	22 Jun 2006 12:39:52 -0000
In-Reply-To: <449A7FDC.2030304@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A.Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

fair enough -- i had thought about it a little more on the way to  
work, and that makes sense.  But, once the native drivers work, it  
would probably be a good idea to make note someplace that the other  
drivers would provide better performance than this one.

btw -- the intelfb driver in it's current state might not work on the  
intel macs anyway.  The intelfb driver doesn't do well with anything  
but the analog output, and the MacBook and mini both have DVI ports.

another quick question regarding this driver -- is it only needed  
when a native EFI boot is done?  or does it also get used when Boot  
Camp is used?  I would think that Boot Camp would allow the VESA  
driver to work, since it's purpose is to make it look like the  
machine has a true x86 BIOS...

dennis

On Jun 22, 2006, at 7:32 AM, Antonino A. Daplas wrote:

> Dennis Munsie wrote:
>> Why is a new framebuffer driver required in this case?
>
> It is a platform driver, much like vga16fb and vesafb are for
> x86. They are backup drivers.
>
>> Why not use
>> the intelfb driver for the mini and the MacBook and an ati driver for
>> the iMac and the MacBook Pro?
>
> The same reason that people use vesafb because the chipset-specific
> driver either conflicts with X or does not work.
>
> Tony
>


All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
