From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 06 Jan 2010 18:25:22 +0000
Subject: Re: 2.6.33-rc3 -- Intel 945GME (inteldrmfb) -- Two Tux images
Message-Id: <1262802322.4049.55.camel@laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <a44ae5cd1001060916s4db1d94fsb7e012ab80ce6add@mail.gmail.com>
	 <1262801263.4049.53.camel@laptop>
	 <a44ae5cd1001061010u2d31f24fx2dca6e7953687db@mail.gmail.com>
In-Reply-To: <a44ae5cd1001061010u2d31f24fx2dca6e7953687db@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Miles Lane <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>, Sylvain Meyer <sylvain.meyer@worldonline.fr>, linux-fbdev@vger.kernel.org

On Wed, 2010-01-06 at 13:10 -0500, Miles Lane wrote:
> On Wed, Jan 6, 2010 at 1:07 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Wed, 2010-01-06 at 12:16 -0500, Miles Lane wrote:
> >> For a long time I have gotten two pictures of Tux showing up when I
> >> include the Tux display option in my custom kernel builds.
> >
> > Doesn't it show one for each cpu in the system?
> 
> Apparently so.  And, why this should be true is beyond me.

drivers/video/fbmem.c:

int fb_show_logo(struct fb_info *info, int rotate)
{
        int y;

        y = fb_show_logo_line(info, rotate, fb_logo.logo, 0,
                              num_online_cpus());
        y = fb_show_extra_logos(info, y, rotate);

        return y;
}


I guess its just a cute way of showing off how many cpus you've got ;-)

