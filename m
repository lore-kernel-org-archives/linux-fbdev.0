From: Ondrej Zajicek <santiago@mail.cz>
Subject: Two bugs in fbcon?
Date: Tue, 16 May 2006 16:07:43 +0200
Message-ID: <20060516140743.GA11762@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fg0DI-0003Y2-Ol
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 May 2006 07:07:52 -0700
Received: from smtp1.kolej.mff.cuni.cz ([195.113.24.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Fg0DG-0005YJ-Vb
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 May 2006 07:07:52 -0700
Received: from localhost.localdomain (feanorr.kolej.mff.cuni.cz [195.113.26.209])
	by smtp1.kolej.mff.cuni.cz (8.13.1/8.13.1) with ESMTP id k4GE7j8f060214
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 16 May 2006 16:07:46 +0200 (CEST)
	(envelope-from zajio1am@artax.karlin.mff.cuni.cz)
Received: from santiago by localhost.localdomain with local (Exim 4.50)
	id 1Fg0D9-0003Tc-4g
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 May 2006 16:07:43 +0200
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

(i resent this email as previous one seems to be lost, so i am sorry
in case you get both ones)

Hello

I found that in  kernel 2.6.16.16 is some very strange behavior in fbcon.
I added some printks to some functions in fbcon and i found this:

I am on vt0, i have active vt0-vt3. When i modprobe fbcon (having fbdev
driver inserted before), functions fbcon.c/fbcon_init() and
fbcon.c/updatescrollmode() are called for each active vt.

Order is:
fbcon_init(vt0)
updatescrollmode(vt0)
updatescrollmode(vt1)
fbcon_init(vt1)
updatescrollmode(vt2)
fbcon_init(vt2)
updatescrollmode(vt3)
fbcon_init(vt3)

for vt1-vt3 updatescrollmode is called before fbcon_init which caused that
associated struct display::vrows value is computed (in updatescrollmode()
- fbcon.c:1970) from old vc->vc_rows (which is updated in fbcon_init()).

Now second strangeness - I am still on vt0 (immediately after modprobe
fbcon), but during calls to bitblit.c/bit_cursor() display structure
associated with vt3 is used (in bitblit.c:244 - ops->p). Combined with
previous strangeness (bad vrows values in vt1-vt3) i get cursor visible
on bad row.

When i switch to another vt or switch resolution, then this is corrected
(next calls to bitblit.c/bit_cursor() are using correct display
structure).

I don't understand fbcon enough to correct this problem (and be sure not to
make some other :-)).


-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
