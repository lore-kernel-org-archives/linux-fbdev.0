From: John Zielinski <grim@undead.cc>
Subject: Re: Missing radeonfb_setup
Date: Wed, 12 Nov 2003 23:43:03 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FB30BD7.7070904@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AK9K2-0002U1-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Nov 2003 20:43:10 -0800
Received: from gw-undead3.tht.net ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AK9K2-0004lA-1C
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Nov 2003 20:43:10 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net

Changing monitor_layout and mode_option to fixed length arrays was 
causing problems for me.  Looks like it might have been because the 
arrays were uninitialized.  The following patch adds the radeonfb_setup 
function while leaving those variables as pointers:

http://www.undead.cc/linux/patch.radeon_setup

I didn't include the change to the default video mode as I'm still 
mucking around with that.  Also, I left the default video mode code as 
is as the changes in the update looked wrong.

Also, here's a patch to fix some compiler warnings.  Most were harmless 
but the one about xtal was indeed a bug.  Can someone let me know if I 
got the fix for that one right:

http://www.undead.cc/linux/patch.fixwarnings

I'm also having a cursor problem.  It makes the character it's over 
disappear when it flashes active.  So I have the character then the 
cursor then the character then the cursor, etc.  This is very 
distracting since it's the line cursor and not the block cursor.  How do 
I go about fixing this?

One more thing, which patch added the CONFIG_FB_RADEON_I2C menu choice?  
I had to add that one myself to get it?

John





-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
