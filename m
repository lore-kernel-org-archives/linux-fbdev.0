From: Ian Romanick <idr@us.ibm.com>
Subject: Re: [Linux-fbdev-devel] CRTC scanout buffer types
Date: Sun, 07 Aug 2005 14:03:21 -0700
Message-ID: <42F67719.9050805@us.ibm.com>
References: <9e47339105080513195dee0804@mail.gmail.com>	 <Pine.LNX.4.62.0508071135450.31010@gorilla.sonytel.be> <9e47339105080706414faf1e40@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-admin@lists.sourceforge.net>
In-Reply-To: <9e47339105080706414faf1e40@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, DRI developer's list <dri-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jon Smirl wrote:
> I'm trying to work out a syntax for the sysfs attribute that will
> control the config. My first idea is to use a alpha/red/blue/green
> syntax. When red is set and blue/green are missing index mode is set.
> When green is set and red/blue are missing gray scale is set.
> 
> Are there chips that can scanout from buffers not packed at a power of two?
> How should I work different color spaces (YCbCr) into this?
> 
> 4bpp Index = /4
> 4bpp greyscale = //4
> 8bpp Index = /8
> 8bpp RGB 332 = /3/3/2
> 8bpp greyscale = //8
> 16bpp aRGB 1555 = 1/5/5/5
> 16bpp RGB 565 = /5/6/5
> 16bpp aRGB 4444 = 4/4/4/4
> 16bpp aIndex 88 = 8/8
> 24bpp RGB 888 = /8/8/8
> 24bpp aRGB 6666 = 6/6/6/6
> 32bpp aRGB 8888 = 8/8/8/8
> 32bpp aRGB 2:10:10:10 = 2/10/10/10

What would be wrong with using a letter, a colon, and a number to
describe the field?  So, instead of 2/10/10/10 you'd have
A:2/R:10/G:10/B:10.  Or A:8/I:8 for aIndex 88.  I'm not familiar with
how sysfs attributes work, so this may be pure nonsense.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFC9ncYX1gOwKyEAw8RAnjwAJ4mVXa5RGo/1yja036IdUi8U+2wyACfe8gg
mloAzlOC33YqPCP6zM6BHKM=
=Qr6o
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
--
