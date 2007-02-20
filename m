From: Aitor Garcia <carrierphasejitter@yahoo.com>
Subject: enquiry about 4 bpp frame buffer with nibbles
	swapped
Date: Tue, 20 Feb 2007 04:11:56 -0800 (PST)
Message-ID: <20070220121156.41538.qmail@web51601.mail.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJTqm-0006sX-Ow for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Feb 2007 04:12:04 -0800
Received: from web51601.mail.yahoo.com ([206.190.38.206])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HJTqk-0002c8-8F
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Feb 2007 04:12:04 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi all,

I am trying to design a 4 bpp FB driver for iMX1 using
imxfb.c code as 
an starting point.
The problem that I have found is that MX1 video memory
is organised as
follows:

b7 b6 b5 b4  --> pixel 0.
b3 b2 b1 b0  --> pixel 1.

The software that I'm using to display things (Qtopia
Core) assumes a 
different scheme of memory to pixel mapping:

b7 b6 b5 b4 ---> pixel 1.
b3 b2 b1 b0 ---> pixel 0.

The solution to overcome this problem is apparently
easy:

#define SWAP_NIBBLES(in,out) (out=((in&0xf)<<4) |
((in&0xf0)>>4) |\
                                  ((in&0xf00)<<4) |
((in&0xf000)>>4) |\
		                  ((in&0xf0000)<<4) |
((in&0xf00000)>>4) |\
		                  ((in&0xf000000)<<4) |
((in&0xf0000000)>>4))

But I do not know where to do it. 
Frame Buffer has 3 functions cfb_fillrect,
cfb_copyarea and cfb_imageblit which I thought were
the key to solve my problems but Qtopia Core does not
make use
of them.  
imxfb_map_video_memory function or fb_mmap, seem to be
good candidates but I do not know how to progress
further.

I would be very grateful if I could receive some kind
of help.

Best wishes,

Aitor


 
____________________________________________________________________________________
It's here! Your new message!  
Get new email alerts with the free Yahoo! Toolbar.
http://tools.search.yahoo.com/toolbar/features/mail/

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
