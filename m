From: Anatolij Gustschin <agust@denx.de>
Subject: Re: disableing screen saver
Date: Tue, 07 Oct 2008 17:08:09 +0200
Message-ID: <48EB7B59.1000707@denx.de>
References: <331533.68660.qm@web38101.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <agust@denx.de>) id 1KnEDC-00049l-G6
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Oct 2008 15:10:58 +0000
Received: from mail-out.m-online.net ([212.18.0.9])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KnEAc-0006U6-AW for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Oct 2008 15:10:58 +0000
In-Reply-To: <331533.68660.qm@web38101.mail.mud.yahoo.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: batic62@yahoo.com
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi,

a a wrote:

> When we are in console of linux ( and not in X-Window) the console have
> screen saver ( that will blank the console after a period of time).
> 
> How we can disable this screen saver ( of console frame buffer) ?
>

try to disable console blanking by running

$ setterm -blank 0

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
