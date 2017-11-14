From: Finn Thain <fthain@telegraphics.com.au>
Date: Tue, 14 Nov 2017 00:18:49 +0000
Subject: Re: [PATCH 12/14] nubus: Rename struct nubus_dev
Message-Id: <alpine.LNX.2.00.1711132052080.3@nippy.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1510377368.git.fthain@telegraphics.com.au> <e431877669099f4245c8e9ef4d0240896195c467.1510377369.git.fthain@telegraphics.com.au> <CAMuHMdUkMTHZA8zjky6Tmj1mdtyA0GkJXGt2QSvFd8Of63TOaA@mail.gmail.com>
In-Reply-To: <CAMuHMdUkMTHZA8zjky6Tmj1mdtyA0GkJXGt2QSvFd8Of63TOaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/m68k <linux-m68k@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On Mon, 13 Nov 2017, Geert Uytterhoeven wrote:

> Hi Finn,
> 
> On Sat, Nov 11, 2017 at 7:12 AM, Finn Thain <fthain@telegraphics.com.au> 
> wrote:
> > It is misleading to use "dev" to mean a functional resource. And in 
> > adopting the Linux Driver Model, struct nubus_board will embed a 
> > struct device. Drivers will then bind with boards, not with functional 
> > resources.
> >
> > Rename struct nubus_dev as struct nubus_functional_resource. This is 
> > the vendor's terminology and avoids confusion.
> 
> Isn't "struct nubus_functional_resource" a bit long? 

Right.

> What about "nubus_res"? "nubus_fres"?
> 

I think the temporary variables can remain 'fres', as that's just a 
mnemonic, though the declaration really ought to tell us something 
meaningful.

You and I both avoided 'func' as an abbreviation. I think it suggests a 
'C' function pointer. And 'res' and 'rsrc' suggest an ioport.h struct 
resource. An unambiguous compromise would be 'nubus_functional_rsrc' but 
maybe this is still too long?

Perhaps 'struct nubus_rsrc' or 'struct nubus_res' are okay if we can keep 
the distinction between 'functional resources', 'slot resources' and 
'board resources' clear by naming instances appropriately? E.g.

@@ -33,7 +33,7 @@ struct nubus_dirent {
 
 struct nubus_board {
        struct nubus_board *next;
-       struct nubus_dev *first_dev;
+       struct nubus_rsrc *first_func_rsrc;
 
        /* Only 9-E actually exist, though 0-8 are also theoretically
           possible, and 0 is a special case which represents the
@@ -81,8 +81,8 @@ struct nubus_dev {
        struct nubus_board *board;
 };
 
-/* This is all NuBus devices (used to find devices later on) */
-extern struct nubus_dev *nubus_devices;
+/* This is all NuBus functional resources (used to find devices later on) 
*/
+extern struct nubus_rsrc *nubus_func_rsrcs;
 /* This is all NuBus cards */
 extern struct nubus_board *nubus_boards;

etc.

-- 

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
