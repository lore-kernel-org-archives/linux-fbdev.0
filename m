From: Anatolij Gustschin <agust@denx.de>
Date: Fri, 30 Apr 2010 07:43:43 +0000
Subject: Re: [PATCH 5/5] fsl-diu-fb: Support setting display mode using EDID
Message-Id: <20100430094343.2a504b2a@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<1272584978-19063-6-git-send-email-agust@denx.de>
	<n2oed82fe3e1004291844habbdfe76lc369d66cf9a9d9fd@mail.gmail.com>
In-Reply-To: <n2oed82fe3e1004291844habbdfe76lc369d66cf9a9d9fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Timur Tabi <timur.tabi@gmail.com>
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de, devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org, yorksun@freescale.com

On Thu, 29 Apr 2010 20:44:12 -0500
Timur Tabi <timur.tabi@gmail.com> wrote:

> On Thu, Apr 29, 2010 at 6:49 PM, Anatolij Gustschin <agust@denx.de> wrote:
> 
> > +Optional properties:
> > +- EDID : verbatim EDID data block describing attached display.
> > +  Data from the detailed timing descriptor will be used to
> > +  program the display controller.
> 
> The property name should be lower-case.

Will change to lower-case.

> >  /*
> >  * These parameters give default parameters
> > @@ -217,6 +218,7 @@ struct mfb_info {
> >        int x_aoi_d;            /* aoi display x offset to physical screen */
> >        int y_aoi_d;            /* aoi display y offset to physical screen */
> >        struct fsl_diu_data *parent;
> > +       char *edid_data;
> 
> edid_data should be "u8 *".  "char *" is should be used only for
> strings or arrays of characters.

Will fix it, too.

> > +       /* Still not found, use preferred mode from database if any */
> > +       if (!has_default_mode && info->monspecs.modedb != NULL) {
> 
> No need for the "!= NULL"

Ok, I will simplify this.

Thanks,
Anatolij
