From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: [BK FBDEV] A few more updates.
Date: Wed, 26 Mar 2003 11:53:24 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <85019355E7@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailgw.cvut.cz ([147.32.3.235])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18y8XR-000597-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Mar 2003 02:53:45 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: adaplas@pol.net
Cc: jsimmons@infradead.org, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 26 Mar 03 at 11:42, Petr Vandrovec wrote:
> 
> accel_cursor unconditionally sets FB_CUR_SETPOS. Can you write it
> down to the TODO list to eliminate this? Cursor position lives 
> in different registers than cursor enable/disable on my hardware...
 
> And if we could rename FB_CUR_SETCUR to FB_CUR_SETVISIBILITY and
> leave cursor->enable setting on accel_cursor's caller, it would
> be even better.

I just noticed that softcursor.c contains copy of FB_CUR_SETCUR ->
cursor->enable code from accel_cursor(). Either 'enable' field has 
no bussiness in the fb_cursor structure (as it can be always infered from 
set flags, and if softcursor needs some internal bookkeeping, it should 
use some other variable and not fb_cursor's field), or this conversion 
should disappear from softcursor.c, and FB_CUR_SETCUR semantic should
change.
                                                Petr
                                                



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
