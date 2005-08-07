From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [patch resend] w100fb: Rewrite for platform
 independence
Date: Sun, 07 Aug 2005 21:22:03 +0800
Message-ID: <42F60AFB.9070107@gmail.com>
References: <1123417929.7800.11.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1l6I-0004Dk-Sl
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 06:22:02 -0700
Received: from wproxy.gmail.com ([64.233.184.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1l6H-0001g9-Dd
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 06:22:02 -0700
Received: by wproxy.gmail.com with SMTP id i21so599469wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Aug 2005 06:21:52 -0700 (PDT)
In-Reply-To: <1123417929.7800.11.camel@localhost.localdomain>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@osdl.org, adaplas@pol.net, Richard Purdie <rpurdie@rpsys.net>

Richard Purdie wrote:
> The code w100fb was based on was horribly Sharp SL-C7x0 specific
> and there was little else that could be done as I had no access to
> anything else with a w100 in it. There is no real documentation 
> about this chipset available.
> 
> Ian Molton has access to other platforms with the w100 (Toshiba
> e-series) and so between us, we've improved w100fb and made it 
> platform independent. Ian Molton also added support for the 
> very similar w3220 and w3200 chipsets.
> 
> There are a lot of changes here and it nearly amounts to a rewrite 
> of the driver but it has been extensively tested and is being used 
> in preference to the original driver in the Zaurus community. I'd
> therefore like to update the mainline code to reflect this. 
> 
> [Comments from Antonino Daplas taken on board, thanks.]
> 
> Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Acked-by: Antonino Daplas <adaplas@pol.net>

> -		gSaveImagePtr[i] = NULL;
> +	if (par->extmem_active && par->saved_extmem) {
> +		memsize=par->mach->mem->size;
> +		memcpy(remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), par->saved_extmem, memsize);

You missed converting this to memcpy_toio though.

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
