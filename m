From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] 0/3 Add I2C/DDC support to
	radeonfb (resend)
Date: 23 Aug 2003 01:43:53 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1061595832.1259.41.camel@thor.holligenstrasse29.lan>
References: <20030822170905.GA5757@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [195.141.226.27] (helo=netline-mail1.netline.ch)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19qLeK-0008DF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 22 Aug 2003 16:48:57 -0700
In-Reply-To: <20030822170905.GA5757@dreamland.darkstar.lan>
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
To: kronos@kronoz.cjb.net
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, 2003-08-22 at 19:09, Kronos wrote:=20
>=20
> i2c  bus  is registered  in  radeonfb_pci_register  and unregistered  in
> radeonfb_pci_unregister. I'm a  bit concerned about XFree  that uses the
> same bus...

If there was an interface to userspace, the X driver could use that?


BTW, regarding the EDID discussion, I'm not sure that a list of modes
will cut it - e.g., the EDID of the panel in this TiBook only contains
the native mode, but the chip can scale up pretty much any lower
resolution.


--=20
Earthling Michel D=C3=A4nzer   \  Debian (powerpc), XFree86 and DRI develop=
er
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
