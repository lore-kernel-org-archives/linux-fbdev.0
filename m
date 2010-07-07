From: James Simmons <jsimmons@infradead.org>
Date: Wed, 07 Jul 2010 11:37:33 +0000
Subject: Re: [PATCH 1/3] FB: Add some members for CPU Interface.
Message-Id: <alpine.LFD.2.00.1007071236300.19507@casper.infradead.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1985284609-83660284-1278502653=:19507"
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTilgB3s8hy5Qg7IYpyBzwHCgK_GswVZqpxhryU5L@mail.gmail.com>
In-Reply-To: <AANLkTilgB3s8hy5Qg7IYpyBzwHCgK_GswVZqpxhryU5L@mail.gmail.com>
To: linux-fbdev@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1985284609-83660284-1278502653=:19507
Content-Type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 6 Jul 2010, Geert Uytterhoeven wrote:

> On Tue, Jul 6, 2010 at 17:30, James Simmons <jsimmons@infradead.org> wrote:
> >
> > CPU interface needs cs, wr setup, wr act and hold delay.
> > I added some members for them to common framework.
> >
> > Signed-off-by: InKi Dae <inki.dae@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >
> > diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
> >
> > index 0a4dbdc..74122d1 100644
> > --- a/drivers/video/modedb.c
> > +++ b/drivers/video/modedb.c
> > @@ -759,6 +759,27 @@ void fb_videomode_to_var(struct fb_var_screeninfo *var,
> >  }
> >
> >  /**
> > + * fb_cpumode_to_var - convert fb_cpumode to fb_var_screeninfo
>          ^^^
> > + * @var: pointer to struct fb_var_screeninfo
> > + * @mode: pointer to struct fb_cpumode
> > + */
> > +void fb_cmdmode_to_var(struct fb_var_screeninfo *var,
>            ^^^
> 
> cpu vs cmd?
> 

Forward comment to original author.
--1985284609-83660284-1278502653=:19507--
