From: =?iso-8859-15?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: Re: [Linux-fbdev-devel] Matrox G550, dual head, 1680x1050
Date: Mon, 5 Mar 2007 08:34:57 +0100
Message-ID: <200703050834.57831.hjk@linutronix.de>
References: <200703021053.00955.hjk@linutronix.de>
	<200703042247.21590.hjk@linutronix.de>
	<45EBA3B6.3060701@vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <xorg-bounces@lists.freedesktop.org>
In-Reply-To: <45EBA3B6.3060701@vc.cvut.cz>
Content-Disposition: inline
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

Am Montag, 5. M=E4rz 2007 05:59 schrieb Petr Vandrovec:
> Hans-J=FCrgen Koch wrote:
> > Am Freitag, 2. M=E4rz 2007 16:24 schrieb Tilman Sauerbeck:
> > Meanwhile I doubt this explanation. Here's what fbset has to say:
> >
> > $ fbset -fb /dev/fb1 --show
> >
> > mode "1680x1050-60"
> >     # D: 135.501 MHz, H: 65.396 kHz, V: 59.997 Hz
> >     geometry 1680 1050 1680 1050 32
> >     timings 7380 32 224 32 4 136 4
> >     rgba 8/16,8/8,8/0,8/24
> > endmode
> >
> > So, even fbset thinks it's 1680x1050. But where does the distortion come
> > from???
>
> Can you try setting vxres for second head from 1680 to 1696, or 1728?
> Maybe X look at vxres and not at framebuffer line length (what fbset -i
> reports for line length?)

Thanks a lot, Petr, you're on the right track! With

fbset -fb /dev/fb1 -g 1680 1050 1696 1050 32 -t 7380 224 32 32 4 136 4

the distortion disappears. At the moment I have to do this manually after X=
=20
has started. I'll have to experiment a bit with my configurations, but at=20
least now I have working xinerama.

Thanks again for your help.

Hans
