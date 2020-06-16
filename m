From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 16 Jun 2020 14:05:58 +0000
Subject: Re: [PATCH 0/6] remove deprecated i2c_new_device API
Message-Id: <CACvgo52PaW97cxMeGhbpD4FUVy5BRAunaCxX3106OOAZm6x67A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200615075816.2848-1-wsa+renesas@sang-engineering.com>
 <20200616121244.GN20149@phenom.ffwll.local>
In-Reply-To: <20200616121244.GN20149@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-fbdev <linux-fbdev@vger.kernel.org>, x86@kernel.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, platform-driver-x86@vger.kernel.org, linux-media@vger.kernel.org

Hi all,

On Tue, 16 Jun 2020 at 13:12, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Jun 15, 2020 at 09:58:09AM +0200, Wolfram Sang wrote:
> > I want to remove the above API this cycle, and just a few patches have
> > not made it into 5.8-rc1. They have been reviewed and most had been
> > promised to get into linux-next, but well, things happen. So, I hope it
> > is okay for everyone to collect them like this and push them via I2C for
> > 5.8-rc2.
>
> for the drm side of things:
>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >
> > One minor exception is the media documentation patch which I simply have
> > missed so far, but it is trivial.
> >
> > And then, finally, there is the removal of the old API as the final
> > patch. Phew, that's been a long ride.
> >
> > I am open for comments, of course.
> >
> > Happy hacking,
> >
> >    Wolfram
> >
> >
> > Wolfram Sang (6):
> >   drm: encoder_slave: fix refcouting error for modules
> >   drm: encoder_slave: use new I2C API

The first two are in drm-misc-next and are to be expected with the 5.9
merge window. As long as that doesn't cause major nuisance proceed as
you prefer.

-Emil
