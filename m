From: Jim Hague <jim.hague@acm.org>
Subject: Re: pm2fb fixes
Date: Thu, 22 Apr 2004 16:36:05 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040422163605.jim.hague@acm.org>
References: <20040422104344.0e798a7a@zerocool>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGgFQ-00028M-Ba
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Apr 2004 08:36:20 -0700
Received: from cpc3-oxfd2-6-0-cust100.oxfd.cable.ntl.com ([81.103.193.100] helo=fluffy.bear-cave.org.uk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BGgFQ-0005x4-0G
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 22 Apr 2004 08:36:20 -0700
In-Reply-To: <20040422104344.0e798a7a@zerocool>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Marcelo Ramos <mramos@montevideo.com.uy>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 22-Apr-2004 Marcelo Ramos wrote:
> El (On) Wed, 21 Apr 2004 19:21:34 +0100 (BST)
> Jim Hague <jim.hague@acm.org> escribi=F3 (wrote):
>> BTW, I'd be interested in hearing if you see any unusual behaviour.
>=20
> Sorry, i didn't read well the first time :/
> I see a thin white line like you describe *only* when booting and it
> disappears
> when the boot messages make the screen to scroll up.
>=20
> I don't see any problem when switching from X to the console.
> =20
>> Also when shutting down from gdm with the full screen display, my console
>> background goes a bluey sort of shade.
>=20
> I don't see that here.

Thanks for the feedback. It sounds like it's working OK for you.

The problem I'm having with gdm is, I think, mode related. My consoles are =
at 8
bit colour depth, but X runs at 16 bit. If I boot and login via gdm, when I
hotkey to consoles the mode is correctly switched back to 8 bit. If I hotkey
back to X and then log out back to gdm and then hotkey to consoles, the mode
isn't switched back to 8 bit but is switched to (i.e. remains at) 16 bit de=
pth.
In case anyone else is interested, this is on freshly updated Debian Sid.

--=20
Jim Hague - jim.hague@acm.org          Never trust a computer you can't lif=
t.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dclick
