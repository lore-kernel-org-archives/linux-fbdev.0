From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: Warnings from matroxfb i2c driver
Date: Sat, 03 Mar 2007 22:31:22 -0800
Message-ID: <45EA67BA.1040603@vc.cvut.cz>
References: <200703022100.58028.hjk@linutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HNkFm-0000hq-9v for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 03 Mar 2007 22:31:30 -0800
Received: from mailgw.cvut.cz ([147.32.3.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HNkFk-0008GY-Tc
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 03 Mar 2007 22:31:30 -0800
In-Reply-To: <200703022100.58028.hjk@linutronix.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: hjk@linutronix.de
Cc: linux-fbdev-devel@lists.sourceforge.net

Hans-J=FCrgen Koch wrote:
> In my boot logs I find the following warnings:
> =

> matroxfb: Matrox G550 detected
> PInS memtype =3D 5
> matroxfb: MTRR's turned on
> matroxfb: 1280x1024x24bpp (virtual: 1280x4369)
> matroxfb: framebuffer at 0xD4000000, mapped to 0xf8880000, size 33554432
> Console: switching to colour frame buffer device 160x64
> fb0: MATROX frame buffer device
> matroxfb_crtc2: secondary head of fb0 was registered as fb1
> **WARNING** I2C adapter driver [DDC:fb0 #0] forgot to specify physical de=
vice; =

> fix it!
> **WARNING** I2C adapter driver [DDC:fb0 #1] forgot to specify physical de=
vice; =

> fix it!
> **WARNING** I2C adapter driver [MAVEN:fb0] forgot to specify physical dev=
ice; =

> fix it!
> =

> Kernel is a vanilla 2.6.20.1. Can somebody please explain this to me? Can=
 I =

> ignore these warnings?

Yes, they just warn you that in sysfs tree i2c buses for your monitors =

will appear under platform and not under your g550 device in device =

tree.  There is no functionality impact.

Problem is fixed in 2.6.21-rc1 and newer kernels.
								Petr



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
