From: James Simmons <jsimmons@infradead.org>
Subject: Re: hw cursor is corrupted on Mach64
Date: Tue, 6 Jan 2004 17:15:15 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401061709440.18404-100000@phoenix.infradead.org>
References: <200311211945.30242.alex.kern@gmx.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdunZ-0004Cd-Jf
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 09:15:21 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AdunX-0006kj-K7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 09:15:20 -0800
In-Reply-To: <200311211945.30242.alex.kern@gmx.de>
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
To: Alexander Kern <alex.kern@gmx.de>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>


> does know anybody, what is mask layout in 
> 
> void aty_set_cursor_shape(struct fb_info *info, u8 *dst, u8 *src, unsigned int 
> width)
> 
> I think, here is a corrupted mask! First scanlines are
> FF FF <- seems to be correct, but the rest A5 A5 A5 A5...
> And is it top - bottom or bottom - top ?

That is correct. The cursor data area (what do you call it?) is 2 bits in 
size. The 2 bits are 

00    	Background color
01	Transparent.
10	Forground color. 
11	??

I can't remember off the top of my head.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
