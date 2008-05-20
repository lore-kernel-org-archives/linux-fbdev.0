From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/4] tridentfb: fix console freeze
 when switching from X11
Date: Tue, 20 May 2008 02:18:54 -0700
Message-ID: <20080520021854.9c82c2d4.akpm@linux-foundation.org>
References: <20080520071421.4d1727d0.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JyNzr-0003ei-UT for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 May 2008 02:19:04 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JyNzp-0001Vo-Hd
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 May 2008 02:19:03 -0700
In-Reply-To: <20080520071421.4d1727d0.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 20 May 2008 07:14:21 +0200 Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> This is tridentfb patch number 25.
> 
> I thought that it would be the last patch in the batch of changes but there
> seemed to be another bug for every fixed or enabled feature. I hope that
> all these 25 patches will make in next kernel release (2.6.27).

yup, I was planning on merging all this into 2.6.27.

> Unfortunately, more fixes will follow. I hope they will be only minor ones.

Fixes are not unfortunate ;)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
