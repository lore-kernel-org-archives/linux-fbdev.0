From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Fw: 2.6.10-rc2 swsusp status & framebuffer problems
Date: Sat, 20 Nov 2004 05:26:44 +0800
Message-ID: <200411200526.44238.adaplas@hotpop.com>
References: <20041119041043.0b4ad40d.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CVGHY-0007fG-Nk
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 13:27:04 -0800
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CVGHX-0000Yr-8V
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 13:27:04 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id BBCE476693
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Nov 2004 21:26:47 +0000 (UTC)
In-Reply-To: <20041119041043.0b4ad40d.akpm@osdl.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

On Friday 19 November 2004 20:10, Andrew Morton wrote:
> Begin forwarded message:
>
> Date: Fri, 19 Nov 2004 13:08:56 +0100
> From: Pavel Machek <pavel@ucw.cz>
> To: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton
> <akpm@zip.com.au> Subject: 2.6.10-rc2 swsusp status & framebuffer problems
>
>
> Hi!
>
> If works for me, modulo graphics problems. So if it is broken on your
> machine, try finding driver that is responsible.
>
> Graphics problems: for some reason, swsusp now eats cursor
> (radeonfb)... or is it softcursor breakage?

Try 2.6.10-rc2-mm1 or just this particular changeset:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/broken-out/fbcon-disable-fbcon-cursor-if-vt-softcursor-is-enabled.patch

> There are more problems in
> framebuffer, something seems to be very wrong in palete handling. (I
> set green palete by default. mutt likes to reset terminal in such way
> that font goes white; with -rc2 it affects even non-current console).

Can you give instructions on how to reproduce it?  I use

echo -e '\033 P ] nrrggbb'

to change the console palette, and I can't seem to trigger the bug.  This is with
vesafb 1024x768-8.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
