From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Portrait display mode
Date: 11 Sep 2002 06:22:57 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1031696622.548.13.camel@daplas>
References: <3D7E59B0.5FC023D3@bluewin.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17otOd-0005t9-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 10 Sep 2002 15:22:11 -0700
In-Reply-To: <3D7E59B0.5FC023D3@bluewin.ch>
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
To: otto.wyss@bluewin.ch
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2002-09-11 at 04:44, Otto Wyss wrote:
> I guess the framebuffer drivers so far don't support turning the display =
90=B0 as
> the Pivot software does for Windows/MacOS. Since I'm considering buying a
I posted a patch under the thread titled "Console Rotation" 2 days ago.=20
It should support rotation in 3 additional directions (90, 180 and 270
degrees).  As far as fb-based apps, they have to do the rotation on
their own.  XFbdev in 4.2.0 already does that.

> turnable display I rather see this feature implemented. I even may help b=
ut can
> spend much time. How difficult would it be?
>=20
It should not be too difficult to add per-driver support once the
rotation wrappers are implemented.  The main requirement is that the
driver must support the drawing primitives (xxxfillrect, xxxcopyarea,
xxximageblit -- main reason I like the primitives is because you can do
a lot of fancy things with minimal code change).  I already did this
with VESA fb, and it required less than 100 lines of code.

Doing this in 2.4 will be trickier because of absence of support for
drawing primitives.  (The i810fb driver had console rotation for half a
year now, though)

If you are interested, try the patches (apply them in the order I
mentioned).  http://i810fb.sourceforge.net/fb_rotate.tar.gz

Tony



-------------------------------------------------------
In remembrance
www.osdn.com/911/
