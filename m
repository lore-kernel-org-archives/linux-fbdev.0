From: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Subject: Re: Framebuffer console not working with matroxfb on 2.6
Date: Thu, 16 Sep 2004 13:42:58 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040916114258.GP18257@uvt316-2.ruk.cuni.cz>
References: <20040915060926.GM18257@uvt316-2.ruk.cuni.cz> <200409152111.49959.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7uhW-0001Je-Jl
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Sep 2004 04:45:22 -0700
Received: from dec59.ruk.cuni.cz ([195.113.2.17])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C7uhU-0003VL-Ov
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Sep 2004 04:45:22 -0700
Content-Disposition: inline
In-Reply-To: <200409152111.49959.adaplas@hotpop.com>
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
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, vandrove@vc.cvut.cz

On Wed, Sep 15, 2004 at 09:11:49PM +0800, Antonino A. Daplas wrote:
> 
> In matroxfb_accel.c:matroxfb_imageblit(), try changing this line:
> 
> if (image->depth == 0)
> 
> to 
> 
> if (image->depth == 1)
> 
May I ask what this change is suposed to do?
As already explained the driver works if compiled into kernel as opposed
to loading it as a module. This change seems too small to fix module
loading :)

Thanks

Michal Suchanek


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
