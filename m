From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Sat, 11 Jun 2005 09:23:17 -0400
Message-ID: <9e473391050611062323284c4e@mail.gmail.com>
References: <9e47339105061021571f479b10@mail.gmail.com>
	 <Pine.LNX.4.56.0506110711100.24250@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dh5xM-0005tb-3n
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Jun 2005 06:23:24 -0700
Received: from wproxy.gmail.com ([64.233.184.195])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Dh5xL-00042I-N3
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Jun 2005 06:23:24 -0700
Received: by wproxy.gmail.com with SMTP id 69so717808wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Jun 2005 06:23:17 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0506110711100.24250@pentafluge.infradead.org>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@www.infradead.org>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>, James Simmons <jsimmons@pentafluge.infradead.org>

On 6/11/05, James Simmons <jsimmons@www.infradead.org> wrote:
>=20
> Ug no. I see in the future more drivers using hardware cursors instead.
> We would be carry around extra software cursor code in the the framebuffe=
r
> console all the time. We need to properly fix the cursor code. Unfortunel=
y
> that will take more work. In the mean time please encourage people to
> support hardware cursors. Even crappy cards have hardware cursors most of
> the time.

Also, I didn't delete the fb_cursor field. I just removed all of the
assignments of .fb_cursor =3D soft_cursor. The field is still there and
defaulting to null, except in the three drivers with hardware cursors
where it is set.

For a driver to implement software cursors it has to know the location
of the scanout buffer, scanbuffer format, etc. I not sure if all of
this is always know for user space apps. The hardware cursor doesn't
need as much info about the framebuffer.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
