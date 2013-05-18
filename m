From: Alexandre Courbot <gnurou@gmail.com>
Date: Sat, 18 May 2013 10:29:53 +0000
Subject: Re: [PATCH V2] video: implement a simple framebuffer driver
Message-Id: <CAAVeFuJ5q4Y0QtvJX2iVmq_O2ofs1B9=MB_aA8VdcEBdM4zf2Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
In-Reply-To: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Apr 4, 2013 at 11:39 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> +struct simplefb_format {
> +       const char *name;
> +       u32 bits_per_pixel;
> +       struct fb_bitfield red;
> +       struct fb_bitfield green;
> +       struct fb_bitfield blue;
> +       struct fb_bitfield transp;
> +};
> +
> +struct simplefb_format simplefb_formats[] = {
> +       { "r5g6b5", 16, {11, 5}, {5, 6}, {0, 5}, {0, 0} },
> +};

I have been adding a few extra formats to this list, and I wonder if
this could not simply be turned into a function that would directly
convert the name string into the corresponding right format. The
mapping between name and format seems to be a 1:1 and this would
probably avoid errors in the future. I'm especially thinking about
color order here - I started adding a mode that reads

    { "r8g8b8a8", 32, {0, 8}, {8, 8}, {16, 8}, {24, 8} },

while it should probably be called "a8b8g8r8" as the order of colors
is not the same as your r5g6b5.

I can submit a patch if there is no issue with that idea.

Alex.
