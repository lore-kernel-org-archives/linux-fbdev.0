From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date: Mon, 11 Mar 2019 21:15:55 +0000
Subject: Re: [PATCH] FBTFT: fbtft-bus: Fix code style problems
Message-Id: <CAAEAJfAcdFZO_h9dr_hBBh=Rqogg78UOnAOQWNCW-A7ndPMCQA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190309214852.12233-1-dante.paz@gmail.com>
 <20190311162527.GA20652@ravnborg.org>
 <CAJdeGOTPLoSwQ9hb7Tk_cZ+VmT-xvEtGU_pbSUXoxcB20d3rcw@mail.gmail.com>
In-Reply-To: <CAJdeGOTPLoSwQ9hb7Tk_cZ+VmT-xvEtGU_pbSUXoxcB20d3rcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: DANTE JAVIER PAZ <dpaz@unc.edu.ar>
Cc: devel@driverdev.osuosl.org, leobras.c@gmail.com, linux-fbdev@vger.kernel.org, nishadkamdar@gmail.com, Greg KH <gregkh@linuxfoundation.org>, Dante Paz <dante.paz@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, renatoys08@gmail.com, Sam Ravnborg <sam@ravnborg.org>

Hi everyone,

Dante: please avoid top-posting. In other words, put your replies in-line,
like I'm gonna do now. See below (and see how discussion goes on other thre=
ads).

On Mon, 11 Mar 2019 at 17:34, DANTE JAVIER PAZ <dpaz@unc.edu.ar> wrote:
>
> Hello Sam, thank you very much for your comments,
> As I told Dan (my email did not reach the mailing list) this is my
> first attempt to contribute,
> So I'm learning a lot from your advice and corrections.
>
> I will look for TODO lists to see if there are more useful
> contributions to make, all suggestions are also welcome.
>
> Thanks again for the patience of all of you.
> Best,
> Dante
>
>
> El lun., 11 mar. 2019 a las 13:25, Sam Ravnborg (<sam@ravnborg.org>) escr=
ibi=C3=B3:
> >
> > Hi Dante
> >
> > Thanks for the patch.
> > On Sat, Mar 09, 2019 at 06:48:52PM -0300, Dante Paz wrote:
> > > From: Dante Paz <dpaz@unc.edu.ar>
> > >
> > >     Style and coding function issues were corrected, by avoiding macr=
o functions with a conflicting coding style.
> > >     Signed-off-by: Dante Paz <dpaz@unc.edu.ar>
> >
> > But it raised a few comments.
> >
> > The staging/fbtft is a dumping of a set of drivers that
> > in the end will be migrated to DRM.
> > And there is not much gained trying to do coding style changes to these
> > drivers.
> > So please conmsider finding a drver where this is more relevant.
> >

Sam,

Why is this driver still here? I thought we migrated everyhing to
tinydrm already.

Maybe there's a list of panels still not migrated?

Thanks,
Eze
