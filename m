From: James Simmons <jsimmons@infradead.org>
Subject: Re: clipping
Date: Thu, 9 Jan 2003 21:09:20 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301092108100.5660-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0301081053400.21171-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Wjw9-0001dn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 09 Jan 2003 13:10:02 -0800
In-Reply-To: <Pine.GSO.4.21.0301081053400.21171-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> > > What happens if you resize the VT to such a large size that columns*fontwidth >
> > > xres_virtual or rows*fontheight > yres_virtual? I guess clipping prevents a
> > > crash there?
> > 
> > Correct. Actually fbcon_resize checks to make sure the user doesn't do 
> > something stupid like this. So we might not needed. Hm.
> 
> And what if you use fbset to reduce the resolution below what's needed to
> accomodate the current console size?

I haven't fixed that issue yet. One the last close of /dev/fb the tty 
should be set back to its original state before /dev/fb was first open.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
