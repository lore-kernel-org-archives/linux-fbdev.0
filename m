From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 1/1 2.6.24] fbdev: defio and
	Metronomefb v4
Date: Sun, 2 Mar 2008 23:50:53 -0800
Message-ID: <45a44e480803022350u4fd9c217q670dda5f9dce51ec@mail.gmail.com>
References: <20080301034136.32426.77821.sendpatchset@hit-nxdomain.opendns.com>
	<20080302231941.c744f159.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JW5Rn-0004lo-Fo for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 02 Mar 2008 23:50:55 -0800
Received: from wf-out-1314.google.com ([209.85.200.172])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JW5Rm-0006GN-6y
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 02 Mar 2008 23:50:55 -0800
Received: by wf-out-1314.google.com with SMTP id 28so6687556wff.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 02 Mar 2008 23:50:53 -0800 (PST)
In-Reply-To: <20080302231941.c744f159.akpm@linux-foundation.org>
Content-Disposition: inline
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Sun, Mar 2, 2008 at 11:19 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
>
>  I now do not have a usable changelog for this patch.  Please send one, and
>  please do always send the full changelog (possibly updated) with each iteration
>  of a patch, thanks.
>

Ok, will do.

This patch implements support for the E-Ink Metronome controller. It
provides an mmapable interface to the controller using defio support.
It was tested with a gumstix pxa255 with Vizplex media using Xfbdev
and various X clients such as xeyes, xpdf, xloadimage.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
