From: Andrew Walrond <andrew@walrond.org>
Subject: Re: x86_64 64bit kernel rivafb broke between 2.6.8.1 and linus bk as of today
Date: Wed, 17 Nov 2004 11:34:22 +0000
Message-ID: <200411171134.22537.andrew@walrond.org>
References: <200411162244.37709.andrew@walrond.org> <200411171107.21823.andrew@walrond.org> <Pine.GSO.4.61.0411171210590.20349@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUO4v-0004CZ-Nc
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 03:34:25 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CUO4u-0000N3-Nb
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Nov 2004 03:34:25 -0800
In-Reply-To: <Pine.GSO.4.61.0411171210590.20349@waterleaf.sonytel.be>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, adaplas@pol.net

On Wednesday 17 Nov 2004 11:11, Geert Uytterhoeven wrote:
>
> It's used for the text cursor, so you're definitely using it.
>

Ah Ok.

I'm developing a fb application so I'd like to get this fixed. Any 
insights/clues, before I start digging? As I said, it broke between rc1 and 
rc2, so I guess I can narrow it down to a particular cset and work it from 
there if nobody has any better ideas.

Andrew


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
