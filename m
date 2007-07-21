From: "John Lumby" <johnlumby@hotmail.com>
Subject: typo errors in the modedb.c video mode tables
Date: Sat, 21 Jul 2007 18:59:29 -0400
Message-ID: <BAY137-F3235E7DB69C9967750E90DA3F50@phx.gbl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ICNvF-0007t2-Ov for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 21 Jul 2007 15:59:37 -0700
Received: from bay0-omc2-s40.bay0.hotmail.com ([65.54.246.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ICNvE-0003cc-UA
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 21 Jul 2007 15:59:37 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

I believe there are a few typos in the mode tables in modedb.c   -   in the 
current 2.6.22 :

  .  line 77
	/* 1152x864 @ 89 Hz interlaced, 44 kHz hsync */
	NULL, 69, 1152, 864, 15384, 96, 16, 110, 1, 216, 10,
should be
	/* 1152x864 @ 89 Hz interlaced, 44 kHz hsync */
	NULL, 89, 1152, 864, 15384, 96, 16, 110, 1, 216, 10,

. line 125

	/* 1400x1050 @ 60Hz, 63.9 kHz hsync */
	NULL, 68, 1400, 1050, 9259, 136, 40, 13, 1, 112, 3,
should be
	/* 1400x1050 @ 60Hz, 63.9 kHz hsync */
	NULL, 60, 1400, 1050, 9259, 136, 40, 13, 1, 112, 3,

. line 129
	/* 1400x1050 @ 75,107 Hz, 82,392 kHz +hsync +vsync*/
	NULL, 75, 1400, 1050, 9271, 120, 56, 13, 0, 112, 3,
is wrong somewhere but I don't know what should be changed

. line 258
	/* 1152x768, 60 Hz, PowerBook G4 Titanium I and II */
	NULL, 60, 1152, 768, 15386, 158, 26, 29, 3, 136, 6,
is wrong somewhere but I don't know what should be changed

. line 311
        /* 12 1024x768i-43 VESA */
	{ NULL, 53, 1024, 768, 22271, 56, 8, 41, 0, 176, 8,
should be
        /* 12 1024x768i-43 VESA */
	{ NULL, 43, 1024, 768, 22271, 56, 8, 41, 0, 176, 8,

. line 388
	/* 33 1920x1440-75 VESA */
	{ NULL, 60, 1920, 1440, 3367, 352, 144, 56, 1, 224, 3,
should be
	/* 33 1920x1440-75 VESA */
	{ NULL, 75, 1920, 1440, 3367, 352, 144, 56, 1, 224, 3,

In the cases where I've stated the correction, in every case it's the v_sync 
refresh rate which is wrong and it's pretty obvious as the preceding comment 
has the correct value.      In the other cases, I'm not sure but my 
calculations indicates the refresh is not consistent with the other values 
(but I could be wrong).

I also don't know what effect these errors are having - I found them from 
studying the code after I could not get my desired 1400x1050@60 for my 
supersavage framebuffer console.       One of the above entries is the one I 
want.    Is the refresh value in these tables used for matching modes?      
It seems so from my reading of fb_find_mode() in the same file.

John

_________________________________________________________________
Tell us your tech love story in the Summer Lovin Competition for your chance 
to win laptop loaded with Windows Vista, Office 2007 and Windows Live 
OneCare. 
http://www.microsoft.com/canada/home/contests/summerlovin/default.aspx


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
