From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 01/29] move acornfb's probe function to .devinit.text
Date: Tue, 26 Jan 2010 09:46:41 +0100
Message-ID: <20100126084641.GB20792@pengutronix.de>
References: <1264189758-7197-1-git-send-email-u.kleine-koenig@pengutronix.de> <1264278937-19675-1-git-send-email-u.kleine-koenig@pengutronix.de> <20100123232813.GB4146@x200>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752554Ab0AZIqw@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100123232813.GB4146@x200>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Antonino Daplas <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>

On Sun, Jan 24, 2010 at 01:25:58 +0200, Alexey Dobriyan wrote:
> gods, can you just send one patch for all framebuffer drivers?
Well, I thought one logical change per changeset is the favourite way t=
o
go.  And as the people Cc:d are different I think most people prefer it
this way.

On Sun, Jan 24, 2010 at 01:28:13AM +0200, Alexey Dobriyan wrote:
> On Sat, Jan 23, 2010 at 09:35:09PM +0100, Uwe Kleine-K=F6nig wrote:
> > -static int __init acornfb_probe(struct platform_device *dev)
> > +static int __devinit acornfb_probe(struct platform_device *dev)
>=20
> Even more, if this function is marked __devinit, some other functions
> can very well be marked __devinit, can you do this?
Probably, the big pro after my patch is that modpost can warn about
this.  Actually this applies to all (initially) over 50 patches in this
series.  If you take my patches, squash them together and fix all calle=
d
functions, I'm happy, too.

If you don't I might come back to this and do it myself.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
