From: Mario Lang <mlang@delysid.org>
Subject: fbcon has a empty unimap after boot
Date: Fri, 12 Sep 2003 13:07:36 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <874qzip8nb.fsf@lexx.delysid.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xlmp-0003dg-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 04:08:23 -0700
Received: from chello080109223066.lancity.graz.surfer.at
	([80.109.223.66] helo=lexx.delysid.org ident=mail)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xlmo-00032K-HD
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 04:08:22 -0700
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
Cc: jsimmons@infradead.org, geert@linux-m68k.org

Hi.

I noticed that with 2.6.0 kernels, when using fbcon
(with the sisfb driver in my case, using a Sis630 card), the
ioctl GIO_UNIMAP returns a empty unimap.
This results in problems for BRLTTY[1], which relies
on a valid unimap to back-translate the font-positions of
/dev/vcsa to the actual characters used.

Further digging showed that this problems has probably gone
unnoticed because there is a special case in
drivers/char/consolemap.c:conv_uni_to_pc which returns -3 when
there is no unimap available.  This -3 return value
is caught in drivers/char/vt.c:do_con_write like this:

                        tc = conv_uni_to_pc(vc_cons[currcons].d, tc);
                        ...
                        } else if ( tc == -3 ) {
                                /* Bad hash table -- hope for the best */
                                tc = c;
                        }

This is why I think the uninitialized unimap did go
unnoticed, since this code will make things work for
standard iso-8859 type of charsets.

However, user space apps which rely on GIO_UNIMAP do not
work correctly, and in general, I think I18N should be broken
on fbcon currently.

I have a very crude patch which works for me here, but I
am not sure if this is the right way to fix this.
Anyway, it is attached.  Note that I am very new to
kernel hacking, so my analysis of the problem might be
bogus, but I do think I am on the right track...

--- linux-2.6.0-test4/drivers/video/console/fbcon.c.orig        2003-09-03 15:32:42.000000000 +0200
+++ linux-2.6.0-test4/drivers/video/console/fbcon.c     2003-09-03 15:27:09.000000000 +0200
@@ -695,6 +695,7 @@
                fb_display[unit].scrollmode = SCROLL_YNOMOVE;
        else
                fb_display[unit].scrollmode = SCROLL_YREDRAW;
+       con_set_default_unimap(unit);
        fbcon_set_display(vc, init, !init);
 }


[1] http://mielke.cc/brltty/

-- 
CYa,
  Mario | Debian Developer <URL:http://debian.org/>
        | Get my public key via finger mlang@db.debian.org
        | 1024D/7FC1A0854909BCCDBE6C102DDFFC022A6B113E44


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
