From: Jimmy Jazz <Jimmy.Jazz@gmx.net>
Subject: Re: radeonfb doesn't work with an ati X800	pcie
 card
Date: Fri, 13 Apr 2007 11:04:33 +0200
Message-ID: <461F47A1.5030606@gmx.net>
References: <46093D22.3090401@gmx.net> <461BD18E.5020706@gmx.net>	
	<461CD1F7.40004@gmx.net>
	<1176329514.8061.106.camel@localhost.localdomain>
Reply-To: Jimmy.Jazz@gmx.net, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HcHhy-0007K0-Hm for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Apr 2007 02:04:42 -0700
Received: from ip-62-241-114-101.evc.net ([62.241.114.101]
	helo=snowman.cryosphere.shacknet.nu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HcHhx-0003pW-RU
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Apr 2007 02:04:42 -0700
In-Reply-To: <1176329514.8061.106.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Benjamin Herrenschmidt a =E9crit :
> On Wed, 2007-04-11 at 14:17 +0200, Jimmy Jazz wrote:
>> Hello,
>>
>> i sent it without care and i forgot to add some diff files you will have =

>> to apply to radeonfb.h, ati_ids.h and radeon_base.c with both =

>> radeon_accel.c and radeon_monitor.c patches. Otherwise, you won't be =

>> able to compile the kernel anymore. Sorry for the inconvenient.
>>
>> Thank you all of you who contributed to these patches, the initiator of =

>> the radeonfb driver and of course the Xorg team who made ATI cards =

>> compatible with the xorg server.
> =

> There are already patches from Solomon for Atom BIOSes.
> =

> I admit that I never found the time to fully cleanup, split, test,
> etc... those along with other fixes I have in my queue. I could use a
> co-maintainer for radeonfb...
> =

> Ben.

Hello  Ben,

I would be happy to help you to improve ATI framebuffer driver but
really i have few knowlegdes about videocards. I followed the logic of
the program and compared it to the xorg version. Besides, it is sad that
xorg and kernel teams didn't follow the same code writing conventions.
Also, i tried to stay as near as possible with the original kernel
version without increasing the size of the binary code. Moreover, i'm a
bit lost about the notion of connectors and how they share s-video, dvi
and vga and why we need to invert them sometimes :). Really, it is
hardly explained and there is too much exceptions thru the source code
that make it difficult to understand what is a dirty hack and what is
not. Perhaps, i could bypass many difficulties just because my bios card
is "well programmed".


Jj

PS: I don't know if tables are used exclusively by laptops or if they
have atom bios too, so i didn't try to include code about it.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
