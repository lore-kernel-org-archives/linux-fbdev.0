From: biatx@portugalmail.com
Subject: Re: Issues with radeonfb (new) in widescreen displays
Date: Wed, 23 Jun 2004 19:16:14 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1088014574.40d9c8eee32ad@webmail.portugalmail.pt>
References: <1087949171.40d8c97373b9e@webmail.portugalmail.pt> <200406230904.20399.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdCjA-0003u0-1e
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 11:44:08 -0700
Received: from galadriel.portugalmail.pt ([195.245.179.73])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BdCj9-0001YV-IK
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 11:44:07 -0700
In-Reply-To: <200406230904.20399.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: "adaplas@pol.net" <adaplas@pol.net>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

When I run "stty -F /dev/tty7 cols 80 rows 30" the problem seems gone and
radeonfb acts perfect...hope you can fix it definitively then.

Thank you a lot

Carlos Silva


"Antonino A. Daplas" <adaplas@hotpop.com> wrote:

 A workaround which may or may not work is to set the tty where X is loca=
ted
 to a different size as compared to the tty's where your console is mappe=
d.
=20
 So if X is in /dev/tty7, you can do something like this:
=20
 stty -F /dev/tty7 cols 80 rows 30
=20
 (Use the latest BK or mm release.  stty will fail in 2.6.7)
=20
 The above will set tty7 to 640x480.  This way, when you switch to any of=
=20
 your consoles (assuming they are not in 640x480), the framebuffer consol=
e
 will "reinitialize" the hardware.=20
=20
 A more definitive fix is in the works.
=20
 Tony



__________________________________________________________
Continua a preferir gastar mais? Adira =E0 liga=E7=E3o Portugalmail.
http://acesso.portugalmail.pt/compare


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
