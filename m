From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: EDID through sysfs
Date: Mon, 18 Aug 2003 02:36:50 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030818023650.B16366@sci.fi>
References: <20030817144528.GA843@dreamland.darkstar.lan> <20030817173407.16010.qmail@web14907.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19oX1c-0002wk-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 17 Aug 2003 16:33:28 -0700
Received: from simpukka.saunalahti.fi (simpukka.saunalahti.fi [195.74.0.20])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 0A039247A3B
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 18 Aug 2003 02:33:26 +0300 (EEST)
In-Reply-To: <20030817173407.16010.qmail@web14907.mail.yahoo.com>; from jonsmirl@yahoo.com on Sun, Aug 17, 2003 at 10:34:07AM -0700
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
To: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sun, Aug 17, 2003 at 10:34:07AM -0700, Jon Smirl wrote:
> Does anyone know how other vendors handle the EDID/DDC
> info? Do other cards use I2C?

DDC2 uses I2C. There's aready a module that reads EDID via DDC2 in
lm_sensors. It does require a working i2c adapter driver for the graphics
card. matroxfb has the i2c driver included and lm_sensors has a driver fo=
r
voodoo3. Not sure about other cards but maybe that katos driver has
something for ATI cards...

In DDC1 mode the monitor transmits the EDID continuously with vsync actin=
g
as the clock. I don't think that any driver supports DDC1.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
