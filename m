From: James Simmons <jsimmons@infradead.org>
Subject: Re: vertical stripes under OpenFirmware and offb
Date: Wed, 2 Apr 2003 23:12:45 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304022311440.3919-100000@phoenix.infradead.org>
References: <20030328110528.GA2403@gajba.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 190qTv-00015q-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 02 Apr 2003 14:13:20 -0800
In-Reply-To: <20030328110528.GA2403@gajba.net>
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
To: Boris Bezlaj <boris@gajba.net>
Cc: linux-fbdev-devel@lists.sourceforge.net


> Hello,
> 
> could anyone explain what kind of misconfiguration of framebuffer in OpenFirmware
> or in general would cause the vertical stripes effect? White stripes, width about the
> same as the width of characters and some garbage pixels between lines on black background.
> If the white stripes would stick together, the screen with letters would look in order.

Which kernel are you using? What is configuration?
 
> AFAIK, OF doesn't initialize the video card (IMS TT 128mb8) and i get the same under
> offb driver(unless i use the hacked version of imsttfb).
> 
> In what should i look into to fix that? I have the documentation for TVP3030 ramdac.

A IMS card user. Could you try out the imsttfb driver as well. I liek to 
know how well it works in 2.5.X.




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
