From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] fb: straighten up fb drivers menu
Date: Thu, 29 Sep 2005 15:54:28 +0800
Message-ID: <433B9DB4.3010101@gmail.com>
References: <20050928210000.57fb7ce6.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKtFl-00072x-EE
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Sep 2005 00:54:53 -0700
Received: from zproxy.gmail.com ([64.233.162.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EKtFk-0004Ld-8U
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Sep 2005 00:54:53 -0700
Received: by zproxy.gmail.com with SMTP id i11so697869nzh
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 29 Sep 2005 00:54:44 -0700 (PDT)
In-Reply-To: <20050928210000.57fb7ce6.rdunlap@xenotime.net>
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm <akpm@osdl.org>, adaplas@pol.net, linux-fbdev-devel@lists.sf.net

Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Arrange frame buffer menu:
> - puts all Epson drivers together
> - removes split of FB_PXA and FB_PXA_PARAMETERS by FB_W100
> - results in PXA, W100, Epson, S3C2410, & Virtual FB drivers being
>   presented at the same menu level as all other FB drivers
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Acked-by: Antonino Daplas <adaplas@pol.net>


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
