From: James Simmons <jsimmons@infradead.org>
Subject: Re: [BK fbdev updates]
Date: Wed, 15 Jan 2003 22:02:37 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301152201490.23774-100000@phoenix.infradead.org>
References: <3E220526.4040802@macp.eti.br>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Yvcu-0005Ua-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Jan 2003 14:03:12 -0800
In-Reply-To: <3E220526.4040802@macp.eti.br>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcelo Pacheco <marcelo@macp.eti.br>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> I have 2 machines that are running 2.5.56 beatifully, except for fbcon 
> and ISDN.
> The laptop runs ATI radeon - when I attempt to boot with radeonfb+fbcon 
> statically linked it wraps the pixels as if the driver is using 1410 
> pixels per row while the hardware only has 1400

Can you try it with the latest code. I think fixes are in the standard 
tree for this.

> The desktop has a Vodoo 3500 AGP - when I attempt to boot with 
> 3dfxfb+fbcon statically it freezes early in the boot, probably right 
> when the fb stuff starts.

It will work now. A bug in the imagebliting code for the fonts.



-------------------------------------------------------
This SF.NET email is sponsored by: A Thawte Code Signing Certificate 
is essential in establishing user confidence by providing assurance of 
authenticity and code integrity. Download our Free Code Signing guide:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0028en
