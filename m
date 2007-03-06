From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: Matrox G550, dual head, 1680x1050
Date: Tue, 06 Mar 2007 01:25:15 -0800
Message-ID: <45ED337B.6010209@vc.cvut.cz>
References: <200703021053.00955.hjk@linutronix.de>
	<200703042247.21590.hjk@linutronix.de>
	<45EBA3B6.3060701@vc.cvut.cz>
	<200703052102.31786.hjk@linutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOVvr-0004TR-0M for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 01:26:07 -0800
Received: from mailgw.cvut.cz ([147.32.3.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HOVvm-0006tp-Go
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 01:26:04 -0800
In-Reply-To: <200703052102.31786.hjk@linutronix.de>
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
Content-Type: text/plain; charset="iso-8859-1"
To: =?ISO-8859-15?Q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Cc: Tilman Sauerbeck <tilman@code-monkey.de>, linux-fbdev-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

Hans-J=FCrgen Koch wrote:
> Am Montag, 5. M=E4rz 2007 05:59 schrieb Petr Vandrovec:
> =

>> Can you try setting vxres for second head from 1680 to 1696, or 1728?
>> Maybe X look at vxres and not at framebuffer line length (what fbset -i
>> reports for line length?)
>>
> =

> Here are more details:
> =

> 1.) I boot my kernel (vanilla 2.6.20.1) with the following parameters:
> =

> video=3Dmatroxfb:outputs:120,pixclock:7380,xres:1680,yres:1050,upper:32,
>                lower:4,left:32,right:224,hslen:136,vslen:4,depth:32
> =

> This initializes the primary head correctly. The second head is probably =

> wrong, because the monitor's on screen message complains about a non-idea=
l =

> resolution.

Second head always starts in 640x480/32bpp.  You have to use fbset to =

switch it to different mode, so matroxfb works fine as far as I can tell.

> As you can see, the second monitor fell back to VGA resolution, but the l=
ogs =

> tell that X thinks it successfully switched to 1680x1050. The KDE control =

> center reports the same. The image on the second monitor is distorted.

Because X (mga driver) was programming hardware...

> 4.) I then issue the following command:
> =

> $ fbset -fb /dev/fb1 -g 1680 1050 1696 1050 32 -t 7380 224 32 32 4 136 4
> =

> With that, the image on the second monitor immediately becomes clear, and=
 I =

> have a fully working xinerama configuration then.

Yes, and this corrects X programming mistake.

> As far as I can see, fbset is the only way to initialize the second head =

> properly. Neither matroxfb nor mga do it correctly with 1680x1050.

Well, fbset =3D=3D matroxfb, so I do not quite understand your complaint.
							Petr


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
