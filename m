From: =?iso-8859-1?q?alain=20volmat?= <avolmat@yahoo.fr>
Subject: Framebuffer with banked memory
Date: Wed, 30 Oct 2002 11:49:22 +0100 (CET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021030104922.6612.qmail@web14206.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14206.mail.yahoo.com ([216.136.173.70])
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 186qPa-0003d0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Oct 2002 02:49:22 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

I've been searching on the mailing list concerning the
case of writing a framebuffer for a video card which
DOESN'T have linear video memory. Actually I didn't
found any reply to my question.
(well this might means that there is no solution to my
problem .. but in that case I would like
confirmation).

As I said the video card I am now writing a
framebuffer for, doesn't have linear memory, which
means that I can only access a small part of the
memory at a time and then set offset registers in
order to access another part of the memory.

I would like to know if there is such case in current
framebuffer drivers ?? If so, what is the common
solution to do that ??

In fact the problem remains in the case of mmap (which
is the most common ;( of course), since the memory
seams to be accessed directly by pointer, there might
be no wait to detect if we need to set or not an
offset. In case of fb_read fb_write, it is possible to
do that before the actual write at the end (even if it
is not sooo beautiful ... ).

Anyway, it would be very helpful to me if I could get
an answer to this question.
Thanks by advance.

Alain Volmat

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en fran=E7ais !
Yahoo! Mail : http://fr.mail.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future=20
of Java(TM) technology. Join the Java Community=20
Process(SM) (JCP(SM)) program now.=20
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
