From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Add three new IOCTLs to FB API
Date: Tue, 23 Sep 2003 18:45:08 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030923184508.A24234@sci.fi>
References: <20030922052838.53671.qmail@web14913.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1pI0-0004El-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Sep 2003 08:41:20 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A1pHz-0003wL-4K
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Sep 2003 08:41:19 -0700
Received: from simpukka.saunalahti.fi (simpukka.saunalahti.fi [195.74.0.20])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 366F23CA788
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Sep 2003 18:41:16 +0300 (EEST)
In-Reply-To: <20030922052838.53671.qmail@web14913.mail.yahoo.com>; from jonsmirl@yahoo.com on Sun, Sep 21, 2003 at 10:28:38PM -0700
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

On Sun, Sep 21, 2003 at 10:28:38PM -0700, Jon Smirl wrote:
> I'd like to add three new IOCTLs to the FB API to help support standalo=
ne Mesa.
> The idea is to eliminate the need for config files. Xfree might even us=
e these
> in the future.
>=20
> 1) Get location of card that is associated with this fb device. It woul=
d return
> bus,dev,func of hardware. There may be more than one piece of the same =
hardware
> installed.
>=20
> 3) Get vendor and card PCI ID

I'd like to have these too. DirectFB needs to know if the chip is G400 or
G450/G550. Currently we just pick the first entry found in /proc/bus/pci
and hope it has the same chip type as the /dev/fb we're using.

> 2) Get 3D driver name. Return the name of the DRM driver that is associ=
ated
> with this fb device. For example aty128fb would return r128, radeonfb w=
ould
> return radeon. Empty string if there is none. There are eight DRM drive=
rs and
> 15 fb ones.

Why does this have to be in the kernel? You already have the PCI IDs so
you should be able to handle this in user space.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
