From: "Antonino A. Daplas" <adaplas@swissinfo.org>
Subject: Re: [PATCH] skeletonfb
Date: Sat, 5 Feb 2005 05:57:46 +0800
Message-ID: <200502050557.46676.adaplas@swissinfo.org>
References: <200501301911.17552.lucasvr@gobolinux.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CxBad-0003gb-V1
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Feb 2005 14:06:11 -0800
Received: from md1.swissinfo.org ([146.159.4.92])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CxBac-0006GX-8w
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Feb 2005 14:06:11 -0800
Received: from mail.swissinfo.org ([194.6.181.33])
	by md1.swissinfo.org (phad1.swissinfo.org [146.159.6.9])
	(MDaemon.PRO.v7.2.1.R)
	with ESMTP id 59-md50000279874.msg
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 04 Feb 2005 22:54:19 +0100
Received: from [203.177.116.119] (203.177.116.119) by mail.swissinfo.org (7.0.020) (authenticated as adaplas)
        id 4153942001EE30C8 for linux-fbdev-devel@lists.sourceforge.net; Fri, 4 Feb 2005 22:57:52 +0100
In-Reply-To: <200501301911.17552.lucasvr@gobolinux.org>
Content-Disposition: inline
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

On Monday 31 January 2005 05:11, Lucas Correia Villa Real wrote:
> Hi,
>
> This patch just fixes some typos and adds retval documentation for some
> functions that were missing it.
>
> I've also a question here: skeletonfb says that  xxxfb_setcolreg() should
> return a negative errno on error. However, if the register number being
> accessed is out of bounds, 1 is returned. Shouldn't it be better to return
> -EINVAL instead?  By looking at fbcmap.c, the retval isn't being checked
> against positive/negative values, so it doesn't make sense to return 1.
>
> Thanks,

Please, add a "Signed-off-by:" line next time.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
