From: =?iso-8859-1?q?Marc_Poulhi=E8s?= <marc.poulhies@epfl.ch>
Subject: Re: Fw: [Bugme-new] [Bug 4217] New: radeonfb makes system hang and
 LCD "burn"
Date: Thu, 17 Feb 2005 09:02:08 +0100
Message-ID: <87brajlim7.fsf@kataplop.net>
References: <20050215121555.54c63ed2.akpm@osdl.org>
	<1108502142.13394.2.camel@gaston> <87fyzxsdo7.fsf@kataplop.net>
	<1108504143.13376.14.camel@gaston> <87r7jggxc7.fsf@kataplop.net>
	<1108592133.5533.6.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1gbo-0002yS-FD
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 00:02:00 -0800
Received: from cernmx05.cern.ch ([137.138.166.161] helo=cernmxlb.cern.ch)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D1gbk-0000mi-IF
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 00:02:00 -0800
In-Reply-To: <1108592133.5533.6.camel@gaston> (Benjamin Herrenschmidt's
 message of "Thu, 17 Feb 2005 09:15:33 +1100")
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
Content-Type: text/plain; charset="iso-8859-1"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Wed, 2005-02-16 at 19:43 +0100, Marc Poulhi=E8s wrote:
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>>=20
>> > Try building radeonfb in the kernel and booting with
>> > radeonfb.default_dynclk=3D-1, let me know if that works. fbdev's in
>> > modules have always been sort-of dodgy....
>>=20
>> Ok, did that. Same result. The only thing displayed is the system
>> caret. I can see it moving left and right while the system boots and
>> "displays" the messages (X is working nicely).
>
> Well... looks like radeonfb is actually working ... You can try booting
> with radeonfb.noaccel=3D1 on your kernel command line and tell me what'=
s
> up ? I looks like your fbcon is having trouble actually. Not sure what'=
s
> up, I haven't had any report of that so far.

Same result as without (screen "burns").

Marc


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
