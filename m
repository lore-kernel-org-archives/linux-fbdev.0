From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/1 2.6.24] fbdev: defio and
	Metronomefb v4
Date: Sun, 2 Mar 2008 23:19:41 -0800
Message-ID: <20080302231941.c744f159.akpm@linux-foundation.org>
References: <20080301034136.32426.77821.sendpatchset@hit-nxdomain.opendns.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JW4xn-0001jC-8s for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 02 Mar 2008 23:19:55 -0800
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JW4xl-0007wW-UY
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 02 Mar 2008 23:19:55 -0800
In-Reply-To: <20080301034136.32426.77821.sendpatchset@hit-nxdomain.opendns.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, 29 Feb 2008 22:41:37 -0500 Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> Hi Andrew, fbdev,
> 
> Appended is version 4 of the metronomefb code. 
> 
> The fixes are for the issues you pointed out. These are:
> 
> - fixed and cleaned up metronomefb_write
> - use wait_event_timeout for uninterruptible wait in *_cmd() used in probe()
> - use msleep in disable_controller
> - use get_unaligned to handle unaligned access
> - make load_waveform static and some cleanup
> 
> I did not change the handling of display_cmd because I think that using
> interruptible wait there is not a problem. In the case of the defio
> page->mapping, I could not find an issue and I have left it unchanged because
> it seems to work in testing.
> 
> I welcome your feedback.

Well... assuming you've addressed everything I raised to your satisfaction,
I won't be reading it again.

I now do not have a usable changelog for this patch.  Please send one, and
please do always send the full changelog (possibly updated) with each iteration
of a patch, thanks.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
