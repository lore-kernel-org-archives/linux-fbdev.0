From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] atyfb (2.6): Memory type correction
Date: Fri, 7 May 2004 14:37:18 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040507113718.GA21174@sci.fi>
References: <20040507021126.GA11648@sci.fi> <Pine.GSO.4.58.0405071035410.28787@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BM3fO-0001Ar-DU
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 May 2004 04:37:22 -0700
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BM3fN-0006yF-LB
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 May 2004 04:37:21 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id AD4C311413DB
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri,  7 May 2004 14:37:18 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0405071035410.28787@waterleaf.sonytel.be>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, May 07, 2004 at 10:36:50AM +0200, Geert Uytterhoeven wrote:
> On Fri, 7 May 2004, Ville [iso-8859-1] Syrj=E4l=E4 wrote:
> > This patch changes the memory type message to match reality. This agr=
ees
> > with both my hardware and the Mobility register specs.
>=20
> I took the values from the RAGE II+ manual. So ATI recycled the WRAM va=
lue for
> Mobility? Unless they never actually made boards with WRAM.

My Rage Pro manual lists WRAM in CONFIG_STAT2.CFG_MEM_TYPEb. And that's=20
the only place where WRAM in mentioned as a valid memory type in my=20
manuals. Also the values of CFG_MEM_TYPEb look like the xor of=20
CONFIG_STAT0.CFG_MEM_TYPE except that WRAM is CFG_MEM_TYPEb=3D001 and=20
CFG_MEM_TYPE=3D110 is listed as a reserved value.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
