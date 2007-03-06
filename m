From: =?iso-8859-15?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: Re: [Linux-fbdev-devel] Matrox G550, dual head, 1680x1050
Date: Tue, 6 Mar 2007 10:38:15 +0100
Message-ID: <200703061038.15930.hjk@linutronix.de>
References: <200703021053.00955.hjk@linutronix.de>
	<200703052102.31786.hjk@linutronix.de>
	<45ED337B.6010209@vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <xorg-bounces@lists.freedesktop.org>
In-Reply-To: <45ED337B.6010209@vc.cvut.cz>
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

Am Dienstag, 6. M=E4rz 2007 10:25 schrieb Petr Vandrovec:
> Hans-J=FCrgen Koch wrote:
> > Am Montag, 5. M=E4rz 2007 05:59 schrieb Petr Vandrovec:
> >> Can you try setting vxres for second head from 1680 to 1696, or 1728?
> >> Maybe X look at vxres and not at framebuffer line length (what fbset -i
> >> reports for line length?)
> >
> > Here are more details:
> >
> > 1.) I boot my kernel (vanilla 2.6.20.1) with the following parameters:
> >
> > video=3Dmatroxfb:outputs:120,pixclock:7380,xres:1680,yres:1050,upper:32,
> >                lower:4,left:32,right:224,hslen:136,vslen:4,depth:32
> >
> > This initializes the primary head correctly. The second head is probably
> > wrong, because the monitor's on screen message complains about a
> > non-ideal resolution.
>
> Second head always starts in 640x480/32bpp.  You have to use fbset to
> switch it to different mode, so matroxfb works fine as far as I can tell.
>
> > As you can see, the second monitor fell back to VGA resolution, but the
> > logs tell that X thinks it successfully switched to 1680x1050. The KDE
> > control center reports the same. The image on the second monitor is
> > distorted.
>
> Because X (mga driver) was programming hardware...
>
> > 4.) I then issue the following command:
> >
> > $ fbset -fb /dev/fb1 -g 1680 1050 1696 1050 32 -t 7380 224 32 32 4 136 4
> >
> > With that, the image on the second monitor immediately becomes clear, a=
nd
> > I have a fully working xinerama configuration then.
>
> Yes, and this corrects X programming mistake.
>
> > As far as I can see, fbset is the only way to initialize the second head
> > properly. Neither matroxfb nor mga do it correctly with 1680x1050.
>
> Well, fbset =3D=3D matroxfb, so I do not quite understand your complaint.
> 						=09

If matroxfb deliberately initializes the second head to 640x480/32bpp, then=
 it=20
is OK. I thought the kernel boot parameters would apply to both heads. But =
on=20
second thought, I agree, it has to be that way. Otherwise you'd run into=20
trouble if you had two different monitors connected as there are no=20
individual settings for both heads.

Thanks for your explanations!

Hans
