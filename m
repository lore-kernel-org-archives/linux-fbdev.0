From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Another problem, seemingly coming f
Date: Wed, 16 Oct 2002 21:40:35 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021016214035.A29206@sci.fi>
References: <4C636B97ED1@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from kura.mail.jippii.net ([195.197.172.113])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181t5w-0000v7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Oct 2002 11:40:36 -0700
Received: from simpukka.saunalahti.fi (simpukka.saunalahti.fi [195.74.0.20])
	by kura.mail.jippii.net (Postfix) with ESMTP id 8AA7343A08
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Oct 2002 21:40:32 +0300 (EEST)
Received: (from syrjala@localhost) by simpukka.saunalahti.fi (8.8.5/8.8.3) id VAA29454 for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Oct 2002 21:40:35 +0300 (EET DST)
In-Reply-To: <4C636B97ED1@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Wed, Oct 16, 2002 at 04:25:20PM +0200
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
To: linux-fbdev-devel@lists.sourceforge.net

On Wed, Oct 16, 2002 at 04:25:20PM +0200, Petr Vandrovec wrote:
> On G450/G550 I use frequency specified in BIOS PINS. G400 (and older)=20
> historically used hardwired values in matroxfb, and because of I do not=20
> use them regulary anymore, I try to not touch their initialization code=20

Ok that clears it up. I have a G400.

> If you'll cook and test patch which will set system clocks on G400
> according to the value specified in the BIOS, or if you'll create
> patch which will add ioctl() or some other operation to set system
> PLL, I'll apply it without problem (if code is correct, changing
> system PLL is not trivial operation).

Maybe I'll try something if/when I have too much time on my hands.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
