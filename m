From: James Simmons <jsimmons@infradead.org>
Date: Thu, 11 Mar 2010 15:17:36 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <alpine.LFD.2.00.1003111516540.1912@casper.infradead.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1985284609-741838265-1268320657=:1912"
List-Id: <linux-fbdev.vger.kernel.org>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
	<21d7e9970911202027l1d4deec6p5750b8425cd6bb3f@mail.gmail.com>
	<a5d587fb1003010118r1b586990ja4144441143bb4be@mail.gmail.com>
	<21d7e9971003022102v232c099r441b0bd843b30313@mail.gmail.com>
	<alpine.LFD.2.00.1003101738420.4419@casper.infradead.org>
	<a728f9f91003101005v374b2cacpb307542e65d22d6f@mail.gmail.com>
	<a728f9f91003101010m4fc94398l14c8625d7442100a@mail.gmail.com>
	<1268302426.7444.117.camel@thor.local>
	<a728f9f91003110712l407ed04dl28b86ef77a427218@mail.gmail.com>
In-Reply-To: <a728f9f91003110712l407ed04dl28b86ef77a427218@mail.gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?ISO-8859-15?Q?Michel_D=E4nzer?= <michel@daenzer.net>, dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net, Paulius Zaleckas <paulius.zaleckas@gmail.com>, Michal Suchanek <hramrach@centrum.cz>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1985284609-741838265-1268320657=:1912
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


> >> It would be nice to find a way to reclaim the console memory for X,
> >> but I'm not sure that can be done and still provide a good way to
> >> provide oops support.
> >
> > What do you think the average user will care about more?
> >
> > =A0 =A0 =A0* Seeing kernel oops/panic output about once in a lifetime.
> > =A0 =A0 =A0* Being able to start/use X in the first place and enabling =
it to
> > =A0 =A0 =A0 =A0use all of VRAM.
> >
> > Personally, I've never even seen any kernel oops/panic output despite
> > numerous opportunities for that in the couple of months I've been using
> > KMS. But I have spent considerable time and effort trying to get rid of
> > the pinned fbcon BO. If the oops/panic output is the only thing
> > preventing that, maybe that should only be enabled via some module
> > option for developers.
>=20
> I'm all for it!

I'm looking into the details for this. It will require some changes to=20
internal apis to make it to work.

--1985284609-741838265-1268320657=:1912
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--1985284609-741838265-1268320657=:1912
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--1985284609-741838265-1268320657=:1912--
