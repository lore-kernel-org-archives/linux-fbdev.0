From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [Linux-fbdev-devel] Re: radeon, apertures & memory mapping
Date: Sun, 13 Mar 2005 23:28:43 -0500
Message-ID: <1110774523.4003.511.camel@localhost>
References: <1110677744.19810.80.camel@gaston>
	<9e47339105031219223e606a52@mail.gmail.com>
	<1110696189.5787.100.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1110696189.5787.100.camel@gaston>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: dri-devel@lists.sourceforge.net, Jon Smirl <jonsmirl@yahoo.com>, xorg@lists.freedesktop.org

On Sun, 2005-03-13 at 17:43 +1100, Benjamin Herrenschmidt wrote:
>=20
> And finally, I want to blank the screen (using the accel engine) before
> setting the new mode, so that we come out "clean" of the mode setting
> (without ugly artifact), and I will probably clean both fb's (simpler).

That would break X with UseFBDev.


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer
