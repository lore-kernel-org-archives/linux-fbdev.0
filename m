From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: [PATCH] Remove voodoo code from i2c
Date: Fri, 5 Mar 2004 20:02:53 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040306040253.30871.qmail@web14913.mail.yahoo.com>
References: <1078544564.6327.146.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AzTG2-0003KR-Rd
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Mar 2004 20:17:50 -0800
Received: from web14913.mail.yahoo.com ([216.136.225.240])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AzT1Z-0004an-QU
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Mar 2004 20:02:53 -0800
In-Reply-To: <1078544564.6327.146.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kronos <kronos@kronoz.cjb.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

--- Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Sat, 2004-03-06 at 13:10, Jon Smirl wrote:
> > Can this be written as a generic i2c probe function by calling i2c chan=
el
> > functions instead of directly calling radeon_gpio_setscl, etc? The i2c
> chanel
> > functions will then in turn call radeon_gpio_setscl, etc.
>=20
> Why ? we aren't doing normal i2c big banging here, just hacking
> around.

If I understand correctly, this code is needed to enable DDC on older monit=
ors.=20
If this is the case it is a generic problem and it needs to be corrected in=
 all
of the framebuffer drivers. Correcting it in all of the drivers is easier i=
f the
code is written in the generic i2c form.

Also, how do we know this is working? Nobody can come up with one of the
monitors that needs this or even a spec describing it.

The discussion about this got started around a port of 2.4 ddcmon (i2c devi=
ce
driver like eeprom) to 2.6 and sysfs. The code in the radeon driver is not =
in
ddcmon and the question is, should it be added? If it should be added it ne=
eds
to be converted to the i2c generic form, not the radeon specific one.


=3D=3D=3D=3D=3D
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! Search - Find what you=92re looking for faster
http://search.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dclick
