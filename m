From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Help re Frame Buffer/Console Problems
Date: Wed, 3 Nov 2004 05:40:06 +0800
Message-ID: <200411030540.06262.adaplas@hotpop.com>
References: <Pine.LNX.4.10.10411021743001.4822-100000@mtfhpc.demon.co.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CP6OC-0000ls-Dx
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 13:40:28 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CP6OA-0003tx-LM
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 13:40:28 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 1E05011A5630
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  2 Nov 2004 21:40:12 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.10.10411021743001.4822-100000@mtfhpc.demon.co.uk>
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
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org, geert@linux-m68k.org, sparclinux@vger.kernel.org, ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org, wli@holomorphy.com

On Wednesday 03 November 2004 02:03, Mark Fortescue wrote:
> Hi all,
>
> I have identified what is going on. My CG3 console uses the same font and
> exactly overlaps prom console. [I have re-inserted the console margin code
> for my CG3 driver]. The timing is such that the prom overwrites the
> console text (using colour 255) a fraction later than the fbcon code.
>
> The two problems to be solved are (apart from seting the red,green and
> blue structures up for the cg series fb cards):
>
> 1) The prom write (from -p) needs to be disabled as soon as an alternative
> console becomes active (either prom console, fbcon console or serial
> console). This has probably been the major cause of hassel.
>
> 2) The restore pallet function (see cgsix.c in the 2.2.x or 2.4.x kernels)
> needs to be re-introduced in some form and called when exiting fbcon so
> that the prom does not end up as black on black. My prom uses fg=255,

You can implement a cg3fb_open() and cg3fb_release() hooks and set up a
use_count field. You increment the count on every open, decrement on every
release. Then restore whatever on the last release. Optionally, you can even
do hardware inits on the first open.

Tony 




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
