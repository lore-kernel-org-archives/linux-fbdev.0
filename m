From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: 2.5 offb breakage
Date: Wed, 31 Jul 2002 14:49:05 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020731124905.12781@192.168.4.1>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [217.167.51.129] (helo=zion.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Zsuh-0005lY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 31 Jul 2002 05:49:15 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@transvirtual.com>, linux-fbdev-devel@lists.sourceforge.net

Hi !

I've investigated a bit why offb dies on boot with current 2.5.

It appears that dispsw is never set. You removed the code setting
it for the various bit depth. It seems the gen_set_disp() call
is supposed to do that instead.

However, gen_set_disp() only does it for var.bits_per_pixel == 24,
not for the other bit depths. In my case, offb boots at 8bpp, thus
dispsw is never set, causing fbcon_setup to die when trying to
call set_font(). That is without the accel in config. If I enable
accel support, then it dies later, in cfbimgblt, apparently due
to cfb_imageblit() beeing called with a NULL argument.

What is the correct fix ? Changing back offb to set dispsw or 
changing gen_set_disp() to set dispsw for all bit depth ?

Also, when code in fbcon_accel.c is calling things like
cfb_imageblit, it uses the "fb_info" field of structure
struct display. Where is this supposed to be initialized ?
It doesn't seem it's done in the drivers themselves (surely
not in offb).

Regards,
Ben.





-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
