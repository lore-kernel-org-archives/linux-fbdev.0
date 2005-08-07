From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [Linux-fbdev-devel] CRTC scanout buffer types
Date: Sun, 7 Aug 2005 09:41:53 -0400
Message-ID: <9e47339105080706414faf1e40@mail.gmail.com>
References: <9e47339105080513195dee0804@mail.gmail.com>
	 <Pine.LNX.4.62.0508071135450.31010@gorilla.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <dri-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.62.0508071135450.31010@gorilla.sonytel.be>
Content-Disposition: inline
Sender: dri-devel-admin@lists.sourceforge.net
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: DRI developer's list <dri-devel@lists.sourceforge.net>

I'm trying to work out a syntax for the sysfs attribute that will
control the config. My first idea is to use a alpha/red/blue/green
syntax. When red is set and blue/green are missing index mode is set.
When green is set and red/blue are missing gray scale is set.

Are there chips that can scanout from buffers not packed at a power of two?
How should I work different color spaces (YCbCr) into this?

4bpp Index =3D /4
4bpp greyscale =3D //4
8bpp Index =3D /8
8bpp RGB 332 =3D /3/3/2
8bpp greyscale =3D //8
16bpp aRGB 1555 =3D 1/5/5/5
16bpp RGB 565 =3D /5/6/5
16bpp aRGB 4444 =3D 4/4/4/4
16bpp aIndex 88 =3D 8/8
24bpp RGB 888 =3D /8/8/8
24bpp aRGB 6666 =3D 6/6/6/6
32bpp aRGB 8888 =3D 8/8/8/8
32bpp aRGB 2:10:10:10 =3D 2/10/10/10

How are these packed?
1 bpp monochrome (black =3D 0 and white =3D 1 or vice versa)
1 bpp indexed
2 bpp indexed
3 bpp indexed
5 bpp indexed
6 bpp indexed
7 bpp indexed

These would have the same config, //8, right? You then just control
what you write to the byte.
8 bpp monochrome (black is all zeroes and white is all ones or vice versa)
8 bpp greyscale

How does this work, is one 24 bit color the key?
32 bpp indexed+RGB 888 with color key to enable RGB888

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
--
