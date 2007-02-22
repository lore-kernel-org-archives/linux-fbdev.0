From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH 1/1] PXAFB: Support for backlight
	control
Date: Thu, 22 Feb 2007 00:59:06 +0000
Message-ID: <1172105946.5790.78.camel@localhost.localdomain>
References: <20070221145353.GA23916@enneenne.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK2JT-0001yE-Rs for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 17:00:00 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HK2JS-0003VZ-83
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 16:59:59 -0800
In-Reply-To: <20070221145353.GA23916@enneenne.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk, Paul Sokolovsky <pmiscml@gmail.com>, linux-kernel@vger.kernel.org

On Wed, 2007-02-21 at 15:53 +0100, Rodolfo Giometti wrote:
> Backlight control support for the PXA fram buffer.
> 
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> 
> ---
> 
> Each platform should define the backlight properties in its own setup
> file in "linux/arch/arm/mach-pxa/" as follow:
> 
>    static int pxafb_bl_get_brightness(struct backlight_device *bl_dev)
>    {
>         return read_the_backlight_brightness();
>    }
> 
>    static int pxafb_bl_update_status(struct backlight_device *bl_dev)
>    {
>            int perc, ret;
> 
>            if (bl_dev->props->power != FB_BLANK_UNBLANK ||
>                bl_dev->props->fb_blank != FB_BLANK_UNBLANK)
>                    perc = 0;
>            else
>                    perc = bl_dev->props->brightness;
> 
>         write_the_backlight_brightness(perc);
> 
>            return 0;
>    }
> 
>    static struct backlight_properties wwpc1100_backlight_props = {
>            .get_brightness         = pxafb_bl_get_brightness,
>            .update_status          = pxafb_bl_update_status,
>            .max_brightness         = 100,
>    };
>       
> and then seting up the fb info as follow:
> 
>    wwpc1100_pxafb_info.modes = &special_modes;
>    wwpc1100_pxafb_info.bl_props = &wwpc1100_backlight_props;
>    set_pxa_fb_info(&wwpc1100_pxafb_info);

Reading through the patch its:

1) Not against any mainline kernel
2) Not against a recent kernel

There were a number of backlight class changes just merged into mainline
and you need to sync up any patch against them.

As mentioned by others, there is no need to tie the backlight driver
into the framebuffer any more. Have a look at
drivers/video/backlight/corgi_bl.c for an example (its used by PXA
devices).

I have said elsewhere I will take patches to make corgi_bl a more
generic driver (or maybe create a simple generic backlight driver) along
the lines of what Paul mentioned.

Regards,

Richard



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
