From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: radeonfb on pegasos powerpc motherboard and X endianess problem
Date: Tue, 10 Jun 2003 11:54:42 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030610095442.GA3980@iliana>
References: <20030604145423.GA22876@iliana> <1054799986.701.20.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp8.wanadoo.fr ([193.252.22.30] helo=mwinf0104.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Pfq7-0003Xz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 10 Jun 2003 02:54:51 -0700
Content-Disposition: inline
In-Reply-To: <1054799986.701.20.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Jun 05, 2003 at 09:59:47AM +0200, Benjamin Herrenschmidt wrote:
> On Wed, 2003-06-04 at 16:54, Sven Luther wrote:
> > Hello,
> >=20
> > I finally have a working pegasos motherboard as well as a working kernel
> > with a 1.6 radeonfb. I have also installed Daniel Stone's X 4.3.0
> > debian/sid packages, and notice the following :
> >=20
> >   1) radeonfb works fine in 8bpp and 32bpp but depth 15 and 16 only give
> >   me some very dark grey.
>=20
> Can you try my devel tree version ?
>=20
> (rsync.penguinppc.org::benh-devel)

Nope, it did fail with :

radeonfb.c: Dans la fonction =AB radeonfb_pci_register =BB:
radeonfb.c:1106: =AB FP2_GEN_CNTL =BB non d=E9clar=E9 (premi=E8re utilisati=
on dans cette fonction)
radeonfb.c:1106: (Chaque identificateur non d=E9clar=E9 est rapport=E9 une =
seule fois
radeonfb.c:1106: pour chaque fonction dans laquelle il appara=EEt.)
radeonfb.c:1108: =AB TMDS_CNTL =BB non d=E9clar=E9 (premi=E8re utilisation =
dans cette fonction)
radeonfb.c:1110: =AB DAC_CNTL2 =BB non d=E9clar=E9 (premi=E8re utilisation =
dans cette fonction)
radeonfb.c: Dans la fonction =AB radeon_engine_init =BB:
radeonfb.c:1893: =AB DST_PITCH_OFFSET =BB non d=E9clar=E9 (premi=E8re utili=
sation dans cette fonction)
radeonfb.c: Dans la fonction =AB radeon_setcolreg =BB:
radeonfb.c:2794: =AB DAC_CNTL2 =BB non d=E9clar=E9 (premi=E8re utilisation =
dans cette fonction)
radeonfb.c:2795: =AB DAC2_PALETTE_ACCESS_CNTL =BB non d=E9clar=E9 (premi=E8=
re utilisation dans cette fonction)
radeonfb.c: Dans la fonction =AB radeon_load_video_mode =BB:
radeonfb.c:3051: =AB NONSURF_AP1_SWP_16BPP =BB non d=E9clar=E9 (premi=E8re =
utilisation dans cette fonction)
radeonfb.c:3056: =AB NONSURF_AP1_SWP_32BPP =BB non d=E9clar=E9 (premi=E8re =
utilisation dans cette fonction)
radeonfb.c:3216: =AB TMDS_ICHCSEL =BB non d=E9clar=E9 (premi=E8re utilisati=
on dans cette fonction)

Altough i am not entirely sure which rsync tree i used, will check again
to make sure.

(Still confused about all the ppc kernel trees ...)

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
