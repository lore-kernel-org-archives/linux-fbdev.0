From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: fbdraw 0.1 available
Date: Sun, 12 Sep 2004 03:40:03 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409120340.04133.adaplas@hotpop.com>
References: <41426651.2010201@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6DmI-0007Vb-3O
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Sep 2004 12:43:18 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C6DmH-0000Ud-B7
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Sep 2004 12:43:18 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 5E84FE473
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Sep 2004 19:43:06 +0000 (UTC)
In-Reply-To: <41426651.2010201@comcast.net>
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
To: linux-fbdev-devel@lists.sourceforge.net, Zack <plinius@comcast.net>

On Saturday 11 September 2004 10:43, Zack wrote:
> My changes to permit (optional) in-kernel drawing for applications
> are available. It's only version 0.1 at this point, meaning alpha,
> but I'm happy with the performance and structure. I've included
> a test application that allows benchmarking.
>
> home.comcast.net/~plinius/fbdraw-0.1.tar.gz
>
> To install, move the tarfile to the 2.6.8.1 root dir, and use
> tar zxfv fbdraw-0.1.tar.gz.
>
> Constructive criticism is welcome.

(Better if you provided an inlined file so it's easier to make comments) 

Here's a few, just from a quick scan:

1. First, you need to follow Documentation/CodingStyle.

2. Do not directly access framebuffer memory, use: 

fb_{read|write}{b|w|l}

3. Do not use copy_{to|from}_user when the destination/source is the
framebuffer.

4. Do not memset the framebuffer.  You can probably create an equivalent
function using fb_read/write.  (Once, we have fb_memset and fb_memcpy, but
they're gone in 2.6).

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
