From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [ANNOUCE] fbdev changes finished.
Date: Thu, 17 Oct 2002 18:27:56 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021017182756.B3326@flint.arm.linux.org.uk>
References: <Pine.LNX.4.33.0210170919210.4730-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210170919210.4730-100000@maxwell.earthlink.net>; from jsimmons@infradead.org on Thu, Oct 17, 2002 at 09:38:37AM -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux console project <linuxconsole-dev@lists.sourceforge.net>

On Thu, Oct 17, 2002 at 09:38:37AM -0700, James Simmons wrote:
>   I like to annouce that I just finished the final fbdev changes. They are
> in the BK repository bk://fbdev.bkbits.net/fbdev-2.5. The changes are
> 
> 1) Removal of all console related code in the lower level drivers. Smaller
>    easier to program drivers.
> 
> 2) Now you can use the framebuffer driver WITHOUT framebuffer console.
>    Last night I built a kernel with MDA console and used the VESA
>    framebuffer by itself. Now you can easily debug new framebuffer
>    drivers. The real bonus is for embedded systems you have much smaller
>    kernels.
> 
> 3) I moved the agp and drm code into drivers/video. I did NOT place any
>    drm code with framebuffer code at people's request. I simiple moved the
>    directory from one spot to another. The main reason I did this was
>    because some framebuffer drivers will need to use the agp code initialized
>    before the framebuffer layer. The DRM code was moved because it makes
>    sense to move it there.
> 
> 4) I cleaned up the config.in for all the video stuff across all
>    platforms.
> 
> You can grab the lastest BK tree at
> 
> bk://fbdev.bkbits.net/fbdev-2.5
> 
> Give it a try. For people who want a diff it is avaiable at
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

... which is not representative of the changes.

Can you _please_ take much more care over patches and such like and take
the time to get them correct _please_.

I really don't like patches that float around that unintentionally delete
other peoples drivers for no reason.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html



-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
