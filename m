From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH 2.6.7-rc2] get rid of fbmem warning
Date: Mon, 7 Jun 2004 14:45:30 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040607144530.56aba4f4@dell_ss3.pdx.osdl.net>
References: <20040607101025.2e30b001@dell_ss3.pdx.osdl.net>
	<Pine.GSO.4.58.0406072314020.521@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BXRw1-0006w4-DG
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Jun 2004 14:45:37 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BXRw0-0002YP-PL
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Jun 2004 14:45:36 -0700
In-Reply-To: <Pine.GSO.4.58.0406072314020.521@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 7 Jun 2004 23:14:56 +0200 (MEST)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Mon, 7 Jun 2004, Stephen Hemminger wrote:
> > Get rid of warning because fb_image data is declared 'const char *' but is
> > being modified by the copy_from_user.

My preference would be to get rid of all qualifiers on individual structure elements.
It is kind of like putting volatile on the structure element, it isn't really what you
want to do.  I can't see how it could help code generation and since you have to overide
it anyway it doesn't make much sense.


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
