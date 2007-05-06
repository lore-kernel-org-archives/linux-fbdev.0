From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH 06/20] vt8623fb: New
	framebuffer	driver for VIA VT8623
Date: Sun, 6 May 2007 04:36:17 +0300
Message-ID: <20070506013617.GA29760@sci.fi>
References: <463C996A.9050005@gmail.com> <20070505181551.GB6016@sci.fi>
	<20070505200801.GA28014@localhost.localdomain>
	<20070505203450.GC6016@sci.fi> <20070505224855.GA18807@skynet.be>
	<1178406457.22828.7.camel@daplas>
	<20070505233147.GA19039@skynet.be>
	<20070505233834.GA19120@skynet.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkVfi-00053A-Rp for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 18:36:23 -0700
Received: from smtp6.pp.htv.fi ([213.243.153.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkVfg-0007qm-NY
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 18:36:22 -0700
Content-Disposition: inline
In-Reply-To: <20070505233834.GA19120@skynet.be>
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

On Sun, May 06, 2007 at 01:38:34AM +0200, Luc Verhaegen wrote:
> On Sun, May 06, 2007 at 01:31:47AM +0200, Luc Verhaegen wrote:
> > On Sun, May 06, 2007 at 07:07:37AM +0800, Antonino A. Daplas wrote:
> > > =

> > > Yep, just looking at that patch, it will be a difficult one to clean =
up.
> > > =

> > > Tony
> > =

> > It takes a special kind of idiot to take something like that on and =

> > keep it up too.
> =

> So you're better off with the rudimentary driver, at least that can be =

> fixed on reasonable terms.

It would be nice to have a clean driver with enough features so
people don't have to hunt around in a maze of different driver versions
to get the features they need. It's a shame people have just forked the
driver several times without really trying to work on a common codebase
and get it included in the kernel.

I think a big portion of the blame falls on VIA since they are the
original authors and the they have decided not to work with the community.
Maybe that's changing now that they posted the patches (even though they
aren't clean). I didn't really read the viafb patch thread so I missed the
details. Are they are prepared to clean it up or do they just expect to
dump the code here and forget about it?

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
