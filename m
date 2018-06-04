From: Dave Airlie <airlied@gmail.com>
Date: Mon, 04 Jun 2018 01:25:06 +0000
Subject: Re: [PATCH 00/21] USB DisplayLink patches
Message-Id: <CAPM=9twz_g6xw_C_XdNsB7nhx3-5iy4=AoxR1NadTfA+Xy-S5g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
In-Reply-To: <20180603144053.875668929@twibright.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Ladislav Michl <ladis@linux-mips.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bernie Thompson <bernie@plugable.com>, dri-devel <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>

On 4 June 2018 at 00:40, Mikulas Patocka <mpatocka@redhat.com> wrote:
> Hi
>
> Here I'm sending bug fixes and performance improvements for the USB
> DisplayLink framebuffer and modesetting drivers for this merge window.
>

Hi,

You probably want to split these up into separate series for the kms and fbdev
drivers.

Otherwise at least for drm you've missed this merge window, since it
closes around rc6 of the previous kernel, did you use git send-email
for these patches, at least some of them viewed funny on my phone,
I'll try and look over the kms ones soon. Do you have any numbers for
improvements to the kms ones?

Dave.
