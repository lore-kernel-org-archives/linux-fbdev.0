From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: [PATCH] 0/3 Add I2C/DDC support to radeonfb (resend)
Date: Mon, 25 Aug 2003 11:40:32 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030825094032.GA3327@iliana>
References: <20030822170905.GA5757@dreamland.darkstar.lan> <1061595832.1259.41.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp8.wanadoo.fr ([193.252.22.30] helo=mwinf0104.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19rDq5-00074y-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 25 Aug 2003 02:40:41 -0700
Content-Disposition: inline
In-Reply-To: <1061595832.1259.41.camel@thor.holligenstrasse29.lan>
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
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: kronos@kronoz.cjb.net, linux-fbdev-devel@lists.sourceforge.net

On Sat, Aug 23, 2003 at 01:43:53AM +0200, Michel D=E4nzer wrote:
> On Fri, 2003-08-22 at 19:09, Kronos wrote:=20
> >=20
> > i2c  bus  is registered  in  radeonfb_pci_register  and unregistered  in
> > radeonfb_pci_unregister. I'm a  bit concerned about XFree  that uses the
> > same bus...
>=20
> If there was an interface to userspace, the X driver could use that?
>=20
>=20
> BTW, regarding the EDID discussion, I'm not sure that a list of modes
> will cut it - e.g., the EDID of the panel in this TiBook only contains
> the native mode, but the chip can scale up pretty much any lower
> resolution.

Which is a good thing, compared to my sony SDM-X52, which in digital
mode only supports the native resolution, but the EDID erroneously
reports the mode supported by the digital connection in both case.

The EDID should report only the supported (native) mode, and the chip,
knowing what it can scale or not, should handle the other cases, no ?

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
