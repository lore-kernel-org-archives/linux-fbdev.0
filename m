From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: radeonfb on pegasos powerpc motherboard and X endianess problem
Date: Tue, 10 Jun 2003 12:45:58 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030610104558.GA4650@iliana>
References: <20030604145423.GA22876@iliana> <1054799986.701.20.camel@gaston> <20030610095442.GA3980@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp8.wanadoo.fr ([193.252.22.30] helo=mwinf0102.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Pgdj-0004el-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 10 Jun 2003 03:46:07 -0700
Content-Disposition: inline
In-Reply-To: <20030610095442.GA3980@iliana>
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
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, Jun 10, 2003 at 11:54:42AM +0200, Sven Luther wrote:
> On Thu, Jun 05, 2003 at 09:59:47AM +0200, Benjamin Herrenschmidt wrote:
> > On Wed, 2003-06-04 at 16:54, Sven Luther wrote:
> > > Hello,
> > >=20
> > > I finally have a working pegasos motherboard as well as a working ker=
nel
> > > with a 1.6 radeonfb. I have also installed Daniel Stone's X 4.3.0
> > > debian/sid packages, and notice the following :
> > >=20
> > >   1) radeonfb works fine in 8bpp and 32bpp but depth 15 and 16 only g=
ive
> > >   me some very dark grey.
> >=20
> > Can you try my devel tree version ?
> >=20
> > (rsync.penguinppc.org::benh-devel)
>=20
> Nope, it did fail with :
>=20
> radeonfb.c: Dans la fonction =AB radeonfb_pci_register =BB:
> radeonfb.c:1106: =AB FP2_GEN_CNTL =BB non d=E9clar=E9 (premi=E8re utilisa=
tion dans cette fonction)
> radeonfb.c:1106: (Chaque identificateur non d=E9clar=E9 est rapport=E9 un=
e seule fois
> radeonfb.c:1106: pour chaque fonction dans laquelle il appara=EEt.)
> radeonfb.c:1108: =AB TMDS_CNTL =BB non d=E9clar=E9 (premi=E8re utilisatio=
n dans cette fonction)
> radeonfb.c:1110: =AB DAC_CNTL2 =BB non d=E9clar=E9 (premi=E8re utilisatio=
n dans cette fonction)
> radeonfb.c: Dans la fonction =AB radeon_engine_init =BB:
> radeonfb.c:1893: =AB DST_PITCH_OFFSET =BB non d=E9clar=E9 (premi=E8re uti=
lisation dans cette fonction)
> radeonfb.c: Dans la fonction =AB radeon_setcolreg =BB:
> radeonfb.c:2794: =AB DAC_CNTL2 =BB non d=E9clar=E9 (premi=E8re utilisatio=
n dans cette fonction)
> radeonfb.c:2795: =AB DAC2_PALETTE_ACCESS_CNTL =BB non d=E9clar=E9 (premi=
=E8re utilisation dans cette fonction)
> radeonfb.c: Dans la fonction =AB radeon_load_video_mode =BB:
> radeonfb.c:3051: =AB NONSURF_AP1_SWP_16BPP =BB non d=E9clar=E9 (premi=E8r=
e utilisation dans cette fonction)
> radeonfb.c:3056: =AB NONSURF_AP1_SWP_32BPP =BB non d=E9clar=E9 (premi=E8r=
e utilisation dans cette fonction)
> radeonfb.c:3216: =AB TMDS_ICHCSEL =BB non d=E9clar=E9 (premi=E8re utilisa=
tion dans cette fonction)
>=20
> Altough i am not entirely sure which rsync tree i used, will check again
> to make sure.

No, it was not the right tree, now it builds, but with the following
warning :

gcc-3.2 -D__KERNEL__
-I/home/luther/pegasos/2.4.18-rc4/linuxpegasos/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common
-I/home/luther/pegasos/2.4.18-rc4/linuxpegasos/arch/ppc -fsigned-char
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
-DKBUILD_BASENAME=3Dradeonfb  -c -o radeonfb.o radeonfb.c
radeonfb.c:859: AVERTISSEMENT: =AB OUTMC =BB d=E9clar=E9 =ABstatic =BB mais=
 n'a jamais =E9t=E9 d=E9fiie
radeonfb.c:860: AVERTISSEMENT: =AB INMC =BB d=E9clar=E9 =ABstatic =BB mais =
n'a jamais =E9t=E9 d=E9fiie
radeonfb.c:861: AVERTISSEMENT: =AB radeon_pm_disable_dynamic_mode =BB d=E9c=
lar=E9 =ABstatic =BB mais n'a jamais =E9t=E9 d=E9fiie
radeonfb.c:862: AVERTISSEMENT: =AB radeon_pm_enable_dynamic_mode =BB d=E9cl=
ar=E9 =ABstatic =BB mais n'a jamais =E9t=E9 d=E9fiie
radeonfb.c:863: AVERTISSEMENT: =AB radeon_pm_yclk_mclk_sync =BB d=E9clar=E9=
 =ABstatic =BB mais n'a jamais =E9t=E9 d=E9fiie
radeonfb.c:864: AVERTISSEMENT: =AB radeon_pm_program_mode_reg =BB d=E9clar=
=E9 =ABstatic =BB mais n'a jamais =E9t=E9 d=E9fiie
radeonfb.c:865: AVERTISSEMENT: =AB radeon_pm_enable_dll =BB d=E9clar=E9 =AB=
static =BB mais n'a jamais =E9t=E9 d=E9fiie
radeonfb.c:866: AVERTISSEMENT: =AB radeon_pm_full_reset_sdram =BB d=E9clar=
=E9 =ABstatic =BB mais n'a jamais =E9t=E9 d=E9fiie

I suppose this is either harmless or due to the pegasos patch disabling
config_all_ppc or something such, will try it out, and look at it more
in detail this WE.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
