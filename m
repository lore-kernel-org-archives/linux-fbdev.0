From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Tue, 19 Oct 2004 23:54:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20041019215401.GG1142@elf.ucw.cz>
References: <416E6ADC.3007.294DF20D@localhost> <87d5zkqj8h.fsf@bytesex.org> <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be> <1097844301.9863.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S270003AbUJSV7j@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1097844301.9863.11.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, penguinppc-team@lists.penguinppc.org

Hi!

On P=E1 15-10-04 13:45:10, Alan Cox wrote:
> On Gwe, 2004-10-15 at 13:38, Geert Uytterhoeven wrote:
     ~~~-
	  eh? :-)

> > Why not? Of course you won't get any output before the graphics car=
d has been
> > re-initialized to a sane and usable state...
>=20
> That will depend on the system. The AMD64 boxes I have all allow the
> bios to post the video card on S3 resume.=20

Do you have Arima a.k.a. eMachines notebook near you? That's the one I
can't get to work...

> For a lot of other stuff we can run the bios directly on the resume p=
ath
> without emulation (or for intel call the video restore bios
> int). For the rest this could be a useful weapon.

What's the video restore bios int?
								Pavel
--=20
People were complaining that M$ turns users into beta-testers...
=2E..jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
