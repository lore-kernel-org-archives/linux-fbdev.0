From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 31 Jul 2018 10:50:26 +0000
Subject: Re: [PATCH] fb: amifb: fix build warnings when not builtin
Message-Id: <2959711.91EZXKFJ5b@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cda83e71-7bfc-5997-a271-0362a7ac0354@infradead.org>
 <CGME20180727071658epcas1p4d24ffaddc497ceb479a5e3320b4ef0a4@epcas1p4.samsung.com>
 <CAMuHMdVL8v4Y5iEyYxSAfFnWFq5+trAr+cWHbF59Ge_5gRwpNA@mail.gmail.com>
In-Reply-To: <CAMuHMdVL8v4Y5iEyYxSAfFnWFq5+trAr+cWHbF59Ge_5gRwpNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, DRI Development <dri-devel@lists.freedesktop.org>

On Friday, July 27, 2018 09:16:42 AM Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Fri, Jul 27, 2018 at 2:00 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> >
> > Fix build warning when built as a loadable module.
> > amifb_setup() and amifb_setup_mcap() are only needed when the driver
> > is builtin.
> > This matches how the functions are called (using #ifndef MODULE).
> >
> > ../drivers/video/fbdev/amifb.c:2344:19: warning: 'amifb_setup' defined but not used [-Wunused-function]
> >  static int __init amifb_setup(char *options)
> >
> > ../drivers/video/fbdev/amifb.c:2307:20: warning: 'amifb_setup_mcap' defined but not used [-Wunused-function]
> >  static void __init amifb_setup_mcap(char *spec)
> 
> Thanks for your patch!
> 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

