From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: RFC: bitmap line alignment
Date: Fri, 25 Nov 2005 13:16:35 +0100
Message-ID: <438700A3.3070503@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EfcVN-0003qI-KB
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Nov 2005 04:16:41 -0800
Received: from mailout01.sul.t-online.com ([194.25.134.80])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EfcVM-0006uT-7U
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Nov 2005 04:16:41 -0800
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

Hi everybody

I learned the hard way that image->width*image->height is not equal to th=
e
number of bits consumed by the image bitmap. Every single line of bits is
aligned to a byte boundary.

Wouldn=B4t it be much more efficient to align every line to an u32 bounda=
ry?
Despite the obvious advantages of aligned cpu access to large arrays it
would also help to simplify the code for at least the cyberblade=20
acceleration
engine.

The cyberblade always requires 32 bit quantities, so if the width of the=20
image
is eg. 33, I have to feed _two_ u32 to it for every pixel line. Is the=20
same true
for other acceleration engines?

I have not read the code of most of the framebuffer drivers, but I know=20
that
a lot of them do not use accelerated imageblits. Those that do provide=20
their own
functions would need to be adapted, as well as the cfb_imageblit=20
function ...

Comments, please.

cu,
 Knut


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
