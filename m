From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] "remap_page_range" i810 compile time problem ..
Date: Fri, 11 Mar 2005 11:47:13 +0800
Message-ID: <200503111147.14726.adaplas@hotpop.com>
References: <4EE0CBA31942E547B99B3D4BFAB348113A48FA@mail.esn.co.in>
Reply-To: linux-fbdev-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348113A48FA@mail.esn.co.in>
Content-Disposition: inline
Sender: linux-fbdev-users-admin@lists.sourceforge.net
Errors-To: linux-fbdev-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-users>,
	<mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-users@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-users>,
	<mailto:linux-fbdev-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-users>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, "Mukund JB." <mukundjb@esntechnologies.co.in>, adaplas@pol.net, linux-fbdev-users@lists.sourceforge.net

On Thursday 10 March 2005 13:26, Mukund JB. wrote:
> Hi adaplas,
>
> > > I have problem with compiling the i810fb driver downloaded from
> > > Sourceforge site.
> > > I have D/W the i810fb patch "linux-i810fb-0.0.35.tar.bz2".
> > >
> > > When I run the make modules I get the following error
> >
> > Try the i810fb-lite driver.  If that does not work, let me know what
> > kernel version you are using.
>
> I got it.
> The " remap_page_range" API the i810fb driver is using is old & when I
> modifies the API with required parameters , I  compiled well & worked.
>
> When I inserted the module using the modprobe i.e
>
> Modprobe i810fb vram=2 xres=1024 bpp=16 hsync1=30 hsync2=55 vsync1=50
> vsync2=85 accel=1 rotate=1
>
> the screen rotated. GREAT.
>
> But when I try this without accel=1 rotation fails. Can u just narrate
> me what is accel accentually doing?

Because if accel is on, the driver is using it's own version of drawing
functions which are flexible enough that additional features can be added,
such as screen rotation.

If accel is off, the driver will use the generic functions which cannot do
screen rotation.  Of course, one can write a software version that can do
screen rotation.

>
> Also, the font I am getting looks linear & is not good? I do I modify
> the font format

Use setfont.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
