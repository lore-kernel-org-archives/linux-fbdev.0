From: James Simmons <jsimmons@infradead.org>
Subject: Re: scrollmode, accel_flags, fbcon.c ...
Date: Mon, 29 Mar 2004 18:50:46 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403291824020.15706-100000@phoenix.infradead.org>
References: <Pine.GSO.4.58.0403281014010.364@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B80uV-0008MS-UV
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Mar 2004 09:50:55 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B80uT-0008AG-Qk
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Mar 2004 09:50:54 -0800
In-Reply-To: <Pine.GSO.4.58.0403281014010.364@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Eger <eger-dated-1080865620.ef4dea@theboonies.us>, Jakub Jelinek <jj@ultra.linux.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > But an fbdev that implements an accelerated copyarea ?
> >
> > I don't want such heuristics in fbcon, they are just asking for trouble,
> > I think we should redraw on non-accelerated and copy on accelerated,
> 
> You mean, if ywrap/ypan is not available/not possible (e.g. partial screen
> scrolls)? Yes, that makes sense.

Sounds like we need to update update_scrollmode. So what do we have so 
far. 

1. test for ywrap/ypan. This test should see if the screen is more than 
   two whole screens in size. 

2. Test if xxxfb_copyarea is accelerated. If it is set to YMOVE.

3. If xxxfb_copyare is not accelerated then redraw the screen.

If I'm missing anything let me know.

> Which means additional flags to fb_fix_screeninfo...

:-( I'm hoping we can develope some kind of nice logic. Often I seen 
a driver writer use the wrong flag.

> > One thing I don't like in the new fbcon is the way it deals with the
> > var structure anyway. I think it should have one var per VC.
> 
> I agree.

Why do we need a var for ever VC. The card is on one hardware state at 
all times. The only times we nned to be concern with changes is for 
setfont, resize and VC switching. These are not common occurs. If the 
fbcon layer can't get the data it needs from struct vc_data then the upper
console layer is broken.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
