From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux 2.6.16: Cursor trouble on Matrox Millenium II framebuffer
Date: Thu, 23 Mar 2006 23:15:03 +0000 (GMT)
Message-ID: <20060323231503.72390.qmail@web52906.mail.yahoo.com>
References: <4421F84B.2010801@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMZ1N-00023L-1Y
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 15:15:13 -0800
Received: from web52906.mail.yahoo.com ([206.190.49.16])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1FMZ1J-00016L-PW
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Mar 2006 15:15:12 -0800
In-Reply-To: <4421F84B.2010801@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, vandrove@vc.cvut.cz

--- "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> Someone reported a similar problem, with a different driver.  It seems =
to be related to
> an init script running kbd.
> Don't bother then, just check first if it's related to an rc script run=
ning kbd.

I do have this line in my rc.S script:

loadkeys uk < /dev/console > /dev/console

However, I need this line (don't I?).

Cheers,
Chris



	=09
___________________________________________________________=20
Does your mail provider give you FREE antivirus protection?=20
Get Yahoo! Mail http://uk.mail.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
that extends applications into web and mobile media. Attend the live webc=
ast
and join the prime developer group breaking into this new coding territor=
y!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
