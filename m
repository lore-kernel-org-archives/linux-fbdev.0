From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Linux-fbdev-devel] [Bugme-new] [Bug 13285] New: INTELFB:
	Colors display incorrectly
Date: Sat, 16 May 2009 23:19:32 -0700
Message-ID: <20090516231932.2e02647b.akpm@linux-foundation.org>
References: <bug-13285-10286@http.bugzilla.kernel.org/>
	<20090512151934.d7e6c54e.akpm@linux-foundation.org>
	<20090517081743.92002707.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20090517081743.92002707.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=dri-devel>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: dri-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: samanddeanus@yahoo.com, linux-fbdev-devel@lists.sourceforge.net, dri-devel@lists.sourceforge.net, bugzilla-daemon@bugzilla.kernel.org

On Sun, 17 May 2009 08:17:43 +0200 Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> The intelfb driver sets color map depending on currently active pipe. However, if an LVDS 
> display is attached (like in laptop) the active pipe variable is never set. The default value is 
> PIPE_A and can be wrong.
> Set up the pipe variable during driver initialization after hardware state was read.
> 
> I also found by experiment that if both pipes were enabled, the PIPE_B is used (active).
> 
> The problem is visible in the 8 bpp mode if colors above 15 are used. The first 16 color
> entries are displayed correctly.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> ---
> This is not a regression. I have reproduced it in the 2.6.28 easily.

hm, Dean's original report had

    This does not occur in kernel 2.6.29 -- I can see the Tasmanian
    devil in a penguin mask (Tuz) just fine and can view images, etc on
    the framebuffer.

> Dean, please test the patch.

Yes please.

> diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
> index ace14fe..b47f6dd 100644
> --- a/drivers/video/intelfb/intelfbdrv.c
> +++ b/drivers/video/intelfb/intelfbdrv.c
> @@ -871,6 +871,12 @@ static int __devinit intelfb_pci_register(struct pci_dev *pdev,
>  
>  	intelfbhw_print_hw_state(dinfo, &dinfo->save_state);
>  
> +	/* Check whether pipe A or pipe B is enabled. */
> +	if (dinfo->save_state.pipe_a_conf & PIPECONF_ENABLE)
> +		dinfo->pipe = PIPE_A;
> +	if (dinfo->save_state.pipe_b_conf & PIPECONF_ENABLE)
> +		dinfo->pipe = PIPE_B;
> +
>  	if (bailearly == 18)
>  		bailout(dinfo);


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
--
