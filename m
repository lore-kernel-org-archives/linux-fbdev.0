From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/4 2.6.24] fbdev: metronomefb and
 hecubafb bugfix and platforming v4
Date: Mon, 7 Apr 2008 16:53:31 -0700
Message-ID: <20080407165331.9cbf654b.akpm@linux-foundation.org>
References: <20080404122358.6404.54652.sendpatchset@hit-nxdomain.opendns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jj19m-0004jB-8Y for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Apr 2008 16:53:46 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jj19l-0002MV-0D
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 07 Apr 2008 16:53:46 -0700
In-Reply-To: <20080404122358.6404.54652.sendpatchset@hit-nxdomain.opendns.com>
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
Cc: jayakumar.lkml@gmail.com, linux-fbdev-devel@lists.sourceforge.net

On Fri, 04 Apr 2008 08:23:59 -0400
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> Hi Tony, Geert, Andrew, fbdev,
> 
> This is version4 of the metronomefb and hecubafb bugfix and platforming
> patchset. It has 4 patches, which are as follows:
> 
> 1 - bugfix for metronomefb
> 2 - bugfix for hecubafb
> 3 - platforming metronomefb
> 4 - platforming hecubafb
> 
> The improvement over v2 is that the bugfixes are split into
> individual patches and that the Kconfig/Makefile changes for hecubafb
> are moved in patch 4 (as they should be) rather than patch 3. Thanks Geert.
> 

Thanks.

Do you believe that #1 and #2 should be in 2.6.25?  2.6.24.x?

If so, for what reason(s)?

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
