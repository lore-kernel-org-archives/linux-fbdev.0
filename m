From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 17 Oct 2017 13:37:20 +0000
Subject: Re: [bug report] out of bounds read parsing vmode commandline option
Message-Id: <5014119.cNFvECyesu@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171004125038.gkzaemlefrpfa2m2@mwanda>
 <CAMuHMdUNvtDunWK-4oRFMqTVz_QKzXW_Fosg883jd7Wu7mp3_A@mail.gmail.com>
 <CGME20171017133722epcas2p1361446d57dfad4ef9a9bc2a0a247e70a@epcas2p1.samsung.com>
In-Reply-To: <CAMuHMdUNvtDunWK-4oRFMqTVz_QKzXW_Fosg883jd7Wu7mp3_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>


Hi,

On Wednesday, October 04, 2017 06:42:37 PM Geert Uytterhoeven wrote:
> Hi Dan,
> 
> On Wed, Oct 4, 2017 at 2:50 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > This bug predates git but it looks like it might be simple to fix if the
> > right person looked at the code.
> >
> >         drivers/video/fbdev/controlfb.c:560 control_setup()
> >         error: buffer overflow 'control_mac_modes' 20 <= 21
> >
> > drivers/video/fbdev/controlfb.c
> >    549  static void __init control_setup(char *options)
> >    550  {
> >    551          char *this_opt;
> >    552
> >    553          if (!options || !*options)
> >    554                  return;
> >    555
> >    556          while ((this_opt = strsep(&options, ",")) != NULL) {
> >    557                  if (!strncmp(this_opt, "vmode:", 6)) {
> >    558                          int vmode = simple_strtoul(this_opt+6, NULL, 0);
> >                                     ^^^^^
> > We get vmode from the command line.
> >
> >    559                          if (vmode > 0 && vmode <= VMODE_MAX &&
> >                                                           ^^^^^^^^^
> > We check that it's <= 22.
> >
> >    560                              control_mac_modes[vmode - 1].m[1] >= 0)
> >                                     ^^^^^^^^^^^^^^^^^
> > But the problem is that control_mac_modes[] only has 20 elements so the
> > highest valid index is 19.  vmode - 1 can be up to 21.
> 
> Nice catch!
> 
> The bug was introduced in v2.4.5.6, when 2 new modes were added to
> macmodes.h, but control_mac_modes[] wasn't updated:
> 
> https://kernel.opensuse.org/cgit/kernel/diff/include/video/macmodes.h?h=v2.5.2&id)f279c764808560eaceb88fef36cbc35c529aad
> 
> A simple fix is to check against ARRAY_SIZE(control_mac_modes) instead.
> 
> A better fix is to add the missing entries to control_mac_modes[], cfr. the
> (gmail-whitespace-damaged) patch below:
> 
> --- a/drivers/video/fbdev/controlfb.h
> +++ b/drivers/video/fbdev/controlfb.h
> @@ -141,5 +141,7 @@ static struct max_cmodes control_mac_modes[] = {
>         {{ 1, 2}},      /* 1152x870, 75Hz */
>         {{ 0, 1}},      /* 1280x960, 75Hz */
>         {{ 0, 1}},      /* 1280x1024, 75Hz */
> +       {{ 1, 2}},      /* 1152x768, 60Hz */
> +       {{ 0, 1}},      /* 1600x1024, 60Hz */
>  };
> 
> (this array lists the maximum color mode (8, 16, or 32 bpp) for each
>  video mode given RAM restrictions (2 or 4 MiB)).
> 
> The 1152x768 mode is probably OK. Given the 1600x1024 mode has a lower
> dotclock (112 MHz) than the supported 1280x960 mode, it's probably OK, too.

Looks fine to me, could you please submit it as a normal patch?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

