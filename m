From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: FB model basic issues (WAS: radeon, apertures & memory mapping)
Date: Wed, 16 Mar 2005 07:37:01 +0800
Message-ID: <200503160737.04850.adaplas@hotpop.com>
References: <1110696189.5787.100.camel@gaston> <Pine.LNX.4.62.0503150946180.30569@numbat.sonytel.be> <20050315133628.GA16051@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050315133628.GA16051@sci.fi>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>, linux-fbdev-devel@lists.sourceforge.net
Cc: Michel =?iso-8859-1?q?D=E4nzer?= <michel@daenzer.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org, Jon Smirl <jonsmirl@yahoo.com>

On Tuesday 15 March 2005 21:36, Ville Syrj=E4l=E4 wrote:
> On Tue, Mar 15, 2005 at 09:51:40AM +0100, Geert Uytterhoeven wrote:
> > On Tue, 15 Mar 2005, Ville [iso-8859-1] Syrj??wrote:
> > > If radeonfb will allocate the buffer for the second head from the top
> > > of the memory users would basically have to guess it's location.
> > > matroxfb simply cuts the memory in two pieces and allocates the buffe=
rs
> > > from the start of each piece. I don't really like that approach. Addi=
ng
> > > a simple byte_offset field to fb_var_screeninfo would solve the probl=
em
> > > quite nicely but I don't know if such API changes are acceptable at
> > > this stage.
> >
> > You wouldn't have to guess its location, look at fix.smem_start.
>
> But how would someone mmap() the whole memory then? matroxfb already plays

This is multi-head, right?  That implies one fb per head.  So,  can't you do
separate mmaps?  fb0->fix.smem_start|len and fb1->fix.smem_start|len.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
