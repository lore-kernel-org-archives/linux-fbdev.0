From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: vesafb with special resolution?
Date: Sat, 16 Oct 2004 05:52:20 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410160552.20443.adaplas@hotpop.com>
References: <20041015190606.GN30583@charite.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIZzd-0008Vf-2p
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 14:52:09 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CIZzc-0001Md-8L
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 14:52:09 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 5BE478E9747
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 15 Oct 2004 21:51:54 +0000 (UTC)
In-Reply-To: <20041015190606.GN30583@charite.de>
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
To: linux-fbdev-devel@lists.sourceforge.net, Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>

On Saturday 16 October 2004 03:06, Ralf Hildebrandt wrote:
> I have a 16:10 screen on my laptop (1280x768). vesafb runs OK with a
> 1024x768 resolution, but is 1280x768 also possible?

With the current vesafb incarnation, no. The vesafb driver currently selects
the mode from a table of standard vesa modes provided by the BIOS, and  
1280x768 is not standard.

Try vesafb-tng if you need a non-vesa standard mode.

http://dev.gentoo.org/~spock/projects/vesafb-tng/

Tony

PS:  A mode settable vesafb may happen soon enough...




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
