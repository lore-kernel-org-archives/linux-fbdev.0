From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] matroxfb update to new API
Date: Tue, 27 May 2003 21:53:10 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305272059110.26160-100000@phoenix.infradead.org>
References: <2BAC427619B@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19KlS7-00083V-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 27 May 2003 13:53:47 -0700
In-Reply-To: <2BAC427619B@vcnet.vc.cvut.cz>
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
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Nicolas Souchu <nsouch@free.fr>, linux-fbdev-devel@lists.sourceforge.net


Sorry I have been ill for several days. Now I'm finally getting on my 
feet.
 
> What I say... matroxfb driver & fbcon layer which supports fbset,

The mode changing only worked on a select few cards before. What we need 
is better DDC support and start working on fbmon.c. The functions are all 
there to support this stuff.

> updates all visible screens, 

???

> supports text mode, 

Fbcon is over kill for text hardware mode. The best approach is what the 
STI driver does. A core set of functions shared between text mode and 
graphics mode. 

> implements clear_margins as black color and not current background 
> color.

It would look bad if the margin where a different color from the screen 
when it was cleared.




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
