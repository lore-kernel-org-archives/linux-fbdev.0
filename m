From: James Simmons <jsimmons@infradead.org>
Date: Fri, 20 Nov 2009 20:01:42 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <alpine.LFD.2.00.0911201958380.22712@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
In-Reply-To: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


> > > > Paulius Zaleckas wrote:
> > > > > On drivers using drm_fb_helper's in fb_ops it is not possible to
> > > > > change
> > > > > video mode, because of different var->pixclock evaluation: ...
> > > > 
> > > > patch:
> > > > http://www.mail-archive.com/dri-devel@lists.sourceforge.net/msg44369.html
> > > 
> > > Those patches will enable fbdev apps to run properly. More patches are
> > > needed if you want to support mode switching using the fbdev emulation
> > > layer. I noticed my patches and yours where lost. Who do you send patches
> > > too that can merge them ?
> > 
> > y:/usr/src/git26>  perl scripts/get_maintainer.pl -f
> > drivers/gpu/drm/drm_fb_helper.c
> > David Airlie<airlied@linux.ie>
> > Dave Airlie<airlied@redhat.com>
> > Jesse Barnes<jbarnes@virtuousgeek.org>
> > Mikael Pettersson<mikpe@it.uu.se>
> > dri-devel@lists.sourceforge.net
> > linux-kernel@vger.kernel.org
> > 
> > That's accurate enough.
> > 
> > Generally, if nothing has happened in a week, the chances that it's
> > lost are very high.  Resend.  If you like, cc me and I'll maintain the
> > patches
> > and resend them for you.
> 
> You can add Tested-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> for http://www.mail-archive.com/dri-devel@lists.sourceforge.net/msg44369.html
> as this was preventing DirectFB from running on my Asus Eee PC 701.

I tested it as well with the both my 3Dfx driver that I wrote with KMS and 
the nouveau driver. We just need to make sure that the patches end up in 
the drm-next tree or these patches will be lost when drm-next gets merged 
to linus tree.
