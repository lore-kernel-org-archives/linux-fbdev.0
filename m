From: Bram Stolk <b.stolk@chello.nl>
Subject: tridentfb in 2.5.70 broken
Date: Sun, 8 Jun 2003 21:24:35 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030608212435.17118c5b.b.stolk@chello.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19PIDA-0005AW-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 09 Jun 2003 01:41:06 -0700
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h598eQpI024077
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 9 Jun 2003 10:40:26 +0200 (MEST)
ReSent-To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
ReSent-Message-ID: <Pine.GSO.4.21.0306091040220.1347@vervain.sonytel.be>
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
To: jani@iv.ro, geert@linux-m68k.org

Hi there,


tridentfb 0.7.8-NEWAPI, as shipping with linux-2.5.70 is broken.
in tridentfb_check_var(), the check for nativex should read:

        if (flatpanel && nativex && var->xres > nativex)

instead of:

	if (var->xres > nativex)

otherwise all modes are rejected on a non FP.

Also, the Documents/fb/ docs are out of date, with regard
to option passing.

And the comment in tridentfb.c
 * Parse user specified options (`video=trident:')
...is plain wrong.
Only 'video=tridentfb:' will work.

modedb.txt should include the 'tridentfb' target for video=
tridentfb.txt should be updated on how to pass parameters.

And last:
video=tridentfb:mode=800x600 does not work, as mode= is
not recognized. I think it should. Currently, you are forced to
skip the mode=, thus: video=tridentfb:800x600

  Regards,

     Bram Stolk



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
