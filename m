From: Sven LUTHER <luther@dpt-info.u-strasbg.fr>
Subject: Re: Re: board with broken vga ...
Date: Tue, 23 Jul 2002 16:35:01 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020723143501.GA5119@iliana>
References: <BA82E1E583C@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23] helo=mel-rto4.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17X0go-0002Wn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Jul 2002 07:31:02 -0700
Content-Disposition: inline
In-Reply-To: <BA82E1E583C@vcnet.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Sven <luther@dpt-info.u-strasbg.fr>, linux-fbdev-devel@lists.sourceforge.net

On Mon, Jul 22, 2002 at 11:07:28PM +0200, Petr Vandrovec wrote:
> On 22 Jul 02 at 23:00, Sven wrote:
>=20
> > > Just put it into vc_screenbuf after register_framebuffer() returns,=
 and
> > > force redraw...
> >=20
> > mmm, will try.
> >=20
> > BTW, how can i force a redraw from pm3fb ?
> >=20
> > > If you'll override save_screen, and you'll put set_origin() into vi=
sual_init,
> >=20
> > NO, just tried, i got no more display, and the box hanged ...
>=20
> Oops. fbcon_set_origin will call scrolldelta which ... So what about si=
mple
> origin =3D screenbuf in visual_init ? It should have no side effects.

I gave it another try, checking some stuff as i went.

Latest state is :

I copy the console data by overriding the vgacon save_screen function.

i have tested that in vc_resize, the data is effectively where i want
it, but that the origin function is not poiting to it, so i initialized
ol with screenbuf and not origin.

The result is the same as when i tried to simply clear the space instead
of copying, which seems strange to me. Even filling them with a bogus
character doesn't seem to work.

Also, i manage to clear only the top of the screen, the bottom of it, in
a distance the size of the logo still contains the the garbage.

The bottom of the 80x25 region of the screen that is.

here are the dumps i made :

SVEN : pm3fb.common_init : l_fb_info->v_fb is c8830000.
SVEN : Saving the console data : ...done
FB@880 has : L 4c 07 00 00 00 00 00 00.
FB@880 has : 0007.
sven@880 has : 074c.
  * here is position 880 of the vga console data, the L that starts the
  * log.
SVEN : Am using my own function ...
SVEN : sven@880 has : Linux.
SVEN : c->vc_screenbuf is c11223c0.
SVEN : c->vc_screenbuf@880 has : Linux.
SVEN : c->vc_origin is c00bbd40.
  * vc_origin is pointing to some bogus place.
SVEN : c->vc_origin@880 has : =C0^K=C4^K=C8.
  * and holds bogus data.
SVEN : vc_resize [0] screenbuf is c11223c0.
SVEN : vc_resize [0] origin is c00bbe80.
  * in vc_resize they are the same.
SVEN : vc_resize [0] kmallocated a new screenbuf at c7e42000.
SVEN : vc_resize [0] : oll =3D 25, osr =3D 160.
SVEN : vc_resize [0] : ol =3D c11223c0, nl =3D c7e42000.
  * i use screenbuf instead of origin for the copy.
SVEN : vc_resize [0] : oss =3D 4000, ss =3D 7400.
SVEN : ol@880 has : Linux.
SVEN : ol@880 has : 074c.
SVEN : nl@880 has :      .
  * and verify that ol holds the console data (nl is empty still).
Console: switching to colour frame buffer device 100x37

I did not manage to do real tests after the copying was done though.
But, i see nothing on the screen.

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
