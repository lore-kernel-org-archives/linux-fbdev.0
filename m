From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Framebuffer console not working with matroxfb on 2.6
Date: Wed, 15 Sep 2004 21:11:49 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409152111.49959.adaplas@hotpop.com>
References: <20040915060926.GM18257@uvt316-2.ruk.cuni.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7ZZV-00025G-Hi
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Sep 2004 06:11:41 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C7ZZU-0003pu-UL
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Sep 2004 06:11:41 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 628B0845E7C
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Sep 2004 13:11:34 +0000 (UTC)
In-Reply-To: <20040915060926.GM18257@uvt316-2.ruk.cuni.cz>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Michal 'hramrach' Suchanek <hramrach@centrum.cz>, vandrove@vc.cvut.cz
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wednesday 15 September 2004 14:09, Michal 'hramrach' Suchanek wrote:
> Hello
>
> I tried using the framebuffer console with matroxfb on a 2.6 kernel and
> I see only reddish pattern on the screen. I do not get any letters.
> However, I can run X with UseFBdev option and a directfb program.
> I can also use the fbcons on an iMac with atifb.
> Tested with 2.6.7, with 2.6.8.1 I still do not get usable fbcons.
> THe hardware is G400 and G550.

In matroxfb_accel.c:matroxfb_imageblit(), try changing this line:

if (image->depth == 0)

to 

if (image->depth == 1)

Tony
>
> Thanks
>
> Michal Suchanek
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
> Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
> Camcorder. More prizes in the weekly Lunch Hour Challenge.
> Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel




-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
