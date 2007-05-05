From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH 06/20] vt8623fb: New framebuffer
	driver for VIA VT8623
Date: Sat, 5 May 2007 21:15:51 +0300
Message-ID: <20070505181551.GB6016@sci.fi>
References: <463C996A.9050005@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkOnU-0003Q8-FJ for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 11:15:56 -0700
Received: from smtp5.pp.htv.fi ([213.243.153.39])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkOnT-000398-Uy
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 11:15:56 -0700
Content-Disposition: inline
In-Reply-To: <463C996A.9050005@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>

On Sat, May 05, 2007 at 10:49:14PM +0800, Antonino A. Daplas wrote:
> From: Ondrej Zajicek <santiago@crfreenet.org>
> =

> This patch adds fbdev driver for graphics core in VIA VT8623
> =

> Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>
> ---
> =

>  Documentation/fb/vt8623fb.txt |   64 +++
>  drivers/video/Kconfig         |   14 +
>  drivers/video/Makefile        |    1 =

>  drivers/video/vt8623fb.c      |  920 +++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 999 insertions(+), 0 deletions(-)
> =

> diff --git a/Documentation/fb/vt8623fb.txt b/Documentation/fb/vt8623fb.txt
> new file mode 100644
> index 0000000..f654576
> --- /dev/null
> +++ b/Documentation/fb/vt8623fb.txt
> @@ -0,0 +1,64 @@
> +
> +	vt8623fb - fbdev driver for graphics core in VIA VT8623 chipset
> +	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Doesn't viafb support this hardware?

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
