From: Chris Howells <chrish@gmx.co.uk>
Subject: Possible bug: nasty interaction between framebuffer and DRI/DRM
Date: Fri, 31 May 2002 12:54:39 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200205311254.50400.chrish@gmx.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Content-Description: clearsigned data
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: Text/Plain; charset="us-ascii"
To: ajoshi@shell.unixbox.com, faith@valinux.com
Cc: linux-fbdev-devel@lists.sourceforge.net, dri-devel@lists.sourceforge.net

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I seem to have discovered a nasty interaction between framebuffer and DRI/D=
RM=20
in OpenGL applications. I can reproduce this problem in at least Return to=
=20
Castle Wolfenstein (version 1.1b) and Tux Racer.

I am using a 32 MB ATI Rage Pro 128 on Debian woody (XFree86 4.1). If I run=
=20
Tuxracer or RTCW, and wait for the game to load, everything is alright.=20
However if I switch to a spare virtual terminal, and switch back to X, the=
=20
fonts become illegible -- they just appear as coloured boxes with no=20
outlines, making things unplayable.

The problem does not occur when using software based OpenGL rendering which=
 is=20
why I believe DRI/DRM is involved. This problem only occurs when framebuffe=
r=20
is enabled in the kernel, if framebuffer is disabled the problem disappears=
,=20
so I believe framebuffer is also at fault.

Greatful for any help...

Chris Howells
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE892SKF8Iu1zN5WiwRAgMbAJ0V5bWa85Lfsgu4FFtKeIj4c/YX8gCcCrn6
YU1lq0HuQpefLVGsDvFzN4E=3D
=3DqzHZ
=2D----END PGP SIGNATURE-----


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
