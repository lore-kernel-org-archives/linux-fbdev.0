From: Sascha Wilde <wilde@sha-bang.de>
Subject: [bug][matroxfb] linux2.6.0-test6: garbled fb-console
Date: Sat, 4 Oct 2003 20:49:01 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031004184901.GA693@kenny>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A5rSm-0002cP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 04 Oct 2003 11:49:08 -0700
Received: from mail1.kontent.de ([81.88.34.36] ident=30)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A5rSk-0000Ed-29
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 04 Oct 2003 11:49:06 -0700
Received: from kenny.sha-bang.de (xdslb009.osnanet.de [212.95.100.9])
	by Mail1.KONTENT.De (Postfix) with ESMTP id 2B7EA1C5E11
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat,  4 Oct 2003 20:49:10 +0200 (CEST)
Received: from wilde by kenny.sha-bang.de with local (Kenny MUA v.0307044.20)
	ID 1A5rSf-0000Ce-Ah
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 04 Oct 2003 20:49:01 +0200
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hello,

I've just tested linux 2.6.0-test6 with fbdev and console on fb.
I'm using a Matrox G400 and noticed following problem:  after starting
X11 (_not_ using the fbdev but the xfree4.2 mga driver) when switching
back to the console the display is somewhat distorted:  when reching
the lowest line of the screen right to the text on the line a colorful
pattern of pixelnoise appears.

After switching back and forth from one vconsole to another the noise
disapears but returns when entering the next line...

This (mis)behavior continues even after quiting X11.

I tested both matrox-fb-drivers of 2.6.0-test6 and different
screen-resolutions but with no significant difference.


Hope this is the right place for this Bugreport.
Please CC me in your reply, for I'm not subscribed to this list.

cheers
-- 
Sascha Wilde : The sum of intelligence on earth is a constant; 
             : population is growing


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
