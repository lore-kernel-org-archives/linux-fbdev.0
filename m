From: Baruch Siach <baruch@tkos.co.il>
Date: Tue, 20 Sep 2011 11:24:28 +0000
Subject: Re: [PATCH 1/3] include: fb: Add definiton for window positioning
Message-Id: <20110920112427.GB19695@sapphire.tkos.co.il>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316532641-2657-1-git-send-email-ajaykumar.rs@samsung.com>
	<1316532641-2657-2-git-send-email-ajaykumar.rs@samsung.com>
In-Reply-To: <1316532641-2657-2-git-send-email-ajaykumar.rs@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Ajay,

On Tue, Sep 20, 2011 at 11:30:39AM -0400, Ajay Kumar wrote:
> This patch adds a data structure definiton to hold framebuffer windows/planes.
> An ioctl number is also added to provide user access
> to change window position dynamically.

[snip]

> +/* Window overlaying */
> +struct fb_overlay_win_pos {
> +	__u32 win_pos_x;	/* x-offset from LCD(0,0) where window starts */
> +	__u32 win_pos_y;	/* y-offset from LCD(0,0) where window starts */
> +};

Why not allow negative offsets where the left or upper part of the framebuffer 
is hidden?

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
