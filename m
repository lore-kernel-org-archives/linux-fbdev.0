From: James Simmons <jsimmons@infradead.org>
Subject: Re: video dir reorg
Date: Wed, 15 Jan 2003 00:37:54 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301150035470.23774-100000@phoenix.infradead.org>
References: <20030114212646.GA3731@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18YbZf-000566-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Jan 2003 16:38:31 -0800
In-Reply-To: <20030114212646.GA3731@iliana>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: Jon Smirl <jonsmirl@yahoo.com>, fbdev <linux-fbdev-devel@lists.sourceforge.net>


> There is a response of linus in the mailing list archive about this, i
> don't remember nor checked if it was only the first time, or not. I
> think the objection was about complicate to supervise diffs.

Yes. The DRI people want to keep there work seperate from us.

> Also, i think the drm drivers should compile not only on linux, but on
> other oses too (BSDs at least).

That will be difficult. The VM layer to BSD is very very different from 
linux. There is no way they coudl use the same code set for both without 
making a mess. 

> Also, i believe some of the XFree86 guys don't like fbdevs.
 
:-(



-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
