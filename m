From: Rob Herring <robh@kernel.org>
Date: Mon, 07 Jan 2019 17:31:12 +0000
Subject: Re: [PATCH] video: offb: Pass actual name in offb_init_palette_hacks
Message-Id: <CAL_JsqL=Q4cct+ZQR4VOnxxDsUog5D54hUqjjTYhtHV4d1LB-Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181207125844.18775-1-malat@debian.org> <CA+7wUszBpmd2r18WZVjAXv2xq+ySrnKTqaRT7bGcHa71_M_j7g@mail.gmail.com>
 <CA+7wUsxN664BUjetUX3LhjN4JvZAAWY_Atv2d_eE9_UFGGwg2Q@mail.gmail.com>
In-Reply-To: <CA+7wUsxN664BUjetUX3LhjN4JvZAAWY_Atv2d_eE9_UFGGwg2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Malaterre <malat@debian.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "# v4 . 11" <stable@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Elimar Riesebieter <riesebie@lxtec.de>

On Wed, Jan 2, 2019 at 2:03 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> Bartlomiej,
>
> Do you need an Acked-by from Rob, or can you take it in the next round
> of fixes for v4.20 ?

Sorry, I missed this.

>
> Just to repeat myself, previous code would call
> offb_init_palette_hacks(), which in turn would do:
>
>        if (dp && !strncmp(name, "ATY,Rage128", 11)) {
>
> with name=NULL.

I prefer to fix this properly using node name helper in
offb_init_palette_hacks(). I'll send a patch shortly.


Rob
