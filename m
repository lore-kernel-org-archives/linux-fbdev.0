From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: Kernel Summit presentation
Date: Thu, 28 Jul 2005 14:45:25 +0600
Message-ID: <200507281445.25521.patrakov@ums.usu.ru>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dy42S-0004D9-C2
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 01:46:48 -0700
Received: from relay4.usu.ru ([194.226.235.39])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Dy42Q-00040M-Re
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 01:46:48 -0700
Received: from relay4.usu.ru (localhost [127.0.0.1])
	by relay4.usu.ru (PostSystem) with ESMTP id B0ACC167FC
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Jul 2005 14:45:28 +0600 (YEKST)
Received: from usu2.usu.ru (usu2.usu.ru [194.226.237.16])
	by relay4.usu.ru (PostSystem) with ESMTP id A6668167BA
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Jul 2005 14:45:28 +0600 (YEKST)
Received: from localhost.usu2.usu.ru (localhost.usu2.usu.ru [127.0.0.1])
	by usu2.usu.ru (Postfix) with ESMTP id 1951BA7A31
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Jul 2005 14:45:22 +0600 (YEKST)
Received: from ums.usu.ru (ums.usu.ru [194.226.236.116])
	by usu2.usu.ru (Postfix) with ESMTP id 0ACC8A7A2F
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Jul 2005 14:45:22 +0600 (YEKST)
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

Jon Smirl wrote:

> I attached the slides from my kernel summit presentation. The major
> change is that Linus does not want a new VT state. Instead we should
> open a new VT, switch it to VT_GRAPHICS, and then refuse to
> acknowledge VT swap requests. Dave Airlie did another presentation on
> mode setting and suspend/resume.
> 
> The simple overview: goal is to get rid of the current VT swap system
> but replace it with something that looks just like it. To do this the
> console is split into two halves.
> 
> 1) kernel console - it is as simple as possible and always guaranteed
> to work. It is simpler than current fbconsole. It automatically uses
> whatever mode is set on the monitor. There is only one kernel console
> - no VTs.
> 
> 2) user console - implements your normal VTs. Fully accelerated,
> supports Unicode, etc.
> 
> No one was really against restructuring the consoles. There was
> support for a console that always works even when something like X is
> running.

I am really interested in this, and want to help (with code, once 
architectural issues are solved). But there is a question:

How should applications that currently rely upon a kernel VT system being 
present (e.g. Xorg, MPlayer, SDL) be modified? (I mean, is there any proposed 
API for hunting for a free userspace VC?)

-- 
Alexander E. Patrakov


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
