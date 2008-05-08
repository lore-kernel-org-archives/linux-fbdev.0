From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH]: radeon: Misc corrections.
Date: Thu, 08 May 2008 20:32:22 +1000
Message-ID: <1210242742.1421.58.camel@pasglop>
References: <20080508.032238.23875845.davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ju3QO-0002Lk-2y for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 03:32:37 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX19LsAIC9X4BY8QBRLyS5Fz+YYlxeNUZcRo=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ju3QM-0007D1-HJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 May 2008 03:32:32 -0700
In-Reply-To: <20080508.032238.23875845.davem@davemloft.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: David Miller <davem@davemloft.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


On Thu, 2008-05-08 at 03:22 -0700, David Miller wrote:
> I have a new PCI-E radeon RV380 series card (PCI device ID 5b64) that
> hangs in my sparc64 boxes when the init scripts set the font.  The
> problem goes away if I disable acceleration.

There's a whole lot of known issues there with r3xx and later, mostly
because of the memory map...

I must admit I've been letting this driver rot for some time, hoping
that the integration of radeon mode setting in the kernel DRM would
replace it soon, but that hasn't happened yet...

> I haven't figured out that bug yet, but along the way
> I found some corrections to make based upon some auditing.

You may find clues about what's wrong by looking at the way the X driver
sets up the card internal memory map. I think that's where the problem
is for most newer cards.

> 1) The RB2D_DC_FLUSH_ALL value used by the kernel fb driver
>    and the XORG video driver differ.  I've made the kernel
>    match what XORG is using.
> 
> 2) In radeonfb_engine_reset() we have top-level code structure
>    that roughly looks like:
> 
> 	if (family is 300, 350, or V350)
> 		do this;
> 	else
> 		do that;
> 	...
> 	if (family is NOT 300, OR
> 	    family is NOT 350, OR
> 	    family is NOT V350)
> 		do another thing;
> 
>    this last conditional makes no sense, is always true,
>    and obviously was likely meant to be "family is NOT
>    300, 350, or V350".  So I've made the code match the
>    intent.

Yeah, looks like a copy/paste bug from some old broken ATI code, thanks
for spotting it.

I'll give your patch a quick test tomorrow on my rv350 to check it
doesn't break anything.

Thanks !

Ben.

> Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> diff --git a/drivers/video/aty/radeon_accel.c b/drivers/video/aty/radeon_accel.c
> index 3ca27cb..4d13f68 100644
> --- a/drivers/video/aty/radeon_accel.c
> +++ b/drivers/video/aty/radeon_accel.c
> @@ -241,8 +241,8 @@ void radeonfb_engine_reset(struct radeonfb_info *rinfo)
>  	INREG(HOST_PATH_CNTL);
>  	OUTREG(HOST_PATH_CNTL, host_path_cntl);
>  
> -	if (rinfo->family != CHIP_FAMILY_R300 ||
> -	    rinfo->family != CHIP_FAMILY_R350 ||
> +	if (rinfo->family != CHIP_FAMILY_R300 &&
> +	    rinfo->family != CHIP_FAMILY_R350 &&
>  	    rinfo->family != CHIP_FAMILY_RV350)
>  		OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset);
>  
> diff --git a/include/video/radeon.h b/include/video/radeon.h
> index 83467e1..95a1f20 100644
> --- a/include/video/radeon.h
> +++ b/include/video/radeon.h
> @@ -527,8 +527,9 @@
>  
> 
>  /* DSTCACHE_CTLSTAT bit constants */
> -#define RB2D_DC_FLUSH				   (3 << 0)
> -#define RB2D_DC_FLUSH_ALL			   0xf
> +#define RB2D_DC_FLUSH_2D			   (1 << 0)
> +#define RB2D_DC_FREE_2D				   (1 << 2)
> +#define RB2D_DC_FLUSH_ALL			   (RB2D_DC_FLUSH_2D | RB2D_DC_FREE_2D)
>  #define RB2D_DC_BUSY				   (1 << 31)
>  
> 


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
