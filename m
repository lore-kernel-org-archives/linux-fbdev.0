From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: ToDo 4 2.6.16: Harden the framebuffer subsystem
Date: Thu, 05 Jan 2006 08:37:07 +0100
Message-ID: <43BCCCA3.2090009@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EuPfP-0008DV-Td
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Jan 2006 23:36:11 -0800
Received: from mailout08.sul.t-online.com ([194.25.134.20])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EuPfP-0004qb-Km
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Jan 2006 23:36:12 -0800
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

The framebuffer subsystem should survive loading a driver within xterm.
Does it? I don=B4t think so.

The framebuffer subsystem should ignore all requests from within X, e.g.=20
fbset,
setfont, etc run from xterm must not result in any screen distortions or=20
system
hangs.

A script running setfont, fbset, echo ? >=20
/sys/class/graphics/fb?/con_rotate, and
cat of data to the framebuffer continuously on a framebuffer vt must not=20
harm
X in the foreground.

Setfont operations executed from a program running on e.g. vt1 must=20
change the
context of that vt, not that of the current foreground vt.

Some small fixes for xpan and ypan scrolling.

Faster construction of the image data for unusual font dimensions.

Did I miss something?

Yes, at least a happy new year to all of you!

cu,
 Knut


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
